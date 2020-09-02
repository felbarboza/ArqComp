library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity unidadecontrole_tb is
end entity;

architecture a_unidadecontrole_tb of unidadecontrole_tb is
  component unidadecontrole is
    port(
      clk: in std_logic;
      rst: in std_logic
    );
  end component unidadecontrole;
  signal rst, clk: std_logic;

begin
  uut: unidadecontrole port map(clk=>clk, rst=>rst);

  process
  begin
    rst<='1';
    wait for 100 ns;
    rst<='0';
    wait;
  end process;

  process
  begin
    clk<='1';
    wait for 50 ns;
    clk<='0';
    wait for 50 ns;
  end process;

  end architecture a_unidadecontrole_tb;