library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
entity mips_processor is 
end mips_processor ;
architecture behave of mips_processor is 

-- pc
component pc is port ( 	
input : in std_logic_vector (31 DOWNTO 0 );		
clk : in std_logic;
output : out std_logic_vector (31 DOWNTO 0):= "00000000000000000000000000000000") ;
end component ;

--adderPC
component Adder4 IS port ( 
c : in std_logic_vector (31 DOWNTO 0);
result : out std_logic_vector (31 DOWNTO 0));
end component;

-- inst mem 
component instructionMemory is port(
read_address : in std_logic_vector(31 downto 0);
instruction : out std_logic_vector(31 downto 0));
end component ;

-- sign extend 
component signextend is port (
input : in std_logic_vector (15 downto 0);
sign :IN std_logic ; 
output : out std_logic_vector (31 downto 0 ));
end component ;

-- shift left  
component shift_left2 IS port (
input :IN std_logic_vector (31 downto 0) ; 
output: out std_logic_vector (31 downto 0));
 end component  ;

-- control
component control IS port (
opcode :in std_logic_vector (5 downto 0) ;
Branch, MemRead, MemWrite, ALUSrc, RegWrite,jump : out std_logic  ;
ALUOp, RegDst, MemtoReg : out std_logic_vector(1 downto 0)  );
end component ;

--mux_4_5bit
component Mux_4x1_5bit is port( 
I3:       in std_logic_vector(4 downto 0);
I2:       in std_logic_vector(4 downto 0);
I1:       in std_logic_vector(4 downto 0);
I0:       in std_logic_vector(4 downto 0);
selector: in std_logic_vector(1 downto 0);
O:        out std_logic_vector(4 downto 0));
end component;
 
--mux_2_32bit  
component Mux_2x1_32bit is port( 
I1:       in std_logic_vector(31 downto 0);
I0:       in std_logic_vector(31 downto 0);
selector: in std_logic;
O:        out std_logic_vector(31 downto 0));
end component;

-- decoder 
component decoder IS
		  port (instruction :IN std_logic_vector (31 downto 0 ) ;
		  opcode : out std_logic_vector (5 downto 0) ;
		  rs : out std_logic_vector (4 downto 0);
		  rt : out std_logic_vector (4 downto 0);
		  rd : out std_logic_vector (4 downto 0);	
		  shamt : out std_logic_vector (4 downto 0); 
		  funct : out std_logic_vector (5 downto 0);
		  shift : out std_logic_vector (15 downto 0);
		  jump_address : out std_logic_vector (25 downto 0) );
	
	  end component;

-- reg file 
component RegisterFile is port ( 
 read_reg1, read_reg2, write_reg : in std_logic_vector(4 downto 0);
write_data : in std_logic_vector(31 downto 0);
RegWrite , cllk : in std_logic ; 
read_data1, read_data2 : out std_logic_vector (31 downto 0 )) ;
end component ;

-- data mem  
component data_mem is port(
address : in std_logic_vector(31 downto 0);
clk : in std_logic ;
datain: in std_logic_vector(31 downto 0); 
wrtenb,readenb: in std_logic; 
dataout : out std_logic_vector(31 downto 0));
end component;

--alu 
component alu is port ( 
	a,b : in std_logic_vector( 31 DOWNTO 0);
	alu_control : in std_logic_vector (3 DOWNTO 0);
	shamt :in std_logic_vector ( 4 DOWNTO 0);
	result : out std_logic_vector(31 DOWNTO 0);
	zero : std_logic );
end component ;
-- adder 
component adder IS port ( 
a : in std_logic_vector (31 DOWNTO 0);
b : in std_logic_vector (31 DOWNTO 0) ;
result : out std_logic_vector (31 DOWNTO 0));
end component;

--alu control  
component aluControl is 
 port ( ALUOp : in std_logic_vector ( 1 DOWNTO 0 ) ;
 Funct : in std_logic_vector ( 5 DOWNTO 0 );
 jr ,sign :out std_logic;
 aluControl : out std_logic_vector( 3 DOWNTO 0 ));
