library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--ENTITY
entity Cpt is
   PORT
	(   
        Clk_50M                         : in std_logic;
 	    Clk_1Hz    						: in std_logic;
 	    In_freq_anemometre				: in std_logic;
 	    ARaz_n							: in std_logic;
 	    Output							: out std_logic_vector(7 downto 0)
 	 );
 	 
end Cpt;

--ARCHITECTURE
architecture moncompteur of Cpt is

    signal Temp             :   std_logic_vector(7 downto 0);

begin

        process(Clk_1Hz,In_freq_anemometre,ARaz_n) 
        begin
    
		    if ARaz_n    =	'1' then
                Temp    <=  "00000000";

		    elsif(Clk_1Hz'event and Clk_1Hz = '1') then
                if	(In_freq_anemometre = '1') then
				    Temp    <=  Temp + 1;
                elsif Temp  >   "11111111" then
                    Temp    <=  "00000000";
			    end if;
		    end if;
		
   end process;

Output <= Temp;

end moncompteur;
