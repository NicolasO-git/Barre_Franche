library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Div_Freq is
    port 
    (
        Clk     :   in  std_logic;
        ARst_n  :   in  std_logic;
        D       :   in  std_logic;
        Q       :   out std_logic;
        Q_N     :   out std_logic
    );
end entity Div_Freq;

architecture rtl of Div_Freq is
    
begin
    DIV: process(Clk, ARst_n)
    begin
    if ARst_n = '1' then
        Q   <=  '0';
        Q_N <=  '0';
    elsif rising_edge(clk) then
        Q   <=  D;
        Q_N <=  not D;
    end if;
    end process DIV;
end architecture rtl;