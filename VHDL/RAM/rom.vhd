library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is
  port( clk : in std_logic;
        endereco : in unsigned(6 downto 0);
        dado : out unsigned(11 downto 0) 
      );
end entity;
architecture a_rom of rom is
 type mem is array (0 to 127) of unsigned(11 downto 0);
 constant conteudo_rom : mem := (
   -- ACUMULADOR = 001
   -- ENDERECO RAM = 010
  0 => "111100001000", -- MOV A, Zero
  1 => "001100000001", -- ADDI A, 1
  2 => "111100010001", -- MOV RAM, A
  3 => "001100000101", -- ADDI A, 5
  4 => "011000000000", -- SW RAM, A
  5 => "001100001111", -- ADDI A, 15
  6 => "111100010001", -- MOV RAM, A
  7 => "001100010101", -- ADDI A, 21
  8 => "011000000000", -- SW RAM, A
  9 => "001100010001", -- ADDI A, 17
  10 => "111100010001", -- MOV RAM, A
  11 => "001100000111", -- ADDI A, 7
  12 => "011000000000", -- SW RAM, A
  13 => "111100001000", -- MOV A, Zero
  14 => "001100010101", -- ADDI A, 21
  15 => "111100010001", -- MOV RAM, A
  16 => "010000000000", -- LW A, RAM
  17 => "111100101001", -- MOV R5, A
  others => (others=>'0')
  );
begin
  process(clk)
    begin
      if(rising_edge(clk)) then
        dado <= conteudo_rom(to_integer(endereco));
      end if;
  end process;
end architecture;
