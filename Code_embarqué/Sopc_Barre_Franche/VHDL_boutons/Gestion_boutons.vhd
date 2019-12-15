LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY Gestion_boutons IS
	PORT (
			clk, chipselect, write_n, reset_n: in std_logic;
			writedata : in std_logic_vector (31 downto 0);
			address : in std_logic;
			readdata : out std_logic_vector (31 downto 0);
			BP_Babord,BP_Tribord, BP_STBY  : in std_logic;  
			ledBabord, ledTribord,ledSTBY, out_bip : out std_logic		  
		  );
END Gestion_boutons  ;

ARCHITECTURE arch_avalon_gestion_bp OF Gestion_boutons IS
signal fin_tempo, val_tempo, val_bip, fin_bip, bip_simple, bip_double: std_logic;
signal codeFonction: std_logic_vector (3 downto 0);
signal clk_1Hz, bip, clk_50, clk_100, rst_n : std_logic;
signal compt_bip: integer range 0 to 200;
begin

--********************************************************************
--machine à état de gestion des bp
--********************************************************************
gestion_bp:process (rst_n, clk_100)
variable etat : integer range 0 to 13;
begin
	if rst_n ='0' then
	etat:= 0;
	codeFonction <="0000";
	elsif clk_100'event and clk_100='1' then
	case etat is
	when 0 =>
		if BP_Babord='0' then 
		etat:=1; codeFonction <="0001";
		end if;
		if BP_Tribord='0' then 
		etat:=2; codeFonction <="0010";
		end if;
		if BP_STBY='0' then 
		etat:=3; codeFonction <="0000"; 
		end if;
		ledSTBY <= clk_1Hz; ledBabord <= clk_50; ledTribord <= clk_50;
	when 1 =>
		if BP_Babord='1' then 
		etat:=0; codeFonction <="0000";
		end if;
		ledSTBY <= clk_1Hz; ledBabord <= clk_50; ledTribord <= clk_50;
	when 2 =>
		if BP_Tribord='1' then 
		etat:=0; codeFonction <="0000";
		end if;
		ledSTBY <= clk_1Hz; ledBabord <= clk_50; ledTribord <= clk_50;
	when 3 =>
		if BP_STBY='1' then 
		etat:=4; codeFonction <="0011";
		end if;
		ledSTBY <= clk_1Hz; ledBabord <= clk_50; ledTribord <= clk_50;
	when 4 =>
		if BP_STBY='0' then 
		etat:=5; codeFonction <="0000";
		end if;
		if BP_Babord='0' and BP_Tribord='1'then 
		etat:=6; codeFonction <="0011"; val_tempo <='1';
		end if;
		if BP_Tribord='0' and BP_Babord='1'then 
		etat:=9; codeFonction <="0011";val_tempo <='1';
		end if;
		ledSTBY <= '1'; ledBabord <= clk_50; ledTribord <= clk_50;
	when 5 =>
		if BP_STBY='1' then 
		etat:=0; codeFonction <="0000";
		end if;
		ledBabord <= clk_50; ledTribord <= clk_50;
	when 6 =>
		if BP_Babord='0' and fin_tempo='1' then 
		etat:=7; codeFonction <="0101";val_tempo <='0'; bip_double<='1';
		end if;
		if BP_Babord='1' and fin_tempo='0' then 
		etat:=8; codeFonction <="0100"; val_tempo <='0'; bip_simple<='1';
		end if;
		ledBabord <= clk_50; ledTribord <= clk_50;
	when 7 =>
		if fin_bip='1' then 
		etat:=13; codeFonction <="0101"; bip_double<='0';
		end if;
		ledBabord <= bip ; ledTribord <= clk_50;
	when 8 =>
		if fin_bip='1' then 
		etat:=4; codeFonction <="0011";bip_simple<='0'; 
		end if;
		ledBabord <= bip ; ledTribord <= clk_50;
	when 9 =>
		if BP_Tribord='0' and fin_tempo='1' then 
		etat:=10; codeFonction <="0110"; val_tempo <='0'; bip_double<='1';
		end if;
		if BP_Tribord='1' and fin_tempo='0' then 
		etat:=11; codeFonction <="0111"; val_tempo <='0'; bip_simple<='1';
		end if;
		ledBabord <= clk_50; ledTribord <= clk_50;
	when 10 =>
		if fin_bip='1' then 
		etat:=12; codeFonction <="0110"; bip_double<='0';
		end if;
		ledBabord <= clk_50; ledTribord <= bip;
	when 11 =>
		if fin_bip='1' then 
		etat:=4; codeFonction <="0011"; bip_simple<='0';
		end if;
		ledBabord <= clk_50; ledTribord <= bip;
	when 12 =>
		if BP_Tribord='1'  then 
		etat:=4; codeFonction <="0011"; bip_double<='0';
		end if;
		ledBabord <= clk_50; ledTribord <= clk_50;
	when 13 =>
		if BP_Babord='1'  then 
		etat:=4; codeFonction <="0011"; bip_double<='0';
		end if;
		ledBabord <= clk_50; ledTribord <= clk_50;
	end case;
	end if;
	end process gestion_bp;
