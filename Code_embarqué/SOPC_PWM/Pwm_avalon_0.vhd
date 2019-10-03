-- Pwm_avalon_0.vhd

-- This file was auto-generated as part of a SOPC Builder generate operation.
-- If you edit it your changes will probably be lost.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Pwm_avalon_0 is
	port (
		clk        : in  std_logic                     := '0';             --          clock.clk
		chipselect : in  std_logic                     := '0';             -- avalon_slave_0.chipselect
		write_n    : in  std_logic                     := '0';             --               .write_n
		address    : in  std_logic                     := '0';             --               .address
		writedata  : in  std_logic_vector(31 downto 0) := (others => '0'); --               .writedata
		readdata   : out std_logic_vector(31 downto 0);                    --               .readdata
		reset_n    : in  std_logic                     := '0';             --          reset.reset_n
		out_pwm    : out std_logic                                         --    conduit_end.export
	);
end entity Pwm_avalon_0;

architecture rtl of Pwm_avalon_0 is
	component Pwm_avalon is
		port (
			clk        : in  std_logic                     := 'X';             -- clk
			chipselect : in  std_logic                     := 'X';             -- chipselect
			write_n    : in  std_logic                     := 'X';             -- write_n
			address    : in  std_logic                     := 'X';             -- address
			writedata  : in  std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			readdata   : out std_logic_vector(31 downto 0);                    -- readdata
			reset_n    : in  std_logic                     := 'X';             -- reset_n
			out_pwm    : out std_logic                                         -- export
		);
	end component Pwm_avalon;

begin

	pwm_avalon_0 : component Pwm_avalon
		port map (
			clk        => clk,        --          clock.clk
			chipselect => chipselect, -- avalon_slave_0.chipselect
			write_n    => write_n,    --               .write_n
			address    => address,    --               .address
			writedata  => writedata,  --               .writedata
			readdata   => readdata,   --               .readdata
			reset_n    => reset_n,    --          reset.reset_n
			out_pwm    => out_pwm     --    conduit_end.export
		);

end architecture rtl; -- of Pwm_avalon_0
