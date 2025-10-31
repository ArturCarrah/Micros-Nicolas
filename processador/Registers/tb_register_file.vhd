library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity testbench is
end entity testbench;

architecture main of testbench is
    signal clk_tb       :    std_logic;
    signal re_tb        :    std_logic;
    signal we_tb        :    std_logic;

    signal addr_tb      :   std_logic_vector(2 downto 0);
    signal data_tb      :   std_logic_vector(7 downto 0) := (others => 'Z');

    signal r0_tb        :    std_logic_vector(7 downto 0); 
    signal r1_tb        :    std_logic_vector(7 downto 0); 
    signal r2_tb        :    std_logic_vector(7 downto 0); 
    signal r3_tb        :    std_logic_vector(7 downto 0); 
    signal r4_tb        :    std_logic_vector(7 downto 0); 
    signal r5_tb        :    std_logic_vector(7 downto 0);
    signal r6_tb        :    std_logic_vector(7 downto 0);
    signal r7_tb        :    std_logic_vector(7 downto 0);
    begin
        uut: entity work.register_file
            port map (
                clk     => clk_tb,
                re      => re_tb,
                we      => we_tb,

                addr    => addr_tb,
                data    => data_tb,

                r0      => r0_tb,
                r1      => r1_tb,
                r2      => r2_tb,
                r3      => r3_tb,
                r4      => r4_tb,
                r5      => r5_tb,
                r6      => r6_tb,
                r7      => r7_tb
            );

        clock_gen: process
        begin
            for i in 0 to 40 loop  -- 40 ciclos de clock
                clk_tb <= '0';
                wait for 5 ns;
                clk_tb <= '1';
                wait for 5 ns;
            end loop;
            wait; -- encerra o processo
        end process;


        process
        begin
        	wait until rising_edge(clk_tb);
            -- escrever data em r4
            re_tb   <= '1';
            we_tb   <= '1';
            addr_tb <= "100";
            data_tb <= "11110011";
            wait until rising_edge(clk_tb);
            
            -- ler r4
            re_tb   <= '1';
            we_tb   <= '0';
            addr_tb <= "100";
            wait until rising_edge(clk_tb);

            -- reseta todos 
            re_tb   <= '0';
            we_tb   <= '0';
            wait until falling_edge(clk_tb);

             -- tenta escrever com clock em 0 
            re_tb   <= '1';
            we_tb   <= '1';
            addr_tb <=  "100";
            data_tb <= "11110011";
            wait until rising_edge(clk_tb);
            wait;
        end process;
end main;