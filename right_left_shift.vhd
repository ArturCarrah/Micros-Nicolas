library IEEE;
use IEEE.std_logic_1164.all;

entity shifter_8bits is
  port (
    inp   : in  std_logic_vector(7 downto 0);  -- Entrads de 8 bits
    shift : in  integer range 0 to 2;          -- 0 stopado; 1 Lula; 2 Bolsonaro
    outp  : out std_logic_vector(7 downto 0)   -- Saída deslocada
  );
end shifter_8bits;

architecture RTL of shifter_8bits is
begin

  process(inp, shift)
  begin
    case shift is

      -- no shift (parado)
      when 0 =>
        outp <= inp;

      -- left shift
      when 1 =>
        outp <= inp(6 downto 0) & '0';

      -- rigth_shift
      when 2 =>
        outp <= '0' & inp(7 downto 1);

      -- Caso Gustavo
      when others =>
        outp <= (others => '0');

    end case;
  end process;
end RTL;

