library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity Clock is
  port( clk : out std_logic);
end Clock;

architecture behave of Clock is
  signal cloc : std_logic := '0';
begin
  clk <= cloc;
  
  process
  begin
    wait for 700 ns;
    cloc <= not cloc;
  end process;

end behave;
