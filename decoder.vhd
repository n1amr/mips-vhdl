library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

	 	  entity decoder IS
		  port (instruction :IN std_logic_vector (31 downto 0 ) ;
		  opcode : out std_logic_vector (5 downto 0) ;
		  rs : out std_logic_vector (4 downto 0);
		  rt : out std_logic_vector (4 downto 0);
		  rd : out std_logic_vector (4 downto 0);	
		  shamt : out std_logic_vector (4 downto 0); 
		  funct : out std_logic_vector (5 downto 0);
		  shift : out std_logic_vector (15 downto 0);
		  jump_address : out std_logic_vector (25 downto 0) );
	  end decoder;
	  architecture behave OF decoder IS
	  begin 
		  process (instruction)
		  begin
   opcode <= instruction(31 downto 26)after 10 ns;	  			   
   rs <= instruction(25 downto 21) after 10 ns;
  rt <= instruction(20 downto 16) after 10 ns;
   rd <= instruction(15 downto 11) after 10 ns;
   shamt <= instruction(10 downto 6) after 10 ns;
   funct <= instruction(5 downto 0)after 10 ns;
  shift <= instruction(15 downto 0) after 10 ns;
   jump_address <= instruction(25 downto 0) after 10 ns;

		  end process;
		  end behave ;