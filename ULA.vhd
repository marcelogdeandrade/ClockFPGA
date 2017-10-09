library IEEE;
use IEEE.STD_LOGIC_1164.ALL;	
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ULA is

	port
	(
		A, B   : in STD_LOGIC_VECTOR(3 DOWNTO 0);
		rst  : in std_logic;
	
		result   : out STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
end entity;


architecture SumSub of ULA is

begin

	result <= "0000" when (rst = '1') else
				 A + B;
				 
end architecture;