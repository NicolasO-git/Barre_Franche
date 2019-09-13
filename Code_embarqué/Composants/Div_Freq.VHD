library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Div_Freq is
    port 
    (
        clk_50M :   in  std_logic;
        raz_n   :   in  std_logic;
        D       :   in  std_logic;
        Q       :   out std_logic;
        clk_out :   out std_logic
    );
end entity Div_Freq;

architecture rtl of Div_Freq is
    
begin

    generate_clkdiv: for i in 2 to 7 generate
        
    end generate generate_clkdiv;
    
end architecture rtl;