library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity testbench is
end entity testbench;

architecture main of testbench is
    signal a_tb 	: std_logic_vector(7 downto 0);
    signal b_tb 	: std_logic_vector(7 downto 0);
    signal cin_tb	: std_logic;
    
    signal s_tb		: std_logic_vector(7 downto 0);
    signal cout_tb		: std_logic;
    begin
    	uut: entity work.fadder_8bits
          port map (
              a => a_tb,
              b => b_tb,
              cin => cin_tb,
              s => s_tb,
              cout => cout_tb
        );
        process
        begin
        	a_tb <= "00000001";
            b_tb <= "00000010";
            cin_tb <= '0';
            wait for 10 ns;

            -- Teste 2
            a_tb <= "11111111";
            b_tb <= "00000001";
            cin_tb <= '0';
            wait for 10 ns;

            -- Teste 3
            a_tb <= "00001111";
            b_tb <= "00001111";
            cin_tb <= '1';
            wait for 10 ns;

			wait;
        end process;
end main;	