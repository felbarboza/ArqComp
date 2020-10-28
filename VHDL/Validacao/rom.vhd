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
   -- ACUMULADOR = 001 (R1)
   -- ENDERECO @DPTR = 010 (R2)
   -- CARREGANDO A RAM COM 2 A 32
  0 => "111100001000", -- MOV A, Zero
  1 => "001100000001", -- ADDI A, 1
  2 => "111100011001", -- MOV R3, A
  3 => "111100001011", -- MOV A, R3
  4 => "001100000001", -- ADDI A, 1
  5 => "111100010001", -- MOV DPTR, A
  6 => "111100011001", -- MOV R3, A
  7 => "011000000000", -- MOVX @DPTR, A
  8 => "101100100000", -- SUBB A, 32
  9 => "110000000011", -- JC 3
    -- VOLTANDO O ENDERECO PRA 2
  10 => "111100001000", -- MOV A, ZERO
  11 => "001100000010", -- ADDI A, 2
  12 => "111100010001", -- MOVX DPTR, A
  13 => "111100011001", -- MOV R3, A
    -- PEGANDO VALORES DIFERENTES DE 0
  14 => "111100010011", -- MOV DPTR, R3
  15 => "010000000000", -- MOVX A, @DPTR       COLOCA O VALOR DO ENDERECO DA DPTR NO ACUMULADOR 
  16 => "111100100001", -- MOV R4, A       COLOCA O VALOR DO A EM R4
  17 => "111100101100", -- MOV R5, R4      COLOCA O VALOR DE R4 EM R5
  18 => "111100001011", -- MOV A, R3       PEGA O VALOR QUE VAI INCREMENTANDO EM 1 PRO ACUMULADOR
  19 => "101100100000", -- SUBB A, 32      VE SE NAO PASSOU DE 32
  20 => "110100100101", -- JNC 37          O VALOR QUE VAI PULAR QUANDO FOR MAIOR QUE 32
  21 => "111100001100", -- MOV A, R4       COLOCA O VALOR DA DPTR EM A
  22 => "101100000000", -- SUBB A, 0       VERIFICA SE NAO LEU 0
  23 => "111000100001", -- JZ 33           SE FOR 0 VAI PRA 32 PRA INCREMENTAR 1
    --ENQUANTO O VALOR FOR MENOR QUE 32, VAI FAZENDO A SOMA E COLOCANDO 0
  24 => "111100001101", -- MOV A, R5       COLOCA O VALOR DO ENDERECO DA DPTR NO ACUMULADOR
  25 => "001000000100", -- ADD A, R4       FICA ADICIONANDO OUTRO LOOP 
  26 => "111100101001", -- MOV R5, A       PEGA O VALOR DA SOMA NOVA E GUARDA EM R5 
  27 => "111100010001", -- MOV DPTR, A      PEGA ESSE VALOR DO ENDERECO E PASSA PRO REG DA DPTR
  28 => "111100001000", -- MOV A, ZERO     COLOCA 0 NO ACUMULADOR PRA PREENCHER A DPTR
  29 => "011000000000", -- MOVX @DPTR, A       COLOCAR O VALOR DE A 0 NO ENDERECO DO R2 DPTR
  30 => "111100001101", -- MOV A, R5       
  31 => "101100100000", -- SUBB A, 32
  32 => "110000011000", -- JC 24
  33 => "111100001011", -- MOV A, R3
  34 => "001100000001", -- ADDI A, 1
  35 => "111100011001", -- MOV R3, A
  36 => "011100001110", -- JUMP 14
    -- ACABOU O LOOP DE ELIMINACAO, COMECA IMPRESSAO
  37 => "111100001000", -- MOV A, ZERO
  38 => "001100000010", -- ADDI A, 2
  39 => "111100010001", -- MOV DPTR, A
  40 => "111100011001", -- MOV R3, A
  41 => "111100010011", -- MOV DPTR, R3
  42 => "010000000000", -- MOVX A, @DPTR       COLOCA O VALOR DO ENDERECO DA DPTR NO ACUMULADOR 
  43 => "111100100001", -- MOV R4, A       COLOCA O VALOR DO A EM R4 
  44 => "111100001011", -- MOV A, R3       PEGA O VALOR QUE VAI INCREMENTANDO EM 1 PRO ACUMULADOR
  45 => "101100100000", -- SUBB A, 32      VE SE NAO PASSOU DE 32
  46 => "110100110111", -- JNC 55          O VALOR QUE VAI PULAR QUANDO FOR MAIOR QUE 32
  47 => "111100001100", -- MOV A, R4       COLOCA O VALOR DA DPTR EM A
  48 => "101100000000", -- SUBB A, 0       VERIFICA SE NAO LEU 0
  49 => "111000110011", -- JZ 51           SE LEU 0 NAO PRINTA
  50 => "111100110001", -- MOV R6, A       FAZ UM MOV PRA APARECER OS NUMEROS PRIMOS
  51 => "111100001011", -- MOV A, R3
  52 => "001100000001", -- ADDI A, 1
  53 => "111100011001", -- MOV R3, A 
  54 => "011100101001", -- JUMP 41
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
