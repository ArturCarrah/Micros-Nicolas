-----------------------------------------------------------
-- Porta XOR
-----------------------------------------------------------

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
  process(a, b)
  begin
    for i in 0 to 7 loop
      if (a(i) /= b(i)) then
        y(i) <= '1';
      else
        y(i) <= '0';
      end if;
    end loop;
  end process;
end manual;

-----------------------------------------------------------
-- Porta AND
-----------------------------------------------------------

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
  process(a, b)
  begin
    for i in 0 to 7 loop
      if (a(i) = '1' and b(i) = '1') then
        y(i) <= '1';
      else
        y(i) <= '0';
      end if;
    end loop;
  end process;
end manual;

-----------------------------------------------------------
-- Porta OR
-----------------------------------------------------------

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
  process(a, b)
  begin
    for i in 0 to 7 loop
      if (a(i) = '1' or b(i) = '1') then
        y(i) <= '1';
      else
        y(i) <= '0';
      end if;
    end loop;
  end process;
end manual;


-----------------------------------------------------------
-- Porta NOT
-----------------------------------------------------------

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
  process(a)
  begin
    for i in 0 to 7 loop
      if a(i) = '1' then
        y(i) <= '0';
      else
        y(i) <= '1';
      end if;
    end loop;
  end process;
end manual;

-----------------------------------------------------------
-- Testbench de tudo ai
-----------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_portas is
end tb_portas;

architecture sim of tb_portas is
    
    signal a, b   : std_logic_vector(7 downto 0);
    signal y_and  : std_logic_vector(7 downto 0);
    signal y_or   : std_logic_vector(7 downto 0);
    signal y_xor  : std_logic_vector(7 downto 0);
    signal y_not  : std_logic_vector(7 downto 0);

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
        a <= "00000000"; b <= "00000000"; 
        wait for 10 ns;
        report "a=0, b=0 => AND=" & to_string(y_and) &
               " OR=" & to_string(y_or) &
               " XOR=" & to_string(y_xor) &
               " NOT(a)=" & to_string(y_not);

        a <= "00000000"; b <= "11111111"; 
        wait for 10 ns;
        report "a=0, b=255 => AND=" & to_string(y_and) &
               " OR=" & to_string(y_or) &
               " XOR=" & to_string(y_xor) &
               " NOT(a)=" & to_string(y_not);

        a <= "01010101"; b <= "10011100"; 
        wait for 10 ns;
        report "a=255, b=0 => AND=" & to_string(y_and) &
               " OR=" & to_string(y_or) &
               " XOR=" & to_string(y_xor) &
               " NOT(a)=" & to_string(y_not);

        a <= "11111111"; b <= "11111111"; 
        wait for 10 ns;
        report "a=255, b=255 => AND=" & to_string(y_and) &
               " OR=" & to_string(y_or) &
               " XOR=" & to_string(y_xor) &
               " NOT(a)=" & to_string(y_not);

        wait;
    end process;

end sim;
