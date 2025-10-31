library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- ALU Entity
entity simple_alu is
    port (
        A       : in  std_logic_vector(7 downto 0);  -- First operand
        B       : in  std_logic_vector(7 downto 0);  -- Second operand
        opcode  : in  std_logic_vector(7 downto 0);  -- Operation select
        result  : out std_logic_vector(7 downto 0)   -- ALU result
    );
end simple_alu;

architecture Behavioral of simple_alu is

    -- Signals for intermediate results
    signal add_result  : std_logic_vector(7 downto 0);
    signal sub_result  : std_logic_vector(7 downto 0);
    signal shift_result : std_logic_vector(7 downto 0);
    signal move_result : std_logic_vector(7 downto 0);
    signal mul_result  : std_logic_vector(15 downto 0);
    signal div_result  : std_logic_vector(7 downto 0);
    signal cmp_result  : std_logic_vector(7 downto 0)

    -- Components for the operations
    component mov is
        port (
            v       : in  std_logic_vector(7 downto 0);
            rout    : out std_logic_vector(7 downto 0)
        );
    end component;

    component bitshift is
        port (
            inp   : in  std_logic_vector(7 downto 0);
            shift : in  std_logic;
            outp  : out std_logic_vector(7 downto 0)
        );
    end component;

    component fadder_8bits is
        port (
            a     : in std_logic_vector(7 downto 0);
            b     : in std_logic_vector(7 downto 0);
            cin   : in std_logic;
            s     : out std_logic_vector(7 downto 0);
            cout  : out std_logic
        );
    end component;

    component subtrator_8bits is
        port (
            a     : in std_logic_vector(7 downto 0);
            b     : in std_logic_vector(7 downto 0);
            cin   : in std_logic;
            s     : out std_logic_vector(7 downto 0);
            cout  : out std_logic
        );
    end component;
    
    component multiplicador is
    	port (
        	a : in std_logic_vector(7 downto 0);
        	b : in std_logic_vector(7 downto 0);

        	s : out std_logic_vector(15 downto 0)
    	);
	end component;
    
    component comparador_8bits is
    	port (
        	a : in std_logic_vector(7 downto 0);
        	b : in std_logic_vector(7 downto 0);

        	s: out std_logic;
 			g: out std_logic;
  			e: out std_logic
    	);
	end component;

begin

    -- MOV operation
    mov_inst : mov
        port map (
            v       => A,
            rout    => move_result
        );

    -- SHL/SHR operation
    shift_inst : bitshift
        port map (
            inp   => A,
            shift => opcode(0),  -- assuming the least significant bit controls the direction of the shift
            outp  => shift_result
        );

    -- ADD operation
    add_inst : fadder_8bits
        port map (
            a     => A,
            b     => B,
            cin   => '0',
            s     => add_result,
            cout  => open  -- we don't need the carry out
        );

    -- SUB operation
    sub_inst : subtrator_8bits
        port map (
            a     => A,
            b     => B,
            cin   => '1',  -- subtraction is done by adding A and the 2's complement of B
            s     => sub_result,
            cout  => open  -- we don't need the carry out
        );
        
        -- MUL operation
    mul_inst : multiplicador
        port map (
            a     => A,
            b     => B,
            
            s     => mul_result,
        );
        
        -- CMP operation
    cmp_inst : comparador_8bits
        port map (
            a     => A,
            b     => B,
            
            s     => mul_result,
        );
        

    -- ALU operation based on opcode
    process (opcode, A, B)
    begin
        case opcode is
            -- MOV: Move A to result
            when "00000000" =>
                result <= move_result;  -- MOV operation, copy A to result

            -- BIT NOT (Invert A)
            when "00000001" =>
                result <= not A;

            -- SHR: Shift right
            when "00000010" =>
                result <= shift_result;

            -- SHL: Shift left
            when "00000011" =>
                result <= shift_result;

            -- ADD: A + B
            when "00000100" =>
                result <= add_result;

            -- SUB: A - B
            when "00000101" =>
                result <= sub_result;

            -- MUL: A * B
            when "00000110" =>
                result <= mul_result; 

            -- DIV (Division, assuming some basic logic like A / B)
            when "00000111" =>
                result <= div_result;  -- Assuming division logic is defined (not implemented here)
            
            -- CMP: A * B
            when "00001001" =>
                result <= cmp_result; 

            -- Default case: Zero output
            when others =>
                result <= (others => '0');
        end case;
    end process;

end Behavioral;
