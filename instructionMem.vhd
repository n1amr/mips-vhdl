library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.std_logic_unsigned.ALL;
use IEEE.std_logic_textio.ALL;
use std.textio.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity InstructionMemory is
  port( address : in std_logic_vector(31 downto 0);
        instruction : out std_logic_vector(31 downto 0)
      );
end entity;

architecture behave of InstructionMemory is
  type memory is array (0 to 255) of std_logic_vector(31 downto 0);
  
  --initialization function
  impure function readmemb(filename : in string) return memory is
    file mFile : text is in filename;
    variable mLine : line;
    variable ret_mem : memory;
    variable i : integer := 0;
  begin
    while( (i < 256) and (not EndFile(mFile))) loop
      readline (mFile, mLIne);
      next when mLIne(1) = '#'; -- skip comments
      read(mLine, ret_mem(i));
      i := i + 1;
    end loop;

    return ret_mem;
  end function;

  signal mem : memory := readmemb("instruction-memory.mem");
begin
  
  process(address)
  begin
      instruction <= mem(conv_integer(address) / 4) after 200 ns;
  end process;
end behave;
