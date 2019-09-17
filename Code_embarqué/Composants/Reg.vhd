library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Reg is
    port 
    (
        Clk     :   in  std_logic;
        ARst_N  :   in  std_logic;
        D       :   in  std_logic_vector(7  downto  0);
        Q       :   out std_logic_vector(7  downto  0)    
    );
end entity Reg;

architecture rtl of Reg is

begin
    
    fReg    :   for i   in  0   to  7   generate
        Reg :   entity  work.Bascule_D
        (
            ARst_N  =>  ARst_N,
            Clk     =>  Clk,
            D       =>  D(i),
            Q       =>  Q(i)
        );
    end generate fReg;

end architecture rtl;