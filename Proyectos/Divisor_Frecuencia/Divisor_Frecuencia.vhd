-- Ejemplo basado del sitio:
-- https://www.digilogic.es/divisor-de-frecuencia-reloj-1hz-vhdl/

---------------------Bloque librerias ----------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

--------------------- Bloque Entidad -----------------------

entity Divisor_Frecuencia is
	port (
		clk50mhz : in STD_LOGIC;
		clk      : out STD_LOGIC
	);
end Divisor_Frecuencia;

------------------ Bloque Arquitectura ---------------------

architecture Arq_Div_Fre of Divisor_Frecuencia is

	constant max_count : INTEGER := 25000000;
	signal count       : INTEGER range 0 to max_count;
	signal clk_state   : STD_LOGIC := '0';
	
begin
	genclock: process(clk50mhz, clk_state, count)
	begin
		if rising_edge (clk50mhz) then
			if count < max_count then 
				count <= count+1;
			else
				clk_state <= not clk_state;
				count <= 0;
			end if;
		end if;
	end process;
	
	persecond: process (clk_state)
	begin
		clk <= clk_state;
	end process;
	
end Arq_Div_Fre;