end component ;  --out, select, in0, in1, in2, in3)
--Mux_4x1_32bit
component Mux_4x1_32bit is port( 
I3:in std_logic_vector(31 downto 0);
I2:in std_logic_vector(31 downto 0);
I1:in std_logic_vector(31 downto 0);
I0:in std_logic_vector(31 downto 0);
selector:in std_logic_vector(1 downto 0);
O:out std_logic_vector(31 downto 0));
end component;
  signal pc1,next_pc, pc_plus_4,sign_extended_shift,branch_offset : std_logic_vector (31 DOWNTO 0);
  signal instruction : std_logic_vector (31 DOWNTO 0);
  signal opcode,funct : std_logic_vector (5 DOWNTO 0);
  signal rs,rt,rd,shamt : std_logic_vector (4 DOWNTO 0);
  signal shift : std_logic_vector (15 DOWNTO 0);
  signal jump_address : std_logic_vector (25 DOWNTO 0);
  signal Branch, MemRead, MemWrite, ALUSrc, RegWrite, Jump,signextend1,alu_zero : std_logic;
  signal ALUOp, RegDst, MemtoReg  : std_logic_vector (1 DOWNTO 0);
  signal reg_file_write_reg  : std_logic_vector (4 DOWNTO 0);
  signal reg_file_write_data,reg_file_read_data1, reg_file_read_data2,alu_input_b,alu_output: std_logic_vector (31 DOWNTO 0);
  signal alu_control : std_logic_vector (3 DOWNTO 0);  
  signal jump_mux_pc : std_logic_vector (31 DOWNTO 0);
  signal jump_pc : std_logic_vector (31 DOWNTO 0);
  signal not_jr,jr,clk : std_logic;
  signal RegWrite_unless_jr : std_logic;
  signal take_branch : std_logic;
  signal branch_mux_pc : std_logic_vector (31 DOWNTO 0);
  signal taken_branch_pc,data_mem_output : std_logic_vector (31 DOWNTO 0);
  
  
begin  
  jump_pc <= pc_plus_4(31) & pc_plus_4(30) & pc_plus_4(29) & pc_plus_4(28) & jump_address & "00" ;
  take_branch <= Branch and alu_zero ;
  RegWrite_unless_jr <= RegWrite and not_jr;
  not_jr <= not(jr);  
  pc_module : PC port map (pc1, clk, next_pc ); --tmam
  adder_module: adder4 port map (pc1, pc_plus_4); --tmam
  instruction_module : instructionMemory port map (pc1, instruction); --tmam
  decoder_module : decoder port map(instruction, opcode, rs, rt, rd, shamt, funct, shift, jump_address);--tmam
  control_module : control port map (opcode, Branch, MemRead,MemWrite,ALUSrc,RegWrite,Jump, ALUOp,RegDst,MemtoReg);--tmam
  reg_dst_mux:  Mux_4x1_5bit port map( "XXXXX","11111",rd,rt,RegDst,reg_file_write_reg);--tmam
  register_file_module : RegisterFile port map (rs, rt, reg_file_write_reg, reg_file_write_data, RegWrite_unless_jr, clk, reg_file_read_data1, reg_file_read_data2); --tmam
  alu_control_module :  aluControl port map(ALUOp, funct,jr, signextend1,alu_control); --tmam
  sign_extend_module : signextend port map (shift, signextend1,sign_extended_shift); --tmam
  alu_src_mux : Mux_2x1_32bit port map(sign_extended_shift ,reg_file_read_data2,  ALUSrc,alu_input_b); --tmam
  alu_module : alu port map(reg_file_read_data1, alu_input_b, alu_control, shamt, alu_output, alu_zero); --tmam
  data_memory_module : data_mem port map(alu_output,clk, reg_file_read_data2,  MemWrite,MemRead,  data_mem_output);--mshMot2kd
  mem_to_reg_mux : Mux_4x1_32bit port map("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",pc_plus_4,data_mem_output,alu_output,MemtoReg,reg_file_write_data);--tmam
  sift_left_module :  shift_left2 port map (sign_extended_shift, branch_offset);--tmam
  branch_adder_module : adder port map (pc_plus_4, branch_offset, taken_branch_pc);--tmam
  branch_mux : Mux_2x1_32bit port map (taken_branch_pc,pc_plus_4,take_branch,branch_mux_pc); --tmam
  jump_mux : Mux_2x1_32bit port map (jump_pc,branch_mux_pc,Jump,jump_mux_pc); --tmam
  jr_mux : Mux_2x1_32bit port map (reg_file_read_data1,jump_mux_pc,jr,next_pc); --tmam
 
end behave;
