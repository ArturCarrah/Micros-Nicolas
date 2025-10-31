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
    signal r_add    :   std_logic_vector(7 downto 0);
    signal r_mul    :   std_logic_vector(7 downto 0);
begin

    iadd: entity work.fadder_8bits port map (
        a   => op1,
        b   => op2,
        cin => '0',
        s   => r_add
    );

    imul: entity work.multiplicador port map (
        a   => op1,
        b   => op2,
        s   => r_mul
    );

    process(clk)
    begin

        if rising_edge(clk) then
            case operation is
                when "00000100" =>
                    r <= r_add;
                when "00000110" =>
                    r <= r_mul;
                when others => 
        			r <= (others => '0');
            end case;
        end if;
    end process;

end main;