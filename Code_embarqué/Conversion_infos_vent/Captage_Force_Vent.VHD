library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Captage_Force_Vent is
    port 
    (
            
    );
end entity Captage_Force_Vent;

architecture rtl of Captage_Force_Vent is
    constant N : integer := 8;
    signal iQ   :   std_logic_vector(N - 1 downto 0);
begin
    
    entity Compteur is
    generic map
    (
        N       => N
    )
    port map
    (
        ARst_N  => ,
        Clk     => ,
        SRst    => ,
        En      => ,
        Q       => 
    );
    
end architecture rtl;