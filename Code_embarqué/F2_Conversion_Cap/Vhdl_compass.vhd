library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Vhdl_compass is
    port 
    (
        clk, chipselect, write_n, address, reset_n  : in std_logic;
        in_pwm_compas                               : in std_logic;
        writedata                                   : in std_logic_vector (31 downto 0);
        readdata                                    : out std_logic_vector (31 downto 0)
    );
end entity Vhdl_compass;

architecture rtl of Vhdl_compass is
    signal compas 							: std_logic_vector (8 downto 0);
    signal continu, start_stop, raz_n  : std_logic;
    signal config 							: std_logic_vector (2 downto 0);
    signal clk_10K							: std_logic;
    signal sig_duree, valeur_compas 	: std_logic_vector (8 downto 0);
	 TYPE State_type IS (etat0, etat1, etat2, etat3, etat4); 
	 signal State          					: State_Type;
	 signal clk_1Hz, val_compt, valid_data, fin_mesure, pwm_compas: std_logic;    

begin
--*********************************************************************	
-- Clock 10KHz (rapport cyclique=50%)
--*********************************************************************
process(clk,raz_n)
	variable count : integer range 0 to 2500;	
	BEGIN
		if raz_n= '0' then
			count:=0; clk_10K <= '0';
		elsif clk'event and clk='1' then
			count:= count +1;
			if count =  2499 then
				clk_10K <= not clk_10K;
				count:= 0;
			end if;
		end if;	
end process;
--*********************************************************************	
-- Synchro pwm
--*********************************************************************
synchro_pwm:	process(clk_10K,raz_n)	
	BEGIN
		if raz_n= '0' then
			pwm_compas <= '0';
		elsif clk_10K'event and clk_10K='0' then
				pwm_compas <= in_pwm_compas;
		end if;	
	end process synchro_pwm;
--*******************************************************************	
--Création du top seconde 
--*******************************************************************
top_1s:	process(clk_10K,raz_n)
    variable count : integer range 0 to 5000;	
	BEGIN
		if raz_n= '0' then
			count:= 0;
		elsif clk_10K'event and clk_10K='1' then
			count:= count +1;
			if count = 4999 then
				clk_1Hz <= not clk_1Hz;
				count:= 0;
			end if;
		end if;	
    end process top_1s;
    
raz_n <= config(0);
continu <= config(1);
start_stop <= config(2);
--********************************************************************
--MEF mesure compas
--********************************************************************
MEF_Compass: process(raz_n, clk)
begin
    if  Raz_n		=	'0' then 
        State           <= etat0;
        val_compt <= '0';
        valid_data<='0';
    elsif   (clk'event and clk ='1') then
        CASE State IS
            When etat0 =>
                if continu ='0' then 
                    if start_stop='1' and pwm_compas='0' then
                        State   <= etat1;
                        val_compt <= '1';
                    end if;
                else
                    if clk_1Hz = '1' and pwm_compas='0' then 
                        State   <= etat3;
                        val_compt <= '1';
                    end if;
                end if;

            When etat1 =>
                if fin_mesure='1' then 
                    State   <= etat2;
                    val_compt <= '0';
                    valid_data<='1';
                end if;

            When etat2 =>
                if start_stop='0' then 
                    State   <= etat0;
                    val_compt <= '0';
                    valid_data<='0';
                end if;

            When etat3 =>
                if fin_mesure='1' then 
                    State   <= etat4;
                    val_compt <= '0';
                    valid_data<='1';
                end if;

            When etat4 =>
                if clk_1Hz = '0' then 
                    State   <= etat0;
                    val_compt <= '0';
                    valid_data<='0';
                end if;

            When others => 
				State    <=  etat0;
				val_compt <= '0';
                valid_data<='0';
        end CASE;			
    end if;
end process MEF_Compass;
--*********************************************************************	
-- comptage durée état haut de pwm_compas
--*********************************************************************
duree_pwm:	process(clk_10K,raz_n)	
	BEGIN
		if raz_n= '0' then
           sig_duree	<=	(others => '0');

		elsif clk_10K'event and clk_10K ='1' then
			if val_compt ='1' then 
				if pwm_compas = '1' then
				    sig_duree <= sig_duree + 1;
				end if;
            else 
                sig_duree	<=	(others => '0');
			end if;
		end if;	
	end process duree_pwm;

--*********************************************************************	
--Bascule D
--*********************************************************************
memo_data:	process(pwm_compas, val_compt, raz_n)	
	BEGIN
		if raz_n= '0' then
		    valeur_compas	<=	(others => '0');
		elsif val_compt='0' then 
		    fin_mesure <= '0';	
		elsif pwm_compas'event and pwm_compas ='0' then
		    valeur_compas <= sig_duree;
		    fin_mesure <= '1';
		end if;	
	end process memo_data;

--*********************************************************************
--  interface avalon
--*******************************************************   
-- Ecriture registres
--*******************************************************  
registers: process (clk, reset_n)
begin
	if reset_n = '0' then
	config <= (others => '0');
	elsif clk'event and clk = '1' then
		if chipselect ='1' and write_n = '0' then
			if address = '0' then
			config <= (writedata (2 downto 0));
			end if;
		end if;
	end if;
end process registers;
--*******************************************************   
-- Lecture registres
--*******************************************************  
readdata <= X"0000000"&"0"&config when address = '0' else X"00000"&"00"&valid_data&valeur_compas ;

end architecture rtl;