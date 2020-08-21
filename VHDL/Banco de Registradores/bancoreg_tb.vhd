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
  
  signal sel_reg1, sel_reg2, sel_reg_write: unsigned(2 downto 0) := "000";
  signal clk, rst, enable_write: std_logic := '0';
  signal saida_1, saida_2, data_in: unsigned(15 downto 0) := "0000000000000000";

begin
  uut: bancoreg port map ( seleciona_reg1 => sel_reg1,
                      seleciona_reg2 => sel_reg2,
                      seleciona_reg_write => sel_reg_write,
                      data_in => data_in,
                      enable_write => enable_write,
                      clk => clk,
                      rst => rst,
                      saida_1 => saida_1,
                      saida_2 => saida_2
  );
 
  process
  begin
    rst <= '1';
    wait for 100 ns;
    rst <= '0';
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
    enable_write <= '0';
    wait for 200 ns;
    enable_write <= '1';
    wait;
  end process;

  process
  begin
    sel_reg1 <= "001";
    sel_reg2 <= "001";
    sel_reg_write <= "001";
    data_in <= "0000000000100100";
    wait for 100 ns;   
    sel_reg1 <= "001";
    sel_reg2 <= "001";
    sel_reg_write <= "001";
    data_in <= "0000000000100100";
    wait for 100 ns;   
    sel_reg1 <= "000";
    sel_reg2 <= "000";
    sel_reg_write <= "001";
    data_in <= "0000000000100100";
    wait for 100 ns;   
    sel_reg1 <= "000";
    sel_reg2 <= "001";
    sel_reg_write <= "010";
    data_in <= "0000000000100101";
    wait for 100 ns;   
    sel_reg1 <= "001";
    sel_reg2 <= "010";
    sel_reg_write <= "011";
    data_in <= "0000000000100111";
    wait for 100 ns;   
    sel_reg1 <= "010";
    sel_reg2 <= "011";
    sel_reg_write <= "100";
    data_in <= "0000001100100100";
    wait for 100 ns;   
    sel_reg1 <= "011";
    sel_reg2 <= "100";
    sel_reg_write <= "101";
    data_in <= "0011000000100100";
    wait for 100 ns;   
    sel_reg1 <= "100";
    sel_reg2 <= "101";
    sel_reg_write <= "110";
    data_in <= "0111000000100100";
    wait for 100 ns;
    sel_reg1 <= "101";
    sel_reg2 <= "111";
    sel_reg_write <= "111";
    data_in <= "0111001110100100";
    wait for 100 ns;
    sel_reg1 <= "111";
    sel_reg2 <= "000";
    sel_reg_write <= "110";
    data_in <= "0111001100100100";
    wait for 100 ns;
    wait;
  end process;
  end architecture a_bancoreg_tb;

