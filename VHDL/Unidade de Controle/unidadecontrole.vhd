library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity unidadecontrole is
  port(
    clk: std_logic;
    rst: std_logic
  );
end entity unidadecontrole;

architecture a_unidadecontrole of unidadecontrole is
  component pc is
    port(
      clk : in std_logic;
      rst : in std_logic;
      wr_en : in std_logic;
      data_in : in unsigned(6 downto 0);
      data_out : out unsigned(6 downto 0)
    );
  end component pc;
  signal data_out_pc: unsigned(6 downto 0);
  signal pc_enable: std_logic;

  component somador is
    port(
      data_in : in unsigned(6 downto 0);
		  data_out : out unsigned(6 downto 0)
    );
  end component somador;
  signal data_out_sum: unsigned(6 downto 0);

  component rom is
    port(
      clk : in std_logic;
      endereco : in unsigned(6 downto 0);
      dado : out unsigned(11 downto 0) 
    );
  end component rom;
  signal data_out_rom: unsigned(11 downto 0);

  component maquinaestado is
    port(
      clk : in std_logic;
      rst : in std_logic;
      estado : out std_logic
    );
  end component maquinaestado; 
  signal estado: std_logic;

  component mux is
    port(
      sel: in std_logic;
      entr0: in unsigned(6 downto 0);
      entr1: in unsigned(6 downto 0);
      saida: out unsigned(6 downto 0)
    );
  end component;
  signal data_out_mux: unsigned(6 downto 0);  

  signal opcode: unsigned(2 downto 0);
  signal jump_enable: std_logic;

begin
  pc_i: pc port map(clk=>clk, rst=>rst, wr_en=>pc_enable, data_in=>data_out_mux, data_out=>data_out_pc);
  somador_i: somador port map(data_in=>data_out_pc, data_out=>data_out_sum);
  rom_i: rom port map(clk=>clk, endereco=>data_out_pc, dado=>data_out_rom);
  maquinaestados_i: maquinaestado port map(clk=>clk, rst=>rst, estado=>estado);
  mux_i: mux port map(sel=>jump_enable, entr0=>data_out_sum, entr1=>data_out_rom(6 downto 0), saida=>data_out_mux);
 
  opcode <= data_out_rom(11 downto 9);
  jump_enable <= '1' when opcode="001" else
  '0';
  pc_enable <= estado;
end architecture a_unidadecontrole;
