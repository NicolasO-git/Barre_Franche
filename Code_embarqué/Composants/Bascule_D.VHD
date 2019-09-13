library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Bascule_D is
    port 
    (
        Clk :   in  std_logic;
        ARst_n :   in  std_logic;
        D   :   in  std_logic;
        Q   :   out std_logic
    );
end entity Bascule_D;

architecture rtl of Bascule_D is
    
begin
    Bascule: process(Clk, ARst_n)
    begin
    if ARst_n = '1' then
        Q   <=  '0';
    elsif rising_edge(clk) then
        Q   <=  D;
    end if;
    end process Bascule;
end architecture rtl;