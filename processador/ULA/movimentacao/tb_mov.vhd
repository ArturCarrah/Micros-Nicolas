library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity testbench is
end entity testbench;

architecture main of testbench is
    signal v_tb     : std_logic_vector(7 downto 0);
    signal rout_tb  : std_logic_vector(7 downto 0);
    begin
        uut: entity work.mov
            port map (
                v       => v_tb,
                rout    => rout_tb
            );
        process
        begin
            v_tb <= "00000101";
            wait for 10 ns;

            v_tb <= "00001111";
            wait for 10 ns;

            v_tb <= "00110101";
            wait for 10 ns;

            wait;
        end process;
end main;