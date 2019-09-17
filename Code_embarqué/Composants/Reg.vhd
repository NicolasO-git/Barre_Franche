library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Reg is
    port 
    (
        Clk     :   in  std_logic;
        ARst_N  :   in  std_logic;
        D       :   in  std_logic;
        Q       :   out std_logic_vector(7  downto  0)    
    );
end entity Reg;

architecture rtl of Reg is

    signal  Clk_1Hz         :   std_logic;
    signal  Data_anemo_in   :   std_logic_vector(7  downto  0);
    signal  Data_anemo_out  :   std_logic_vector(7  downto  0);

begin
    
    Reg :   entity  work.Bascule_D
    port map
    (
        ARst_N  =>  ARst_N,
        Clk     =>  Clk_1Hz,
        D       =>  Data_anemo_in(0),
        Q       =>  Data_anemo_out(0)
    );
    
    fReg    :   for i   in  1   to  7   generate
        Reg :   entity  work.Bascule_D
        (
            ARst_N  =>  ARst_N,
            Clk     =>  Clk_1Hz,
            D       =>  Data_anemo_in(i + 1),
            Q       =>  Data_anemo_out(i + 1)
        );
    end generate fReg;
    
    Q   <=  Data_anemo_out;

end architecture rtl;