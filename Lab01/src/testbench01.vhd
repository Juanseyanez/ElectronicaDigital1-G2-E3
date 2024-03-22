-- TEST BENCH
library IEEE;
 use ieee.std_logic_1164.all;
 
 entity testbench is
 end entity;
 
 architecture pr of testbench is
 component Lab01 is 
 port
	(
		-- Input ports
		A, B	: in  std_logic;

		-- Output ports
		Snot, Sand, Sor, Sxor	: out std_logic
	);
end component;

signal A,B: std_logic :='0';
signal Snot, Sand, Sor, Sxor: std_logic :='0';

begin

	comp: Lab01 port map (A, B, Snot, Sand, Sor, Sxor);
	A <= '0' after 10 ns, '1' after 20 ns, '0' after 30 ns, '1' after 40 ns; 
	B <= '0' after 10 ns, '0' after 20 ns, '1' after 30 ns, '1' after 40 ns;

end architecture;
