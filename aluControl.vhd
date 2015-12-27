library ieee;
use ieee.std_logic_1164.all;

entity ALUControl is
	port(	ALUOp : in std_logic_vector (1 downto 0);
				Funct : in std_logic_vector (5 downto 0);
				jr :out std_logic;
				aluControl : out std_logic_vector(3 downto 0)
			);
end ALUControl;

architecture behave of ALUControl is
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
end behave;
