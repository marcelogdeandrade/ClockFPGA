library IEEE;
use IEEE.STD_LOGIC_1164.ALL;	
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ULA is

	port
	(
		A, B   : in integer;
		op     : in std_logic;
		enable : in std_logic;
		reset  : in std_logic;
	
		overflow : out std_logic;
		result   : out integer
	);
end entity;


architecture SumSub of ULA is

begin

	result <= 0 when (reset = '1') else
				 A when (enable = '0') else
				 A + B when (op = '0') else
				 A - B;
				 
	overflow <= '1' when (reset = '1') else '0';

end architecture;