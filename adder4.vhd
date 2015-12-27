library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
entity adder4 IS port ( 
c : in std_logic_vector (31 DOWNTO 0);
result : out std_logic_vector (31 DOWNTO 0));
end adder4;

architecture behave of adder4 is 
begin

result <= c+"00000000000000000000000000000100" after 50 ns;
end behave;
