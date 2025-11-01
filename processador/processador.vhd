library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity processador is
    port(
        clk_p   : in std_logic;
        rst_p   : in std_logic
    );
end entity;

architecture main of processador is

    -- Sinais de memória
    signal md_data_out  : std_logic_vector(7 downto 0); -- saída da memória de dados
    signal mp_data_out  : std_logic_vector(7 downto 0); -- saída da memória de programa
    signal mp_addr      : std_logic_vector(7 downto 0); -- endereço para memória de programa
    signal md_addr      : std_logic_vector(7 downto 0); -- endereço para memória de dados

    -- Sinais para banco de registradores
    signal reg_write    : std_logic;                     -- write enable pro banco
    signal dreg         : std_logic_vector(2 downto 0);  -- registrador destino
    signal data_fregf   : std_logic_vector(7 downto 0); -- dado a ser escrito
    signal r0_s         : std_logic_vector(7 downto 0);
    signal r1_s         : std_logic_vector(7 downto 0);
    signal r2_s         : std_logic_vector(7 downto 0);
    signal r3_s         : std_logic_vector(7 downto 0);
    signal r4_s         : std_logic_vector(7 downto 0); -- operando ULA
    signal r5_s         : std_logic_vector(7 downto 0); -- pilha
    signal r6_s         : std_logic_vector(7 downto 0); -- instrução
    signal r7_s         : std_logic_vector(7 downto 0); -- flags

    -- Sinais para UC
    signal opcode       : std_logic_vector(7 downto 0);
    signal alu_op       : std_logic_vector(7 downto 0);
    signal ula_r        : std_logic_vector(7 downto 0);
    signal op1_fdm      : std_logic_vector(7 downto 0);
    signal op2_fdm      : std_logic_vector(7 downto 0);

begin

    -- Instancia memória de programa
    imemp: entity work.memoria_programa
        port map (
            addr      => mp_addr,
            data_out  => mp_data_out
        );

    -- Instancia memória de dados
    imemd: entity work.memoria_dados
        port map (
            addr      => md_addr,
            data_out  => md_data_out
        );

    -- Instancia banco de registradores
    iregf: entity work.register_file
        port map (
            clk   => clk_p,
            rst   => rst_p,
            we    => reg_write,
            addr  => dreg, -- ?
            data  => data_fregf, --?
            r0    => r0_s,
            r1    => r1_s,
            r2    => r2_s,
            r3    => r3_s,
            r4    => r4_s,
            r5    => r5_s,
            r6    => r6_s,
            r7    => r7_s
        );

    -- Instancia unidade de controle
    iuc: entity work.control_unit
        port map (
            clk_uc      => clk_p,
            rst_uc      => rst_p,
            mp_addr     => mp_addr, 
            mp_data_out => mp_data_out,
            md_addr     => md_addr,
            md_data_out => md_data_out,
            dreg        => dreg, -- ?
            valor_op1   => r4_s,  -- ?
            valor_op2   => r5_s,  -- ?
            reg_write   => reg_write,
            dado_escrita=> data_fregf
        );

    -- Instancia ULA
    iula: entity work.ula
        port map (
            clk       => clk_p,
            operation => alu_op,
            op1       => op1_fdm,
            op2       => op2_fdm,
            r         => ula_r
        );

end architecture;