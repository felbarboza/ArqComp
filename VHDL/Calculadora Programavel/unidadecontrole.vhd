library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity unidadecontrole is
  port(
    instruction: unsigned(15 downto 0);
    jump		: out std_logic;
    regwrite	: out std_logic;
    ulasrca		: out std_logic;
    ulasrcb		: out std_logic;
    ulaop     : out unsigned(1 downto 0);
    operror		: out std_logic
  );
end entity unidadecontrole;

architecture a_unidadecontrole of unidadecontrole is
  signal opcode: unsigned(2 downto 0);

begin
  opcode <= instruction(11 downto 9);
  jump <= '1' when opcode="001" else
  '0';
  regwrite <= '1' when opcode="010" or opcode="011" else
    '0';
  ulasrca <= '0' when opcode="001" else
    '1';
  ulasrcb <= '1' when opcode="010" else
    '0';
  operror <= '0' when opcode ="001" or opcode="010" or opcode="011" else '1';
  ulaop   <= "01" when opcode = "101" or opcode="110" else
              "00";
end architecture a_unidadecontrole;
