library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb1 is 
end;
 
architecture beh of tb1 is 
signal clock,res: std_logic;
signal NSsig,EWsig:std_logic_vector(1 downto 0);
signal EWlight,NSlight: std_logic_vector(2 downto 0);

component tlc1  port(clk,reset:in std_logic;
        ewSig,carNS: in std_logic_vector(1 downto 0);   
        northSouth,EW:out std_logic_vector(2 downto 0));
end component;

begin

TrafficLight: tlc1 port map (clk=>clock,  --instantiation of component
			     reset=>res,
			     ewSig=>EWsig,
			     carNS=>NSsig,
			     northSouth=>NSlight,
			     EW=>EWlight);

process
	begin   

		--default inputs for simulation
clock<='1';
res<='0';
NSsig<="00";
EWsig<="00";
	wait for 100 ns;
clock<='0';
EWsig<="10";
	wait for 100 ns;
clock<='1';
	wait for 100 ns;
clock<='0';
	wait for 100 ns;
clock<='1';
	wait for 100 ns;
clock<='0';
NSsig<="01";
	wait for 100 ns;
clock<='1';
	wait for 100 ns;
clock<='0';
	wait for 100 ns;
clock<='1';
	wait for 100 ns;
clock<='0';


end process;
end beh;
