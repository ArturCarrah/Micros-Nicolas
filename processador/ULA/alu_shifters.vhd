entity simple_alu is
    port (
        A       : in  std_logic_vector(7 downto 0);  -- operando A
        B       : in  std_logic_vector(7 downto 0);  -- operando B (usado em MOV e lógicas)
        opcode  : in  std_logic_vector(2 downto 0);  -- código da operação
        result  : out std_logic_vector(7 downto 0)   -- resultado
    );
end simple_alu;

architecture Behavioral of simple_alu is
begin
    process(A, B, opcode)
    begin
        case opcode is
            -- 000: MOV (movimentação de dados)
            when "000" =>
                result <= B;  -- copia valor de B para o resultado

            -- NOT 
            when "001" =>
                result <= not A;

            -- AND 
            when "010" =>
                result <= A and B;

            -- OR
            when "011" =>
                result <= A or B;

            --  XOR (exclusive or)
            when "100" =>
                result <= A xor B;

            -- left_shift
            when "101" =>
                result <= A(6 downto 0) & '0';

            -- rigth_shift
            when "110" =>
                result <= '0' & A(7 downto 1);

            -- no_shift
            when "111" =>
                result <= A;

            when others =>
                result <= (others => '0');
        end case;
    end process;
end Behavioral;
