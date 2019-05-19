library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tlc1 is
  Port (clk,reset:in std_logic;
        ewSig,carNS: in std_logic_vector(1 downto 0);  -- car sensors for northsouth and eastwest lanes
        northsouth,EW:out std_logic_vector(2 downto 0));
end tlc1;

architecture Behavioral of tlc1 is

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
process(cs,ewSig,carNS)
begin 

case cs is
when GNS =>
           
           northsouth <= "001";--output
           EW <= "100";--output


      
           
           if(ewSig="01" or ewSig="10" or ewSig="11" )then  -- when a car is on the east or west lanes begin transition to red light

           ns<=YNS;
           else
           ns<=cs;
           
           end if;
           
when YNS =>
           
           northsouth <= "010";
           EW <= "100";     
           ns <= GEW;
           


           
when GEW =>
            
            northsouth <= "100";
            EW <= "001"; 
                         
            if(carNS="01" or carNS ="10" or carNS ="11") then   -- when car is on the north or south begin the transition to a red light
                   ns <= YEW;
                else
                    ns<= cs;                
            end if;

when YEW =>
           
           northsouth <= "100";
           EW <= "010";
           ns <= GNS;
          

           

end case;
end process;
end Behavioral;

