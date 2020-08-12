library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula_tb is
end entity;

architecture a_ula_tb of ula_tb is
  component ula
    port(
      entr0,entr1: in unsigned(15 downto 0);
      op: in unsigned(1 downto 0);
      saida_soma_sub: out unsigned(15 downto 0);
      saida_iguais, saida_e_maior: out std_logic
    );
  end component;
  signal entr0, entr1: unsigned(15 downto 0);
  signal saida_soma_sub: unsigned(15 downto 0);
  signal op: unsigned(1 downto 0);
  signal saida_iguais, saida_e_maior: std_logic;

begin
  uut: ula port map(
    entr0 => entr0,
    entr1 => entr1,
    op => op,
    saida_soma_sub => saida_soma_sub,
    saida_iguais => saida_iguais,
    saida_e_maior => saida_e_maior
  );

process
  begin
    op <= "00";
    entr0 <= "0000000000000100";
    entr1 <= "0000000000000101";
    wait for 50 ns;  
    op <= "00";
    entr0 <= "0000000000000100";
    entr1 <= "1111111111110101";    
    wait for 50 ns;
    op <= "01";
    entr0 <= "0000000000000110";
    entr1 <= "0000000000000101";
    wait for 50 ns;  
    op <= "01";
    entr0 <= "0000000000000100";
    entr1 <= "0000000000001101";    
    wait for 50 ns;
    op <= "10";
    entr0 <= "0000000000000101";
    entr1 <= "0000000000000101";
    wait for 50 ns;  
    op <= "10";
    entr0 <= "0000000000000100";
    entr1 <= "0000000000001101";    
    wait for 50 ns;
    op <= "11";
    entr0 <= "0000000000001101";
    entr1 <= "0000000000000101";
    wait for 50 ns;  
    op <= "11";
    entr0 <= "0000000000000100";
    entr1 <= "0000000000001101";    
    wait for 50 ns;
    wait;
  end process;
end architecture;