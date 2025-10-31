library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ula is
    port (
        clk         : in    std_logic;
        operation   : in    std_logic_vector(7 downto 0);
        op1         : in    std_logic_vector(7 downto 0);
        op2         : in    std_logic_vector(7 downto 0);
        r           : out   std_logic_vector(7 downto 0) 
    );
end ula;

architecture main of ula is

    -- Sinais auxiliares para armazenar resultados das operações
    signal r_mov, r_add, r_mul, r_xor, r_and, r_or, r_not, r_bs : std_logic_vector(7 downto 0);
    signal shift : std_logic;
    signal r_s, r_g, r_e : std_logic;
    signal r_div, r_mod : std_logic_vector(7 downto 0);
    signal flag_div     : std_logic;
    signal reset        : std_logic := '0';

begin

    -- MOV
    imov: entity work.mov 
        port map (
            v     => op1,      
            rout  => r_mov
        );    

    -- SOMA
    iadd: entity work.fadder_8bits 
        port map (
            a   => op1,
            b   => op2,
            cin => '0',
            s   => r_add
        );

    -- MULTIPLICAÇÃO
    imul: entity work.multiplicador 
        port map (
            a   => op1,
            b   => op2,
            s   => r_mul
        );

    idiv: entity work.div_mod
        port map (
            div_output => r_div,
            mod_output => r_mod,
            flag       => flag_div,
            input_A    => op1,
            input_B    => op2,
            clock      => clk,
            reset      => reset
        );            

    -- XOR
    ixor: entity work.xor_manual 
        port map (
            a  => op1,
            b  => op2,
            y  => r_xor
        );

    -- AND
    iand: entity work.and_manual 
        port map (
            a  => op1,
            b  => op2,
            y  => r_and
        );

    -- OR
    ior: entity work.or_manual 
        port map (
            a  => op1,
            b  => op2,
            y  => r_or
        );

    -- NOT (assumindo que só usa op1)
    inot: entity work.not_manual 
        port map (
            a  => op1,
            y  => r_not
        );

    -- SHIFT (assumindo bitshift com direção controlada por 'shift')
    ishift: entity work.bitshift 
        port map (
            inp   => op1,
            shift => shift,
            outp  => r_bs
        );

    icomparador: entity work.comparador_8bits
        port map (
            a  => op1,
            b  => op2,
            s => r_s,
            g => r_g,
            e => r_e
        );
        
    -- PROCESSO PRINCIPAL
    process(clk)
    begin
        if rising_edge(clk) then
            case operation is
                when "00000000" =>   -- MOV
                    r <= r_mov;

                when "00000010" =>   -- SHIFT ESQUERDA
                    shift <= '0';
                    r <= r_bs;

                when "00000011" =>   -- SHIFT DIREITA
                    shift <= '1';
                    r <= r_bs;

                when "00000100" =>   -- ADD
                    r <= r_add;

                when "00000110" =>   -- MUL
                    r <= r_mul;

                when "00000111" =>   -- DIV
                    r <= r_div;

                when "00001000" =>   -- RESTO
                    r <= r_mod

                when "00001001" =>   -- COMP
                    if r_s = '1' then
                        r <= "00000001";  -- a < b
                    elsif r_g = '1' then
                        r <= "00000010";  -- a > b
                    elsif r_e = '1' then
                        r <= "00000100";  -- a = b
                    else
                        r <= (others => '0');
                    end if;

                when "00001010" =>   -- AND
                    r <= r_and;

                when "00001011" =>   -- OR
                    r <= r_or;

                when "00001100" =>   -- NOT
                    r <= r_not;

                when "00001101" =>   -- XOR
                    r <= r_xor;

                when others => 
                    r <= (others => '0');
            end case;
        end if;
    end process;

end main;
