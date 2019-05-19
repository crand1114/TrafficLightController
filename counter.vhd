library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity counter is
  Port (clk,reset:in std_logic;
        input:in std_logic_vector(1 downto 0);
        count5,count3:out std_logic_vector(3 downto 0));
end counter;

architecture Behavioral of counter is
signal tmpC,tmpb,tmpcross: std_logic_vector(3 downto 0);--counter 

begin

process(reset,clk)
begin
    tmpC<="0000";
    tmpb<="0000";
    tmpcross<="0000";
    if(reset='1')then
    tmpC<="0000";
    tmpb<="0000";
    elsif(clk'event and (clk='1'))then
    if(input="01")then
        if(tmpC < "0011") then --count to 3
        tmpC <= tmpC + "0001";            
        end if;
    elsif(input="10")then
        if(tmpb < "0101")then    --count to 5
        tmpb <= tmpb + "0001";
        end if;
        end if;
 end if;   
    count3 <= tmpC;
    count5<=tmpb;
    end process;
end Behavioral;

