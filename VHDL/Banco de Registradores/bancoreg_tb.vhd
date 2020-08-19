library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bancoreg_tb is
end entity bancoreg_tb;

architecture a_bancoreg_tb of bancoreg_tb is
  component bancoreg is
    port (
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
  end component bancoreg;
  component mux is 
    port(
      sel: in std_logic;
      entr0,entr1: in unsigned(15 downto 0);
      saida: out unsigned(15 downto 0)
    );
  end component mux;
  component ula is
    port(
      entr0,entr1: in unsigned(15 downto 0);
      op: in unsigned(1 downto 0);
      saida_soma_sub: out unsigned(15 downto 0);
      saida_iguais, saida_e_maior: out std_logic
    );
  end component ula;

  signal sel_reg1, sel_reg2, sel_reg_write: unsigned(2 downto 0);
  signal clk, rst, enable_write, sel_mux: std_logic;
  signal saida_1, saida_2, saida_ula, top_level_signal, saida: unsigned(15 downto 0);
  signal operacao: unsigned(1 downto 0);
  
begin
  uut: bancoreg port map ( seleciona_reg1 => sel_reg1,
                      seleciona_reg2 => sel_reg2,
                      seleciona_reg_write => sel_reg_write,
                      data_in => saida_ula,
                      enable_write => enable_write,
                      clk => clk,
                      rst => rst,
                      saida_1 => saida_1,
                      saida_2 => saida_2
  );
  uux: mux port map (  sel => sel_mux,
                  entr0 => saida_2,
                  entr1 => top_level_signal,
                  saida => saida
  );
  uuu: ula port map (entr0=>saida_1,
                entr1=> saida,
                op => operacao,
                saida_soma_sub => saida_ula);

  process
  begin
    rst <= '1';
    wait;
  end process;

  process
  begin
    clk <= '0';
    wait for 50 ns;
    clk <= '1';
    wait for 50 ns;
  end process;

  process
  begin
    rst <= '0';
    wait for 400 ns;
    rst <= '1';
    wait for 400 ns;
  end process;

  process
  begin 
    enable_write <= '1';
    wait for 500 ns;
    enable_write <= '0';
    wait for 500 ns;
  end process;

  process
  begin
      sel_reg1 <= "000";
      sel_reg2 <= "010";
      sel_reg_write <= "111";
      operacao <= "00";
      sel_mux <= '1';
      top_level_signal <= "0000000000100100";
      wait for 100 ns;
      sel_reg1 <= "111";
      sel_reg2 <= "000";
      sel_reg_write <= "101";
      operacao <= "00";
      sel_mux <= '0';
      top_level_signal <= "0000011001101100";
      wait for 100 ns;
      sel_reg1 <= "111";
      sel_reg2 <= "000";
      sel_reg_write <= "001";
      operacao <= "01";
      sel_mux <= '0';
      top_level_signal <= "0000000000100100";
      wait for 100 ns;
      sel_reg1 <= "111";
      sel_reg2 <= "000";
      sel_reg_write <= "110";
      operacao <= "01";
      sel_mux <= '1';
      top_level_signal <= "0000000000001100";
      wait for 100 ns;
    end process;
  end architecture a_bancoreg_tb;
