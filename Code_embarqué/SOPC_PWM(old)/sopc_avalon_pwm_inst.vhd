  --Example instantiation for system 'sopc_avalon_pwm'
  sopc_avalon_pwm_inst : sopc_avalon_pwm
    port map(
      out_port_from_the_Leds_gpio => out_port_from_the_Leds_gpio,
      out_pwm_from_the_Pwm_avalon_0 => out_pwm_from_the_Pwm_avalon_0,
      clk_0 => clk_0,
      in_port_to_the_Bp_board => in_port_to_the_Bp_board,
      reset_n => reset_n
    );


