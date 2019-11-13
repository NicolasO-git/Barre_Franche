	component unsaved is
		port (
			clk_clk                   : in std_logic := 'X'; -- clk
			reset_reset_n             : in std_logic := 'X'; -- reset_n
			entree_anemo_vitesse_vent : in std_logic := 'X'  -- vitesse_vent
		);
	end component unsaved;

	u0 : component unsaved
		port map (
			clk_clk                   => CONNECTED_TO_clk_clk,                   --          clk.clk
			reset_reset_n             => CONNECTED_TO_reset_reset_n,             --        reset.reset_n
			entree_anemo_vitesse_vent => CONNECTED_TO_entree_anemo_vitesse_vent  -- entree_anemo.vitesse_vent
		);

