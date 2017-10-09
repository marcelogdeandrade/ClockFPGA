library IEEE;
use IEEE.STD_LOGIC_1164.ALL;	
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity registrador is

	port (
		  DIN : in integer;
		  DOUT : out integer;
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
            DOUT <= 0; -- Assim, o codigo fica reconfiguravel.
         -- ativo na subida do CLK
         elsif CLK'event and CLK = '1' then
             if ENABLE='1' then
                 DOUT <= DIN;
             else            -- para evitar que seja implementado um latch.
                 null;  
             end if;
         end if;
     end process;
end architecture;