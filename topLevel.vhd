library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity topTLC is port(topClk,res,cw: in std_logic;
			ewSignal,nsSignal: in std_logic_vector(1 downto 0);
			walkO: out std_logic;
			cntOUT,EWcnt: out std_logic_vector(3 downto 0);
			NSlight, EWLight: out std_logic_vector(2 downto 0));
end entity;

architecture beh of topTLC is 
signal count, ewCounter: std_logic_vector(3 downto 0);
signal selc: std_logic_vector(1 downto 0);

component tlcthree port (clk,reset,cwsig:in std_logic;		
        ewSig,carNS: in std_logic_vector(1 downto 0);  
	walk:out std_logic; 			
	countIN,countEW: in std_logic_vector(3 downto 0);  
	sel: out std_logic_vector(1 downto 0);
        northsouth,EW:out std_logic_vector(2 downto 0));
end component;

component counter port (clk,reset:in std_logic;
        input:in std_logic_vector(1 downto 0);
        count5,count3:out std_logic_vector(3 downto 0));
end component;

begin

TrafficLight: tlcthree port map(clk=>topClk,
				reset=>res,
				cwsig=>cw,
				ewSig=>ewSignal,
				carNS=>nsSignal,
				countIN=>count,
				countEW=>ewCounter,
				walk=>walkO,
				sel=>selc,
				northsouth=>NSlight,
				EW=>EWLight);

Timer: counter port map(clk=>topClk,
			reset=>res,
			input=>selc,
			count5=>count,
			count3=>ewCounter);
cntOUT<=count;
EWcnt<=ewCounter;
	
end beh;