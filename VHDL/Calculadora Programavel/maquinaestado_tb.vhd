library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity maquinaestado_tb is
end entity maquinaestado_tb;

architecture a_maquinaestado_tb of maquinaestado_tb is
    component maquinaestado is
        port ( 
            clk : in std_logic;
            rst : in std_logic;
            estado : out unsigned(1 downto 0)
        );
    end component maquinaestado;
    signal clk ,rst : std_logic;
    signal estado_s : unsigned(1 downto 0);
begin
    uut : maquinaestado port map( clk => clk,
                                rst => rst,
                                estado => estado_s
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
        rst <= '1';
        wait for 200 ns;
        rst <= '0';
        wait;
    end process;
end architecture a_maquinaestado_tb;