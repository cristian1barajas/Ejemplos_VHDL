------------------------ Bloque librerias ---------------------------

library IEEE;
use ieee.STD_LOGIC_1164.all;
use ieee.STD_LOGIC_ARITH.all;

------------------------- Bloque Entidad ----------------------------

entity Contador is
	port(
		clk50mhz : in STD_LOGIC;
		display :  out STD_LOGIC_VECTOR(6 downto 0)
	);
end Contador;

---------------------- Bloque Arquitectura --------------------------

architecture Arq_Cont of Contador is

	constant max_count : INTEGER := 25000000;
	constant max_count_unidad : INTEGER := 9;
	signal count       : INTEGER range 0 to max_count;
	signal unidad : INTEGER range 0 to max_count_unidad;

begin

	genclock: process(clk50mhz, count, unidad)
	begin
		if rising_edge (clk50mhz) then
			if count < max_count then 
				count <= count+1;
			else
				unidad <= unidad+1;
				count <= 0;
				if unidad = 9 then
					unidad <= 0;
				end if;
			end if;
		end if;
	end process;
	
	Decodificador: process (unidad)
	begin
		case unidad is
       WHEN 0  =>    display<="1000000";
       WHEN 1  =>    display<="1111001";
       WHEN 2  =>    display<="0100100";
       WHEN 3  =>    display<="0110000";
		 WHEN 4  =>    display<="0011001";
       WHEN 5  =>    display<="0010010";
       WHEN 6  =>    display<="0000010";
       WHEN 7  =>    display<="1111000";
		 WHEN 8  =>    display<="0000000";
       WHEN 9  =>    display<="0010000";
     END CASE;
	end process;
	
end Arq_Cont;
