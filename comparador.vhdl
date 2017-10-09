library IEEE;
use IEEE.STD_LOGIC_1164.ALL;	
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity comparador is

	port
	(
		A, B   : in STD_LOGIC_VECTOR(3 DOWNTO 0);
		
		clk : in std_logic;
		
		enable : in std_logic;

		result : out std_logic;
		
		C : out STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
end entity;


architecture comp of comparador is

begin
--	result <= '1' when (A = B) else '0';
--	C <= "0000" when (A = B) else A;
	process(clk)
	begin
		if rising_edge(clk) then
			if (A = B) then
				if (enable = '1') then
					result <= '1';
					C <= "0000";
				else
					result <= '0';
					C <= "0000";
				end if;
			else
				result <= '0';
				C <= A;
			end if;
		end if;
	end process;
	
end architecture;