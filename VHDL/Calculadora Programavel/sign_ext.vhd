library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sign_ext is
    port (
            entr  : in unsigned(5 downto 0);
            saida : out unsigned(15 downto 0)
         );
end entity sign_ext;

architecture a_sign_ext of sign_ext is
begin
	saida <= (15 downto 6 => entr(5)) & entr;
end architecture a_sign_ext;