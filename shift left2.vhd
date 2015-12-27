entity shift_left2 is
	port(	input_data :in bit_vector (31 downto 0);
				output_data : out bit_vector (31 downto 0)
			);
end shift_left2;

architecture behave of shift_left2 is	  
begin
	process (input_data)
	begin
			output_data <= input_data sll 2;
	end process;
end behave;
	  
	
