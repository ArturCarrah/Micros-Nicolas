library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity testbench is
end entity testbench;

architecture main of testbench is
    signal a_tb : std_logic_vector(3 downto 0);
    signal shift_tb : integer range 0 to 4;
    signal b_tb : std_logic_vector(7 downto 0);
begin
    uut: entity work.mshift
        port map (
            a => a_tb,
            shift => shift_tb,
            b => b_tb
        );
    process
    begin
       
        a_tb <= "1111";
        shift_tb <= 4; 
        wait for 5 ns;

        a_tb <= "1001";
        shift_tb <= 4; 
        wait for 5 ns;
        
        wait;
    end process;
end architecture main;