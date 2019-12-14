-- Vhdl_compass_0.vhd

-- This file was auto-generated as part of a SOPC Builder generate operation.
-- If you edit it your changes will probably be lost.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Vhdl_compass_0 is
	port (
		clk           : in  std_logic                     := '0';             --          clock.clk
		chipselect    : in  std_logic                     := '0';             -- avalon_slave_0.chipselect
		write_n       : in  std_logic                     := '0';             --               .write_n
		address       : in  std_logic                     := '0';             --               .address
		writedata     : in  std_logic_vector(31 downto 0) := (others => '0'); --               .writedata
		readdata      : out std_logic_vector(31 downto 0);                    --               .readdata
		reset_n       : in  std_logic                     := '0';             --          reset.reset_n
		in_pwm_compas : in  std_logic                     := '0'              --    conduit_end.in_compass
	);
end entity Vhdl_compass_0;

architecture rtl of Vhdl_compass_0 is
	component Vhdl_compass is
		port (
			clk           : in  std_logic                     := 'X';             -- clk
			chipselect    : in  std_logic                     := 'X';             -- chipselect
			write_n       : in  std_logic                     := 'X';             -- write_n
			address       : in  std_logic                     := 'X';             -- address
			writedata     : in  std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			readdata      : out std_logic_vector(31 downto 0);                    -- readdata
			reset_n       : in  std_logic                     := 'X';             -- reset_n
			in_pwm_compas : in  std_logic                     := 'X'              -- in_compass
		);
	end component Vhdl_compass;

begin

	vhdl_compass_0 : component Vhdl_compass
		port map (
			clk           => clk,           --          clock.clk
			chipselect    => chipselect,    -- avalon_slave_0.chipselect
			write_n       => write_n,       --               .write_n
			address       => address,       --               .address
			writedata     => writedata,     --               .writedata
			readdata      => readdata,      --               .readdata
			reset_n       => reset_n,       --          reset.reset_n
			in_pwm_compas => in_pwm_compas  --    conduit_end.in_compass
		);

end architecture rtl; -- of Vhdl_compass_0
