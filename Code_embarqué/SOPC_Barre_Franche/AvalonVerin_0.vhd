-- AvalonVerin_0.vhd

-- This file was auto-generated as part of a SOPC Builder generate operation.
-- If you edit it your changes will probably be lost.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity AvalonVerin_0 is
	port (
		clk        : in  std_logic                     := '0';             --          clock.clk
		reset_n    : in  std_logic                     := '0';             --          reset.reset_n
		chipselect : in  std_logic                     := '0';             -- avalon_slave_0.chipselect
		write_n    : in  std_logic                     := '0';             --               .write_n
		address    : in  std_logic_vector(2 downto 0)  := (others => '0'); --               .address
		writedata  : in  std_logic_vector(31 downto 0) := (others => '0'); --               .writedata
		readdata   : out std_logic_vector(31 downto 0);                    --               .readdata
		cs_n       : out std_logic;                                        --    conduit_end.cs_n
		out_pwm    : out std_logic;                                        --               .out_pwm
		clk_adc    : out std_logic;                                        --               .clk_adc
		out_sens   : out std_logic;                                        --               .out_sens
		data_in    : in  std_logic                     := '0'              --               .data_in
	);
end entity AvalonVerin_0;

architecture rtl of AvalonVerin_0 is
	component AvalonVerin is
		port (
			clk        : in  std_logic                     := 'X';             -- clk
			reset_n    : in  std_logic                     := 'X';             -- reset_n
			chipselect : in  std_logic                     := 'X';             -- chipselect
			write_n    : in  std_logic                     := 'X';             -- write_n
			address    : in  std_logic_vector(2 downto 0)  := (others => 'X'); -- address
			writedata  : in  std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			readdata   : out std_logic_vector(31 downto 0);                    -- readdata
			cs_n       : out std_logic;                                        -- cs_n
			out_pwm    : out std_logic;                                        -- out_pwm
			clk_adc    : out std_logic;                                        -- clk_adc
			out_sens   : out std_logic;                                        -- out_sens
			data_in    : in  std_logic                     := 'X'              -- data_in
		);
	end component AvalonVerin;

begin

	avalonverin_0 : component AvalonVerin
		port map (
			clk        => clk,        --          clock.clk
			reset_n    => reset_n,    --          reset.reset_n
			chipselect => chipselect, -- avalon_slave_0.chipselect
			write_n    => write_n,    --               .write_n
			address    => address,    --               .address
			writedata  => writedata,  --               .writedata
			readdata   => readdata,   --               .readdata
			cs_n       => cs_n,       --    conduit_end.cs_n
			out_pwm    => out_pwm,    --               .out_pwm
			clk_adc    => clk_adc,    --               .clk_adc
			out_sens   => out_sens,   --               .out_sens
			data_in    => data_in     --               .data_in
		);

end architecture rtl; -- of AvalonVerin_0
