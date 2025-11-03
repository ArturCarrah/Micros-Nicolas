library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity control_unit is
    port (
        clk_uc        : in  std_logic;
        rst_uc        : in  std_logic;
        mp_addr       : out std_logic_vector(7 downto 0);
        mp_data_out   : in  std_logic_vector(7 downto 0);
        md_addr       : out std_logic_vector(7 downto 0);
        md_data_out   : in  std_logic_vector(7 downto 0);
        addr_dest     : out std_logic_vector(2 downto 0);
        addr_op1      : out std_logic_vector(2 downto 0);
        addr_op2      : out std_logic_vector(2 downto 0);
        valor_op1     : in  std_logic_vector(7 downto 0);
        valor_op2     : in  std_logic_vector(7 downto 0);
        reg_write     : out std_logic;
        dado_escrita  : out std_logic_vector(7 downto 0)
    );
end entity;

architecture main of control_unit is

    type state_type is (
        FETCH_A, FETCH_B,           -- Busca de Instrução (2 ciclos)
        DECODE_D_A, DECODE_D_B,     -- Busca Addr Destino (2 ciclos)
        DECODE_O1_A, DECODE_O1_B,    -- Busca Addr Op1 (2 ciclos)
        DECODE_O2_A, DECODE_O2_B,    -- Busca Addr Op2 (2 ciclos)
        EXECUTE,
        WAIT_ALU_1,
        WAIT_ALU_2,
        WRITEBACK
    );

    signal state    : state_type := FETCH_A;
    signal pc       : integer range 0 to 31 := 0;
    signal ireg     : std_logic_vector(7 downto 0);
    signal opcode   : std_logic_vector(7 downto 0);
    signal alu_op   : std_logic_vector(7 downto 0);
    signal ula_r    : std_logic_vector(7 downto 0);
    
begin

    iula: entity work.ula
        port map (
            clk       => clk_uc,
            operation => alu_op,
            op1       => valor_op1,
            op2       => valor_op2,
            r         => ula_r
        );

    process(clk_uc, rst_uc)
    begin
        if rst_uc = '1' then
            pc <= 0;
            state <= FETCH_A;
            reg_write <= '0';
            md_addr <= (others => '0');
            mp_addr <= (others => '0');
            addr_dest <= (others => '0');
            addr_op1 <= (others => '0');
            addr_op2 <= (others => '0');
            alu_op <= (others => '0');
            
        elsif rising_edge(clk_uc) then

            reg_write <= '0'; 
            
            case state is
                -- CICLO 1: Envia endereço 'pc' para a Memória de Programa
                when FETCH_A =>
                    mp_addr <= std_logic_vector(to_unsigned(pc, 8));
                    state <= FETCH_B;

                -- CICLO 2: O dado (opcode) chegou. Salva em 'ireg'
                when FETCH_B =>
                    ireg <= mp_data_out;
                    state <= DECODE_D_A;

                -- CICLO 3: Envia endereço '3*pc' para a Memória de Dados
                when DECODE_D_A =>
                    md_addr <= std_logic_vector(to_unsigned(3*pc, 8));
                    state <= DECODE_D_B;

                -- CICLO 4: O dado (addr_dest) chegou. Salva.
                when DECODE_D_B =>
                    addr_dest <= md_data_out(2 downto 0);
                    state <= DECODE_O1_A;

                -- CICLO 5: Envia endereço '3*pc + 1'
                when DECODE_O1_A =>
                    md_addr <= std_logic_vector(to_unsigned(3*pc + 1, 8));
                    state <= DECODE_O1_B;
                    
                -- CICLO 6: O dado (addr_op1) chegou. Salva.
                when DECODE_O1_B =>
                    addr_op1 <= md_data_out(2 downto 0);
                    state <= DECODE_O2_A;

                -- CICLO 7: Envia endereço '3*pc + 2'
                when DECODE_O2_A =>
                    md_addr <= std_logic_vector(to_unsigned(3*pc + 2, 8));
                    state <= DECODE_O2_B;
                    
                -- CICLO 8: O dado (addr_op2) chegou. Salva.
                when DECODE_O2_B =>
                    addr_op2 <= md_data_out(2 downto 0);
                    opcode <= ireg; -- Salva o opcode para a ULA
                    state <= EXECUTE;

                -- CICLO 9: Executa a operação na ULA
                when EXECUTE =>
                    alu_op <= opcode;
                    state <= WAIT_ALU_1;
                    
                when WAIT_ALU_1 =>
                    --Fazendo isso pra evitar problema de sincronização
                    state <= WAIT_ALU_2;
                    
                when WAIT_ALU_2 =>
                    --Fazendo isso pra evitar problema de sincronização
                    state <= WRITEBACK;
                

                -- CICLO 10: Salva o resultado no Banco de Registradores
                when WRITEBACK =>
                    reg_write <= '1';
                    dado_escrita <= ula_r;
                    
                    if pc = 31 then
                        pc <= 0;
                    else
                        pc <= pc + 1;
                    end if;
                    state <= FETCH_A;
            end case;
        end if;
    end process;
end architecture;
