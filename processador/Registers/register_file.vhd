library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity register_file is
    port (
        clk     : in std_logic;
        re      : in std_logic;
        we      : in std_logic;

        addr    : in    unsigned(1 downto 0);
        data    : inout std_logic_vector(7 downto 0);

        r0      : inout std_logic_vector(7 downto 0); -- USO GERAL
        r1      : inout std_logic_vector(7 downto 0); -- USO GERAL
        r2      : inout std_logic_vector(7 downto 0); -- USO GERAL
        r3      : inout std_logic_vector(7 downto 0); -- USO GERAL
        r4      : inout std_logic_vector(7 downto 0); -- Registrador padrão de Operações da ULA
        r5      : inout std_logic_vector(7 downto 0);
        r6      : inout std_logic_vector(7 downto 0);
        r7      : inout std_logic_vector(7 downto 0); -- Registrador de flag
    );
end register_file;

architecture main of register_file is
    type reg_arr is array(7 downto 0) of std_logic_vector(7 downto 0);
    signal regs : reg_arr := (others => (others => '0'));
    begin
        process(clk)
        begin

        end process;
end main;