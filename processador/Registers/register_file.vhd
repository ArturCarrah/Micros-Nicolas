library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity register_file is
    port (
        clk         : in  std_logic;
        rst         : in  std_logic;
        we          : in  std_logic;                     
        wr_addr     : in  std_logic_vector(2 downto 0); 
        data_in     : in  std_logic_vector(7 downto 0); 


        rd_addr_1   : in  std_logic_vector(2 downto 0); 
        data_out_1  : out std_logic_vector(7 downto 0); 

       
        rd_addr_2   : in  std_logic_vector(2 downto 0); 
        data_out_2  : out std_logic_vector(7 downto 0); 

        r0, r1, r2, r3, r4, r5, r6, r7 : out std_logic_vector(7 downto 0)
    );
end entity register_file;

architecture main of register_file is
    -- O array de 8 registradores de 8 bits
    type reg_arr is array(0 to 7) of std_logic_vector(7 downto 0);
    
    --Inicializando os registradores R1 e R2 pra não dar problema
    signal regs : reg_arr := (1 => x"0A", 2 => x"05", others => (others => '0'));
begin

    process(clk, rst)
    begin
        if rst = '1' then
            regs <= (1 => x"0A", 2 => x"05", others => (others => '0'));
            
        elsif rising_edge(clk) then
            if we = '1' then
                regs(to_integer(unsigned(wr_addr))) <= data_in;
            end if;
        end if;
    end process;

    data_out_1 <= regs(to_integer(unsigned(rd_addr_1)));
    data_out_2 <= regs(to_integer(unsigned(rd_addr_2)));


    r0 <= regs(0);
    r1 <= regs(1);
    r2 <= regs(2);
    r3 <= regs(3);
    r4 <= regs(4);
    r5 <= regs(5);
    r6 <= regs(6);
    r7 <= regs(7);

end architecture main;
