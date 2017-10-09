library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux is
    Port ( SEL : in  STD_LOGIC;
           A   : in  STD_LOGIC_VECTOR(3 DOWNTO 0);
           B   : in  STD_LOGIC_VECTOR(3 DOWNTO 0);
           X   : out STD_LOGIC_VECTOR(3 DOWNTO 0)
			);
end mux;

architecture mux_arc of mux is
begin
    X <= A when (SEL = '1') else B;
end mux_arc;