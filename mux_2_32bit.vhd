library ieee;
use ieee.std_logic_1164.all;

entity Mux_2x1_32bit is
  port( I1:       in std_logic_vector(31 downto 0);
        I0:       in std_logic_vector(31 downto 0);
        selector: in std_logic;
        O:        out std_logic_vector(31 downto 0)
      );
end Mux_2x1_32bit;

architecture behave of Mux_2x1_32bit is
begin
  process(I1 ,I0 , selector)
  begin
    case selector is
      when '0'   =>  O <= I0 after 1 ns;
      when '1'   =>  O <= I1 after 10 ns;
      when others =>  O <= "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ" ;
    end case;
  end process;
end behave;
