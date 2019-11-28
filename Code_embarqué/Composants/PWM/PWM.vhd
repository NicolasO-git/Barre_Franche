library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;
entity PWM is
port (
clk		:	in std_logic;
Raz_n		:	in std_logic;
freq 		: 	in std_logic_vector (15 downto 0); 
duty 		: 	in std_logic_vector (15 downto 0); 
out_pwm	: 	out std_logic
);
end entity;

ARCHITECTURE arch_pwm of PWM IS
-- signaux relatifs au circuit gestion PWM
	signal counter 	:	std_logic_vector (15 downto 0);
	signal pwm_on		:	std_logic;
BEGIN

divide: process (clk, Raz_n) 
    begin
        if Raz_n = '0' then
            counter <= (others => '0');
        elsif clk'event and clk = '1' then
            if counter >= freq then counter <= (others => '0'); else
                counter <= counter + 1; 
            end if;
        end if;
end process divide;

compare: process (clk, Raz_n) 
    begin
        if Raz_n = '0' then
            pwm_on <= '1';
        elsif clk'event and clk = '1' then
            if counter >= duty then
                pwm_on <= '0';
            elsif counter = 0 then
                pwm_on <= '1';
            end if; 
        end if;
end process compare; 
out_pwm <= pwm_on;

end arch_PWM;
