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
	signal run_clk: std_logic := '1';
    
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

    -- Geração de clock
    clock_gen: process
    begin
    	
        loop
            clk_tb <= '0';
            wait for CLK_PERIOD / 2;
            clk_tb <= '1';
            wait for CLK_PERIOD / 2;
            
            if run_clk = '0' then
            	exit; 
        	end if;
        end loop;
        wait;
    end process;

    stim_proc : process
    begin
        -----------------------------------------------------------------
        -- MOV
        -----------------------------------------------------------------
        operation_tb <= "00000000";
        op1_tb <= "00001111"; -- 15
        wait until rising_edge(clk_tb);
        wait for 1 ns;
        report "Saida MOV: " & to_string(r_tb);

        -----------------------------------------------------------------
        -- SHIFT ESQUERDA
        -----------------------------------------------------------------
        operation_tb <= "00000010";
        wait until rising_edge(clk_tb);  
        op1_tb <= "00001101"; -- 13
        wait until rising_edge(clk_tb);
        wait until rising_edge(clk_tb);  
        wait for 1 ns;
        report "Saida SHL: " & to_string(r_tb);

        -----------------------------------------------------------------
        -- SHIFT DIREITA
        -----------------------------------------------------------------
        operation_tb <= "00000011";
        wait until rising_edge(clk_tb);  
        op1_tb <= "00001010"; -- 10
        wait until rising_edge(clk_tb);
        wait until rising_edge(clk_tb); 
        wait for 1 ns;
        report "Saida SHR: " & to_string(r_tb);

        -----------------------------------------------------------------
        -- ADD
        -----------------------------------------------------------------
        operation_tb <= "00000100";
        op1_tb <= "00001010"; -- 10
        op2_tb <= "00000101"; -- 5
        wait until rising_edge(clk_tb);
        wait for 1 ns;
        report "Saida ADD: " & to_string(r_tb);

        -----------------------------------------------------------------
        -- MUL
        -----------------------------------------------------------------
        operation_tb <= "00000110";
        op1_tb <= "00000011"; -- 3
        op2_tb <= "00000100"; -- 4
        wait until rising_edge(clk_tb);
        wait for 1 ns;
        report "Saida MUL: " & to_string(r_tb);

        -----------------------------------------------------------------
        -- DIV
        -----------------------------------------------------------------
        operation_tb <= "00000111";
        op1_tb <= "00001010"; -- 10
        op2_tb <= "00000010"; -- 2
        wait until rising_edge(clk_tb);
        wait for 1 ns;
        report "Saida DIV: " & to_string(r_tb);

        -----------------------------------------------------------------
        -- MOD
        -----------------------------------------------------------------
        operation_tb <= "00001000";
        op1_tb <= "00001010"; -- 10
        op2_tb <= "00000110"; -- 6
        wait until rising_edge(clk_tb);
        wait for 1 ns;
        report "Saida MOD: " & to_string(r_tb);

        -----------------------------------------------------------------
        -- COMPARADOR
        -----------------------------------------------------------------
        -- A < B
        operation_tb <= "00001001";
        op1_tb <= "00000101"; -- 5
        op2_tb <= "00001000"; -- 8
        wait until rising_edge(clk_tb);
        wait for 1 ns;
        report "Saida CMP_S: " & to_string(r_tb);

        -- A > B
        operation_tb <= "00001001";
        op1_tb <= "00001111"; -- 15
        op2_tb <= "00001000"; -- 8
        wait until rising_edge(clk_tb);
        wait for 1 ns;
        report "Saida CMP_G: " & to_string(r_tb);

        -- A = B
        operation_tb <= "00001001";
        op1_tb <= "00000110"; -- 6
        op2_tb <= "00000110"; -- 6
        wait until rising_edge(clk_tb);
        wait for 1 ns;
        report "Saida CMP_E: " & to_string(r_tb);

        -----------------------------------------------------------------
        -- AND
        -----------------------------------------------------------------
        operation_tb <= "00001010";
        op1_tb <= "00001100"; -- 12 (1100)
        op2_tb <= "00001010"; -- 10 (1010)
        wait until rising_edge(clk_tb);
        wait for 1 ns;
        report "Saida AND: " & to_string(r_tb);

        -----------------------------------------------------------------
        -- OR
        -----------------------------------------------------------------
        operation_tb <= "00001011";
        op1_tb <= "00001100"; -- 12
        op2_tb <= "00001010"; -- 10
        wait until rising_edge(clk_tb);
        wait for 1 ns;
        report "Saida OR: " & to_string(r_tb);

        -----------------------------------------------------------------
        -- NOT
        -----------------------------------------------------------------
        operation_tb <= "00001100";
        op1_tb <= "00000000"; -- 0
        wait until rising_edge(clk_tb);
        wait for 1 ns;
        report "Saida NOT: " & to_string(r_tb);

        -----------------------------------------------------------------
        -- XOR
        -----------------------------------------------------------------
        operation_tb <= "00001101";
        op1_tb <= "00001100"; -- 12 (1100)
        op2_tb <= "00001010"; -- 10 (1010)
        wait until rising_edge(clk_tb);
        wait for 1 ns;
        report "Saida XOR: " & to_string(r_tb);

        wait for 10 ns;
        run_clk <= '0';
        wait;
    end process;
end sim;

