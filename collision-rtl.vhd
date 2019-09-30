architecture rtl of collision is

signal s_x_pos_1 : std_logic_vector(11 downto 0);
signal s_y_pos_1 : std_logic_vector(8 downto 0);

begin
s_x_pos_1 <= x_pos(10 downto 0) & '0' when (x_dir = '1' and x_pos(11) = '0') or (x_pos(0) = '1' and x_dir='0') else '0' & x_pos(11 downto 1);
s_y_pos_1 <= y_pos(7 downto 0) & '0' when (y_dir = '1' and y_pos(8) = '0') or (y_pos(0) = '1' and y_dir='0') else '0' & y_pos(8 downto 1);

change <= '1' when (s_x_pos_1 = "010000000000") and (bat_pos or s_y_pos_1) = bat_pos else '0'; 

end architecture rtl;

