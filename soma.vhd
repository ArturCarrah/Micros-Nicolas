library IEEE;
use IEEE.std_logic_1164.all;
use IEE.numeric_std.all;

entity full_adder is
port(
  a, b, cin: in BIT;
  s, cout: out BIT);

end full_adder;

architecture dataflow of full_adder is
begin
s <= a xor b xor cin;
  
cout <= (a and b) OR (a and cin) or (b and cin);
  
end dataflow;
