-- LABORATORIO 01 ELECTRONICA ANALOGA - 20204-1
-- DESCRIPCION DE COMPUERTAS LOGICAS NOT, AND, OR Y XOR
library IEEE;
 use ieee.std_logic_1164.all;
entity Lab01 is
	port
	(
		-- Input ports
		A, B	: in  std_logic;

		-- Output ports
		Snot, Sand, Sor, Sxor	: out std_logic
	);
end Lab01;
architecture dataflow of Lab01 is
begin
	Snot <= not A;
	Sand <= A and B;
	Sor <= A or B;
	Sxor <= A xor B;
end dataflow;