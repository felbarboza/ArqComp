library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity maquinaestado_tb is
end entity;

architecture a_maquinaestado_tb of maquinaestado_tb is
  component maquinaestado
    port(
      clk : in std_logic;
      rst : in std_logic;
      estado : out std_logic
    );
  end component;
  signal clk,rst,estado: std_logic := '0';

begin
  uut: maquinaestado port map(
    clk => clk,
    rst=>rst,
    estado=>estado
  );

process
  begin
    rst <= '1';
    wait for 100 ns;
    rst <= '0';
    wait;
end process;

process
  begin
    clk <= '0';
    wait for 50 ns;
    clk <= '1';
    wait for 50 ns;
end process;

end architecture;