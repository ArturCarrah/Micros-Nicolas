library ieee;
use ieee.std_logic_1164.all;

entity bitshift is
  port (
    inp   : in  std_logic_vector(7 downto 0);
    shift : in  std_logic; 
    outp  : out std_logic_vector(7 downto 0)
  );
end bitshift;

architecture combinational of bitshift is
begin
  process (inp, shift)
  begin
    if shift = '1' then
      outp <= inp(6 downto 0) & '0';  -- left shift
    else
      outp <= '0' & inp(7 downto 1);  -- right shift
    end if;
  end process;
end combinational;
