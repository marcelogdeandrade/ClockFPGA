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

	signal sec: STD_LOGIC;

	signal enable_sec_d: STD_LOGIC := '0';
	signal enable_min_u: STD_LOGIC := '0';
	signal enable_min_d: STD_LOGIC := '0';
	signal enable_hora_u: STD_LOGIC := '0';
	signal enable_hora_d: STD_LOGIC := '0';



begin
	-- Divisor
	divisor : work.divisor
   port map (
        clk => CLOCK_50, sec => sec
        );
		  
	-- Sec unidade
	sec_uni: work.controlador_tempo
   port map (
        clk => CLOCK_50, 
		  enable => sec, 
		  func => "1010", 
		  enable_out => enable_sec_d,
		  hex_out => HEX0
    );
	 	-- Sec dezena
	sec_d: work.controlador_tempo
   port map (
		  clk => CLOCK_50, 
		  enable => enable_sec_d, 
		  func => "0110", 
		  enable_out => enable_min_u,
		  hex_out => HEX1
    );
	 -- Min Unidade
	min_uni: work.controlador_tempo
   port map (
        clk => CLOCK_50, 
		  enable => enable_min_u, 
		  func => "1010", 
		  enable_out => enable_min_d,
		  hex_out => HEX2
    );
	 -- Min Dezena
	min_d: work.controlador_tempo
   port map (
        clk => CLOCK_50, 
		  enable => enable_min_d, 
		  func => "0110", 
		  enable_out => enable_hora_u,
		  hex_out => HEX3
    );
	 -- Hora unidade
	hora_u: work.controlador_tempo_hora
   port map (
        clk => CLOCK_50, 
		  enable => enable_hora_u,
		  hex_out => HEX4,
		  hex_out2 => HEX5
    );
--	------------
end architecture;
