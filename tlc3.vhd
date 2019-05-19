library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tlcthree is
  Port (clk,reset,cwsig:in std_logic;			--cross walk button
        ewSig,carNS: in std_logic_vector(1 downto 0);  -- car sensors for northsouth and eastwest lanes
	walk:out std_logic; 				--crosswalk output
	countIN,countEW: in std_logic_vector(3 downto 0);  --additional count inputs 
	sel: out std_logic_vector(1 downto 0);
        northsouth,EW:out std_logic_vector(2 downto 0));
end tlcthree;

architecture Behavioral of tlcthree is

type state_type is (GNS,YNS,GEW,YEW);

signal cs,ns: state_type;
begin
process(clk,reset)
begin
    if (reset='1')then
        cs<=GNS;
    elsif(clk'event and clk='1')then
       cs<=ns;
    end if;
    end process;
process(cs,ewSig,carNS,cwsig)
begin 
sel<="00";
case cs is
when GNS =>
           sel<="10";
           northsouth <= "001";--output
           EW <= "100";--output
	  		
	   walk<='1'; --walk across EW lanes
      	   
           if(countIN="0101")then   -- count input from counter 
           if(ewSig="01" or ewSig="10" or ewSig="11")then  -- when a car is on the east or west lanes begin transition to red light

           ns<=YNS;
           else
           ns<=cs;
           end if;
           end if;
           
when YNS =>
           
           northsouth <= "010";
           EW <= "100";     
           ns <= GEW;
           


           
when GEW =>
	   sel<="10";
           walk<='0'; 
            northsouth <= "100";
            EW <= "001"; 
	    if(countIN="0101")then
            if(cwsig='1')then   --if the cross walk button is not pressed
		ns<=YEW;
	    else
             
            	if(ewSig="01" or ewSig ="10" or ewSig ="11") then   -- when car is on the north or south begin the transition to a red light
		 if(countEW="0011")then   -- count input from counter for additional 3 sec in the EW direction if a 
                  	 ns <= cs;
			end if;
                	else
                   	 ns<= YEW;                
           	 end if;
	    end if;
	end if;  

when YEW =>
           
           northsouth <= "100";
           EW <= "010";
           ns <= GNS;
          

           

end case;
end process;
end Behavioral;
