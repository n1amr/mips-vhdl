library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Adder4 is
  port (  a : in std_logic_vector (31 downto 0);
          result : out std_logic_vector (31 downto 0));
end Adder4;

architecture behave of Adder4 is
begin
  process(a)
  begin
    result <= a + "00000000000000000000000000000100" after 50 ns;
  end process;
end behave;

