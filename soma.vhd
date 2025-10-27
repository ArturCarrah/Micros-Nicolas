library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity full_adder is
port(
  a, b, cin: in std_logic;
  s, cout: out std_logic);

end full_adder;

architecture dataflow of full_adder is
begin
s <= a xor b xor cin;
  
cout <= (a and b) OR (a and cin) or (b and cin);
  
end dataflow;

 -- teste bench dessa soma nada heterosexual (eu acho que funciona assim, testei separados no eda e deu bom, se tiver erro mim ensinem dpois)

  entity tb_full_adder is
end tb_full_adder;

architecture sim of tb_full_adder is
    signal a, b, cin : std_logic := '0'; -- aqui basicamente ta dizendo que geral começa como zero
    signal s, cout   : std_logic;
begin
    uut: entity work.full_adder   -- dizendo qual nego vai trabalhar e insntaciando a galera pra dizer que existem
        port map (
            a    => a,
            b    => b,
            cin  => cin,
            s    => s,
            cout => cout
        );

    -- Processo de estímulos
    process
    begin
        -- Teste 1: 0 + 0 + 0 = 00
        a <= '0'; b <= '0'; cin <= '0';
        wait for 10 ns;

        -- Teste 2: 0 + 0 + 1 = 01
        a <= '0'; b <= '0'; cin <= '1';
        wait for 10 ns;

        -- Teste 3: 0 + 1 + 0 = 01
        a <= '0'; b <= '1'; cin <= '0';
        wait for 10 ns;

        -- Teste 4: 0 + 1 + 1 = 10
        a <= '0'; b <= '1'; cin <= '1';
        wait for 10 ns;

        -- Teste 5: 1 + 0 + 0 = 01
        a <= '1'; b <= '0'; cin <= '0';
        wait for 10 ns;

        -- Teste 6: 1 + 0 + 1 = 10
        a <= '1'; b <= '0'; cin <= '1';
        wait for 10 ns;

        -- Teste 7: 1 + 1 + 0 = 10
        a <= '1'; b <= '1'; cin <= '0';
        wait for 10 ns;

        -- Teste 8: 1 + 1 + 1 = 11
        a <= '1'; b <= '1'; cin <= '1';
        wait for 10 ns;
        wait; 
    end process;
end sim;
