library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Mux is
    port 
    (
        A   :   in  std_logic_vector(7 downto 0);
        S   :   in  std_logic_vector(2 downto 0);
        Q   :   out std_logic 
    );
end entity Mux;

architecture rtl of Mux is
    
begin
    with    S   select
        Q   <=  A(0)    when    "000",
                A(1)    when    "001",
                A(2)    when    "010",
                A(3)    when    "011",
                A(4)    when    "100",
                A(5)    when    "101",
                A(6)    when    "110",
                A(7)    when    "111",
end architecture rtl;