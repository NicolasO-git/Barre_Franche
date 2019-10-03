library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Clk10K is
    port 
    (
        Clk50M  :   in  std_logic;
        ARst_N  :   in  std_logic;
        Clk10K  :   out std_logic 
    );
end entity Clk10K;

architecture rtl of Clk10K is

signal s_clk_50M    :   std_logic_vector(25 downto  0);
   
begin
    
    pPulse10K: process(Clk50M, ARst_N)
    begin
        if  ARaz_n = '0'    then
            s_clk_50M   <=(others => '0');
            Clk_10K       <= '0'; 
        elsif   Clk_50M'event and Clk_50M = '1' then
            if s_clk_50M = 50000000 then 
                s_clk_50M <= (others => '0');
                Clk_10K <= '1';
            else
                s_clk_50M <= s_clk_50M + 1;
                Clk_10K <= '0';
            end if;
        end if;
    
    end process pPulse10K;
end architecture rtl;