--*********************************************************************
	
	
--*********************************************************************
-- génération de la temporisation de 2s
--*********************************************************************
gen_tempo:process (rst_n, clk_100)
variable duree_tempo : integer range 0 to 200;
begin
	if rst_n ='0' then
	duree_tempo:= 0; fin_tempo <='0';
	elsif clk_100'event and clk_100='1' then
		if val_tempo ='1' then
		duree_tempo:=duree_tempo+1;
			if duree_tempo=200 then duree_tempo:=0;
			fin_tempo <='1';
			end if;
		else duree_tempo:=0;	fin_tempo <='0';
		end if;
	end if;
end process gen_tempo;
--*********************************************************************


--*********************************************************************	
-- génération 100Hz
--*********************************************************************
gene_100:	process(clk,rst_n)
	variable count : integer range 0 to 250000;	
	BEGIN
		if rst_n= '0' then
			count:=0; clk_100 <= '0';
		elsif clk'event and clk='1' then
			count:= count +1;
			if count =  249999 then
				clk_100 <= not clk_100;
				count:= 0;
			end if;
		end if;	
	end process gene_100;
--*********************************************************************


--*******************************************************************	
--génération  1Hz et 50 Hz
--*******************************************************************
gene_1hz:	process (clk_100,rst_n)
    variable count : integer range 0 to 50;	
	BEGIN
		if rst_n= '0' then
			count:= 0; clk_50 <= '0';
		elsif clk_100'event and clk_100='1' then
			clk_50 <= not clk_50;
			count:= count +1;
			if count = 49 then
				clk_1Hz <= not(clk_1Hz);
				count:= 0;
			end if;
		end if;	
	end process gene_1hz;
--*********************************************************************


--*********************************************************************
-- génération du bip et double bip
--*********************************************************************
double_bip:process (rst_n, bip_simple,bip_double, clk_100)
variable etat_bip : integer range 0 to 2;
begin
	if rst_n ='0' or (bip_simple='0' and bip_double='0') then
	etat_bip:= 0;
	compt_bip <= 0; 
	fin_bip <='0';
	bip<='0';
	elsif clk_100'event and clk_100='1' then
	case etat_bip is
	when 0 =>
		if bip_simple='1' or bip_double='1' then 
		etat_bip:=1;
		end if;
	when 1 =>
		compt_bip<=compt_bip+1;
		if bip_simple='1' then
			if compt_bip >=30 then compt_bip<=0; fin_bip <='1';
			etat_bip:=2; bip <='0';
			end if;
		end if;
		if bip_double='1' then
			if compt_bip >=90 then compt_bip<=0; fin_bip <='1';
			etat_bip:=2; bip <='0';
			end if;
		end if;
		if (compt_bip >= 1 and compt_bip <= 30) or (compt_bip >= 60 and compt_bip <= 90) then
		bip <='1';
		else bip<='0';
		end if;
	when 2 =>
		if bip_simple='0' and bip_double='0' then 
		etat_bip:=0;
		end if;
	end case;
	end if;
end process double_bip;
--********************************************************************

-- 				interface bus avalon
--******************************************************
-- écriture registre rst_n
--*******************************************************
ecriture: process (clk, reset_n)
	begin
	if reset_n = '0' then
	rst_n <=  '0';
	elsif clk'event and clk = '1' then
		if chipselect ='1' and write_n = '0' then
			if address ='0' then
			rst_n <=  writedata(0);
			end if;
		end if;
	end if;
end process ecriture;
--****************************************************************

--*****************************************************************
--	lecture des registres
--*****************************************************************
lecture: process (address)
	begin
		case address is
			when '0' =>
			readdata(0) <= rst_n;
			when '1' =>
			readdata(3 downto 0) <= codeFonction  ;
			end case;
end process lecture;
--**********************************************************************
--00000000000000000000000000000000000000000000000000000000000000000000000

--********************************************************************
-- mise à jour des sorties
--********************************************************************
out_bip <= bip;		
end arch_avalon_gestion_bp;		