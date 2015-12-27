library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;
use std.textio.all;
use IEEE.STD_LOGIC_ARITH.ALL;

entity DataMemory is
  port( address : in std_logic_vector(31 downto 0);
        clk : in std_logic ;
        write_data: in std_logic_vector(31 downto 0);
        MemWrite, MemRead: in std_logic;
        read_data : out std_logic_vector(31 downto 0)
      );
end entity;

architecture behave of DataMemory is
  type memory is array (0 to 255) of std_logic_vector(7 downto 0);
  
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

  signal mem : memory := readmemb("data-memory.mem");
begin
  process(clk)
  begin
    if(clk'event and clk = '1' and MemWrite = '1') then
      mem(conv_integer(address)) <= write_data(31 downto 24) after 100ns;
      mem(conv_integer(address) + 1) <= write_data(23 downto 16) after 100ns;
      mem(conv_integer(address) + 2) <= write_data(15 downto 8) after 100ns;
      mem(conv_integer(address) + 3) <= write_data(7 downto 0) after 100ns;
    end if;
  end process;
  
  process(MemRead, address)
  begin
    if(MemRead = '1') then
      read_data(31 downto 24) <= mem(conv_integer(address)) after 200ns;
      read_data(23 downto 16) <= mem(conv_integer(address) + 1) after 200ns;
      read_data(15 downto 8) <= mem(conv_integer(address) + 2) after 200ns;
      read_data(7 downto 0) <= mem(conv_integer(address) + 3) after 200ns;
    end if;
  end process;
end behave;
