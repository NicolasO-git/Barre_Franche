library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Anemo_avalon is
    port
    (
        clk, reset_n, freq_anemometre   : in std_logic;
        out_pwm                         : out std_logic
    );
end entity;

architecture arch_avalon_anemo of Anemo_avalon is


begin
    
    F1_1_valide : entity work.F1_1_valide
    port map
    (
        Clk_50M         =>  clk,
        Araz_n          =>  reset_n,
        Freq_anemometre =>  freq_anemometre,
        Continu         =>  ,
        Start_Stop      =>  ,
        Data_valide     =>  ,
        Data_anemometre =>  , 
    );
    
end architecture arch_avalon_anemo;