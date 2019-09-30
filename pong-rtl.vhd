architecture rtl of pong is

component clock_divider is
	port ( clock   : IN  std_logic;
          reset   : IN  std_logic;
          enable  : OUT std_logic 
          );
end component clock_divider;

component bat is
port(button_up   : in std_logic;
     button_down : in std_logic;
     enable      : in std_logic;
     reset       : in std_logic;
     clock       : in std_logic;
     bat_o       : out std_logic_vector(8 downto 0));
end component bat;

component collision is
port(x_dir   : in std_logic;
     y_dir   : in std_logic;
     x_pos   : in std_logic_vector(11 downto 0);
     y_pos   : in std_logic_vector(8 downto 0);
     bat_pos : in std_logic_vector(8 downto 0);
     change  : out std_logic);
end component collision;

component debouncer is
port(button   : in std_logic;
     enable   : in std_logic;
     reset    : in std_logic;
     clock    : in std_logic;
     button_o : out std_logic);
end component debouncer;

component movement_full is
generic(WIDTH : natural := 9;
        INIT  : std_logic_vector);
port(ext_change : in std_logic;
     enable     : in std_logic;
     reset      : in std_logic;
     clock      : in std_logic;
     pos        : out std_logic_vector(WIDTH - 1 downto 0);
     dir_o      : out std_logic);
end component movement_full;

component score is
port(x_pos  : in std_logic_vector(11 downto 0);
     enable : in std_logic;
     reset  : in std_logic;
     clock  : in std_logic;
     user   : out std_logic_vector(7 downto 0);
     sys    : out std_logic_vector(7 downto 0);
     over   : out std_logic);
end component score;

signal s_reset : std_logic;
signal s_enable : std_logic;
signal s_button_up : std_logic;
signal s_button_down : std_logic;
signal s_bat_pos : std_logic_vector(8 downto 0);
signal s_bat_pos_x : std_logic_vector(11 downto 0) := "010000000000";
signal s_collision : std_logic;
signal s_x_pos : std_logic_vector(11 downto 0);
signal s_y_pos : std_logic_vector(8 downto 0);
signal s_x_dir : std_logic;
signal s_y_dir : std_logic;
signal s_over : std_logic;

begin

display : FOR y IN 8 DOWNTO 0 GENERATE
	oneline : FOR x IN 11 DOWNTO 0 GENERATE
		playfield(y*12+x) <= (s_y_pos(y) AND s_x_pos(x)) OR ( s_bat_pos_x(x) and s_bat_pos(y));
	END GENERATE oneline;
END GENERATE display;

s_reset <= not n_reset;

cD : clock_divider 
	port map (
		clock => clock,
		reset => s_reset,
		enable => s_enable
	);

uBD : debouncer
	port map (
		button => n_button_up,
		enable => s_enable,
		reset => s_reset,
		clock => clock,
		button_o => s_button_up
	);

dBD : debouncer
	port map (
		button => n_button_down,
		enable => s_enable,
		reset => s_reset,
		clock => clock,
		button_o => s_button_down
	);

b : bat
	port map (
		button_up => s_button_up,
		button_down => s_button_down,
		enable => s_enable,
		reset => s_reset,
		clock => clock,
		bat_o => s_bat_pos
	);

x_pos : movement_full
generic map (
	WIDTH => 12,
	INIT => "000000100000"
)
port map (
	ext_change => s_collision,
	enable => s_enable,
	reset => s_reset,
	clock => clock,
	pos => s_x_pos,
	dir_o => s_x_dir
);

y_pos : movement_full
generic map (
	WIDTH => 9,
	INIT => "000010000"
)
port map (
	ext_change => '0',
	enable => s_enable,
	reset => s_reset,
	clock => clock,
	pos => s_y_pos,
	dir_o => s_y_dir
);

scoreCounter : score
port map(
	x_pos  => s_x_pos,
    enable => s_enable,
    reset => s_reset, 
    clock => clock,
    user => user,
    sys => sys,
    over => s_over
);

collisionDetector : collision
port map (
	x_dir => s_x_dir, 
	y_dir => s_y_dir,
	x_pos => s_x_pos,
	y_pos => s_y_pos,
	bat_pos => s_bat_pos,
	change => s_collision
);

end architecture rtl; 
