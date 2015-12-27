library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;
entity instructionMemory is
    port(read_address : in std_logic_vector(31 downto 0);
instruction : out std_logic_vector(31 downto 0));
    end instructionMemory;
    architecture bev of instructionMemory is
        type mem is array (255 downto 0) of std_logic_vector(31 downto 0);
        signal t_mem : mem;
        begin
            process(read_address)
                FILE f : TEXT;
                constant filename : string :="output.txt";
                VARIABLE L : LINE;
                variable i : integer:=0;
                variable b : std_logic_vector(31 downto 0);
                begin
                    
                    File_Open (f,FILENAME, read_mode);	
			while ((i<=255) and (not EndFile (f))) loop
			readline (f, l);
			next when l(1) = '#'; 
			read(l, b);
			t_mem(i) <= b;
			i := i + 1;
		end loop;
		File_Close (f);                    
                instruction<=t_mem(conv_integer(read_address))after 200 ns ;
            end process;
        end bev;
