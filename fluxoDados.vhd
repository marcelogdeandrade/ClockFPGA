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
		CLOCK_50	: in  STD_LOGIC;

		-- Output ports
		HEX0 : out STD_LOGIC_VECTOR(6 DOWNTO 0);
		HEX1 : out STD_LOGIC_VECTOR(6 DOWNTO 0)
		);
end entity;

-- Library Clause(s) (optional)
-- Use Clause(s) (optional)

architecture fluxoDados_arc of fluxoDados is
	
	signal count_sec_u : integer := 0;
	signal count_sec_d : integer := 0;
	signal sec : STD_LOGIC;
--	signal saida7seg : STD_LOGIC_VECTOR(6 DOWNTO 0);

begin
	divisor : work.divisor
   port map (
        clk => CLOCK_50, sec => sec
        );
	process(sec)
	begin
		if (sec = '1') then
			if (count_sec_u = 9) then
				count_sec_u <= 0;
				if (count_sec_d = 5) then
					count_sec_d <= 0;
				else
					count_sec_d <= count_sec_d + 1;
				end if;
			else 
				count_sec_u <= count_sec_u + 1;
			end if;
		end if;
	end process;
	-- instaciaçao sem declaracao de componente:
	display1 : work.conversor7Seg
   port map (
        dadoHex => count_sec_u, apaga => '0', negativo => '0', overFlow => '0', saida7seg => HEX0
        );
	display2 : work.conversor7Seg
	port map (
        dadoHex => count_sec_d, apaga => '0', negativo => '0', overFlow => '0', saida7seg => HEX1
    );
end architecture;
