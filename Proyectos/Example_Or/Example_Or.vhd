-------------------- Bloque librerias --------------------

library IEEE;
use ieee.std_logic_1164.all;

--------------------- Bloque entidad ---------------------

entity Example_Or is
	port (
		input_1	:	in STD_LOGIC;
	   input_2  :  in STD_LOGIC;
		output	:  out STD_LOGIC
	);
end Example_Or;

------------------ Bloque Arquitectura -------------------
		
architecture Arq_Or of Example_Or is
	signal or_gate	: STD_LOGIC;
	begin
		or_gate <= input_1 or input_2;
		output <= or_gate;
	end Arq_Or;