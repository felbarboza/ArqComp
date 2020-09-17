library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula is
  port (  entr0,entr1: in unsigned(15 downto 0);
          op: in std_logic;
          saida: out unsigned(15 downto 0);
          zero, sign: out std_logic
          );
end entity;

architecture a_ula of ula is
  begin
    saida <=    entr0+entr1 when op='0' else
                entr0-entr1 when op='1' else
                "0000000000000000";
    zero <=     '1' when entr0-entr1="0000000000000000" else
                        '0';
    sign  <=    '1' when entr0<entr1 else
                        '0';                                       
end architecture;
