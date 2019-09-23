library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MEF is
    port 
    (
        Clk     	:   in  std_logic;
        ARaz_n  	:   in  std_logic;
        Continu     :   in  std_logic;
        R  			:   out std_logic;
        Rst_pulse	:	out std_logic
  
    );
end entity MEF;

architecture rtl of MEF is
	TYPE State_type IS (etat0, etat1);  -- Define the states
	SIGNAL State : State_Type;    -- Create a signal that uses 

begin
	--t
    process(Clk, ARaz_n)
        begin
			if Araz_n	=	'0' then 
				State <= etat0;
			elsif (Clk'event and Clk = '1') then
				CASE State IS
					When etat0 =>
						if Continu = '1' then
							State <= etat1;
							R <= '1';
						end if;
						
					When etat1 =>
						if Continu ='0' then
							State <= etat0;
							R <= '0';
						end if;
					WHEN others =>
						State <= etat0;
				 end CASE;			
			end if;
    end process; 
    Rst_pulse	<=	'1'	when state = etat0 and Continu = '1' 	else
					'1' when state = etat1 and Continu = '0'	else
					'0';
end architecture rtl;