--ESCUELA COLOMBIANA DE INGENIERIA
--ING: JAVIER SOTO
--Decodificador de teclado, (parecido a un 74922)
--Cuando el usuario presiona una tecla, la salida llamada pulso se pone en 1 logico,
--hasta que el usuario suelte la tecla.
--El codigo binario de la tecla sale por el puerto llamado dato un instante despues
--de presionar la tecla.
--La distribucion de filas y columnas es la siguiente:
-------- -----------------
--fila 0 | 0 | 1 | 2 | 3 |
-------- -----------------
--fila 1 | 4 | 5 | 6 | 7 |
-------- -----------------
--fila 2 | 8 | 9 | A | B |
-------- -----------------
--fila 3 | C | D | E | F |
-------- -----------------
--Columnas 3 2 1 0
--
--De esta forma si presiono la tecla B, se producira un corto entre la
--fila 2 y la columna 0 en el teclado. 
--Caracteristicas especiales: el decodificador necesita de por lo menos 4 pulsos de 
--reloj, un ciclo completo, para detectar que dejaron de presionar la tecla
--DESCRIPCION DE LOS PUERTOS:
--columnas:entrada de las columnas del teclado matricial
--filas:salida que se conecta a las filas del teclado matricial
--ck: oscilador para hacer la decodificacion, su frecuancia puede ser 1000 Hz
--dato: salida binaria que indica el código de la tecla que presionó.
--pulso: indica cuando el usuario tiene una tecla presionada.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity Teclado_Matricial is
Port ( columnas : in std_logic_vector(3 downto 0);
       ck : in std_logic;
       filas : out std_logic_vector(3 downto 0);
       dato : out std_logic_vector(3 downto 0);
       pulso : out std_logic);
end Teclado_Matricial;
architecture Behavioral of Teclado_Matricial is
--declaraciópn de señales temporales
--cont: se utiliza para generar la secuencia 1, 2, 4, 8.
--dec_filas: decodificador de 2x4.
--dec_dato: circuito combinacional que muestra la tecla presionada
--c3, c2, c1, c0: flip flops que indican si una columna cn fue presionada
--pulsoT: señal temporal para el pulso de salida.
signal cont: std_logic_vector(1 downto 0); 
signal dec_filas: std_logic_vector(3 downto 0);
signal dec_dato: std_logic_vector(3 downto 0);
signal c3, c2, c1, c0: std_logic;
signal pulsoT: std_logic;
begin
--Proceso para el contador cont.
Process(ck)
begin
     if (ck'event and ck='1') then
         cont<=cont+1;
     end if;
end process;
--proceso para generar el pulso que indica que se presiona una tecla
Process(ck)
begin
     if (ck'event and ck='1') then
          if (columnas="1000") then
               c3<='1';
               pulsoT <= '1';
          elsif(columnas="0100") then
               c2<='1';
               pulsoT <= '1';
          elsif(columnas="0010") then
               c1<='1';
               pulsoT <= '1';
          elsif (columnas="0001") then
               c0<='1';
               pulsoT <= '1';
          elsif(cont = "11" and(c3='1' or c2='1' or c1='1' or c0='1'))then
               c0<='0'; c1<='0'; c2<='0'; c3<='0';
          elsif(cont = "11" and c3='0' and c2='0' and c1='0' and c0='0')then
               pulsoT <= '0';
          end if;
     end if;
end process;
--proceso para mostrar el dato por el puerto
process(ck)
begin
     if(ck'event and ck='0')then
          if (columnas/="0000" and(c0='1' or c1='1' or c2='1' or c3='1'))          then
               dato<=dec_dato;
         end if;
     end if;
end process;
--genera una secuencia de salida para las filas, utilizando el contador          cont
dec_filas <= "0001" when cont="00" else
         "0010" when cont="01" else
         "0100" when cont="10" else
         "1000" when cont="11" else
         "0000";
filas<= dec_filas;
--decodifica la tecla que estan presionando
--depende del dato que sale por filas y la entrada columnas
dec_dato <= "0000" when dec_filas="0001" and columnas="1000"          else
         "0001" when dec_filas="0001" and columnas="0100"          else
         "0010" when dec_filas="0001" and columnas="0010"          else
         "0011" when dec_filas="0001" and columnas="0001"          else
         "0100" when dec_filas="0010" and columnas="1000"          else
         "0101" when dec_filas="0010" and columnas="0100"          else
         "0110" when dec_filas="0010" and columnas="0010"          else
         "0111" when dec_filas="0010" and columnas="0001"          else
         "1000" when dec_filas="0100" and columnas="1000"          else
         "1001" when dec_filas="0100" and columnas="0100"          else
         "1010" when dec_filas="0100" and columnas="0010"          else
         "1011" when dec_filas="0100" and columnas="0001"          else
         "1100" when dec_filas="1000" and columnas="1000"          else
         "1101" when dec_filas="1000" and columnas="0100"          else
         "1110" when dec_filas="1000" and columnas="0010"          else
         "1111" when dec_filas="1000" and columnas="0001"          else
         "0000";
pulso <= pulsoT;
end Behavioral;
