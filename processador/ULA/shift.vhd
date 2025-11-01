library ieee;
use ieee.std_logic_1164.all;

entity bitshift is
  port (
    clk   : in  std_logic;
    inp   : in  std_logic_vector(7 downto 0);
    shift : in  std_logic;
    outp  : out std_logic_vector(7 downto 0)
  );
end bitshift;

architecture RTL of bitshift is
begin
  process (clk)
  begin
    if rising_edge(clk) then
      if shift = '1' then
        outp <= inp(6 downto 0) & '0'; -- left
      else
        outp <= '0' & inp(7 downto 1); -- right
      end if;
    end if;
  end process;
end RTL;


-- Testbench 

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_shift is
end tb_shift;

architecture sim of tb_shift is
    signal inp : std_logic_vector(7 downto 0);
    signal shift : std_logic;
    signal outp  : std_logic_vector(7 downto 0);
begin
    uut: entity work.bitshift
        port map (
            inp    => inp,
            shift  => shift,
            outp => outp
        );

    process
    begin
        -- Teste 1: Shift Left
        inp <= "01010001"; shift <= '1';
        wait for 10 ns;
        assert(outp = "10100010") report "Fail shl saida" severity error;

        -- Teste 2: Shift Right
        inp <= "01010001"; shift <= '0';
        wait for 10 ns;
        assert(outp = "00101000") report "Fail shr saida" severity error;
        
        wait; 
    end process;
end sim;
