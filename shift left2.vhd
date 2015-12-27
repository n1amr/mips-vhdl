library ieee;
use ieee.std_logic_1164.all;

entity ShiftLeft2 is
	port(	input_data :in std_logic_vector (31 downto 0);
				output_data : out std_logic_vector (31 downto 0)
			);
end ShiftLeft2;

architecture behave of ShiftLeft2 is
begin
	process (input_data)
	begin
			output_data <= to_stdlogicvector(to_bitvector(input_data) sll 2);
	end process;
end behave;
