library IEEE;
use IEEE.std_logic_1164.all

entity porta_and is
  port(
    a,b : in bit;
    s : out bit);
  end porta_and;

architecture ambos of porta_and is begin
  s <= a and b;
  end ambos;

  entity porta_or is
  port(
    a,b : in bit;
    s : out bit);
  end porta_or;

architecture basta_uma of porta_or is begin
  s <= a or b;
  end basta_uma;

  entity porta_not is
  port(
    a : in bit;
    s : out bit);
  end porta_not;

architecture nao of porta_not is begin
  s <= not a;
  end nao;

  entity porta_xor is
  port(
    a,b : in bit;
    s : out bit);
  end porta_xor;

architecture diferentes of porta_xor is begin
  s <= a xor b;
  end diferentes;
