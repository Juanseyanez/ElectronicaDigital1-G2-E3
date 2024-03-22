
-- TEST BENCH
library IEEE;
 use ieee.std_logic_1164.all;
 
 entity testbench is
 end entity;
 
 architecture pr of testbench is
 component Lab01_1 is 
 port
	(
		-- Input ports
		A, B, Ci	: in  std_logic;

		-- Output ports
		S1, Co	: out std_logic
	);
end component;

signal A,B,Ci: std_logic :='0';
signal S1, Co: std_logic :='0';

begin

	comp: Lab01_1 port map (A, B, Ci, S1, Co);
	A <= '0' after 10 ns, '1' after 20 ns, '0' after 30 ns, '1' after 40 ns, '0' after 50 ns, '1' after 60 ns, '0' after 70 ns, '1' after 80 ns; 
	B <= '0' after 10 ns, '0' after 20 ns, '1' after 30 ns, '1' after 40 ns, '0' after 50 ns, '0' after 60 ns, '1' after 70 ns, '1' after 80 ns;
	Ci <= '0' after 10 ns, '0' after 20 ns, '0' after 30 ns, '0' after 40 ns, '1' after 50 ns, '1' after 60 ns,'1' after 70 ns, '1' after 80 ns;
	
end architecture;
