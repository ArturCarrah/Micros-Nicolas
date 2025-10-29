library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity fadder_8bits is
    port(
        a       : in std_logic_vector(7 downto 0);
        b       : in std_logic_vector(7 downto 0);
        cin     : in std_logic;

        s       : out std_logic_vector(7 downto 0);
        cout    : out std_logic;
    );
end entity fadder_8bits;

architecture main of fadder_8bits is
    signal carry : std_logic_vector(6 downto 0);
    component full_adder is
        port (
            a, b, cin   : in std_logic;
            s, cout     : out std_logic;
        );
    end component;
    begin
        a0 : full_adder port map (a(0), b(0), cin, s(0), carry(0));
        a1 : full_adder port map (a(1), b(1), carry(0), s(1), carry(1));
        a2 : full_adder port map (a(2), b(2), carry(1), s(2), carry(2));
        a3 : full_adder port map (a(3), b(3), carry(2), s(3), carry(3));
        a4 : full_adder port map (a(4), b(4), carry(3), s(4), carry(4));
        a5 : full_adder port map (a(5), b(5), carry(4), s(5), carry(5));
        a6 : full_adder port map (a(6), b(6), carry(5), s(6), carry(6));
        a7 : full_adder port map (a(7), b(7), carry(6), s(7), cout);
    end main;