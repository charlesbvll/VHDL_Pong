architecture rtl of bat is

signal s_bat : std_logic_vector(8 downto 0);

begin

bat_o <= s_bat;

move : process(clock)
begin
	if rising_edge(clock) then
			
			if(reset = '1') then
				s_bat <= "000111000";

			elsif (enable = '1') then

				if(button_up = '1' and button_down = '0' and s_bat /= "111000000") then
					s_bat <= s_bat(7 downto 0) & '0';
				end if;

				if(button_down = '1' and button_up = '0' and s_bat /= "000000111") then
					s_bat <= '0' & s_bat(8 downto 1);

				end if;	
			end if;
	end if;
end process;

end architecture rtl;
