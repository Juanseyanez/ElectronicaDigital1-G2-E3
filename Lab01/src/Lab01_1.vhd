-- LABORATORIO 01 ELECTRONICA ANALOGA - 20204-1
-- DESCRIPCION DE SUMADOR DE UN BIT
library IEEE;
 use ieee.std_logic_1164.all;
entity Lab01_1 is
	port
	(
		-- Input ports
		A, B, Ci	: in  std_logic;

		-- Output ports
		S1, Co	: out std_logic
	);
end Lab01_1;
architecture dataflow of Lab01_1 is
begin
	S1 <= (A xor B)xor Ci;
	Co <= ((A xor B) and Ci) or (A and B);
end dataflow;