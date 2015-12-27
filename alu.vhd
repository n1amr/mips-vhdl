library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity alu is port ( 
a,b : in std_logic_vector( 31 DOWNTO 0);
alu_control : in std_logic_vector (3 DOWNTO 0);
shamt :in std_logic_vector ( 4 DOWNTO 0);
result : out std_logic_vector(31 DOWNTO 0);
zero : out std_logic );
end alu;
architecture ALU of alu is
begin
      process ( a,b,alu_control,shamt)
      begin
      if(alu_control = "0010" ) then
              result <= a + b after 100 ns ;
      elsif(alu_control = "0110" ) then
              result <= a - b after 100 ns ;
	      if (a = b ) then
		zero<= '1' after 10 ns ;
              else zero<='0';
	      end if ;
      elsif(alu_control = "0011" ) then
             result <=  to_stdlogicvector(to_bitvector(a) sll to_integer(unsigned(shamt))) after 100 ns ; 
      elsif(alu_control = "0000" ) then
              result <= a and b after 100 ns ;
      elsif(alu_control = "1100" ) then
              result <=  not ( a or b )after 100 ns ;
      elsif(alu_control = "0111" ) then
             if( a < b )then 
                result <= "11111111111111111111111111111111"after 100 ns ;
                else
                 result <="00000000000000000000000000000000" after 100 ns ;
             end if;
      elsif(alu_control = "0001" ) then
              result <= a or b after 100 ns  ;
      end if ;
      end process;
end ALU;     


  