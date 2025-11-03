library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity design is
    Port (
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
end entity design;

architecture Behavioral of design is

    component control_unit
        port (
            clk_uc        : in  std_logic;
            rst_uc        : in  std_logic;
            mp_addr       : out std_logic_vector(7 downto 0);
            mp_data_out   : in  std_logic_vector(7 downto 0);
            md_addr       : out std_logic_vector(7 downto 0);
            md_data_out   : in  std_logic_vector(7 downto 0);
            addr_dest     : out std_logic_vector(2 downto 0);
            addr_op1      : out std_logic_vector(2 downto 0);
            addr_op2      : out std_logic_vector(2 downto 0);
            valor_op1     : in  std_logic_vector(7 downto 0);
            valor_op2     : in  std_logic_vector(7 downto 0);
            reg_write     : out std_logic;
            dado_escrita  : out std_logic_vector(7 downto 0)
        );
    end component;

    component register_file
        port (
            clk        : in  std_logic;
            rst        : in  std_logic;

            we         : in  std_logic;
            wr_addr    : in  std_logic_vector(2 downto 0);
            data_in    : in  std_logic_vector(7 downto 0);

            rd_addr_1  : in  std_logic_vector(2 downto 0);
            data_out_1 : out std_logic_vector(7 downto 0);

            rd_addr_2  : in  std_logic_vector(2 downto 0);
            data_out_2 : out std_logic_vector(7 downto 0);

            r0, r1, r2, r3, r4, r5, r6, r7 : out std_logic_vector(7 downto 0)
        );
    end component;


    component memoria_programa
        port (
            clk      : in  std_logic;
            rst      : in  std_logic;
            addr     : in  std_logic_vector(7 downto 0);
            data_out : out std_logic_vector(7 downto 0)
        );
    end component;

    component memoria_dados
        port (
            clk      : in  std_logic;
            rst      : in  std_logic;
            addr     : in  std_logic_vector(7 downto 0);
            data_out : out std_logic_vector(7 downto 0)
        );
    end component;

    
    signal mp_addr_sig     : std_logic_vector(7 downto 0);
    signal mp_data_out_sig : std_logic_vector(7 downto 0);
    signal md_addr_sig     : std_logic_vector(7 downto 0);
    signal md_data_out_sig : std_logic_vector(7 downto 0);
    
    signal addr_dest_sig   : std_logic_vector(2 downto 0); --Endereço de escrita
    signal addr_op1_sig    : std_logic_vector(2 downto 0); --Endereço de leitura 1
    signal addr_op2_sig    : std_logic_vector(2 downto 0); --Endereço de Leitura 2
    signal reg_write_sig   : std_logic;                    --Write enable
    signal dado_escrita_sig: std_logic_vector(7 downto 0);
    

    signal valor_op1_sig   : std_logic_vector(7 downto 0);
    signal valor_op2_sig   : std_logic_vector(7 downto 0); 
    
begin

    CU: control_unit
        port map(
            clk_uc      => clk,
            rst_uc      => rst,
            mp_addr     => mp_addr_sig,
            mp_data_out => mp_data_out_sig,
            md_addr     => md_addr_sig,
            md_data_out => md_data_out_sig,
            
            -- Saídas de controle para o RF
            addr_dest   => addr_dest_sig,
            addr_op1    => addr_op1_sig,
            addr_op2    => addr_op2_sig,
            reg_write   => reg_write_sig,
            dado_escrita => dado_escrita_sig,
            
            -- Entradas de dados para a ULA (dentro da UC)
            valor_op1   => valor_op1_sig,
            valor_op2   => valor_op2_sig
        );

    PM: memoria_programa
        port map(
            clk      => clk,
            rst      => rst,
            addr     => mp_addr_sig,
            data_out => mp_data_out_sig
        );

    DM: memoria_dados
        port map(
            clk      => clk,
            rst      => rst,
            addr     => md_addr_sig,
            data_out => md_data_out_sig
        );

    RF: register_file
        port map(
            clk        => clk,
            rst        => rst,
            
            we         => reg_write_sig,
            wr_addr    => addr_dest_sig,
            data_in    => dado_escrita_sig,
            
            rd_addr_1  => addr_op1_sig,
            data_out_1 => valor_op1_sig, 
            
            rd_addr_2  => addr_op2_sig,
            data_out_2 => valor_op2_sig,  
            
            r0         => r0_dbg,
            r1         => r1_dbg,
            r2         => r2_dbg,
            r3         => r3_dbg,
            r4         => r4_dbg,
            r5         => r5_dbg,
            r6         => r6_dbg,
            r7         => r7_dbg
        );

end Behavioral;
