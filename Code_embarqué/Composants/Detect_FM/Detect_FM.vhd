library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Detect_FM is
    port 
    (
        Clk_50M                     : in  std_logic;
        Raz_n                       : in  std_logic;
        In_freq_anemometre          : in  std_logic;
        In_freq_anemometre_M        : out std_logic
    );

end Detect_FM;

architecture rtl of Detect_FM is

signal r0_input                           : std_logic;
signal r1_input                           : std_logic;

begin
    p_rising_edge_detector : process(Clk_50M,Raz_n)
    begin
        if(Raz_n = '0') then
            r0_input           <= '0';
            r1_input           <= '0';
        elsif(rising_edge(Clk_50M)) then
            r0_input           <= In_freq_anemometre;
            r1_input           <= r0_input;
        end if;
    end process p_rising_edge_detector;

In_freq_anemometre_M <=  not r1_input and r0_input;

end rtl;