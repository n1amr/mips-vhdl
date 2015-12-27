entity aluControl is 
	port(	ALUOp : in bit_vector (1 DOWNTO 0);
					Funct : in bit_vector (5 DOWNTO 0);
					jr :out bit;
					aluControl : out bit_vector(3 DOWNTO 0)
			);
end aluControl;

architecture ALU_control of aluControl is
begin
	process(ALUOp ,Funct)
	begin
		if ( (ALUOp = "10") and (Funct = "001000")) then
			jr <= '1' after 10ns;
		else
			jr <= '0' after 10ns;
		end if;

		if (ALUOp ="00") then
			aluControl <= "0010" after 10ns;
		elsif (ALUOp = "01") then
			aluControl <= "0110" after 10ns;
		elsif (ALUOp = "10") then
			if(Funct= "100000") then
				aluControl <= "0010" after 10ns;
			elsif (Funct= "100100") then
				aluControl <= "0000" after 10ns;
			elsif (Funct= "100111") then
				aluControl <= "1100" after 10ns;
			elsif (Funct= "101010") then
				aluControl <= "0111" after 10ns;
			elsif (Funct= "000000") then
				aluControl <= "0011" after 10ns;
			end if;
		elsif (ALUOp = "11") then
			aluControl <= "0000" after 10ns;
		end if;
	end process;
end ALU_control;
