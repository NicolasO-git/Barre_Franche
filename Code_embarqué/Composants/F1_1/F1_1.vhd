library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity F1_1 is
    port 
    (
        Clk_50M             :   in  std_logic;
        In_freq_anemometre  :   in  std_logic;
        ARaz_n              :   in  std_logic;
        Continu             :   in  std_logic;
        Start_Stop          :   in  std_logic;
        Data_valid          :   out std_logic;
        Data_anemometre     :   out std_logic_vector(7  downto  0)        
    );
end entity F1_1;

architecture rtl of F1_1 is

signal  Clk_1Hz             :   std_logic;
signal  Freq_anemo_M_FM     :   std_logic;   
signal  Freq_anemo_M_CPT    :   std_logic_vector(7	downto	0);

begin
    
Div_freq    :   entity  work.Div
port map
    (
        Clk_50M =>  Clk_50M,
        ARaz_n  =>  ARaz_n,
        Clk_1Hz =>  Clk_1Hz 
    );    

Cpt_anemo   :   entity  work.Cpt
port map
    (
        Clk_50M             =>  Clk_50M,
        Clk_1Hz             =>  Clk_1Hz,    
        In_freq_anemometre  =>  Freq_anemo_M_FM,
        ARaz_n              =>  ARaz_n,
        Output              =>  Freq_anemo_M_CPT
 	 );    

Detect_front    :   entity  work.Detect_FM
port map
    (
        Clk_50M             	=>  Clk_50M,
 	    In_freq_anemometre		=>  In_freq_anemometre,
        ARaz_n              	=>  ARaz_n,
		In_freq_anemometre_M	=>  Freq_anemo_M_FM
    );

U0_Register    :   entity  work.Reg
port map 
    (
        Clk     =>  Clk_1Hz,
        ARaz_n  =>  ARaz_n,
        D       =>  Freq_anemo_M_CPT,
        Q       =>  Data_anemometre
    );
end architecture rtl;