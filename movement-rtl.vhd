architecture rtl of movement is

signal s_pos: std_logic_vector( WIDTH-1 DOWNTO 0);

begin

pos <= s_pos;	

	fsm : process(clock)
	begin
		if rising_edge(clock) then

			if(reset = '1') then
				s_pos <= INIT;
			else
				if (dir = '1' and enable = '1' and s_pos(WIDTH-1) /= '1' ) then
						s_pos <= (s_pos(WIDTH-2 DOWNTO 0) & '0');

				elsif (dir = '0' and enable = '1' and s_pos(0) /= '1') then
						s_pos <= ( '0' & s_pos(WIDTH-1 DOWNTO 1));
				end if;
			end if;
		end if;
	end process;			
end architecture rtl;
