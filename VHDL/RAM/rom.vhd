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
  1 => "111100011001", -- MOV R3, A
  2 => "111100001000", -- MOV A, Zero
  3 => "111100100001", -- MOV R4, A
  4 => "111100001011", -- MOV A, R3
  5 => "001000000100", -- ADD A, R4
  6 => "111100100001", -- MOV R4, A
  7 => "111100001011", -- MOV A, R3
  8 => "001100000001", -- ADDI A, 1
  9 => "111100011001", -- MOV R3, A
  10 => "000100000000", -- CLR (clear nas flags)
  12 => "111100001011", -- MOV A, R3
  13 => "101100011110", -- SUBI A, 30
  14 => "110000000100", -- JC 3
  15 => "111100101100", -- MOV R5, R4
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
