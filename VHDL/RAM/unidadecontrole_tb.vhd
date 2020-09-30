library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity unidadecontrole_tb is
end entity unidadecontrole_tb;

architecture a_unidadecontrole_tb of unidadecontrole_tb is
	component unidadecontrole is
		port (
			instruction : in unsigned(11 downto 0);
            zero		: in std_logic;
            sign		: in std_logic;
            jump		: out std_logic;
            regwrite	: out std_logic;
            acumulador: out std_logic;
            ulasrca		: out std_logic;
            ulasrcb		: out std_logic;
            ula_op		: out std_logic;
            operror		: out std_logic
		);
	end component unidadecontrole;
	signal instruction : unsigned(11 downto 0);
	signal zero, sign, jump, regwrite, acumulador, ulasrca, ulasrcb, ula_op, operror: std_logic;
begin
	uut : unidadecontrole port map(instruction => instruction,
										  zero => zero,
										  sign => sign,
										  jump => jump,
                      regwrite => regwrite,
                      acumulador => acumulador,
										  ulasrca => ulasrca,
										  ulasrcb => ulasrcb,
										  ula_op => ula_op,
										  operror => operror
										 );

	process
	begin
		instruction <= "000000000000"; --NOP
		wait for 50 ns;
		instruction <= "001000000000"; --ADD
		wait for 50 ns;
		instruction <= "001100000000"; --ADDI
		wait for 50 ns;
		instruction <= "100100000000"; --SUB
		wait for 50 ns;
		instruction <= "101100000000"; --SUBI
		wait for 50 ns;
		instruction <= "111100000000"; --MOV
		wait for 50 ns;
		instruction <= "011100000000"; --JMP
		wait for 50 ns;
		instruction <= "100000000000"; --ERRO
		wait for 50 ns;
		wait;
	end process;
end architecture a_unidadecontrole_tb;