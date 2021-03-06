library ieee;
use ieee.std_logic_1164.all;

entity Mux_4x1_5bit is
  port( I3:       in std_logic_vector(4 downto 0);
        I2:       in std_logic_vector(4 downto 0);
        I1:       in std_logic_vector(4 downto 0);
        I0:       in std_logic_vector(4 downto 0);
        selector: in std_logic_vector(1 downto 0);
        O:        out std_logic_vector(4 downto 0)
      );
end Mux_4x1_5bit;

architecture behave of Mux_4x1_5bit is
begin
  process(I3, I2 ,I1 ,I0 , selector)
  begin
    case selector is
      when "00"   =>  O <= I0 after 10ns;
      when "01"   =>  O <= I1 after 10ns;
      when "10"   =>  O <= I2 after 10ns;
      when "11"   =>  O <= I3 after 10ns;
      when others =>  O <= "ZZZZZ" after 10ns;
    end case;
  end process;
end behave;

library ieee;
use ieee.std_logic_1164.all;

entity Mux_4x1_32bit is
  port( I3:       in std_logic_vector(31 downto 0);
        I2:       in std_logic_vector(31 downto 0);
        I1:       in std_logic_vector(31 downto 0);
        I0:       in std_logic_vector(31 downto 0);
        selector: in std_logic_vector(1 downto 0);
        O:        out std_logic_vector(31 downto 0)
      );
end Mux_4x1_32bit;

architecture behave of Mux_4x1_32bit is
begin
  process(I3, I2 ,I1 ,I0 , selector)
  begin
    case selector is
      when "00"   =>  O <= I0 after 10ns;
      when "01"   =>  O <= I1 after 10ns;
      when "10"   =>  O <= I2 after 10ns;
      when "11"   =>  O <= I3 after 10ns;
      when others =>  O <= "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ" after 10ns;
    end case;
  end process;
end behave;

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
      when '0'   =>  O <= I0 after 10ns;
      when '1'   =>  O <= I1 after 10ns;
      when others =>  O <= "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ" after 10ns;
    end case;
  end process;
end behave;
