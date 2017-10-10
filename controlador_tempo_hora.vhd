library IEEE;
use IEEE.STD_LOGIC_1164.ALL;	
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity controlador_tempo_hora is

	port
	(
		clk : in STD_LOGIC;
		enable: in STD_LOGIC;
		keyv, keyv2 : in integer;
		KEY : in STD_LOGIC_VECTOR(3 DOWNTO 0);
		format: in STD_LOGIC;
		hex_out: out STD_LOGIC_VECTOR(6 DOWNTO 0);
		hex_out2: out STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
end entity;


architecture controlador_tempo_hora_arc of controlador_tempo_hora is

	-- Sinais
	signal out_comp : STD_LOGIC_VECTOR(3 DOWNTO 0); 
	signal entrada_ula : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
	signal output : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
	signal out_ula : STD_LOGIC_VECTOR(3 DOWNTO 0);

	signal out_compa : STD_LOGIC_VECTOR(3 DOWNTO 0); 
	signal entrada_ulaa : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
	signal outputa : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
	signal out_ulaa : STD_LOGIC_VECTOR(3 DOWNTO 0);
	
	signal last_state : std_LOGIC := '1';
	signal last_state2 : std_LOGIC := '1';
	
	signal out_comp_2 : STD_LOGIC_VECTOR(3 DOWNTO 0); 
	signal entrada_ula_2 : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
	signal output_2 : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
	signal out_ula_2 : STD_LOGIC_VECTOR(3 DOWNTO 0);

	signal out_comp_2a : STD_LOGIC_VECTOR(3 DOWNTO 0); 
	signal entrada_ula_2a : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
	signal output_2a : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
	signal out_ula_2a : STD_LOGIC_VECTOR(3 DOWNTO 0);
	
	signal enable_out : STD_LOGIC;
	signal enable_outa : STD_LOGIC;
	signal func_hora_u : STD_LOGIC_VECTOR(3 DOWNTO 0);
	signal func_hora_d : STD_LOGIC_VECTOR(3 DOWNTO 0);
	
	signal aux : integer;
	
begin
	
	-- Variaiveis de limite da hora
	func_hora_u <= "0100" when ((output_2a = "0010") and (format = '0')) else 
						"0011" when ((output_2a = "0001") and (format = '1')) else
						"1010";
	
	func_hora_d <= "0011" when (format = '0') else
						"0010";
	
	-- Controle de tempo unidade
	registrador : work.registrador
	port map (
		DIN => outputa, ENABLE => '1', CLK => clk, RESET => '0' , DOUT => entrada_ula
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
	
	-- Tratar ajuste de hora 
	process(clk)
	begin
		if (keyv < 4) then
			if rising_edge(clk) then
				last_state  <= KEY(keyv);
				last_state2 <= KEY(keyv2);
			end if;
		end if;
	end process;
	
	outputa <= output when (keyv > 3) else
					out_comp when (KEY(keyv) = '1' and last_state = '0') else
					output;
	
	-- Controle de tempo unidade
	display : work.conversor7Seg
	port map (
      dadoHex => outputa, apaga => '0', negativo => '0', overFlow => '0', saida7seg => hex_out
   );
	
	registrador_2 : work.registrador
	port map (
		DIN => output_2a, ENABLE => '1', CLK => clk, RESET => '0' , DOUT => entrada_ula_2
	);
	soma_2 : work.ULA
	port map (
		A => entrada_ula_2, B => "0001", rst => '0', result => out_ula_2
	);
	comp_2 : work.comparador
	port map (
		A => out_ula_2, B => func_hora_d, clk => clk, C => out_comp_2, enable => enable_out
	);
	mux_2 : work.mux
	port map (
		A => out_comp_2, B => entrada_ula_2 , SEL => enable_out, X => output_2
	);
	
	output_2a <= output_2 when (keyv > 3) else
					out_comp_2 when (KEY(keyv2) = '1' and last_state2 = '0') else
					output_2;

	display_2 : work.conversor7Seg
	port map (
      dadoHex => output_2a, apaga => '0', negativo => '0', overFlow => '0', saida7seg => hex_out2
   );


end architecture;