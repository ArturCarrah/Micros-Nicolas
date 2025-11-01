library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity testbench is
end entity;

architecture behavior of testbench is
    -- Sinais para conectar à memória
    signal addr     : std_logic_vector(7 downto 0) := (others => '0');
    signal data_out : std_logic_vector(7 downto 0);
begin
    -- Instancia a memória
    uut: entity work.memoria_dados
        port map(
            addr     => addr,
            data_out => data_out
        );

    -- Processo para simular a leitura sequencial
    stimulus: process
        variable i : integer := 0;
    begin
        -- Espera um pouco para a memória carregar do arquivo
        wait for 10 ns;

        -- Ler todos os endereços da memória
        for i in 0 to 31 loop
            addr <= std_logic_vector(to_unsigned(i, addr'length));
            wait for 10 ns;  -- espera para o EDAWave capturar
        end loop;

        wait; -- termina a simulação
    end process;

end architecture;