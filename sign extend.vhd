library ieee;
use ieee.std_logic_1164.all;

entity SignExtend is
	port(	input_data : in std_logic_vector(15 downto 0);
				SignExtend : in std_logic;
				output_data : out std_logic_vector(31 downto 0)
			);
end SignExtend;
architecture behave of SignExtend is
begin
	process (input_data, SignExtend)
	begin
		if(SignExtend = '0') then
			output_data <= "0000000000000000" & input_data;
		else
			output_data <= (31 downto 16 => input_data (15)) & input_data;
		end if;
	end process;
end behave;
