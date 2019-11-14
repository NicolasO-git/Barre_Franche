-- AvalonAnemo_0.vhd

-- This file was auto-generated as part of a SOPC Builder generate operation.
-- If you edit it your changes will probably be lost.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity AvalonAnemo_0 is
	port (
		clk                : in  std_logic                     := '0';             --          clock.clk
		reset_n            : in  std_logic                     := '0';             --          reset.reset_n
		chipselect         : in  std_logic                     := '0';             -- avalon_slave_0.chipselect
		write_n            : in  std_logic                     := '0';             --               .write_n
		address            : in  std_logic                     := '0';             --               .address
		writedata          : in  std_logic_vector(31 downto 0) := (others => '0'); --               .writedata
		readdata           : out std_logic_vector(31 downto 0);                    --               .readdata
		in_freq_anemometre : in  std_logic                     := '0'              --    conduit_end.export
	);
end entity AvalonAnemo_0;

architecture rtl of AvalonAnemo_0 is
	component AvalonAnemo is
		port (
			clk                : in  std_logic                     := 'X';             -- clk
			reset_n            : in  std_logic                     := 'X';             -- reset_n
			chipselect         : in  std_logic                     := 'X';             -- chipselect
			write_n            : in  std_logic                     := 'X';             -- write_n
			address            : in  std_logic                     := 'X';             -- address
			writedata          : in  std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			readdata           : out std_logic_vector(31 downto 0);                    -- readdata
			in_freq_anemometre : in  std_logic                     := 'X'              -- export
		);
	end component AvalonAnemo;

begin

	avalonanemo_0 : component AvalonAnemo
		port map (
			clk                => clk,                --          clock.clk
			reset_n            => reset_n,            --          reset.reset_n
			chipselect         => chipselect,         -- avalon_slave_0.chipselect
			write_n            => write_n,            --               .write_n
			address            => address,            --               .address
			writedata          => writedata,          --               .writedata
			readdata           => readdata,           --               .readdata
			in_freq_anemometre => in_freq_anemometre  --    conduit_end.export
		);

end architecture rtl; -- of AvalonAnemo_0
