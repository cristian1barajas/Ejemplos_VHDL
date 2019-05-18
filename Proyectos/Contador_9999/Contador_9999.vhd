------------------------ Bloque librerias ---------------------------

library IEEE;
use ieee.STD_LOGIC_1164.all;
use ieee.STD_LOGIC_ARITH.all;

------------------------- Bloque Entidad ----------------------------

entity Contador_9999 is
	port(
		clk50mhz : in STD_LOGIC;
		display_unidades :  out STD_LOGIC_VECTOR(6 downto 0);
		display_decenas  :  out STD_LOGIC_VECTOR(6 downto 0);
		display_centenas :  out STD_LOGIC_VECTOR(6 downto 0);
		display_millares :  out STD_LOGIC_VECTOR(6 downto 0)
	);
end Contador_9999;

---------------------- Bloque Arquitectura --------------------------

architecture Arq_Cont of Contador_9999 is

	constant max_count : INTEGER := 100000;
	signal count       : INTEGER range 0 to max_count;
	signal unidad : INTEGER range 0 to 9;
	signal decena : INTEGER range 0 to 9;
	signal centena : INTEGER range 0 to 9;
	signal millar : INTEGER range 0 to 9;

begin

	genclock: process(clk50mhz, count)
	begin
		if rising_edge (clk50mhz) then
			if count < max_count then 
				count <= count+1;
			else 
				unidad <= unidad+1;
				count <= 0;
				if unidad = 9 then
					decena <= decena+1;
					unidad <= 0;
					if decena = 9 then 
						centena <= centena+1;
						decena <= 0;
						if centena = 9 then
							millar <= millar+1;
							centena <= 0;
							if millar = 9 then
								millar <= 0;
							end if;
						end if;
					end if;
				end if;
			end if;
		end if;
	end process;
	
	Unidades: process (unidad)
	begin
		case unidad is
       WHEN 0  =>    display_unidades<="1000000";
       WHEN 1  =>    display_unidades<="1111001";
       WHEN 2  =>    display_unidades<="0100100";
       WHEN 3  =>    display_unidades<="0110000";
		 WHEN 4  =>    display_unidades<="0011001";
       WHEN 5  =>    display_unidades<="0010010";
       WHEN 6  =>    display_unidades<="0000010";
       WHEN 7  =>    display_unidades<="1111000";
		 WHEN 8  =>    display_unidades<="0000000";
       WHEN 9  =>    display_unidades<="0010000";
     END CASE;
	end process;
	
	Decenas: process (decena)
	begin
		case decena is
       WHEN 0  =>    display_decenas<="1000000";
       WHEN 1  =>    display_decenas<="1111001";
       WHEN 2  =>    display_decenas<="0100100";
       WHEN 3  =>    display_decenas<="0110000";
		 WHEN 4  =>    display_decenas<="0011001";
       WHEN 5  =>    display_decenas<="0010010";
       WHEN 6  =>    display_decenas<="0000010";
       WHEN 7  =>    display_decenas<="1111000";
		 WHEN 8  =>    display_decenas<="0000000";
       WHEN 9  =>    display_decenas<="0010000";
     END CASE;
	end process;
	
	Centenas: process (centena)
	begin
		case centena is
       WHEN 0  =>    display_centenas<="1000000";
       WHEN 1  =>    display_centenas<="1111001";
       WHEN 2  =>    display_centenas<="0100100";
       WHEN 3  =>    display_centenas<="0110000";
		 WHEN 4  =>    display_centenas<="0011001";
       WHEN 5  =>    display_centenas<="0010010";
       WHEN 6  =>    display_centenas<="0000010";
       WHEN 7  =>    display_centenas<="1111000";
		 WHEN 8  =>    display_centenas<="0000000";
       WHEN 9  =>    display_centenas<="0010000";
     END CASE;
	end process;
	
	Millares: process (millar)
	begin
		case millar is
       WHEN 0  =>    display_millares<="1000000";
       WHEN 1  =>    display_millares<="1111001";
       WHEN 2  =>    display_millares<="0100100";
       WHEN 3  =>    display_millares<="0110000";
		 WHEN 4  =>    display_millares<="0011001";
       WHEN 5  =>    display_millares<="0010010";
       WHEN 6  =>    display_millares<="0000010";
       WHEN 7  =>    display_millares<="1111000";
		 WHEN 8  =>    display_millares<="0000000";
       WHEN 9  =>    display_millares<="0010000";
     END CASE;
	end process;
	
end Arq_Cont;