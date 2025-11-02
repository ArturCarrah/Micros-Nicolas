library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity processador is
    port(
        clk_p   : in std_logic;
        rst_p   : in std_logic
    );
end entity;

architecture main of processador is
    signal md_data_out  : std_logic_vector(7 downto 0);
    signal mp_data_out  : std_logic_vector(7 downto 0);
    signal mp_addr      : std_logic_vector(7 downto 0);
    signal md_addr      : std_logic_vector(7 downto 0);

    signal reg_write    : std_logic;
    signal addr_dest    : std_logic_vector(2 downto 0);
    signal addr_op1     : std_logic_vector(2 downto 0);
    signal addr_op2     : std_logic_vector(2 downto 0);
    signal data_in_reg  : std_logic_vector(7 downto 0);
    signal op1_val      : std_logic_vector(7 downto 0);
    signal op2_val      : std_logic_vector(7 downto 0);

begin
    imemp: entity work.memoria_programa
        port map (
            addr     => mp_addr,
            data_out => mp_data_out
        );

    imemd: entity work.memoria_dados
        port map (
            addr     => md_addr,
            data_out => md_data_out
        );

    iregf: entity work.register_file
        port map (
            clk        => clk_p,
            rst        => rst_p,
            we         => reg_write,
            addr_dest  => addr_dest,
            addr_op1   => addr_op1,
            addr_op2   => addr_op2,
            data_in    => data_in_reg,
            data_out1  => op1_val,
            data_out2  => op2_val,
            r0 => open, r1 => open, r2 => open, r3 => open,
            r4 => open, r5 => open, r6 => open, r7 => open
        );

    iuc: entity work.control_unit
        port map (
            clk_uc        => clk_p,
            rst_uc        => rst_p,
            mp_addr       => mp_addr,
            mp_data_out   => mp_data_out,
            md_addr       => md_addr,
            md_data_out   => md_data_out,
            addr_dest     => addr_dest,
            addr_op1      => addr_op1,
            addr_op2      => addr_op2,
            valor_op1     => op1_val,
            valor_op2     => op2_val,
            reg_write     => reg_write,
            dado_escrita  => data_in_reg
        );
end architecture;
