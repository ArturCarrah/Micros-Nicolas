library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity testbench is
end testbench;

architecture sim of testbench is
    -- Component da ULA
    component ula is
        port (
            clk       : in  std_logic;
            operation : in  std_logic_vector(7 downto 0);
            op1       : in  std_logic_vector(7 downto 0);
            op2       : in  std_logic_vector(7 downto 0);
            r         : out std_logic_vector(7 downto 0)
        );
    end component;

    -- Sinais de teste
    signal clk_tb       : std_logic := '0';
    signal operation_tb : std_logic_vector(7 downto 0);
    signal op1_tb       : std_logic_vector(7 downto 0);
    signal op2_tb       : std_logic_vector(7 downto 0);
    signal r_tb         : std_logic_vector(7 downto 0);

    -- Clock period
    constant CLK_PERIOD : time := 10 ns;

begin
    -- Instancia a ULA
    DUT: ula
        port map (
            clk       => clk_tb,
            operation => operation_tb,
            op1       => op1_tb,
            op2       => op2_tb,
            r         => r_tb
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

    -- Estímulos
    stim_proc : process
    begin
        -- Teste 1: operação ADD ("00000100")
        operation_tb <= "00000100";
        op1_tb <= "00001010"; -- 10
        op2_tb <= "00000101"; -- 5
        wait until rising_edge(clk_tb);
        
        -- Teste 2: operação MUL ("00000110")
        operation_tb <= "00000110";
        op1_tb <= "00000011"; -- 3
        op2_tb <= "00000100"; -- 4
       	wait until rising_edge(clk_tb);

        -- Teste 3: operação ADD novamente
        operation_tb <= "00000100";
        op1_tb <= "00001111"; -- 15
        op2_tb <= "00000001"; -- 1
        wait until rising_edge(clk_tb);
        
        -- Finaliza simulação
        wait for 20 ns;
        wait;
    end process;
end sim;