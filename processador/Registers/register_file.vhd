library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity register_file is
    port (
        clk     : in std_logic;
        re      : in std_logic;
        we      : in std_logic;

        addr    : in    std_logic_vector(2 downto 0);
        data    : inout std_logic_vector(7 downto 0);

        r0      : out std_logic_vector(7 downto 0); -- USO GERAL
        r1      : out std_logic_vector(7 downto 0); -- USO GERAL
        r2      : out std_logic_vector(7 downto 0); -- USO GERAL
        r3      : out std_logic_vector(7 downto 0); -- USO GERAL
        r4      : out std_logic_vector(7 downto 0); -- Registrador padrão de Operações da ULA
        r5      : out std_logic_vector(7 downto 0);
        r6      : out std_logic_vector(7 downto 0);
        r7      : out std_logic_vector(7 downto 0) -- Registrador de flag
    );
end register_file;

architecture main of register_file is
    type reg_arr is array(7 downto 0) of std_logic_vector(7 downto 0);
    signal regs : reg_arr := (others => (others => '0'));
    signal addr_int : integer range 0 to 7;
    begin
    	addr_int <= to_integer(unsigned(addr));
        process(clk, re)
        begin

            if (re = '0') then 
                regs <= (others => (others => '0'));

            elsif (rising_edge(clk)) then 
                if (we = '1') then 
                    regs(addr_int) <= data; 
                end if;
            end if;
        end process;

        data <= regs(addr_int) when (we = '0') else (others => 'Z');

        r0 <= regs(0);
        r1 <= regs(1);
        r2 <= regs(2);
        r3 <= regs(3);
        r4 <= regs(4);
        r5 <= regs(5);
        r6 <= regs(6);
        r7 <= regs(7);

end main;