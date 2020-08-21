library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula is
  port (  entr0,entr1: in unsigned(15 downto 0);
          op: in unsigned(1 downto 0);
          saida_soma_sub: out unsigned(15 downto 0);
          saida_iguais, saida_e_maior: out std_logic
          );
end entity;

architecture a_ula of ula is
  begin
    saida_soma_sub <=   entr0+entr1 when op="00" else
                        entr0-entr1 when op="01" else
                        "0000000000000000";
    saida_iguais <=     '1' when entr0-entr1="0000000000000000" and op="10" else
                        '0';
    saida_e_maior  <=   '1' when op="11" and entr1<entr0 else
                        '0';                                       
end architecture;
