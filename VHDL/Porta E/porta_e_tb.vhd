library ieee;
use ieee.std_logic_1164.all;
entity porta_e_tb is
end entity;
architecture aporta_e_tb of porta_e_tb is
 component porta_e is
 port( in_a,in_b: in std_logic;
 a_e_b: out std_logic
 );
 end component;
 signal a,b,e: std_logic;
begin
 uut: porta_e port map(in_a=>a,in_b=>b,a_e_b=>e);
 process
 begin
 a <= '0';
 b <= '0';
 wait for 50 ns;
 a <= '0';
 b <= '1';
 wait for 50 ns;
 a <= '1';
 b <= '0';
 wait for 50 ns;
 a <= '1';
 b <= '1';
 wait for 50 ns;
 a <= '0';
 b <= '0';
 wait;
 end process;
end architecture;