library IEEE;
use IEEE.STD_LOGIC_1164.ALL;	
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity controlador_tempo is

	port
	(
		clk : in STD_LOGIC;
		enable: in STD_LOGIC;
		func : in  STD_LOGIC_VECTOR(3 DOWNTO 0);
		enable_out : out STD_LOGIC;
		hex_out : out STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
end entity;


architecture controlador_tempo_arc of controlador_tempo is

	signal out_comp : STD_LOGIC_VECTOR(3 DOWNTO 0); 
	signal entrada_ula : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
	signal output : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
	signal out_ula : STD_LOGIC_VECTOR(3 DOWNTO 0);
	
begin

	registrador : work.registrador
	port map (
		DIN => output, ENABLE => '1', CLK => clk, RESET => '0' , DOUT => entrada_ula
	);
	soma : work.ULA
	port map (
		A => entrada_ula, B => "0001", rst => '0', result => out_ula
	);
	comp : work.comparador
	port map (
		A => out_ula, B => func, result => enable_out, clk => clk, C => out_comp, enable => enable
	);
	mux : work.mux
	port map (
		A => out_comp, B => entrada_ula , SEL => enable, X => output
	);
	display : work.conversor7Seg
	port map (
      dadoHex => output, apaga => '0', negativo => '0', overFlow => '0', saida7seg => hex_out
   );


end architecture;