library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity control_unit is
    port (
        clk_uc          : in  std_logic;
        rst_uc          : in  std_logic;

        -- Comunicação com memória de programa
        mp_addr         : out std_logic_vector(7 downto 0);
        mp_data_out     : in  std_logic_vector(7 downto 0);

        -- Comunicação com memória de dados
        md_addr         : out std_logic_vector(7 downto 0);
        md_data_out     : in  std_logic_vector(7 downto 0);

        -- Comunicação com banco de registradores
        dreg            : out std_logic_vector(7 downto 0);  -- registrador destino2
        valor_op1       : in  std_logic_vector(7 downto 0);
        valor_op2       : in  std_logic_vector(7 downto 0);
        reg_write       : out std_logic;
        dado_escrita    : out std_logic_vector(7 downto 0)
    );
end entity;

architecture main of control_unit is
    type state_type is (FETCH, DECODE_D, DECODE_O1, DECODE_O2, EXECUTE, WRITEBACK);

    -- Sinais da maquina de estado
    signal state        : state_type := FETCH;          -- estado atual
    signal pc           : integer range 0 to 31 := 0;   -- program counter
    signal ireg         : std_logic_vector(7 downto 0); -- registrador de instrução
    signal opcode       : std_logic_vector(7 downto 0); -- armazena temporariamente a instrução

    -- Sinais para ULA
    signal alu_op       : std_logic_vector(7 downto 0); -- operação para passar pra ula
    signal ula_r        : std_logic_vector(7 downto 0); -- resultado da ula;
    signal op1_fdm      : std_logic_vector(7 downto 0); -- operando 1 interno para ULA
    signal op2_fdm      : std_logic_vector(7 downto 0); -- operando 2 interno para ULA

begin

    iula: entity work.ula
        port map (
            clk         => clk_uc,
            operation   => alu_op,
            op1         => valor_op1,
            op2         => valor_op2,
            r           => ula_r
        );

    process(clk_uc, rst_uc)
    begin
        if rst_uc = '1' then
            pc <= 0;
            state <= FETCH;
            reg_write <= '0';
            md_addr <= (others => '0');
            mp_addr <= (others => '0');
            dreg <= (others => '0');
            op1_fdm <= (others => '0');
            op2_fdm <= (others => '0');
            alu_op <= (others => '0');
            
        elsif rising_edge(clk_uc) then
            case state is
                when FETCH => 
                    mp_addr <= std_logic_vector(to_unsigned(pc, 8)); -- !
                    ireg <= mp_data_out;
                    reg_write <= '0';
                    state <= DECODE_D;

                when DECODE_D =>

                    md_addr <= std_logic_vector(to_unsigned(3*pc, 8));
                    dreg <= md_data_out;

                    state <= DECODE_O1

                when DECODE_O1 =>
                    endereco_1 <= std_logic_vector(to_unsigned(3*pc + 1, 8));
                    op1_fdm <= valor_op1; -- vindo do banco de registradores

                    state <= DECODE_O2

                when DECODE_O2 =>
                    endereco_2 <= std_logic_vector(to_unsigned(3*pc + 2, 8));

                    if md_data_out(7) = '1' then
                        op2_fdm <= md_data_out;  -- imediato
                    else
                        op2_fdm <= valor_op2; -- vindo do banco de registradores
                    end if;

                    opcode <= ireg;

                    state <= EXECUTE;

                when EXECUTE =>
                    alu_op <= opcode;
                    state <= WRITEBACK;

                when WRITEBACK =>
                    reg_write <= '1';
                    dado_escrita <= ula_r;

                    if pc = 31 then
                        pc <= 0;
                    else
                        pc <= pc + 1;
                    end if;

                    state <= FETCH;
            end case;
        end if;
    end process;

end architecture;