library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb3 is 
end;
 
architecture beh of tb3 is 
signal clock,res,cw,walkOut: std_logic;
signal NSsig,EWsig:std_logic_vector(1 downto 0);
signal EWlight,NSlight: std_logic_vector(2 downto 0);

component tlcthree port(clk,reset,cwsig:in std_logic;			--cross walk button
        ewSig,carNS: in std_logic_vector(1 downto 0);  -- car sensors for northsouth and eastwest lanes
	walk:out std_logic; 				--crosswalk output
        northsouth,EW:out std_logic_vector(2 downto 0));
end component;

begin

TrafficLight: tlcthree port map (clk=>clock,  --instantiation of component
			     reset=>res,
			     cwsig=>cw,
			     walk=>walkOut,
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
cw<='0';
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
EWsig<="01";
	wait for 100 ns;
clock<='1';
	wait for 100 ns;
clock<='0';
cw<='1';
	wait for 100 ns;
clock<='1';
	wait for 100 ns;
clock<='0';
cw<='0';
	wait for 100 ns;
clock<='1';
	wait for 100 ns;
clock<='0';

end process;
end beh;
