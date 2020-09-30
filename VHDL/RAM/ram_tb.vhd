library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram_tb is
end entity ram_tb;

architecture a_ram_tb of ram_tb is
    component ram is
        port( 
              clk : in std_logic;
              endereco : in unsigned(6 downto 0);
              wr_en : in std_logic;
              dado_in : in unsigned(15 downto 0);
              dado_out : out unsigned(15 downto 0)
            );
    end component ram;
    signal clk, wr_en : std_logic;
    signal endereco : unsigned(6 downto 0);
    signal dado_in, dado_out : unsigned(15 downto 0);
begin
    uut : ram port map(
                        clk => clk,
                        wr_en => wr_en,
                        endereco => endereco,
                        dado_in => dado_in,
                        dado_out => dado_out
                      );

    process
    begin
        clk <= '0';
        wait for 50 ns;
        clk <= '1';
        wait for 50 ns;
    end process;

    process
    begin
        endereco <= "0000000";
        wr_en <= '1';
        dado_in <= "0000000000000110";
        wait for 100 ns;
        endereco <= "0000000";
        wr_en <= '0';
        wait for 100 ns;
        endereco <= "0000100";
        wr_en <= '1';
        dado_in <= "0010110011100110";
        wait for 100 ns;
        endereco <= "0010011";
        wr_en <= '1';
        dado_in <= "0000011100000110";
        wait for 100 ns;
        endereco <= "0000100";
        wr_en <= '0';
        wait for 100 ns;
        endereco <= "0010011";
        wr_en <= '0';
        wait for 100 ns;
        wait;
    end process;
end architecture a_ram_tb;