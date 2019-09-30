architecture rtl of direction is

signal s_dir: std_logic;

begin

dir <= s_dir;	

	fsm : process(clock)
	begin
		if rising_edge(clock) then
			if(reset = '1') then
				s_dir <= '1';
			elsif (s_dir = '1' and change = '1' and enable = '1') then
				s_dir <= '0';
			elsif (s_dir = '0' and change = '1' and enable = '1') then
				s_dir <= '1';
			else
				s_dir <= s_dir;
			end if;

		end if;
	end process;
end architecture rtl;      
