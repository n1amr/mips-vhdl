library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

  	  entity shift_left2 IS
		  port (input :IN std_logic_vector (31 downto 0) ; output: out std_logic_vector (31 downto 0));
	  end shift_left2  ;
	  architecture behave OF shift_left2 IS
	  
	  begin 
		  process (input)
		  begin
			output <= to_stdlogicvector(to_bitvector(input) sll 2) ;  		  
	  end process;
	  end behave ;		
	  
	