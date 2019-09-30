architecture rtl of score is

type displayArray is array(9 downto 0) of std_logic_vector(7 downto 0);

signal display : displayArray;

signal USER_SCORE : integer range 0 to 9;
signal SYS_SCORE : integer range 0 to 9;
signal next_user_score : integer range 0 to 9;
signal next_sys_score : integer range 0 to 9;
signal s_over : std_logic;
signal s_next_over : std_logic;

begin

display(0) <= "11111100";
display(1) <= "01100000";
display(2) <= "11011010";
display(3) <= "11110010";
display(4) <= "01100110";
display(5) <= "10110110";
display(6) <= "10111110";
display(7) <= "11100000";
display(8) <= "11111110";
display(9) <= "11110110";

next_user_score <= USER_SCORE + 1 when x_pos(0) = '1' and not(USER_SCORE = 9 or SYS_SCORE = 9) else USER_SCORE;
next_sys_score <= SYS_SCORE + 1 when x_pos(11) = '1' and not(USER_SCORE = 9 or SYS_SCORE = 9) else SYS_SCORE;
s_next_over <= '1' when (next_user_score = 9 or next_sys_score = 9) else '0';

user <= display(USER_SCORE);
sys <= display(SYS_SCORE);
over <= s_over;

scoreProcess : process(clock)
begin

	if rising_edge(clock) then
	
		if (reset = '1') then
			USER_SCORE<= 0;
			SYS_SCORE <= 0;
		elsif (enable = '1') then
			USER_SCORE <= next_user_score;
			SYS_SCORE <= next_sys_score;
		end if;

	end if;
end process;

overProcess : process(clock)
begin

	if rising_edge(clock) then
		if (reset = '1') then
			s_over <= '0';
		elsif (enable = '1') then
			s_over <= s_next_over;
		end if;

	end if;
end process;

end architecture rtl;
