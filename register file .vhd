library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity RegisterFile is
	port (	read_reg1, read_reg2, write_reg : in std_logic_vector(4 downto 0);
					write_data : in std_logic_vector(31 downto 0);
					RegWrite , cllk : in std_logic;
					read_data1, read_data2 : out std_logic_vector (31 downto 0)
				);
end RegisterFile;

architecture behave of RegisterFile is
	type registers_array is array (0 to 31) of std_logic_vector(31 downto 0);
	signal registers : registers_array := (others => "00000000000000000000000000000000");
begin
	read_data1 <= registers ( to_integer (unsigned (read_reg1))) after 100 ns;
	read_data2 <= registers ( to_integer (unsigned (read_reg2))) after 100 ns;

	process (cllk)
	begin
		if (cllk'event and cllk = '1') then
			if ((RegWrite = '1') and (write_reg /= "00000")) then
				registers(to_integer(unsigned(write_reg))) <= write_data after 100 ns;
			end if;
		end if;
	end process;
end behave;
