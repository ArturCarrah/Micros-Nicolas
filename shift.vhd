library ieee;
use ieee.std_logic_1164.all;


entity barrel is
port (
  inp: in STD_LOGIC_VECTOR (7 DOWNTO 0);
  shift: in INTEGER RANGE 0 TO 1;
  outp: out STD_LOGIC_VECTOR (7 DOWNTO 0));
end barrel;


architecture RTL of barrel is
begin

  outp <= inp(6 downto 0) & '0' when shift = 1 else inp;
  
end RTL;
