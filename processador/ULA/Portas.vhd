-- XOR

library IEEE;
use IEEE.std_logic_1164.all;

entity xor_manual is
  port (
    a, b : in  std_logic_vector(7 downto 0);
    y    : out std_logic_vector(7 downto 0)
  );
end xor_manual;

architecture manual of xor_manual is
begin
  -- XOR bit a bit usando lógica
  y(0) <= (a(0) and not b(0)) or (not a(0) and b(0));
  y(1) <= (a(1) and not b(1)) or (not a(1) and b(1));
  y(2) <= (a(2) and not b(2)) or (not a(2) and b(2));
  y(3) <= (a(3) and not b(3)) or (not a(3) and b(3));
  y(4) <= (a(4) and not b(4)) or (not a(4) and b(4));
  y(5) <= (a(5) and not b(5)) or (not a(5) and b(5));
  y(6) <= (a(6) and not b(6)) or (not a(6) and b(6));
  y(7) <= (a(7) and not b(7)) or (not a(7) and b(7));
end manual;

-- Porta AND

library IEEE;
use IEEE.std_logic_1164.all;

entity and_manual is
  port (
    a, b : in  std_logic_vector(7 downto 0);
    y    : out std_logic_vector(7 downto 0)
  );
end and_manual;

architecture manual of and_manual is
begin
  y(0) <= a(0) and b(0);
  y(1) <= a(1) and b(1);
  y(2) <= a(2) and b(2);
  y(3) <= a(3) and b(3);
  y(4) <= a(4) and b(4);
  y(5) <= a(5) and b(5);
  y(6) <= a(6) and b(6);
  y(7) <= a(7) and b(7);
end manual;

-- OR

library IEEE;
use IEEE.std_logic_1164.all;

entity or_manual is
  port (
    a, b : in  std_logic_vector(7 downto 0);
    y    : out std_logic_vector(7 downto 0)
  );
end or_manual;

architecture manual of or_manual is
begin
  y(0) <= a(0) or b(0);
  y(1) <= a(1) or b(1);
  y(2) <= a(2) or b(2);
  y(3) <= a(3) or b(3);
  y(4) <= a(4) or b(4);
  y(5) <= a(5) or b(5);
  y(6) <= a(6) or b(6);
  y(7) <= a(7) or b(7);
end manual;

-- NOT

library IEEE;
use IEEE.std_logic_1164.all;

entity not_manual is
  port (
    a : in  std_logic_vector(7 downto 0);
    y : out std_logic_vector(7 downto 0)
  );
end not_manual;

architecture manual of not_manual is
begin
  y(0) <= not a(0);
  y(1) <= not a(1);
  y(2) <= not a(2);
  y(3) <= not a(3);
  y(4) <= not a(4);
  y(5) <= not a(5);
  y(6) <= not a(6);
  y(7) <= not a(7);
end manual;

-- Testbanch 

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_portas is
end tb_portas;
architecture sim of tb_portas is

    signal a, b   : std_logic := '0';
    signal y_and  : std_logic;
    signal y_or   : std_logic;
    signal y_xor  : std_logic;
    signal y_not  : std_logic;

begin
    uut_and : entity work.and_manual
        port map (a => a, b => b, y => y_and);

    uut_or : entity work.or_manual
        port map (a => a, b => b, y => y_or);

    uut_xor : entity work.xor_manual
        port map (a => a, b => b, y => y_xor);

    uut_not : entity work.not_manual
        port map (a => a, y => y_not);
    stim_proc : process
    begin
      
        -- Teste 1
        a <= '0'; b <= '0'; wait for 10 ns;
        report "a=0, b=0 => AND=" & std_logic'image(y_and) &
               " OR=" & std_logic'image(y_or) &
               " XOR=" & std_logic'image(y_xor) &
               " NOT(a)=" & std_logic'image(y_not);

        -- Teste 2
        a <= '0'; b <= '1'; wait for 10 ns;
        report "a=0, b=1 => AND=" & std_logic'image(y_and) &
               " OR=" & std_logic'image(y_or) &
               " XOR=" & std_logic'image(y_xor) &
               " NOT(a)=" & std_logic'image(y_not);

        -- Teste 3
        a <= '1'; b <= '0'; wait for 10 ns;
        report "a=1, b=0 => AND=" & std_logic'image(y_and) &
               " OR=" & std_logic'image(y_or) &
               " XOR=" & std_logic'image(y_xor) &
               " NOT(a)=" & std_logic'image(y_not);

        -- Teste 4
        a <= '1'; b <= '1'; wait for 10 ns;
        report "a=1, b=1 => AND=" & std_logic'image(y_and) &
               " OR=" & std_logic'image(y_or) &
               " XOR=" & std_logic'image(y_xor) &
               " NOT(a)=" & std_logic'image(y_not);

        wait;
    end process;

end sim;
