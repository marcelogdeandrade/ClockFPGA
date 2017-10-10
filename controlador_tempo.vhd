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
		KEY : in STD_LOGIC_VECTOR(3 DOWNTO 0);
		keyv : in integer;

		enable_out : out STD_LOGIC;
		hex_out : out STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
end entity;


architecture controlador_tempo_arc of controlador_tempo is

	signal out_comp  : STD_LOGIC_VECTOR(3 DOWNTO 0);
	signal out_comp2 : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
	signal enable_out2 : STD_LOGIC;
	signal entrada_ula : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
	signal output : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
	signal output2 : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
	signal out_ula : STD_LOGIC_VECTOR(3 DOWNTO 0);
	signal config_result : STD_LOGIC_VECTOR(3 DOWNTO 0) := (others => '0');
	signal last_state : STD_LOGIC := '1';
	
begin

	registrador : work.registrador
	port map (
		DIN => output2, ENABLE => '1', CLK => clk, RESET => '0' , DOUT => entrada_ula
	);
	reconfig : work.ULA
	port map (
		A => entrada_ula, B => "0001", rst => '0', result => config_result
	);
	soma : work.ULA
	port map (
		A => entrada_ula, B => "0001", rst => '0', result => out_ula
	);
	comp : work.comparador
	port map (
		A => out_ula, B => func, result => enable_out, clk => clk, C => out_comp, enable => enable
	);
	comp2 : work.comparador
	port map (
		A => config_result, B => func, result => enable_out2, clk => clk, C => out_comp2, enable => enable
	);
	mux : work.mux
	port map (
		A => out_comp, B => entrada_ula , SEL => enable, X => output
	);
	
	process (clk)
	begin
		if (keyv < 4) then
			if rising_edge(clk) then
				last_state <= KEY(keyv);
			end if;
		end if;
	end process;
	output2 <= output when (keyv > 3) else
					out_comp2 when (KEY(keyv) = '1' and last_state = '0') else
					output;
	display : work.conversor7Seg
	port map (
      dadoHex => output2, apaga => '0', negativo => '0', overFlow => '0', saida7seg => hex_out
   );


end architecture;