library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Reg is
    port 
    (
        Clk     	:   in  std_logic;
        ARaz_n  	:   in  std_logic;
        D       	:   in  std_logic_vector(7	downto	0);
        Data_valid  :   out std_logic;
        Q       	:   out std_logic_vector(7  downto  0)   
    );
end entity Reg;

architecture rtl of Reg is

begin
    
    fReg    :   for i   in  0   to  7   generate
        BasculeD :   entity  work.Bascule_D
		port map
        (
            Clk     	=>  Clk,
            ARaz_n  	=>  ARaz_n,
            D       	=>  D(i),
            Q       	=>  Q(i),
            Q_N			=> 	open
        );
    end generate fReg;
	
    process(Clk, ARaz_n)
        begin
        if ARaz_n   =   '0' then
            Data_valid  <=  '0';
        elsif rising_edge(Clk) then
            Data_valid  <=  '1';
        end if;
    end process; 
end architecture rtl;