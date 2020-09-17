library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity unidadecontrole is
  port(
    instruction: unsigned(11 downto 0);
    zero		: in std_logic;
    sign		: in std_logic;
    jump		: out std_logic;
    regwrite	: out std_logic;
    acumulador: out std_logic;
    ulasrca		: out std_logic;
    ulasrcb		: out std_logic;
    ula_op     : out std_logic;
    operror		: out std_logic
  );
end entity unidadecontrole;

architecture a_unidadecontrole of unidadecontrole is
  signal opcode: unsigned(3 downto 0);

begin
  opcode <= instruction(11 downto 8);
  jump <= '1' when opcode="0111" else
  '0';
  regwrite <= '1' when opcode="1111" or opcode="0010" or opcode="0011" or opcode="1001" or opcode="1011" else
    '0';
  ulasrca <= '0' when opcode="0111" or opcode="1111" else
    '1';
  ulasrcb <= '1' when opcode="0011" or opcode="1011" else
    '0';

  acumulador<= '1' when opcode="0010" or opcode="0011" or opcode="1001" or opcode="1011" else
                '0';
                        
  operror <= '0'  when opcode="0000" or
                        opcode="0010" or
                        opcode="0011" or
                        opcode="1001" or
                        opcode="1011" or
                        opcode="1111" or
                        opcode="0111" else 
                       '1';

  ula_op   <= '1' when opcode = "1001" or opcode="1011" else
              '0';
end architecture a_unidadecontrole;