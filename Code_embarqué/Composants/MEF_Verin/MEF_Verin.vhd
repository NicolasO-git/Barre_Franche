library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity MEF_Verin is
    port 
    (
        clk, Raz_n, Data_in		:   in std_logic;
        cs_n, clk_adc           :   out std_logic;
        angle_barre             :   out std_logic_vector(11 downto 0)
    );
end entity MEF_Verin;

architecture rtl of MEF_Verin is
    TYPE State_type IS (etat0, etat1, etat2, etat3, etat4);
    SIGNAL  s_clk_adc       :   std_logic;
    SIGNAL  fin             :   std_logic;
    SIGNAL  raz_compteur    :   std_logic;
    SIGNAL 	start_conv		:	std_logic;
    SIGNAL 	clk_1M			:	std_logic;
    SIGNAL  s_data          :  	std_logic_vector(11 downto 0);
    signal	compt_front 	: 	integer range 0 to 11;
    SIGNAL  State           :   State_Type;    		-- Création signal d'état MEF
begin

-- **********************************************************
--  Interface avec adc mcp3201
--***********************************************************
--  Machine à état pour piloter l'adc et mémoriser la donnée
--***********************************************************
MEF: process(clk, Raz_n)
begin
    if  Raz_n		=	'0' then 
        State           <= etat0;
        cs_n            <=  '1';
        s_clk_adc       <=  '0';
        raz_compteur    <=  '1';
        angle_barre     <=  X"000";
    elsif   (clk_1M'event and clk_1M ='1') then
        CASE State IS
            When etat0 =>
                if start_conv   =   '1' then
                    State   <=  etat1;
                    cs_n    <=  '0';
                    raz_compteur    <=  '0';
                end if;    
            When etat1 =>
               State        <=  etat2;
               s_clk_adc    <=  '1';
            When etat2 =>
               State        <=  etat3;
               s_clk_adc    <=  '0';
            When etat3 =>
                if fin  =   '1' then
                    State       <=  etat4;
                    s_clk_adc   <=  '0';
                    cs_n        <=  '1';
                    angle_barre <=  s_data;
                else
						  State <= etat2;
                    s_clk_adc   <=  '1';
                end if;
            When etat4 =>
                if start_conv   =   '0' then
                    State           <=  etat0;
                    cs_n            <=  '1';
                    s_clk_adc       <=  '0';
                    raz_compteur    <=  '1';
                end if;
            When others => 
				State    <=  etat0;
				s_clk_adc   <=  '0';
				cs_n        <=  '1';
        end CASE;			
    end if;
end process MEF;
--***********************************************************	 

--***********************************************************	
--  Génération du start_conv toutes les 100ms
--***********************************************************
gene_start_conv	:	process(clk_1M, Raz_n)
	variable count_conv : integer range 0 to 50000;	
	BEGIN
		if Raz_n    =   '0' then
			count_conv  :=  0;
		elsif clk_1M'event and clk_1M = '1' then
			count_conv  :=    count_conv    +   1;
			if count_conv   =   49999 then
				start_conv  <=  not start_conv;
				count_conv  :=  0;
			end if;
		end if;	
	end process gene_start_conv;
--***********************************************************

--***********************************************************	
--  Process de comptage des fronts d'horloge de clk_adc
--***********************************************************
Cpt_fronts: process (s_clk_adc, raz_compteur)
	begin
	if raz_compteur = '1' then
	    compt_front <=  0;
	elsif s_clk_adc'event and s_clk_adc =   '1' then
		if compt_front  =   14 then
		    compt_front <=  0;
		    fin         <= '1';
		else
		    compt_front <=  compt_front +1;
		    fin         <=  '0';
		end if;
    end if;
end process Cpt_fronts;
--***********************************************************

--***********************************************************
-- Registre à décalage
--***********************************************************
rec_dec: process (s_clk_adc)
	variable i: integer ;
	begin
	    if s_clk_adc'event and s_clk_adc    =   '1' then
			s_data(0)   <=  data_in;
		For i in 1 to 11 loop
		    s_data(i)   <=  s_data(i-1);
		end loop;
	End if ;
end process rec_dec;
--***********************************************************

--***********************************************************	
--  Génération 1MHz
--***********************************************************
gene_1M:	process(clk, Raz_n)
	variable count_gene_1M : integer range 0 to 25;	
	BEGIN
		if Raz_n = '0' then
			count_gene_1M       :=  0;
		elsif clk'event and clk =   '1' then
			count_gene_1M       :=  count_gene_1M +1;
			if count_gene_1M =  24 then
				clk_1M          <= not(clk_1M);
				count_gene_1M   :=  0;
			end if;
		end if;	
	end process gene_1M;
--***********************************************************	

--***********************************************************	
--  MàJ des sorties
--***********************************************************
    clk_adc <= s_clk_adc; 
end architecture; 
