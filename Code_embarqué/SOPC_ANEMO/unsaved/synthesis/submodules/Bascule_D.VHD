library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Bascule_D is
    port 
    (
        Clk         :   in  std_logic;
        ARaz_n      :   in  std_logic;
        D           :   in  std_logic;
        Q           :   out std_logic;
        Q_N         :   out std_logic
    );
end entity Bascule_D;

architecture rtl of Bascule_D is
    
begin
    Bascule: process(Clk, ARaz_n)
    begin
    if ARaz_n = '0' then
        Q   <=  '0';
        Q_N <=  '0';
    elsif rising_edge(Clk) then
			Q           <=  D;
			Q_N         <=  not D;
    end if;
    end process Bascule;
end architecture rtl;