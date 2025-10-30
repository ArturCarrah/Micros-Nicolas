library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mov is
    port (
        v       :   in  std_logic_vector(7 downto 0);

        rout    :   out std_logic_vector(7 downto 0)
    );  
end entity mov;

architecture main of mov is
    begin
        process
        begin
            rout <= v;
        end process;
end main;