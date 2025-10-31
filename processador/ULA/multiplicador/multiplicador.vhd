library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity multiplicador is
    port (
        a : in std_logic_vector(7 downto 0);
        b : in std_logic_vector(7 downto 0);

        s : out std_logic_vector(7 downto 0)
    );
end entity multiplicador;

architecture main of multiplicador is
    signal s0 : std_logic_vector(127 downto 0);
    signal s1 : std_logic_vector(63 downto 0);
    signal s2 : std_logic_vector(31 downto 0);
    signal s3 : std_logic_vector(15 downto 0);
begin

    gen_i : for i in 0 to 7 generate
        signal parcial : std_logic_vector(7 downto 0);
        signal parcial_shifted : std_logic_vector(15 downto 0);
    begin

        gen_j : for j in 0 to 7 generate
        begin
            parcial(j) <= a(j) and b(i);
        end generate;

        uut_teste1 : entity work.mshift
            port map(
                a => parcial,
                shift => i,
                b => parcial_shifted
            );

        s0(16*i + 15 downto 16*i) <= parcial_shifted;

    end generate gen_i;

    gen_i1 : for i in 0 to 3 generate
    begin
        uut_teste2 : entity work.fadder_16bits
            port map(
                a => s0((2*i*16+15) downto (2*i*16)),
                b => s0(((2*i+1)*16 + 15) downto ((2*i+1)*16)),
                cin => '0',

                s => s1((16*i+15) downto (16*i))
            );
    end generate gen_i1;

    gen_i2 : for i in 0 to 1 generate
    begin
        uut_teste3 : entity work.fadder_16bits
            port map(
                a => s1((2*i*16+15) downto (2*i*16)),
                b => s1(((2*i+1)*16 + 15) downto ((2*i+1)*16)),
                cin => '0',

                s => s2((16*i+15) downto (16*i))
            );
    end generate gen_i2;

    uut_teste : entity work.fadder_16bits
        port map(
            a => s2(31 downto 16),
            b => s2(15 downto 0),
            cin => '0',

            s => s3
    );

    s <= s3(7 downto 0); -- Criar lógica para overflow;

end architecture main;
