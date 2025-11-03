library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;
use IEEE.std_logic_textio.all;

entity memoria_programa is
    port (
        clk      : in  std_logic;
        rst      : in  std_logic;
        addr     : in  std_logic_vector(7 downto 0);
        data_out : out std_logic_vector(7 downto 0)
    );
end entity;

architecture main of memoria_programa is
    type m_arr is array(0 to 31) of std_logic_vector(7 downto 0);
    signal memoria : m_arr := (others => (others => '0'));
    signal addr_int : integer range 0 to 31;

    file instruction_file : text open read_mode is "instructions.txt";
begin

    addr_int <= to_integer(unsigned(addr));

    memory_proc: process(clk, rst)
        variable line_in : line;
        variable opcode  : std_logic_vector(7 downto 0);
        variable op1     : std_logic_vector(7 downto 0);
        variable op2     : std_logic_vector(7 downto 0);
        variable op3     : std_logic_vector(7 downto 0);
        variable i       : integer := 0;
    begin
        if rst = '1' then
            memoria <= (others => (others => '0'));
        elsif rising_edge(clk) then
            if i = 0 then
                while not endfile(instruction_file) loop
                    readline(instruction_file, line_in);
                    read(line_in, opcode);
                    read(line_in, op1);
                    read(line_in, op2);
                    read(line_in, op3);

                if i <= 31 then
                    memoria(i) <= opcode;
                    i := i + 1;
                end if;
                end loop;
            end if;
        end if;
    end process;

    data_out <= memoria(addr_int);

end architecture;
