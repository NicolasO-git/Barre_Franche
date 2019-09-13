library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Div_Freq is
    port 
    (
        ARst_N      :   in std_logic;
        Clk         :   in std_logic;
        Div         :   in std_logic_vector(2 downto 0);
        ClkDiv      :   out std_logic
    );
end entity Div_Freq;

architecture rtl of Div_Freq is
    signal  backup      :   std_logic_vector(6 downto 0);
    signal  Clkselect   :   std_logic_vector(7 downto 0);

begin
    Bascule_D   :   entity  work.Bascule_D
    port map
    (
        ARst_N  =>  ARst_N,
        Clk     =>  Clk,
        D       =>  backup(0),
        Q       =>  Clkselect(1),
        Q_N     =>  backup(0)
    );
    fDiv: for i in 2 to 7 generate
        Bascule_D   :   entity  work.Bascule_D
        port map
        (
            ARst_N  =>  ARst_N,
            Clk     =>  Clk,
            D       =>  backup(i - 1),
            Q       =>  Clkselect(i - 1),
            Q_N     =>  backup(i - 1)
        );
    end generate fDiv;
        Clkselect(0)    <=  Clk;
    M0_MUX  :   entity  work.Mux
    port map
    (
        A   =>  Clkselect,
        S   =>  Div,
        Q   =>  ClkDiv
    );
end architecture rtl;