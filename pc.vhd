entity pc is port(
input : in bit_vector (31 DOWNTO 0 );
clk : in bit;
output : out bit_vector (31 DOWNTO 0):= "00000000000000000000000000000000");
end pc ;

architecture PC of pc is 
begin
process (clk) 
begin
   if clk ='1' and clk'event then
	 output <= input after 20 ns;
   end if;
end process;
end PC; 