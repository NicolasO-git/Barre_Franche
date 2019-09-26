  --Example instantiation for system 'config_sopc'
  config_sopc_inst : config_sopc
    port map(
      out_port_from_the_Leds => out_port_from_the_Leds,
      clk_0 => clk_0,
      in_port_to_the_Boutons => in_port_to_the_Boutons,
      reset_n => reset_n
    );


