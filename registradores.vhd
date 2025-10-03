library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity registradores is
    port (
        clk     : in std_logic;
        rst     : in std_logic;
        we      : in std_logic;

        addr    : in unsigned(1 downto 0);
        data    : inout std_logic_vector(7 downto 0);

        q0      : inout std_logic_vector(7 downto 0);
        q1      : inout std_logic_vector(7 downto 0);
        q2      : inout std_logic_vector(7 downto 0);
        q3      : inout std_logic_vector(7 downto 0);
    );
end entity registradores;

architecture main of registradores is
    type reg_array is array(0 to 3) of std_logic_vector(7 downto 0);
    signal regs: reg_array := (others => (others => '0')); 
    begin
        process(clk)
        begin
            if rising_edge(clk) then
                if rst = '1' then
                    if we = '0' then
                        reg_array(to_integer(addr)) <= data;
                    else if we = '1' then
                        data <= reg_array(to_integer(addr));
                    else reg_array(others => 'Z');
                else


        end process
    end main;
-- 