library IEEE;
use IEEE.STD_LOGIC_1164.ALL;	
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity controlador_tempo_hora is

	port
	(
		clk : in STD_LOGIC;
		enable: in STD_LOGIC;
		hex_out: out STD_LOGIC_VECTOR(6 DOWNTO 0);
		hex_out2: out STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
end entity;


architecture controlador_tempo_hora_arc of controlador_tempo_hora is

	signal out_comp : STD_LOGIC_VECTOR(3 DOWNTO 0); 
	signal entrada_ula : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
	signal output : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
	signal out_ula : STD_LOGIC_VECTOR(3 DOWNTO 0);
	
	signal out_comp_2 : STD_LOGIC_VECTOR(3 DOWNTO 0); 
	signal entrada_ula_2 : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
	signal output_2 : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
	signal out_ula_2 : STD_LOGIC_VECTOR(3 DOWNTO 0);
	
	signal enable_out : STD_LOGIC;
	signal func_hora_u : STD_LOGIC_VECTOR(3 DOWNTO 0);
	
begin
	
	func_hora_u <= "0100" when (output_2 = "0010") else "1010";
	
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
		A => out_ula, B => func_hora_u, result => enable_out, clk => clk, C => out_comp, enable => enable
	);
	mux : work.mux
	port map (
		A => out_comp, B => entrada_ula , SEL => enable, X => output
	);
	
	display : work.conversor7Seg
	port map (
      dadoHex => output, apaga => '0', negativo => '0', overFlow => '0', saida7seg => hex_out
   );
	
	registrador_2 : work.registrador
	port map (
		DIN => output_2, ENABLE => '1', CLK => clk, RESET => '0' , DOUT => entrada_ula_2
	);
	soma_2 : work.ULA
	port map (
		A => entrada_ula_2, B => "0001", rst => '0', result => out_ula_2
	);
	comp_2 : work.comparador
	port map (
		A => out_ula_2, B => "0011", clk => clk, C => out_comp_2, enable => enable_out
	);
	mux_2 : work.mux
	port map (
		A => out_comp_2, B => entrada_ula_2 , SEL => enable_out, X => output_2
	);
	

	display_2 : work.conversor7Seg
	port map (
      dadoHex => output_2, apaga => '0', negativo => '0', overFlow => '0', saida7seg => hex_out2
   );


end architecture;