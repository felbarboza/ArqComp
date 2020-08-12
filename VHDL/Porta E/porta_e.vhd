library ieee;
use ieee.std_logic_1164.all;
entity porta_e is
 port( in_a,in_b: in std_logic;
 a_e_b: out std_logic
 );
end entity;
architecture aporta_e of porta_e is
begin
 a_e_b <= in_a and in_b;
end architecture;
