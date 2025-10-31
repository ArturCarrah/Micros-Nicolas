------------------------------------------------------------
-- Porta XOR
------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity xor_manual is
  port (
    a, b : in std_logic;
    y    : out std_logic
  );
end xor_manual;

architecture truth_table of xor_manual is
begin
  process(a, b)
  begin
    if a = b then
      y <= '0';
    else
      y <= '1';
    end if;
  end process;
end truth_table;

------------------------------------------------------------
-- Porta AND
------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity and_manual is 
  port (
    a, b : in std_logic;
    y    : out std_logic
  );
end and_manual;

architecture truth_table of and_manual is
begin
  process(a, b)
  begin
    if a = '1' then
        if b = '1' then
            y <= '1';
        end if;
    else
      y <= '0';
    end if;
  end process;
end truth_table;

------------------------------------------------------------
-- Porta OR
------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity or_manual is 
  port (
    a, b : in std_logic;
    y    : out std_logic
  );
end or_manual;

architecture truth_table of or_manual is
begin
  process(a, b)
  begin
    if a = '1' then
      y <= '1';
    elsif b = '1' then
      y <= '1';
    else 
      y <= '0';
    end if;
  end process;
end truth_table;

------------------------------------------------------------
-- Porta NOT
------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity not_manual is
  port (
    a : in std_logic;
    y : out std_logic
  );
end not_manual;

architecture truth_table of not_manual is
begin
  process(a)
  begin
    if a = '1' then
      y <= '0';
    else
      y <= '1';
    end if;
  end process;
end truth_table;

------------------------------------------------------------
-- Testbanch das portas
------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_portas is
end tb_portas;

architecture sim of tb_portas is

    -- Sinais para todas as portas
    signal a, b   : std_logic := '0';
    signal y_and  : std_logic;
    signal y_or   : std_logic;
    signal y_xor  : std_logic;
    signal y_not  : std_logic;

begin

    -----------------------------------------------------------------
    -- Instanciações
    -----------------------------------------------------------------
    uut_and : entity work.and_manual
        port map (a => a, b => b, y => y_and);

    uut_or : entity work.or_manual
        port map (a => a, b => b, y => y_or);

    uut_xor : entity work.xor_manual
        port map (a => a, b => b, y => y_xor);

    uut_not : entity work.not_manual
        port map (a => a, y => y_not);

    -----------------------------------------------------------------
    -- Processo de estimulação e verificação
    -----------------------------------------------------------------
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
