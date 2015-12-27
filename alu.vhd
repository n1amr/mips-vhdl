library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity ALU is
  port( a, b : in std_logic_vector( 31 downto 0);
        alu_control : in std_logic_vector (3 downto 0);
        shamt :in std_logic_vector ( 4 downto 0);
        result : out std_logic_vector(31 downto 0);
        zero : out std_logic );
end ALU;

architecture bev of ALU is
  signal tmp : std_logic_vector(31 DOWNTO 0);
begin
  process (a, b, alu_control, shamt)
  begin
    if(alu_control = "0010") then
      tmp <= a + b;
    elsif(alu_control = "0110") then
      tmp <= a - b;
    elsif(alu_control = "0011") then
      tmp <= to_stdlogicvector(to_bitvector(b) sll to_integer(unsigned(shamt)));
    elsif(alu_control = "0000") then
      tmp <= a and b;
    elsif(alu_control = "1100") then
      tmp <= not (a or b);
    elsif(alu_control = "0111") then
      if(a < b) then
        tmp <= "00000000000000000000000000000001";
      else
        tmp <= "00000000000000000000000000000000";
      end if;
    elsif(alu_control = "0001") then
      tmp <= a or b;
    end if;
  end process;

  process (tmp)
  begin
    result <= tmp after 100ns;
    if(tmp = "00000000000000000000000000000000") then
      zero <= '1' after 10ns;
    else
      zero <= '0' after 10ns;
    end if;
  end process;
end bev;
