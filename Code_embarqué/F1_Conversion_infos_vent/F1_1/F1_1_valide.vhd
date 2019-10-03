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
-- CREATED		"Thu Oct 03 11:20:47 2019"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY F1_1_valide IS 
	PORT
	(
		Clk_50M :  IN  STD_LOGIC;
		ARaz_n :  IN  STD_LOGIC;
		Freq_anemometre :  IN  STD_LOGIC;
		Continu :  IN  STD_LOGIC;
		Start_Stop :  IN  STD_LOGIC;
		Data_valide :  OUT  STD_LOGIC;
		Data_anemometre :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END F1_1_valide;

ARCHITECTURE bdf_type OF F1_1_valide IS 

COMPONENT div
	PORT(Clk_50M : IN STD_LOGIC;
		 ARaz_n : IN STD_LOGIC;
		 Rst_pulse : IN STD_LOGIC;
		 Clk_1Hz : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT mef
	PORT(Clk : IN STD_LOGIC;
		 ARaz_n : IN STD_LOGIC;
		 Continu : IN STD_LOGIC;
		 R : OUT STD_LOGIC;
		 Rst_pulse : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT detect_fm
	PORT(Clk_50M : IN STD_LOGIC;
		 ARaz_n : IN STD_LOGIC;
		 In_freq_anemometre : IN STD_LOGIC;
		 In_freq_anemometre_M : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT cpt
	PORT(Clk_50M : IN STD_LOGIC;
		 Clk_1Hz : IN STD_LOGIC;
		 In_freq_anemometre : IN STD_LOGIC;
		 ARaz_n : IN STD_LOGIC;
		 R : IN STD_LOGIC;
		 Start_stop : IN STD_LOGIC;
		 Data_Valid : OUT STD_LOGIC;
		 Output : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT reg
	PORT(Clk : IN STD_LOGIC;
		 ARaz_n : IN STD_LOGIC;
		 D : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 Q : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_6 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_5 :  STD_LOGIC_VECTOR(7 DOWNTO 0);


BEGIN 



b2v_inst : div
PORT MAP(Clk_50M => Clk_50M,
		 ARaz_n => ARaz_n,
		 Rst_pulse => SYNTHESIZED_WIRE_0,
		 Clk_1Hz => SYNTHESIZED_WIRE_6);


b2v_inst1 : mef
PORT MAP(Clk => Clk_50M,
		 ARaz_n => ARaz_n,
		 Continu => Continu,
		 R => SYNTHESIZED_WIRE_3,
		 Rst_pulse => SYNTHESIZED_WIRE_0);


b2v_inst2 : detect_fm
PORT MAP(Clk_50M => Clk_50M,
		 ARaz_n => ARaz_n,
		 In_freq_anemometre => Freq_anemometre,
		 In_freq_anemometre_M => SYNTHESIZED_WIRE_2);


b2v_inst3 : cpt
PORT MAP(Clk_50M => Clk_50M,
		 Clk_1Hz => SYNTHESIZED_WIRE_6,
		 In_freq_anemometre => SYNTHESIZED_WIRE_2,
		 ARaz_n => ARaz_n,
		 R => SYNTHESIZED_WIRE_3,
		 Start_stop => Start_Stop,
		 Data_Valid => Data_valide,
		 Output => SYNTHESIZED_WIRE_5);


b2v_inst4 : reg
PORT MAP(Clk => SYNTHESIZED_WIRE_6,
		 ARaz_n => ARaz_n,
		 D => SYNTHESIZED_WIRE_5,
		 Q => Data_anemometre);


END bdf_type;