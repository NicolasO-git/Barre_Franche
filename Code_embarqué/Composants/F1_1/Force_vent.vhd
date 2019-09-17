library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Force_vent is
    port 
    (
        Clk_50M             :   in  std_logic;
        In_freq_anemometre  :   in  std_logic;
        Raz_n               :   in  std_logic;
        Continu             :   in  std_logic;
        Start_Stop          :   in  std_logic;
        Data_valid          :   out std_logic;
        Data_anemometre     :   out std_logic        
    );
end entity Force_vent;

architecture rtl of Force_vent is

signal  Clk_1Hz             :   std_logic;
signal  Freq_anemo_M_FM     :   std_logic_vector(7  downto  0);   
signal  Freq_anemo_M_CPT    :   std_logic_vector(7  downto  0);

begin
    
Div_freq    :   entity  work.Div
port map
    (
        Clk_50M =>  Clk_50M,
        Raz_n   =>  Raz_n,
        Clk_1   =>  Clk_1Hz 
    );    

Cpt_anemo   :   entity  work.Cpt
port map
    (
        Clk_50M             =>  Clk_50M,
        Clk_1               =>  Clk_1Hz,    
        In_freq_anemometre  =>  Freq_anemo_FM,
        Raz_n               =>  Raz_n,
        Output              =>  Freq_anemo_M_CPT
 	 );    

Detect_front    :   entity  work.Detect_FM
port map
    (
        Clk_50M             =>  Clk_50M,
        Clk_1               =>  Clk_1Hz,
 	    In_freq_anemometre	=>  In_freq_anemometre,
        Raz_n               =>  Raz_n,
 	    Output				=>  Freq_anemo_FM
    );

Register    :   entity  work.Reg
port map 
    (
        
    )
end architecture rtl;