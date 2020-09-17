library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity toplevel is
  port(
            rst         : in std_logic;
            clk         : in std_logic;
            err_sig     : out std_logic;
            saida_rom   : out unsigned(11 downto 0);
            saida_pc    : out unsigned(6 downto 0);
            saida_reg_1 : out unsigned(15 downto 0);
            saida_reg_2 : out unsigned(15 downto 0);
            saida_ula   : out unsigned(15 downto 0));
  end entity;

architecture a_toplevel of toplevel is
  component unidadecontrole is
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
  end component;
  signal jump, regwrite, ulasrca, ulasrcb, ula_op, operror, acumulador : std_logic;

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
  signal instruction: unsigned(11 downto 0);

  component bancoreg is
    port(
      data_in : in unsigned(15 downto 0);
      seleciona_reg1: in unsigned(2 downto 0);
      seleciona_reg2: in unsigned(2 downto 0);
      seleciona_reg_write: in unsigned(2 downto 0);
      enable_write: in std_logic;
      clk: in std_logic;
      rst: in std_logic;
      saida_1: out unsigned(15 downto 0);
      saida_2: out unsigned(15 downto 0)
    );
  end component;
  signal seleciona_reg1: unsigned(2 downto 0);
  signal bancoreg_saida_1, bancoreg_saida_2: unsigned(15 downto 0);

  component ula is
    port (  
      entr0,entr1: in unsigned(15 downto 0);
      op: in std_logic;
      saida: out unsigned(15 downto 0);
      zero, sign: out std_logic
    );
  end component;
  signal ula_out_16bits: unsigned(15 downto 0);
  signal zero, sign: std_logic;

  component maquinaestado is
    port(
      clk,rst: in std_logic;
      estado: out unsigned(1 downto 0)
    );
  end component maquinaestado; 
  signal estado: unsigned(1 downto 0);

  component mux2x7 is
    port(
      sel: in std_logic;
      entr0: in unsigned(6 downto 0);
      entr1: in unsigned(6 downto 0);
      saida: out unsigned(6 downto 0)
    );
  end component;
  signal data_out_mux2x7: unsigned(6 downto 0); 

  component mux2x16 is
    port (  sel: in std_logic;
            entr0,entr1: in unsigned(15 downto 0);
            saida: out unsigned(15 downto 0));
  end component;
  signal data_out_mux2x16_a, data_out_mux2x16_b: unsigned(15 downto 0);
  
  component sign_ext is
    port (
          entr  : in unsigned(6 downto 0);
          saida : out unsigned(15 downto 0)
    );
  end component sign_ext;
  signal const_extendida : unsigned(15 downto 0);

  component reg16bits is
    port(
      clk : in std_logic;
      rst : in std_logic;
      wr_en : in std_logic;
      data_in : in unsigned(15 downto 0);
      data_out : out unsigned(15 downto 0)
    );
  end component;
  signal reg_intrucao_in, reg_instrucao_out: unsigned(15 downto 0);
  signal reg_instrucao_wr_en: std_logic;

  signal pc_interrupt : std_logic;
  signal fetch, execute : std_logic;
  signal banco_en : std_logic;

  begin
    err_sig <= operror;
    pc_interrupt <= not(operror) and fetch;
    saida_rom <= instruction;
    saida_pc <= data_out_pc;
    saida_reg_1 <= bancoreg_saida_1;
    saida_reg_2 <= bancoreg_saida_2;
    saida_ula <= ula_out_16bits;

    fetch <= '1' when estado = "00" else
             '0';
    execute <= '1' when estado = "01" else
               '0';

    unidade_de_controle_inst : unidadecontrole port map ( instruction => instruction,
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

    pc_inst : pc port map ( rst => rst,
                            clk => clk,
                            wr_en => fetch,
                            data_in => data_out_mux2x7,
                            data_out => data_out_pc);

    somador_inst : somador port map ( data_in => data_out_pc,
                                      data_out => data_out_sum);

    rom_inst : rom port map ( clk => clk,
                              endereco => data_out_pc,
                              dado => instruction);

    banco_en <= '1' when regwrite = '1' and execute = '1' else '0';

    seleciona_reg1 <= "001" when acumulador ='1' else
                      instruction(5 downto 3);

    banco_reg_inst : bancoreg port map ( seleciona_reg1 => seleciona_reg1,
                                          seleciona_reg2 => instruction(2 downto 0),
                                          seleciona_reg_write => seleciona_reg1,
                                          data_in => ula_out_16bits,
                                          enable_write => banco_en,
                                          clk => clk,
                                          rst => rst,
                                          saida_1 => bancoreg_saida_1,
                                          saida_2 => bancoreg_saida_2);

    ula_inst : ula port map ( entr0 => data_out_mux2x16_a,
                              entr1 => data_out_mux2x16_b,
                              op => ula_op,
                              saida => ula_out_16bits,
                              zero => zero,
                              sign => sign);

    maq_estados_inst : maquinaestado port map ( clk => clk,
                                              rst => rst,
                                              estado => estado);

    mux_pc : mux2x7 port map (  sel => jump,
                                entr0 => data_out_sum,
                                entr1 => instruction(6 downto 0),
                                saida => data_out_mux2x7);

    mux_ula_src_a : mux2x16 port map (  sel => ulasrca,
                                        entr0 => "0000000000000000",
                                        entr1 => bancoreg_saida_1,
                                        saida => data_out_mux2x16_a);

    mux_ula_src_b : mux2x16 port map (  sel => ulasrcb,
                                        entr0 => bancoreg_saida_2,
                                        entr1 => const_extendida,
                                        saida => data_out_mux2x16_b);

    sign_ext_inst : sign_ext port map ( entr => instruction(6 downto 0),
                                        saida => const_extendida);

  end architecture a_toplevel;