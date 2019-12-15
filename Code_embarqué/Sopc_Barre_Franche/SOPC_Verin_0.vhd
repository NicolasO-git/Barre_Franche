-- SOPC_Verin_0.vhd

-- This file was auto-generated as part of a SOPC Builder generate operation.
-- If you edit it your changes will probably be lost.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity SOPC_Verin_0 is
	port (
		clk        : in  std_logic                     := '0';             --          clock.clk
		chipselect : in  std_logic                     := '0';             -- avalon_slave_0.chipselect
		write_n    : in  std_logic                     := '0';             --               .write_n
		writedata  : in  std_logic_vector(31 downto 0) := (others => '0'); --               .writedata
		address    : in  std_logic_vector(2 downto 0)  := (others => '0'); --               .address
		readdata   : out std_logic_vector(31 downto 0);                    --               .readdata
		reset_n    : in  std_logic                     := '0';             --          reset.reset_n
		data_in    : in  std_logic                     := '0';             --    conduit_end.data_in
		out_pwm    : out std_logic;                                        --               .out_pwm
		cs_n       : out std_logic;                                        --               .cs_n
		clk_adc    : out std_logic;                                        --               .clk_adc
		out_sens   : out std_logic                                         --               .out_sens
	);
end entity SOPC_Verin_0;

architecture rtl of SOPC_Verin_0 is
	component SOPC_Verin is
		port (
			clk        : in  std_logic                     := 'X';             -- clk
			chipselect : in  std_logic                     := 'X';             -- chipselect
			write_n    : in  std_logic                     := 'X';             -- write_n
			writedata  : in  std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			address    : in  std_logic_vector(2 downto 0)  := (others => 'X'); -- address
			readdata   : out std_logic_vector(31 downto 0);                    -- readdata
			reset_n    : in  std_logic                     := 'X';             -- reset_n
			data_in    : in  std_logic                     := 'X';             -- data_in
			out_pwm    : out std_logic;                                        -- out_pwm
			cs_n       : out std_logic;                                        -- cs_n
			clk_adc    : out std_logic;                                        -- clk_adc
			out_sens   : out std_logic                                         -- out_sens
		);
	end component SOPC_Verin;

begin

	sopc_verin_0 : component SOPC_Verin
		port map (
			clk        => clk,        --          clock.clk
			chipselect => chipselect, -- avalon_slave_0.chipselect
			write_n    => write_n,    --               .write_n
			writedata  => writedata,  --               .writedata
			address    => address,    --               .address
			readdata   => readdata,   --               .readdata
			reset_n    => reset_n,    --          reset.reset_n
			data_in    => data_in,    --    conduit_end.data_in
			out_pwm    => out_pwm,    --               .out_pwm
			cs_n       => cs_n,       --               .cs_n
			clk_adc    => clk_adc,    --               .clk_adc
			out_sens   => out_sens    --               .out_sens
		);

end architecture rtl; -- of SOPC_Verin_0
