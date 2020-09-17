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
  0 => "111100001000", -- MOV A, Zero
  1 => "001100000101", -- ADDI A, 5
  2 => "111100011001", -- MOV R3, A
  3 => "001100000011", -- ADDI A, 3
  4 => "111100100001", -- MOV R4, A
  5 => "111100001100", -- MOV A, R4
  6 => "001000000011", -- ADD A, R3
  7 => "111100101001", -- MOV R5, A
  8 => "111100001101", -- MOV A, R5
  9 => "101100000001", -- SUBI A, 1
  10 => "011100010100", -- JMP 20
  12 => "000000000000", -- NOP
  13 => "000000000000", -- NOP
  14 => "000000000000", -- NOP
  15 => "000000000000", -- NOP
  16 => "000000000000", -- NOP
  17 => "000000000000", -- NOP
  18 => "000000000000", -- NOP
  19 => "000000000000", -- NOP
  20 => "111100011101", -- MOV R3, R5
  21 => "011100000101", -- JMP 5
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
