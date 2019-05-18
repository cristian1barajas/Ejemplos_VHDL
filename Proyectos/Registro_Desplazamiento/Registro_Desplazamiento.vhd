------------------- Bloque librerias --------------------

library IEEE;
use ieee.STD_LOGIC_1164.all;

-------------------- Bloque entidad ---------------------

entity Registro_Desplazamiento is
	port(
		clk	 : in STD_LOGIC;
		input	 : in STD_LOGIC;
		output : out STD_LOGIC
	);
end Registro_Desplazamiento;

------------------ Bloque Arquitectura ------------------

architecture Arq_Reg of Registro_Desplazamiento is
begin
	process (clk)
	begin
		if falling_edge (clk) then
			output <= input;
		end if;
	end process;
end Arq_Reg;	