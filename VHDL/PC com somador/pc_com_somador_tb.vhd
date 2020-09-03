library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc_com_somador_tb is
end entity;

architecture a_pc_com_somador_tb of pc_com_somador_tb is
  component pc_com_somador
    port(
      clk : in std_logic;
      rst: in std_logic
    );
  end component;
  signal clk,rst: std_logic := '0';
begin
  uut: pc_com_somador port map(
    clk=>clk,
    rst=>rst
  );

process
  begin
    clk <= '0';
    wait for 50 ns;
    clk <= '1';
    wait for 50 ns;
end process;

process
begin
  rst <= '1';
  wait for 100 ns;
  rst <= '0';
  wait;
end process;
end architecture a_pc_com_somador_tb;