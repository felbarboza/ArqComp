library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity maquinaestado is
  port( clk : in std_logic;
  rst : in std_logic;
  estado : out std_logic
 );
end entity;

architecture a_maquinaestado of maquinaestado is
  signal registro : std_logic;
begin
  process(clk, rst) 
  begin
  if rst='1' then
    registro <= '0';
  elsif rising_edge(clk) then
    registro <= not(registro);
  end if;
  estado<=registro;
 end process;
 
end architecture;