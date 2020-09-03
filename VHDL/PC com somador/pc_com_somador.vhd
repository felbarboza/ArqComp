library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc_com_somador is
  port(
    clk: std_logic;
    rst: std_logic
  );
end entity pc_com_somador;

architecture a_pc_com_somador of pc_com_somador is
  component pc
    port(
      clk : in std_logic;
      rst : in std_logic;
      wr_en : in std_logic;
      data_in : in unsigned(6 downto 0);
      data_out : out unsigned(6 downto 0) 
    );
  end component;
  component somador
    port(
      data_in : in unsigned(6 downto 0);
		  data_out : out unsigned(6 downto 0) 
    );
  end component;
  signal data_out_p : unsigned(6 downto 0):="0000000";
  signal data_out_s: unsigned(6 downto 0):="0000000";
begin

  pc_i: pc port map(
    clk=>clk, 
    rst=>rst, 
    wr_en=>'1', 
    data_in=>data_out_s, 
    data_out=>data_out_p
  );
  somador_i: somador port map(
    data_in=>data_out_p,
    data_out=>data_out_s
  );
   
end architecture a_pc_com_somador;

