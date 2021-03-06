library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Adder is
  port (  a : in std_logic_vector (31 downto 0);
          b : in std_logic_vector (31 downto 0);
          result : out std_logic_vector (31 downto 0));
end Adder;

architecture behave of Adder is
begin
  process(a, b)
  begin
    result <= a + b after 50 ns;
  end process;
end behave;
