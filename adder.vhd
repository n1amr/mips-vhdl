library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
entity adder IS port ( 
a : in std_logic_vector (31 DOWNTO 0);
b : in std_logic_vector (31 DOWNTO 0) ;
result : out std_logic_vector (31 DOWNTO 0));
end adder;

architecture behave of adder is 
begin
result <= a+b after 50 ns;
end behave;
