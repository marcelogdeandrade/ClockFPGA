library IEEE;
use IEEE.STD_LOGIC_1164.ALL;	
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ULA is

	port
	(
		A, B : in integer;
		op   : in std_logic;
		
		result : out integer
	);
end entity;


architecture SumSub of ULA is

begin

	result <= A when (op = '0') else B;

end architecture;