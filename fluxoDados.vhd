-- A library clause declares a name as a library.  It 
-- does not create the library; it simply forward declares 
-- it. 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;	
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity fluxoDados is
	port
	(
		-- Input ports
		clk	: in  STD_LOGIC;

		-- Output ports
		saida7seg : out STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
end entity;

-- Library Clause(s) (optional)
-- Use Clause(s) (optional)

architecture fluxoDados_arc of fluxoDados is
	
	signal count : integer := 0;
	signal sec : STD_LOGIC;

begin
	divisor : work.divisor
   port map (
        clk => clk, sec => sec
        );
	process(sec)
	begin
		if (sec = '1') then
			if (count = 9) then
				count <= 0;
			else 
				count <= count + 1;
			end if;
		end if;
	end process;
	-- instaciaçao sem declaracao de componente:
	display : work.conversor7Seg
   port map (
        dadoHex => count, apaga => '0', negativo => '0', overFlow => '0', saida7seg => saida7seg
        );
end architecture;
