library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_ula is
end tb_ula;

architecture sim of tb_ula is
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

    -- Geração do clock
    clk_process : process
    begin
        clk_tb <= '0';
        wait for CLK_PERIOD/2;
        clk_tb <= '1';
        wait for CLK_PERIOD/2;
    end process;

    -- Estímulos
    stim_proc : process
    begin
        -- Teste 1: operação ADD ("00000100")
        operation_tb <= "00000100";
        op1_tb <= "00001010"; -- 10
        op2_tb <= "00000101"; -- 5
        wait for CLK_PERIOD;
        
        -- Teste 2: operação MUL ("00000110")
        operation_tb <= "00000110";
        op1_tb <= "00000011"; -- 3
        op2_tb <= "00000100"; -- 4
        wait for CLK_PERIOD;

        -- Teste 3: operação ADD novamente
        operation_tb <= "00000100";
        op1_tb <= "00001111"; -- 15
        op2_tb <= "00000001"; -- 1
        wait for CLK_PERIOD;

        -- Finaliza simulação
        wait for 20 ns;
        assert false report "Fim da simulação." severity failure;
    end process;
end sim;
