-- Gestion_boutons_0.vhd

-- This file was auto-generated as part of a SOPC Builder generate operation.
-- If you edit it your changes will probably be lost.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Gestion_boutons_0 is
	port (
		clk        : in  std_logic                     := '0';             --          clock.clk
		chipselect : in  std_logic                     := '0';             -- avalon_slave_0.chipselect
		write_n    : in  std_logic                     := '0';             --               .write_n
		writedata  : in  std_logic_vector(31 downto 0) := (others => '0'); --               .writedata
		address    : in  std_logic                     := '0';             --               .address
		readdata   : out std_logic_vector(31 downto 0);                    --               .readdata
		reset_n    : in  std_logic                     := '0';             --          reset.reset_n
		BP_Babord  : in  std_logic                     := '0';             --    conduit_end.bp_babord
		BP_Tribord : in  std_logic                     := '0';             --               .bp_tribord
		BP_STBY    : in  std_logic                     := '0';             --               .bp_stby
		ledBabord  : out std_logic;                                        --               .ledbabord
		ledTribord : out std_logic;                                        --               .ledtribord
		ledSTBY    : out std_logic;                                        --               .ledstby
		out_bip    : out std_logic                                         --               .outbip
	);
end entity Gestion_boutons_0;

architecture rtl of Gestion_boutons_0 is
	component Gestion_boutons is
		port (
			clk        : in  std_logic                     := 'X';             -- clk
			chipselect : in  std_logic                     := 'X';             -- chipselect
			write_n    : in  std_logic                     := 'X';             -- write_n
			writedata  : in  std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			address    : in  std_logic                     := 'X';             -- address
			readdata   : out std_logic_vector(31 downto 0);                    -- readdata
			reset_n    : in  std_logic                     := 'X';             -- reset_n
			BP_Babord  : in  std_logic                     := 'X';             -- bp_babord
			BP_Tribord : in  std_logic                     := 'X';             -- bp_tribord
			BP_STBY    : in  std_logic                     := 'X';             -- bp_stby
			ledBabord  : out std_logic;                                        -- ledbabord
			ledTribord : out std_logic;                                        -- ledtribord
			ledSTBY    : out std_logic;                                        -- ledstby
			out_bip    : out std_logic                                         -- outbip
		);
	end component Gestion_boutons;

begin

	gestion_boutons_0 : component Gestion_boutons
		port map (
			clk        => clk,        --          clock.clk
			chipselect => chipselect, -- avalon_slave_0.chipselect
			write_n    => write_n,    --               .write_n
			writedata  => writedata,  --               .writedata
			address    => address,    --               .address
			readdata   => readdata,   --               .readdata
			reset_n    => reset_n,    --          reset.reset_n
			BP_Babord  => BP_Babord,  --    conduit_end.bp_babord
			BP_Tribord => BP_Tribord, --               .bp_tribord
			BP_STBY    => BP_STBY,    --               .bp_stby
			ledBabord  => ledBabord,  --               .ledbabord
			ledTribord => ledTribord, --               .ledtribord
			ledSTBY    => ledSTBY,    --               .ledstby
			out_bip    => out_bip     --               .outbip
		);

end architecture rtl; -- of Gestion_boutons_0
