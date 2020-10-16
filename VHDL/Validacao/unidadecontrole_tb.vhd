library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity unidadecontrole_tb is
end entity unidadecontrole_tb;

architecture a_unidadecontrole_tb of unidadecontrole_tb is
	component unidadecontrole is
		port (
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
	end component unidadecontrole;
	signal instruction : unsigned(11 downto 0);
	signal estado: unsigned(1 downto 0);
	signal jump, zero, sign, ulasrca, ulasrcb, ula_op, operror, acumulador, pc_en, ram_en, load_ram, banco_en, flags_en, flag_clr : std_logic;
begin
	uut : unidadecontrole port map(instruction => instruction,
																zero => zero,
																sign => sign,
																estado  => estado,
																jump => jump,
																acumulador => acumulador,
																ulasrca => ulasrca,
																ulasrcb => ulasrcb,
																ula_op => ula_op,
																pc_en		=> pc_en,
																banco_en	=> banco_en,
																ram_en => ram_en,
																load_ram=> load_ram,
																flags_en	=> flags_en,
																flag_clr => flag_clr,
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
		instruction <= "000100000000"; --CLR
		wait for 50 ns;
		instruction <= "010000000000"; --LW
		wait for 50 ns;
		instruction <= "011000000000"; --SW
		wait for 50 ns;
		instruction <= "110000000000"; --JC
		wait for 50 ns;
		instruction <= "110100000000"; --JNC
		wait for 50 ns;
		instruction <= "111000000000"; --JZ
		wait for 50 ns;
		instruction <= "010100000000"; --JNZ
		wait for 50 ns;
		instruction <= "100000000000"; --ERRO
		wait for 50 ns;
		wait;
	end process;
end architecture a_unidadecontrole_tb;