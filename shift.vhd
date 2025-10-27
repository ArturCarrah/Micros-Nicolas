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

-- Testbanch 

entity tb_barrel is
end tb_barrel;

architecture sim of tb_barrel is
  
    signal inp   : std_logic_vector(7 downto 0);
    signal shift : integer range 0 to 1;
    signal outp  : std_logic_vector(7 downto 0);

begin
    uut: entity work.barrel
        port map (
            inp   => inp,
            shift => shift,
            outp  => outp
        );

    process
    begin
        -- Caso 1: sem deslocar
        inp <= "10110010";
        shift <= 0;
        wait for 10 ns;
        report "Resultado: " & to_string(outp);

        -- Caso 2: deslocar para esquerda
        shift <= 1;
        wait for 10 ns;
        report "Resultado: " & to_string(outp);
       
        -- Caso 3: outro valor de entrada
        inp <= "00011100";
        shift <= 1;
        wait for 10 ns;
        report "Resultado: " & to_string(outp);

        wait;
    end process;

end sim;
