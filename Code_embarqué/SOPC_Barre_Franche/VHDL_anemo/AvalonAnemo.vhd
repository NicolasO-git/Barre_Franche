library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
LIBRARY work;

entity AvalonAnemo is
    port 
    (
        clk, reset_n, chipselect, write_n, in_freq_anemometre   :   in std_logic;
        address 									            :   std_logic;
        writedata                                               :   in std_logic_vector(31 downto 0); 
        readdata                                                :   out std_logic_vector(31 downto 0)
    );
end entity AvalonAnemo;


architecture rtl of AvalonAnemo is
    signal Raz_N            :   std_logic;
    signal Continu          :   std_logic;
    signal Start_stop       :   std_logic;
    signal Data_anemometre  :   std_logic_vector(7 downto 0);
    signal Data_valide      :   std_logic;

    Component F1_1_valide 
	PORT
	(
		Clk_50M :  IN  STD_LOGIC;
		ARaz_n :  IN  STD_LOGIC;
		Freq_anemometre :  IN  STD_LOGIC;
		Continu :  IN  STD_LOGIC;
		Start_Stop :  IN  STD_LOGIC;
		Data_valide :  OUT  STD_LOGIC;
		Data_anemometre :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END Component;

begin
    
    --          Interface bus avalon
    --*******************************************************   
    -- Ecriture registres
    --*******************************************************   
    ecriture: process (clk, reset_n)
    begin
    if reset_n = '0' then
        Raz_N <= '0';
        Continu <= '0';	
        Start_stop <= '0';		
    elsif clk'event and clk = '1' then
        if chipselect ='1' and write_n = '0' then
        case address is
            when '0' =>
                Raz_N <= writedata(0);
                Continu <= writedata(1);
                Start_stop <= writedata(2);
            when others => 
            end case;
        end if;
    end if;
    end process ecriture;
    --*******************************************************

    --*******************************************************   
    --	lecture des registres
    --*******************************************************   
    lecture: process (address, data_anemometre)
    begin
                case address is
                    when '1' =>
                    readdata(9 downto 0) <=  Data_valide & '0' & Data_anemometre;
                    readdata(31 downto 10) <= (others => '0');
                    when others => 
                    readdata <= (others => '0');
                    end case;
    end process lecture;


    Anemo : F1_1_valide 
	PORT map
	(
		Clk_50M => Clk,
		ARaz_n  => Raz_N,
		Freq_anemometre => in_freq_anemometre,
		Continu => Continu,
		Start_Stop => Start_Stop,
		Data_valide => Data_valide,
		Data_anemometre => Data_anemometre
	);
    
end architecture rtl;