library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity pc is
  port( input : in std_logic_vector (31 DOWNTO 0 );
        clk : in std_logic;
        output : out std_logic_vector (31 DOWNTO 0):= "00000000000000000000000000000000");
end pc;

architecture PC of pc is 
begin
  process (clk) 
  begin
    if clk ='1' and clk'event then
      output <= input after 10 ns;
    end if;
  end process;
end PC;
