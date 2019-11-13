library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity Div is
    port 
    (
        Clk_50M 	:   in  std_logic;
        ARaz_n  	:   in  std_logic;
        Rst_pulse	:	in	std_logic;
        Clk_1Hz 	:   out std_logic    
    );
end entity Div;

architecture rtl of Div is

signal s_clk_50M    :   std_logic_vector(25 downto  0);

begin

        process(Clk_50M,ARaz_n)
        begin

            if (ARaz_n = '0')	or	(Rst_pulse	=	'1')	then
                s_clk_50M   <=(others => '0');
                Clk_1Hz       <= '0'; 
            elsif   Clk_50M'event and Clk_50M = '1' then
                if s_clk_50M = 50000000 then 
                    s_clk_50M <= (others => '0');
                    Clk_1Hz <= '1';
                else
                    s_clk_50M <= s_clk_50M + 1;
                    Clk_1Hz <= '0';
                end if;

            end if;
        end process;
    
end architecture rtl;