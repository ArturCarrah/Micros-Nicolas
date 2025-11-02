library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity testbench is
end entity testbench;

architecture main of testbench is
    signal clk_tb    : std_logic := '0';
    signal rst_tb    : std_logic := '1';
    signal addr_tb   : std_logic_vector(7 downto 0) := (others => '0');
    signal dataout_tb: std_logic_vector(7 downto 0);
begin
    -- Instancia a memória de dados
    uut: entity work.memoria_programa
        port map (
            clk      => clk_tb,
            rst      => rst_tb,
            addr     => addr_tb,
            data_out => dataout_tb
        );

    clock_gen: process
        constant NUM_CYCLES : integer := 40;
        variable i          : integer := 0;
    begin
        while i < NUM_CYCLES loop
            clk_tb <= '0';
            wait for 5 ns;
            clk_tb <= '1';
            wait for 5 ns;
            i := i + 1;
        end loop;
        wait;  -- termina o processo
    end process;

    -- Teste: varre a memória
    stimulus_proc: process
    begin
        -- Ativa reset
        rst_tb <= '1';
        wait for 10 ns;
        rst_tb <= '0';  -- Desativa reset

        -- Varre os endereços da memória
        for i in 0 to 31 loop
            addr_tb <= std_logic_vector(to_unsigned(i, 8));
            wait for 10 ns;  -- tempo para visualizar no waveform
        end loop;

        wait;  -- para simulação
    end process;

end architecture;
