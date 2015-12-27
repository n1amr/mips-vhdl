library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;
use std.textio.all;
entity text_read is
    port(address : in std_logic_vector(31 downto 0);
	clk : in std_logic ;
	datain: in std_logic_vector(31 downto 0); 
    wrtenb,readenb: in std_logic; 

	dataout : out std_logic_vector(31 downto 0)
	);
    end entity;
    architecture bev of text_read is
        type mem is array (255 downto 0) of std_logic_vector(7 downto 0);
        signal t_mem : mem;
        begin
        	process (clk , address )
		 begin
		 if (clk' event and clk='1' and wrtenb='1') then 
  	        t_mem(conv_integer(address)+3) <= datain(31 downto 24) ; 
		t_mem(conv_integer(address)+2) <= datain(23 downto 16); 
		t_mem(conv_integer(address)+1) <= datain(15 downto 8); 
		t_mem(conv_integer(address)) <= datain(7 downto 0)after 100 ns;

		 end if;
		 end process ;
			process(address)
                FILE f : TEXT;
                constant filename : string :="output.txt";
                VARIABLE L : LINE;
                variable i : integer:=0;
                variable b : std_logic_vector(7 downto 0);
                begin
                    
                    File_Open (f,FILENAME, read_mode);	
			while ((i<=15) and (not EndFile (f))) loop
			readline (f, l);
			next when l(1) = '#'; 
			read(l, b);
			t_mem(i) <= b;
			i := i + 1;
		end loop;
		File_Close (f); 
		if (readenb='1')then 
			dataout(31 downto 24) <= t_mem(conv_integer(address)+3); 
			dataout(23 downto 16) <= t_mem(conv_integer(address)+2); 
			dataout(15 downto 8)<= t_mem(conv_integer(address)+1);
			dataout(15 downto 8) <= t_mem(conv_integer(address))after 200 ns;
		
		--dataout(7 downto 0) <= b(7 downto 0); 
        end if; 								
	

		 end process;  
		 
        end bev;
