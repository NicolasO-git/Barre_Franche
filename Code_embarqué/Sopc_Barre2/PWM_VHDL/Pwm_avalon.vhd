library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity Pwm_avalon is
    port 
    (
        clk, chipselect, write_n, address, reset_n : in std_logic;
        writedata                                  : in std_logic_vector (31 downto 0); 
        readdata                                   : out std_logic_vector (31 downto 0); 
        out_pwm                                    : out std_logic
);
end entity;

ARCHITECTURE arch_test_pwm of Pwm_avalon IS 

signal freq : std_logic_vector (31 downto 0); 
signal duty : std_logic_vector (31 downto 0); 
signal counter : std_logic_vector (31 downto 0); 
signal pwm_on : std_logic;

BEGIN
    divide: process (clk, reset_n) 
    begin
        if reset_n = '0' then
            counter <= (others => '0');
        elsif clk'event and clk = '1' then
            if counter >= freq then counter <= (others => '0'); else
                counter <= counter + 1; 
            end if;
        end if;
end process divide;


    compare: process (clk, reset_n) 
    begin
        if reset_n = '0' then
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

--interface avalon

    registers: process (clk, reset_n)
    begin
        if reset_n = '0' then
            freq <= (others => '0');
            duty <= (others => '0');
        elsif clk'event and clk = '1' then
            if chipselect ='1' and write_n = '0' then 
                if address = '0' then
                    freq (31 downto 0) <= (writedata (31 downto 0)); 
                else
                    duty (31 downto 0) <= (writedata (31 downto 0)); 
                end if;
            end if; 
        end if;
    end process;

readdata <= (freq) when address = '0' else (duty); 

END arch_test_pwm ;