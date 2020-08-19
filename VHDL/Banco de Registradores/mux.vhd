library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux is
  port (  sel: in std_logic;
          entr0,entr1: in unsigned(15 downto 0);
          saida: out unsigned(15 downto 0));
end entity;

architecture a_mux of mux is
  begin
    saida <=  entr0 when sel='0' else
              entr1 when sel='1' else
              "0000000000000000";
end architecture;