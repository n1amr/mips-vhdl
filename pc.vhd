library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity PC is
  port( input_address : in std_logic_vector (31 downto 0 );
        clk : in std_logic;
        output_address : out std_logic_vector (31 downto 0):= "00000000000000000000000000000000");
end PC;

architecture behave of PC is
begin
  process (clk)
  begin
    if clk ='1' and clk'event then
      output_address <= input_address after 10 ns;
    end if;
  end process;
end behave;
