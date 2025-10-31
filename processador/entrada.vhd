library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;
use IEEE.std_logic_textio.all;

entity instruction_reader is
end entity;

architecture behavior of instruction_reader is

    file instruction_file : text open read_mode is "instructions.txt";

begin
	process
    
    variable line_in  : line;

    variable opcode  : std_logic_vector(7 downto 0);
    variable op1     : std_logic_vector(7 downto 0);
    variable op2     : std_logic_vector(7 downto 0);
	variable op3     : std_logic_vector(7 downto 0);

begin
        -- Passando em cada linha
        while not endfile(instruction_file) loop
            readline(instruction_file, line_in);
            
      		read(line_in, opcode);  --Lendo opcode (dado guardado na variavel opcode)
      		read(line_in, op1);     --Lendo primeiro dado (dado em op1)
      		read(line_in, op2);     --Lendo segundo dado  (dado em op2)
      		read(line_in, op3);     --Lendo terceiro dado  (dado em op3)
       
        end loop;

        wait;
    end process;
end architecture;

  ----------Testbench-----------------





  library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;
use IEEE.std_logic_textio.all;

entity instruction_reader_tb is
end entity;

architecture behavior of instruction_reader_tb is
    -- Open file for reading
    file instruction_file : text open read_mode is "entrada.txt";
begin

    process
        variable line_in  : line;
        variable opcode  : std_logic_vector(7 downto 0);
        variable op1     : std_logic_vector(7 downto 0);
        variable op2     : std_logic_vector(7 downto 0);
        variable op3     : std_logic_vector(7 downto 0);
    begin
        -- Loop through file
        while not endfile(instruction_file) loop
            readline(instruction_file, line_in);
            
            -- Read 4 binary values from the line
            read(line_in, opcode);
            read(line_in, op1);
            read(line_in, op2);
            read(line_in, op3);

            -- Display what was read (for testbench observation)
            report "Read Instruction => Opcode: " & to_string(opcode)
                & " | Op1: " & to_string(op1)
                & " | Op2: " & to_string(op2)
                & " | Op3: " & to_string(op3);
        end loop;

        wait; -- Stop simulation
    end process;

end architecture;
