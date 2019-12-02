-- Copyright (C) 1991-2011 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- PROGRAM		"Quartus II"
-- VERSION		"Version 11.0 Build 208 07/03/2011 Service Pack 1 SJ Web Edition"
-- CREATED		"Mon Dec 02 09:37:29 2019"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY Verin IS 
	PORT
	(
		Clk_50 :  IN  STD_LOGIC;
		Data_in :  IN  STD_LOGIC;
		Raz_n :  IN  STD_LOGIC;
		Sens :  IN  STD_LOGIC;
		Enable :  IN  STD_LOGIC;
		Butee_droite :  IN  STD_LOGIC_VECTOR(11 DOWNTO 0);
		Butee_gauche :  IN  STD_LOGIC_VECTOR(11 DOWNTO 0);
		Duty :  IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
		Freq :  IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
		out_pwm :  OUT  STD_LOGIC;
		out_sens :  OUT  STD_LOGIC;
		Chipselect :  OUT  STD_LOGIC;
		Clk_adc :  OUT  STD_LOGIC
	);
END Verin;

ARCHITECTURE bdf_type OF Verin IS 

COMPONENT gestion_butee
	PORT(pwm_on : IN STD_LOGIC;
		 sens : IN STD_LOGIC;
		 enable : IN STD_LOGIC;
		 angle_barre : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 butee_d : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 butee_g : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 out_pwm : OUT STD_LOGIC;
		 out_sens : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT pwm
	PORT(clk : IN STD_LOGIC;
		 Raz_n : IN STD_LOGIC;
		 duty : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 freq : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 out_pwm : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT mef_verin
	PORT(clk : IN STD_LOGIC;
		 Raz_n : IN STD_LOGIC;
		 Data_in : IN STD_LOGIC;
		 cs_n : OUT STD_LOGIC;
		 clk_adc : OUT STD_LOGIC;
		 angle_barre : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC_VECTOR(11 DOWNTO 0);


BEGIN 



b2v_inst : gestion_butee
PORT MAP(pwm_on => SYNTHESIZED_WIRE_0,
		 sens => Sens,
		 enable => Enable,
		 angle_barre => SYNTHESIZED_WIRE_1,
		 butee_d => Butee_droite,
		 butee_g => Butee_gauche,
		 out_pwm => out_pwm,
		 out_sens => out_sens);


b2v_inst2 : pwm
PORT MAP(clk => Clk_50,
		 Raz_n => Raz_n,
		 duty => Duty,
		 freq => Freq,
		 out_pwm => SYNTHESIZED_WIRE_0);


b2v_inst3 : mef_verin
PORT MAP(clk => Clk_50,
		 Raz_n => Raz_n,
		 Data_in => Data_in,
		 cs_n => Chipselect,
		 clk_adc => Clk_adc,
		 angle_barre => SYNTHESIZED_WIRE_1);


END bdf_type;