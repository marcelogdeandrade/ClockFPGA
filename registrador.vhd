library IEEE;
use IEEE.STD_LOGIC_1164.ALL;	
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity registrador is

	port (
		  DIN : in STD_LOGIC_VECTOR(3 DOWNTO 0);
		  DOUT : out STD_LOGIC_VECTOR(3 DOWNTO 0);
		  ENABLE : in std_logic;
		  CLK, RESET : in std_logic
	  );

end entity;


architecture comportamento of registrador is
 begin
     process(CLK,RESET)
     begin
         -- reset ativo em ALTO
         if RESET = '1' then
            --DOUT <= "00000000";
            DOUT <= "0000"; -- Assim, o codigo fica reconfiguravel.
         -- ativo na subida do CLK
         elsif (rising_edge(CLK)) then
             if ENABLE='1' then
                 DOUT <= DIN;
             end if;
         end if;
     end process;
end architecture;