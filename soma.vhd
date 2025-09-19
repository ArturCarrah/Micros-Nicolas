-- Simple OR gate design
library IEEE;
use IEEE.std_logic_1164.all;
use IEE.numeric_std.all;

entity xor_gate is
port(
  a: in std_logic_vector(2 downto 0);
  b: in std_logic_vector(2 downto 0);
  q: out std_logic;
  c: out std_logic;
  S: out std_logic_vector(3 downto 0));
 
end xor_gate;

architecture rtl of xor_gate is
begin
  process(a, b) is
  begin
  	for i in 0 to 3 loop
    	S(i) <= 0
    end loop;
    
     c <= 0
    for i in 0 to 2 loop
    	S(i) <= (a(i) xor b(i) xor c;
        wait for 1 ns;
        c<= a(i) and b(i);
    end loop;
    
   
  end process;
end rtl;
