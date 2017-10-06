library IEEE;
use IEEE.STD_LOGIC_1164.ALL;	
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity comparador is

	port
	(
		A, B   : in integer;

		result : out std_logic
	);
end entity;


architecture comp of comparador is

begin

	result <= '1' when (A = B) else '0';
	
end architecture;