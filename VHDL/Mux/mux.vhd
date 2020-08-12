library ieee;
use ieee.std_logic_1164.all;

entity mux4x1 is
  port (  sel0,sel1: in std_logic;
          entr0,entr1,entr2,entr3: in std_logic;
          saida: out std_logic);
end entity;

architecture a_mux4x1 of mux4x1 is
  begin
    saida <=  entr0 when sel1='0' and sel0='0' else
              entr1 when sel1='0' and sel0='1' else
              entr2 when sel1='1' and sel0='0' else
              entr3 when sel1='1' and sel0='1' else
              '0';
end architecture;