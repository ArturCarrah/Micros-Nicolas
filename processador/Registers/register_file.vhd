library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity register_file is
    port (
        clk        	: in std_logic;
        rst        	: in std_logic;
        we         	: in std_logic;

        addr  		: in  std_logic_vector(2 downto 0);

        data_in  	: in  std_logic_vector(7 downto 0);
        data_out 	: out std_logic_vector(7 downto 0);

        r0, r1, r2, r3, r4, r5, r6, r7 : out std_logic_vector(7 downto 0)
    );
end register_file;

architecture main of register_file is
    type reg_arr is array(7 downto 0) of std_logic_vector(7 downto 0);
    signal regs : reg_arr := (others => (others => '0'));
begin
    process(clk, rst)
    begin
        if rst = '1' then
            regs <= (others => (others => '0'));
        elsif rising_edge(clk) then
            if we = '1' then
                regs(to_integer(unsigned(addr))) <= data_in;
            end if;
        end if;
    end process;

    data_out <= regs(to_integer(unsigned(addr)));

    r0 <= regs(0);
    r1 <= regs(1);
    r2 <= regs(2);
    r3 <= regs(3);
    r4 <= regs(4);
    r5 <= regs(5);
    r6 <= regs(6);
    r7 <= regs(7);
end main;