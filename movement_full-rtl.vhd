architecture rtl of movement_full is

component movement is
	generic(WIDTH : natural := 9;
        INIT  : std_logic_vector);
	port ( dir   : in std_logic;
     enable : in std_logic;
     reset  : in std_logic;
     clock  : in std_logic;
     pos    : out std_logic_vector(WIDTH - 1 downto 0));
end component movement;

component direction is
	port (change : in std_logic;
     enable : in std_logic;
     reset  : in std_logic;
     clock  : in std_logic;
     dir    : out std_logic);
end component direction;

signal s_and1, s_and2, s_or, s_dir: std_logic;
signal s_pos: std_logic_vector(WIDTH - 1 downto 0);

begin

	s_or <= ext_change or s_and1 or s_and2;
	s_and1 <= s_dir and s_pos(WIDTH-2);
	s_and2 <= not s_dir and s_pos(1);
	dir_o <= s_dir;
	pos <= s_pos;

	M: movement 
		generic map (
			WIDTH => WIDTH,
			INIT => INIT
		)
		port map (
			dir => s_dir,
			enable => enable,
			reset => reset,
			clock => clock,
			pos => s_pos
	);

	D: direction 
		port map (
			change => s_or,
			enable => enable,
			reset => reset,
			clock => clock,
			dir => s_dir
	);
   
end architecture rtl;
