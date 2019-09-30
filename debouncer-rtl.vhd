library ieee;
use ieee.std_logic_1164.all;

entity flipflop is 
   port(
      Q : out std_logic;    
      Clk : in std_logic;   
      D : in  std_logic    
   );
end flipflop;

architecture Behavioral of flipflop is  
begin  
 process(Clk)
 begin 
    if(rising_edge(Clk)) then
   		Q <= D; 
    end if;       
 end process;  
end Behavioral;

architecture rtl of debouncer is

component flipflop is
	port (
		Q : out std_logic;    
    	Clk :in std_logic;   
    	D :in  std_logic 	
	);
end component flipflop;

signal s_q1, s_q2, s_q3, s_q4, s_d4, s_and, s_or : std_logic;

begin

s_d4 <= s_or and not (enable or reset);
s_or <= s_q4 or s_and;
s_and <= s_q2 and not s_q3;

dff1 : flipflop port map (
	Q => s_q1,
	Clk => clock,
	D => button
);

dff2 : flipflop port map (
	Q => s_q2,
	Clk => clock,
	D => s_q1
);

dff3 : flipflop port map (
	Q => s_q3,
	Clk => clock,
	D => s_q2
);

dff4 : flipflop port map (
	Q => s_q4,
	Clk => clock,
	D => s_d4
);

button_o <= s_q4;

end architecture rtl; 



