entity signextend IS
		  port (input : in bit_vector (15 downto 0); sign :IN bit ; output : out bit_vector (31 downto 0 ));
	  end signextend ;
	  architecture behave OF signextend IS
	  begin 
		  process (input , sign)
		  begin
			  if (sign = '0') then 
				  output <= "0000000000000000" & input;
			 else 
			 output <= input (15) & input (15) &input (15) &input (15) &input (15) &input (15) &input (15) &input (15) &input (15) &input (15) &input (15) &input (15) &input (15) &input (15) &input (15) &input (15) & input ; 
		 -- output <= (15 downto 0) => (input(15))  & input;  
			 end if ;
		  end process;
		  end behave ;
		  
				   		
									 			   	 
