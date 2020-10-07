library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity unidadecontrole is
  port(
    instruction: unsigned(11 downto 0);
    zero		: in std_logic;
    sign		: in std_logic;
    estado  : in unsigned(1 downto 0);
    jump		: out std_logic;
    acumulador: out std_logic;
    ulasrca		: out std_logic;
    ulasrcb		: out std_logic;
    ula_op     : out std_logic;
    pc_en		: out std_logic;
    banco_en	: out std_logic;
    ram_en: out std_logic;
    load_ram: out std_logic;
    flags_en	: out std_logic;
    flag_clr  : out std_logic;
    operror		: out std_logic
  );
end entity unidadecontrole;

architecture a_unidadecontrole of unidadecontrole is
  signal opcode: unsigned(3 downto 0);
  signal fetch, execute : std_logic;
  signal opcode_error	  : std_logic;
  
begin
  operror<= opcode_error;

  opcode <= instruction(11 downto 8);

  fetch   <= '1' when estado = "00" else
               '0';

  execute <= '1' when estado = "01" else
               '0';

  banco_en <= '1' when (opcode="1111" or 
                        opcode="0010" or 
                        opcode="0011" or 
                        opcode="1001" or 
                        opcode="1011" or
                        opcode="0100") and 
                        execute = '1' 
                        else '0';
  load_ram <= '1' when opcode="0100" and execute='1' else '0';

  ram_en <= '1' when opcode="0110" and execute='1' else '0';

  jump <= '1' when  opcode="0111" or
                    (opcode="0101" and zero='0') or
                    (opcode="1100" and sign='1') or
                    (opcode="1101" and sign='0') or
                    (opcode="1110" and zero='1') else
                    '0';

  ulasrca <= '0' when opcode="0111" or 
                      opcode="1111" or 
                      opcode="0101" or 
                      opcode="1100" or 
                      opcode="1101" or 
                      opcode="1110" else
                      '1';

  ulasrcb <= '1' when opcode="0011" or opcode="1011" else
    '0';

  acumulador<= '1' when opcode="0010" or 
                        opcode="0011" or 
                        opcode="1001" or 
                        opcode="1011" or
                        opcode="0110" or
                        opcode="0100" else
                        '0';

  pc_en <= '1' when fetch='1' and opcode_error='0' else
    '0';

  flags_en <= '1' when opcode="0010" or opcode="0011" or opcode="1001" or opcode="1011" else
    '0';
                        
  opcode_error <= '0'  when opcode="0000" or
                        opcode="0010" or
                        opcode="0011" or
                        opcode="1001" or
                        opcode="1011" or
                        opcode="1111" or
                        opcode="0111" or
                        opcode="0101" or 
                        opcode="1100" or 
                        opcode="1101" or 
                        opcode="0001" or
                        opcode="1110" or
                        opcode="0100" or
                        opcode="0110" else 
                       '1';

  ula_op   <= '1' when opcode = "1001" or opcode="1011" else
              '0';

  flag_clr <= '1' when opcode="0001" else
    '0';
end architecture a_unidadecontrole;