library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_tb is
end entity;

architecture a_mux_tb of mux_tb is
  component mux
    port(
      sel: in std_logic;
      entr0,entr1: in unsigned(15 downto 0);
      saida: out unsigned(15 downto 0)
    );
  end component;
  signal sel: std_logic := '0';
  signal entr0,entr1,saida: unsigned(15 downto 0) := "0000000000000000";

begin
  uut: mux port map(
    sel => sel,
    entr0=>entr0,
    entr1=>entr1,
    saida=>saida
  );

process 
  begin
    sel <= '0';
    entr0 <= "0000000000000110";
    entr1 <= "0000111000000000";
    wait for 50 ns;
    sel <= '1';
    entr0 <= "0000000000000110";
    entr1 <= "0000111000000000";
    wait for 50 ns;
    wait;
  end process;
end architecture;