library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DIVISION is
    Port ( A : in  STD_LOGIC_VECTOR (7 downto 0);
           B : in  STD_LOGIC_VECTOR (7 downto 0);
           Q : out  STD_LOGIC_VECTOR (7 downto 0);
           R : out  STD_LOGIC_VECTOR (7 downto 0));
end DIVISION;

architecture Behavioral of DIVISION is
begin
    process(A, B)
        variable divisor, dividend : unsigned(7 downto 0);
        variable quotient, remainder : unsigned(7 downto 0);
    begin
        dividend := unsigned(A);
        divisor := unsigned(B);
        quotient := (others => '0');
        remainder := (others => '0');

        if divisor /= 0 then
            for i in 7 downto 0 loop
                remainder := remainder(6 downto 0) & dividend(7);
                dividend := dividend(6 downto 0) & '0';

                if remainder >= divisor then
                    remainder := remainder - divisor;
                    quotient(i) := '1';
                end if;
            end loop;
        end if;

        Q <= std_logic_vector(quotient);
        R <= std_logic_vector(remainder);
    end process;
end Behavioral;

------Testbench------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
 
ENTITY T IS
END T;
 
ARCHITECTURE behavior OF T IS 
 
    COMPONENT DIVISION
    PORT(
         A : IN  std_logic_vector(7 downto 0);
         B : IN  std_logic_vector(7 downto 0);
         Q : OUT  std_logic_vector(7 downto 0);
         R : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;

   signal A : std_logic_vector(7 downto 0) := (others => '0');
   signal B : std_logic_vector(7 downto 0) := (others => '0');

   signal Q : std_logic_vector(7 downto 0);
   signal R : std_logic_vector(7 downto 0);
 
BEGIN
   uut: DIVISION PORT MAP (
          A => A,
          B => B,
          Q => Q,
          R => R
        );
		  
   stim_proc: process
   begin		
		  -- Test case 1: 20 / 4 = 5, remainder = 0
        A <= std_logic_vector(to_unsigned(20, 8));
        B <= std_logic_vector(to_unsigned(4, 8));
        wait for 1 ns;
        report "Quociente 20/4: " & to_string(Q);
        report "Resto 20/4: " & to_string(R);
        wait for 100 ns;

        -- Test case 2: 25 / 6 = 4, remainder = 1
        A <= std_logic_vector(to_unsigned(25, 8));
        B <= std_logic_vector(to_unsigned(6, 8));
        wait for 1 ns;
        report "Quociente 25/6: " & to_string(Q);
        report "Resto 25/6: " & to_string(R);
        wait for 100 ns;

        -- Test case 3: 100 / 10 = 10, remainder = 0
        A <= std_logic_vector(to_unsigned(100, 8));
        B <= std_logic_vector(to_unsigned(10, 8));
        wait for 1 ns;
        report "Quociente 100/10: " & to_string(Q);
        report "Resto 100/10: " & to_string(R);
        wait for 100 ns;

        -- Test case 4: 15 / 8 = 1, remainder = 7
        A <= std_logic_vector(to_unsigned(15, 8));
        B <= std_logic_vector(to_unsigned(8, 8));
        wait for 1 ns;
        report "Quociente 15/8: " & to_string(Q);
        report "Resto 15/8: " & to_string(R);
        wait for 100 ns;

        -- Test case 5: Division by 0 (should be ignored)
        A <= std_logic_vector(to_unsigned(50, 8));
        B <= std_logic_vector(to_unsigned(0, 8));
        wait for 1 ns;
        report "Quociente 50/0: " & to_string(Q);
        report "Resto 50/0: " & to_string(R);
        wait for 100 ns;
      wait;
   end process;
END;
