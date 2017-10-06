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
		HEX1 : out STD_LOGIC_VECTOR(6 DOWNTO 0);
		HEX2 : out STD_LOGIC_VECTOR(6 DOWNTO 0);
		HEX3 : out STD_LOGIC_VECTOR(6 DOWNTO 0);
		HEX4 : out STD_LOGIC_VECTOR(6 DOWNTO 0);
		HEX5 : out STD_LOGIC_VECTOR(6 DOWNTO 0)
		);
end entity;

-- Library Clause(s) (optional)
-- Use Clause(s) (optional)

architecture fluxoDados_arc of fluxoDados is
	
	signal count_sec_u : integer := 0;
	signal count_sec_d : integer := 0;
	signal count_min_u : integer := 0;
	signal count_min_d : integer := 0;
	signal count_hora_u : integer := 0;
	signal count_hora_d : integer := 0;
	signal hora_u : integer := 3;
	signal hora_d : integer := 2;
	signal sec : STD_LOGIC;
--	signal saida7seg : STD_LOGIC_VECTOR(6 DOWNTO 0);

begin
	divisor : work.divisor
   port map (
        clk => CLOCK_50, sec => sec
        );
	soma_sec_u : work.ULA
	port map (
		A => count_sec_u, B => 1, rst => saida_comp_sec_u, enable => sec, overflow => enable_sec_d
	);
	soma_sec_d : work.ULA
	por map (
		A => count_sec_d, B => 1, rst => saida_comp_sec_d, enable => enable_sec_d, overflow => enable_min_u
	);
--	process(sec)
--	begin
--		if (sec = '1') then
--			if (count_sec_u = 9) then
--				count_sec_u <= 0;
--				if (count_sec_d = 5) then
--					count_sec_d <= 0;
--					if (count_min_u = 9) then
--						count_min_u <= 0;
--						if (count_min_d = 5) then 
--							count_min_d <= 0;
--							if (count_hora_d < hora_d) then
--								if (count_hora_u = 9) then
--									count_hora_u <= 0;
--									count_hora_d <= count_hora_d + 1;
--								else
--									count_hora_u <= count_hora_u + 1;
--								end if;
--							else 
--								if (count_hora_u = hora_u) then
--									count_hora_u <= 0;
--									count_hora_d <= 0;
--								else
--									count_hora_u <= count_hora_u + 1;
--								end if;
--							end if;
--						else 
--							count_min_d <= count_min_d + 1;
--						end if;
--					else
--						count_min_u <= count_min_u + 1;
--					end if;
--				else
--					count_sec_d <= count_sec_d + 1;
--				end if;
--			else 
--				count_sec_u <= count_sec_u + 1;
--			end if;
--		end if;
--	end process;
	-- instaciaçao sem declaracao de componente:
	display1 : work.conversor7Seg
   port map (
        dadoHex => count_sec_u, apaga => '0', negativo => '0', overFlow => '0', saida7seg => HEX0
        );
	display2 : work.conversor7Seg
	port map (
        dadoHex => count_sec_d, apaga => '0', negativo => '0', overFlow => '0', saida7seg => HEX1
    );
	display3 : work.conversor7Seg
	port map (
        dadoHex => count_min_u, apaga => '0', negativo => '0', overFlow => '0', saida7seg => HEX2
    );
	display4 : work.conversor7Seg
	port map (
        dadoHex => count_min_d, apaga => '0', negativo => '0', overFlow => '0', saida7seg => HEX3
    );
	display5 : work.conversor7Seg
	port map (
        dadoHex => count_hora_u, apaga => '0', negativo => '0', overFlow => '0', saida7seg => HEX4
    );
	display6 : work.conversor7Seg
	port map (
        dadoHex => count_hora_d, apaga => '0', negativo => '0', overFlow => '0', saida7seg => HEX5
    );
end architecture;
