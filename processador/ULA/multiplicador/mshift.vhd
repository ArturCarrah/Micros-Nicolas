library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mshift is
    port (
        a : in std_logic_vector(7 downto 0);
        shift : in integer range 0 to 8;
        b : out std_logic_vector(15 downto 0)
    );
end entity mshift;

architecture main of mshift is
    signal temp_res : std_logic_vector(15 downto 0);
    begin
        process(a, shift)
        variable temp_8bit : std_logic_vector(15 downto 0) := (others => '0');
        begin
            temp_8bit(7 downto 0) := a;
            temp_res <= std_logic_vector(shift_left(unsigned(temp_8bit), shift));
        end process;
        b <= temp_res;
    end main;
