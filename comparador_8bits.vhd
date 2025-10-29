library IEEE;
use IEEE.std_logic_1164.all;

entity comparador is
port(
  a: in std_logic_vector(7 downto 0);
  b: in std_logic_vector(7 downto 0);
  s: out std_logic;
  g: out std_logic;
  e: out std_logic);
end comparador;

architecture rtl of comparador is
begin
  s <= '1' when a<b else
  	   '0';
       
  g <= '1' when a>b else
  	   '0';
       
  e <= '1' when a=b else
  	   '0';
end rtl;
-------------------------------


  
-- Testbench--


  
library IEEE;
use IEEE.std_logic_1164.all;
 
entity testbench is
-- empty
end testbench; 

architecture tb of testbench is

component comparador is
port(
  a: in std_logic_vector(7 downto 0);
  b: in std_logic_vector(7 downto 0);
  s: out std_logic;
  g: out std_logic;
  e: out std_logic);
end component;

signal a_in, b_in: std_logic_vector(7 downto 0);
signal s_out, g_out, e_out: std_logic;

begin

  DUT: comparador port map(a_in, b_in, s_out, g_out, e_out);

  process
  begin
    a_in <= "00000010";
    b_in <= "00000010";
    wait for 1 ns;
    assert(s_out='0') report "Fail 0/0" severity error;
    assert(g_out='0') report "Fail 0/0" severity error;
    assert(e_out='1') report "Fail 0/0" severity error;
  
    a_in <= "00000001";
    b_in <= "10000000";
    wait for 1 ns;
    assert(s_out='1') report "Fail 0/1" severity error;
    assert(g_out='0') report "Fail 0/1" severity error;
    assert(e_out='0') report "Fail 0/1" severity error;

    a_in <= "10000000";
    b_in <= "00000001";
    wait for 1 ns;
    assert(s_out='0') report "Fail 1/0" severity error;
    assert(g_out='1') report "Fail 1/0" severity error;
    assert(e_out='0') report "Fail 1/0" severity error;
    
    -- Clear inputs
    a_in <= "00000000";
    b_in <= "00000000";

    assert false report "Test done." severity note;
    wait;
  end process;
end tb;
