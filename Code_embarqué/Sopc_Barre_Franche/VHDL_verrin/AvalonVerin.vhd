library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
LIBRARY work;

entity AvalonVerin is
    port 
    (
        clk, reset_n, chipselect, write_n, data_in  :   in std_logic;
        address                                     :   in std_logic_vector(2 downto 0);
        writedata                                   :   in std_logic_vector(31 downto 0); 
        readdata                                    :   out std_logic_vector(31 downto 0);
        out_pwm, cs_n, clk_adc, out_sens            :   out std_logic
    );
end entity AvalonVerin;
      
architecture rtl of AvalonVerin is
    SIGNAL Raz_n            :   	STD_LOGIC;
    SIGNAL Sens             :   	STD_LOGIC;
    SIGNAL Enable           :   	STD_LOGIC;
    SIGNAL Butee_droite     :   	STD_LOGIC_VECTOR(11 DOWNTO 0);
    SIGNAL Butee_gauche     :   	STD_LOGIC_VECTOR(11 DOWNTO 0);
	SIGNAL angle_barre      :   	STD_LOGIC_VECTOR(11 DOWNTO 0);
    SIGNAL Duty             :   	STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL Freq             :   	STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL config           : 		STD_LOGIC_VECTOR(2 downto 0);
	SIGNAL fin_course_d		:		STD_LOGIC;
	SIGNAL fin_course_g 	: 		STD_LOGIC;
    
    Component Verin 
	PORT
	(
		Clk_50 :  IN  STD_LOGIC;
		Data_in :  IN  STD_LOGIC;
		Raz_n :  IN  STD_LOGIC;
		Sens :  IN  STD_LOGIC;
		Enable :  IN  STD_LOGIC;
		Butee_droite :  IN  STD_LOGIC_VECTOR(11 DOWNTO 0);
		Butee_gauche :  IN  STD_LOGIC_VECTOR(11 DOWNTO 0);
		Duty :  IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
		Freq :  IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
		out_pwm :  OUT  STD_LOGIC;
		out_sens :  OUT  STD_LOGIC;
		Chipselect :  OUT  STD_LOGIC;
		Clk_adc :  OUT  STD_LOGIC;
		out_g :  OUT  STD_LOGIC;
		out_d :  OUT  STD_LOGIC
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
			Freq <= (others => '0');
			Duty <= (others => '0');
			Butee_gauche <= (others => '0');
			Butee_droite <= (others => '0');
			config <= (others => '0');
	elsif clk'event and clk = '1' then
		if chipselect ='1' and write_n = '0' then
			case address is
			when "000" =>
			Freq (15 downto 0) <= (writedata (15 downto 0));
			when "001" =>
			Duty (15 downto 0) <= (writedata (15 downto 0));
			when "010" =>
			Butee_gauche (11 downto 0) <= (writedata (11 downto 0));
			when "011" =>
			Butee_droite (11 downto 0) <= (writedata (11 downto 0));
			when "100" =>
			config (2 downto 0)<= (writedata (2 downto 0));
			when others => 
			config <= (others => '0');
			end case;
		end if;
	end if;
end process ecriture;
--****************************************************************
Raz_n <= config (0);
Enable <= config (1);
Sens <= config (2);
--*******************************************************   
--	lecture des registres
--*******************************************************
lecture: process (address, Freq, Duty, Butee_gauche, Butee_droite,angle_barre, fin_course_g, fin_course_d, Enable, Sens)
	begin
		case address is
			when "000" =>
			readdata <= X"0000"&Freq ;
			when "001" =>
			readdata <=  X"0000"&Duty ;
			when "010" =>
			readdata <= X"00000"&Butee_gauche;
			when "011" =>
			readdata <= X"00000"&Butee_droite;
			when "100" =>
			readdata <= X"000000"&"000"&fin_course_g&fin_course_d&Sens&Enable&Raz_n;
			when "101" =>
			readdata(11 downto 0) <= angle_barre;
			readdata(31 downto 12) <= (others => '0'); 
			when others => 
			readdata <= (others => '0');
			end case;
end process lecture;

CmpVerin : Verin 
PORT map
(
    Clk_50          => clk,
    Data_in         => data_in,
    Raz_n           => Raz_n,
    Sens            => Sens,
    Enable          => Enable,
    Butee_droite    => Butee_droite,
    Butee_gauche    => Butee_gauche,
    Duty            => Duty,
    Freq            => Freq,
    out_pwm         => out_pwm,
    out_sens        => out_sens,
    Chipselect		=> cs_n,
    Clk_adc         => clk_adc,
	out_g			=> fin_course_g,
	out_d           => fin_course_d
);

end architecture rtl;