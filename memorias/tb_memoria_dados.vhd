library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity testbench is
end entity testbench;

architecture main of testbench is
    signal clk_tb       :    std_logic;
    signal re_tb        :    std_logic;
    signal we_tb        :    std_logic;

    signal addr_tb      :   std_logic_vector(7 downto 0);
    signal datain_tb    :   std_logic_vector(7 downto 0);
    signal dataout_tb    :   std_logic_vector(7 downto 0);
    begin
        uut: entity work.memoria_dados
            port map (
                clk     => clk_tb,
                re      => re_tb,
                we      => we_tb,

                addr    => addr_tb,

                data_in    => datain_tb,
                data_out   => dataout_tb
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
            -- escrever data em r4
            re_tb   <= '1';
            we_tb   <= '1';
            addr_tb <= "00000100";
            datain_tb <= "11110011";
            wait until rising_edge(clk_tb);
            
            -- ler escrever na posição 5;
            re_tb   <= '1';
            we_tb   <= '1';
            addr_tb <= "00000101";
            datain_tb <= "00001111";
            wait until rising_edge(clk_tb);


            re_tb   <= '1';
            we_tb   <= '0';
            addr_tb <= "00000100";
            wait until rising_edge(clk_tb);

            re_tb   <= '1';
            we_tb   <= '0';
            addr_tb <= "00000101";
            wait until rising_edge(clk_tb);

            -- reseta todos 
            re_tb   <= '0';
            we_tb   <= '0';
            wait until rising_edge(clk_tb);

            wait;
        end process;
end main;