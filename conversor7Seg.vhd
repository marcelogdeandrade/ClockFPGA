library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity conversor7Seg is
    port
    (
        -- Input ports
        dadoHex : in  integer;
        apaga   : in  std_logic := '0';
        negativo : in  std_logic := '0';
        overFlow : in  std_logic := '0';
        -- Output ports
        saida7seg : out std_logic_vector(6 downto 0)  -- := (others => '1')
    );
end entity;

architecture comportamento of conversor7Seg is
   --
   --       0  
   --      ---  
   --     |   |
   --    5|   |1
   --     | 6 |
   --      ---  
   --     |   |
   --    4|   |2
   --     |   |
   --      ---  
   --       3  
   --
    signal rascSaida7seg: std_logic_vector(6 downto 0);

begin
  rascSaida7seg <= "1000000" when dadoHex=0 else ---0     
                   "1111001" when dadoHex=1 else ---1
                   "0100100" when dadoHex=2 else ---2
                   "0110000" when dadoHex=3 else ---3
                   "0011001" when dadoHex=4 else ---4
                   "0010010" when dadoHex=5 else ---5
                   "0000010" when dadoHex=6 else ---6
                   "1111000" when dadoHex=7 else ---7
                   "0000000" when dadoHex=8 else ---8
                   "0010000" when dadoHex=9 else ---9
--                   "0001000" when dadoHex="1010" else ---A
--                   "0000011" when dadoHex="1011" else ---B
--                   "1000110" when dadoHex="1100" else ---C  
--                   "0100001" when dadoHex="1101" else ---D
--                   "0000110" when dadoHex="1110" else ---E
--                   "0001110" when dadoHex="1111" else ---F
                   "1111111"; -- Apaga todos segmentos.
    --              
  saida7seg <=    "1100010" when (overFlow='1') else
                  "1111111" when (apaga='1' and negativo='0') else
                  "0111111" when (apaga='0' and negativo='1') else
                  rascSaida7seg;
end architecture;
