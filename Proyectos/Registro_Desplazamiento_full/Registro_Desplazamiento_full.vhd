------------------- Bloque librerias --------------------

library IEEE;
use ieee.STD_LOGIC_1164.all;

-------------------- Bloque entidad ---------------------

entity Registro_Desplazamiento_full is
	port(
		clk	 : in STD_LOGIC;
		D	 	 : in STD_LOGIC;
		Q      : out STD_LOGIC;
		DA		 : inout STD_LOGIC;
		DB	    : inout STD_LOGIC;
		DC     : inout STD_LOGIC
	);
end Registro_Desplazamiento_full;

------------------ Bloque Arquitectura ------------------

architecture Arq_Reg of Registro_Desplazamiento_full is
begin
	process (clk)
	begin
		if falling_edge (clk) then
			DA <= D;
			DB <= DA;
			DC <= DB;
			Q  <= DC;
		end if;
	end process;
end Arq_Reg;	