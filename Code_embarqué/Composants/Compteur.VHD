library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity Compteur is
    generic 
    (
        N       :   integer := 8
    );
    port 
    (
        ARst_N  :   in  std_logic;
        Clk     :   in  std_logic;
        SRst    :   in  std_logic;
        En      :   in  std_logic;
        Q       :   out std_logic_vector(N - 1 downto 0)
    );
end entity Compteur;

architecture rtl of Compteur is
    signal iQ   :   std_logic_vector(N - 1 downto 0);
begin
    pCpt: process(Clk, ARst_N)
    begin
    if ARst_N = '1' then
        iQ <= (others => '0');
    elsif rising_edge(Clk) then
        if SRst = '1' then
            iQ <= (others => '0');
        elsif En = '1' then
            iQ <= iQ + '1';
        end if;
    end if;
    end process pCpt;
    Q <= iQ;
end architecture rtl;