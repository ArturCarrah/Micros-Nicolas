-- Definição do comportamento da ULA

library IEEE;
use IEEE.std_logic_1164.all;

entity ula is
    port (
        A       : in  std_logic_vector(7 downto 0);  -- operando A
        B       : in  std_logic_vector(7 downto 0);  -- operando B (usado em MOV e lógicas)
        opcode  : in  std_logic_vector(2 downto 0);  -- código da operação
        result  : out std_logic_vector(7 downto 0)   -- resultado
    );
end ula;

architecture sim of ula is
begin
    process(A, B, opcode)
    begin
        case opcode is
            -- 000: MOV (movimentação de dados)
            when "000" =>
                result <= B;  -- copia valor de B para o resultado

            -- 001: NOT (negação bit a bit)
            when "001" =>
                result <= not A;

            -- 010: AND (E lógico bit a bit)
            when "010" =>
                result <= A and B;

            -- 011: OR (OU lógico bit a bit)
            when "011" =>
                result <= A or B;

            -- 100: XOR (OU exclusivo)
            when "100" =>
                result <= A xor B;

            -- 101: SHIFT LEFT (desloca bits à esquerda e faz o L)
            when "101" =>
                result <= A(6 downto 0) & '0';

            -- 110: SHIFT RIGHT (desloca bits à direita)
            when "110" =>
                result <= '0' & A(7 downto 1);

            -- 111: SEM DESLOCAR (mantém valor original)
            when "111" =>
                result <= A;

            when others =>
                result <= (others => '0');
        end case;
    end process;
end sim;

-- Testbanch da ULA

entity tb_ula is
end tb_ula;

architecture sim of tb_ula is
    signal A, B, result : std_logic_vector(7 downto 0);
    signal opcode       : std_logic_vector(2 downto 0);
begin
    uut: entity work.ula
        port map (
            A       => A,
            B       => B,
            opcode  => opcode,
            result  => result
        );

 
    process
    begin
        A <= "10110010";  -- 178 decimal
        B <= "00001111";  -- 15 decimal

        -- 000: MOV
        opcode <= "000";
        wait for 10 ns;

        -- 001: NOT
        opcode <= "001";
        wait for 10 ns;

        -- 010: AND
        opcode <= "010";
        wait for 10 ns;

        -- 011: OR
        opcode <= "011";
        wait for 10 ns;

        -- 100: XOR
        opcode <= "100";
        wait for 10 ns;

        -- 101: SHIFT LEFT
        opcode <= "101";
        wait for 10 ns;

        -- 110: SHIFT RIGHT
        opcode <= "110";
        wait for 10 ns;

        -- 111: NÃO DESLOCA
        opcode <= "111";
        wait for 10 ns;

        wait;
    end process;
end sim;
