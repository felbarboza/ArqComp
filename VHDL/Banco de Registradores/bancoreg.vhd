library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bancoreg is
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
 end entity;
 
 architecture a_bancoreg of bancoreg is
  component reg16bits is
    port( clk : in std_logic;
    rst : in std_logic;
    wr_en : in std_logic;
    data_in : in unsigned(15 downto 0);
    data_out : out unsigned(15 downto 0)
  );
  end component;
    signal zero, reg0_out, reg1_out, reg2_out, reg3_out, reg4_out, reg5_out, reg6_out, reg7_out, reg8_out: unsigned(15 downto 0); 
    signal wr_en0, wr_en1, wr_en2, wr_en3, wr_en4, wr_en5, wr_en6, wr_en7, wr_en8 : std_logic;
  begin
  reg0: reg16bits port map(clk=>clk, rst=>rst, wr_en=>wr_en0, data_in=>zero, data_out=>reg0_out);
  reg1: reg16bits port map(clk=>clk, rst=>rst, wr_en=>wr_en1, data_in=>data_in, data_out=>reg1_out);
  reg2: reg16bits port map(clk=>clk, rst=>rst, wr_en=>wr_en2, data_in=>data_in, data_out=>reg2_out);
  reg3: reg16bits port map(clk=>clk, rst=>rst, wr_en=>wr_en3, data_in=>data_in, data_out=>reg3_out);
  reg4: reg16bits port map(clk=>clk, rst=>rst, wr_en=>wr_en4, data_in=>data_in, data_out=>reg4_out);
  reg5: reg16bits port map(clk=>clk, rst=>rst, wr_en=>wr_en5, data_in=>data_in, data_out=>reg5_out);
  reg6: reg16bits port map(clk=>clk, rst=>rst, wr_en=>wr_en6, data_in=>data_in, data_out=>reg6_out);
  reg7: reg16bits port map(clk=>clk, rst=>rst, wr_en=>wr_en7, data_in=>data_in, data_out=>reg7_out);
  
  saida_1 <= reg0_out when seleciona_reg1 = "000" else
            reg1_out when seleciona_reg1 = "001" else
            reg2_out when seleciona_reg1 = "010" else
            reg3_out when seleciona_reg1 = "011" else
            reg4_out when seleciona_reg1 = "100" else
            reg5_out when seleciona_reg1 = "101" else
            reg6_out when seleciona_reg1 = "110" else
            reg7_out when seleciona_reg1 = "111" else
            "0000000000000000";
  saida_2 <= reg0_out when seleciona_reg2 = "000" else
            reg1_out when seleciona_reg2 = "001" else
            reg2_out when seleciona_reg2 = "010" else
            reg3_out when seleciona_reg2 = "011" else
            reg4_out when seleciona_reg2 = "100" else
            reg5_out when seleciona_reg2 = "101" else
            reg6_out when seleciona_reg2 = "110" else
            reg7_out when seleciona_reg2 = "111" else
            "0000000000000000";
            
  zero<="0000000000000000";
  wr_en0 <= '1';
  wr_en1 <= enable_write when seleciona_reg_write = "001" else '0';
  wr_en2 <= enable_write when seleciona_reg_write = "010" else '0';
  wr_en3 <= enable_write when seleciona_reg_write = "011" else '0';
  wr_en4 <= enable_write when seleciona_reg_write = "100" else '0';
  wr_en5 <= enable_write when seleciona_reg_write = "101" else '0';
  wr_en6 <= enable_write when seleciona_reg_write = "110" else '0';
  wr_en7 <= enable_write when seleciona_reg_write = "111" else '0';
 end architecture a_bancoreg;