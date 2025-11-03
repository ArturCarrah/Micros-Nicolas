library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_processor is
end entity tb_processor;

architecture sim of tb_processor is

    constant C_CLK_PERIOD : time := 10 ns;

    component design
        port (
            clk : in  std_logic;
            rst : in  std_logic;

            r0_dbg : out std_logic_vector(7 downto 0);
            r1_dbg : out std_logic_vector(7 downto 0);
            r2_dbg : out std_logic_vector(7 downto 0);
            r3_dbg : out std_logic_vector(7 downto 0);
            r4_dbg : out std_logic_vector(7 downto 0);
            r5_dbg : out std_logic_vector(7 downto 0);
            r6_dbg : out std_logic_vector(7 downto 0);
            r7_dbg : out std_logic_vector(7 downto 0)
        );
    end component;

    signal s_clk : std_logic := '0';
    signal s_rst : std_logic := '1'; -- Começa resetado

    signal s_r0_dbg : std_logic_vector(7 downto 0);
    signal s_r1_dbg : std_logic_vector(7 downto 0);
    signal s_r2_dbg : std_logic_vector(7 downto 0);
    signal s_r3_dbg : std_logic_vector(7 downto 0);
    signal s_r4_dbg : std_logic_vector(7 downto 0);
    signal s_r5_dbg : std_logic_vector(7 downto 0);
    signal s_r6_dbg : std_logic_vector(7 downto 0);
    signal s_r7_dbg : std_logic_vector(7 downto 0);


begin

    UUT : design
        port map(
            clk    => s_clk,
            rst    => s_rst,
            r0_dbg => s_r0_dbg,
            r1_dbg => s_r1_dbg,
            r2_dbg => s_r2_dbg,
            r3_dbg => s_r3_dbg,
            r4_dbg => s_r4_dbg,
            r5_dbg => s_r5_dbg,
            r6_dbg => s_r6_dbg,
            r7_dbg => s_r7_dbg
        );

    clk_gen_proc : process
    begin
        s_clk <= '0';
        wait for C_CLK_PERIOD / 2;
        s_clk <= '1';
        wait for C_CLK_PERIOD / 2;
    end process;

    stimulus_proc : process
    begin
		--Dando um reset pra sair evitando problema de sincronização
        s_rst <= '1';
        wait for C_CLK_PERIOD * 5;
        
        s_rst <= '0';
        wait for C_CLK_PERIOD * 12; 

        wait; 
        
    end process;

end architecture sim;
