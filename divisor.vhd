-- A library clause declares a name as a library.  It 
-- does not create the library; it simply forward declares 
-- it. 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;	
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity divisor is
	generic
	(
		frequency : integer := 10
	);
	port
	(
		-- Input ports
		clk	: in  STD_LOGIC := '0';

		-- Output ports
		sec	: out STD_LOGIC
	);
end entity;

-- Library Clause(s) (optional)
-- Use Clause(s) (optional)

architecture divisor_arch of divisor is
	
	signal count : integer := 0;
	
begin
	process(clk)
	begin
		if (rising_edge(clk)) then
			if (count = frequency) then
				sec <= '1';
				count <= 0;
			else
				sec <= '0';
				count <= count + 1;
			end if;
		end if;
	end process;
end architecture;
