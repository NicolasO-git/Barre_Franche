library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity TranscodeurBCD is
    port (
        binaire     : in std_logic_vector(7 downto 0);
        centaine    : out std_logic_vector(3 downto 0);
        dizaine     : out std_logic_vector(3 downto 0);
        unite       : out std_logic_vector(3 downto 0)
    );

end entity TranscodeurBCD;

architecture rtl of TranscodeurBCD is

    begin

       process(binaire)
            variable registre : std_logic_vector(19 downto 0);
        begin
            registre := x"000" & binaire ;

        for i in 1 to 8 loop
            if registre(11 downto 8) > 4 then
                registre(11 downto 8) := registre(11 downto 8) + 3; --centaines
            end if;

            if registre(15 downto 12) > 4 then
                registre(15 downto 12) := registre(15 downto 12) + 3; --dizaines
            end if;
            
            if registre(19 downto 16) > 4 then
                registre(19 downto 16) := registre(19 downto 16) + 3; --unites
            end if;
            registre := registre (18 downto 0) & '0';
        end loop;

        centaine <= registre (19 downto 16);
        dizaine <= registre (15 downto 12);
        unite <= registre (11 downto 8);
    end process;
end architecture rtl;