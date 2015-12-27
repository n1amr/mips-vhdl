library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity adder is
  port (  a : in std_logic_vector (31 DOWNTO 0);
          b : in std_logic_vector (31 DOWNTO 0);
          result : out std_logic_vector (31 DOWNTO 0));
end adder;

architecture behave of adder is
begin
  process(a, b)
  begin
    result <= a + b;
  end process;
end behave;

