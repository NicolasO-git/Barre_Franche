library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Compteur is
    generic 
    (
        NCpt :  integer :=  250;
    )
    port 
    (
        Clk     :   in  std_logic;
        Clk_in  :   in  std_logic;
        Clk_out :   out std_logic_vector(7 downto 0)
    );
end entity Compteur;

architecture rtl of Compteur is
    signal S_Clk_out    :   std_logic_vector(7 downto 0);
begin
    cpt: process(sensitivity_list)
    begin
        if Clk'event and Clk = '1' then
            if Clk_in = '1' then
                if S_Clk_out >= NCpt    then
                    S_Clk_out   <= "0000000";
                else
                    S_Clk_out   <= S_Clk_out + 1;
                end if
            end if
        end if
    end process cpt;
end architecture rtl;