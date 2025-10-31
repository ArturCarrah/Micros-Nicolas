library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity memoria_programa is
    port (
        clk         : in    std_logic;
        re          : in    std_logic;
        we          : in    std_logic;

        addr        : in    std_logic_vector(7 downto 0);

        data_in     : in    std_logic_vector(7 downto 0);
        data_out    : out   std_logic_vector(7 downto 0)
    );
end memoria_programa;

architecture main of memoria_programa is
    type m_arr is array(31 downto 0) of std_logic_vector(7 downto 0);
    signal memoria : m_arr := (others => (others => '0'));

    signal addr_int : integer range 0 to 31;
    begin
    	addr_int <= to_integer(unsigned(addr));
        process(clk, re)
        begin

            if (re = '0') then 
                memoria <= (others => (others => '0'));

            elsif (rising_edge(clk)) then 
                if (we = '1') then 
                    memoria(addr_int) <= data_in; 
                end if;
            end if;
        end process;

        data_out <= memoria(addr_int) when (we = '0') else (others => 'Z');

end main;