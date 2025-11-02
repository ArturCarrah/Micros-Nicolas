library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity testbench is
end testbench;

architecture behavior of testbench is
    signal clk      : std_logic := '0';
    signal rst      : std_logic := '0';
    signal we       : std_logic := '0';
    signal addr     : std_logic_vector(2 downto 0);
    signal data_in  : std_logic_vector(7 downto 0);
    signal data_out : std_logic_vector(7 downto 0);

    signal r0, r1, r2, r3, r4, r5, r6, r7 : std_logic_vector(7 downto 0);

begin
    uut: entity work.register_file
        port map (
            clk      => clk,
            rst      => rst,
            we       => we,
            addr     => addr,
            data_in  => data_in,
            data_out => data_out,
            r0 => r0, r1 => r1, r2 => r2, r3 => r3,
            r4 => r4, r5 => r5, r6 => r6, r7 => r7
        );

    clk_process: process
    begin
        for i in 0 to 19 loop 
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end loop;
        wait;
    end process;

    stim_proc: process
    begin
        rst <= '1';
        wait for 10 ns;
        rst <= '0';

        we <= '1';
        addr <= "000"; data_in <= x"AA"; wait for 10 ns;
        addr <= "001"; data_in <= x"BB"; wait for 10 ns;
        addr <= "010"; data_in <= x"CC"; wait for 10 ns;
        addr <= "011"; data_in <= x"DD"; wait for 10 ns;

        we <= '0';
        addr <= "000"; wait for 10 ns;
        addr <= "001"; wait for 10 ns;
        addr <= "010"; wait for 10 ns;
        addr <= "011"; wait for 10 ns;

        wait;
    end process;

end behavior;