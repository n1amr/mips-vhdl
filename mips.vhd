library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity MIPSProcessor is
end MIPSProcessor;

architecture behave of MIPSProcessor is

  component Clock is
    port( clk : out std_logic);
  end component;

  -- PC
  component PC is
  port( input_address : in std_logic_vector (31 downto 0 );
        clk : in std_logic;
        output_address : out std_logic_vector (31 downto 0):= "00000000000000000000000000000000");
  end component;

  --adderPC
  component Adder4 is
  port (  a : in std_logic_vector (31 downto 0);
          result : out std_logic_vector (31 downto 0));
  end component;

  -- InstructionMemory
  component InstructionMemory is
    port( address : in std_logic_vector(31 downto 0);
          instruction : out std_logic_vector(31 downto 0)
        );
  end component ;

  -- SignExtend
  component SignExtend is
    port( input_data : in std_logic_vector(15 downto 0);
          SignExtend : in std_logic;
          output_data : out std_logic_vector(31 downto 0)
        );
  end component;

  -- ShiftLeft2
  component ShiftLeft2 is
  port( input_data :in std_logic_vector (31 downto 0);
      output_data : out std_logic_vector (31 downto 0)
    );
  end component;

  -- Control
  component Control IS
    port( opcode :in std_logic_vector (5 downto 0);
          Branch, MemRead, MemWrite, ALUSrc, RegWrite , SignExtend, Jump: out std_logic;
          ALUOp, RegDst, MemtoReg : out std_logic_vector(1 downto 0)
        );
  end component;
   
  --Mux_2x1_5bit
  component Mux_2x1_32bit is
    port( I1:       in std_logic_vector(31 downto 0);
          I0:       in std_logic_vector(31 downto 0);
          selector: in std_logic;
          O:        out std_logic_vector(31 downto 0)
        );
  end component;

  --Mux_4x1_5bit
  component Mux_4x1_5bit is
    port( I3:       in std_logic_vector(4 downto 0);
          I2:       in std_logic_vector(4 downto 0);
          I1:       in std_logic_vector(4 downto 0);
          I0:       in std_logic_vector(4 downto 0);
          selector: in std_logic_vector(1 downto 0);
          O:        out std_logic_vector(4 downto 0)
        );
  end component;

  --Mux_4x1_32bit
  component Mux_4x1_32bit is
  port( I3:       in std_logic_vector(31 downto 0);
        I2:       in std_logic_vector(31 downto 0);
        I1:       in std_logic_vector(31 downto 0);
        I0:       in std_logic_vector(31 downto 0);
        selector: in std_logic_vector(1 downto 0);
        O:        out std_logic_vector(31 downto 0)
      );
  end component;


  -- Decoder
  component Decoder is
    port( instruction :in std_logic_vector (31 downto 0);
          opcode : out std_logic_vector (5 downto 0);
          rs : out std_logic_vector (4 downto 0);
          rt : out std_logic_vector (4 downto 0);
          rd : out std_logic_vector (4 downto 0);
          shamt : out std_logic_vector (4 downto 0);
          funct : out std_logic_vector (5 downto 0);
          shift : out std_logic_vector (15 downto 0);
          jump_address : out std_logic_vector (25 downto 0)
        );
  end component;

  -- RegisterFile
  component RegisterFile is
    port (  read_reg1, read_reg2, write_reg : in std_logic_vector(4 downto 0);
            write_data : in std_logic_vector(31 downto 0);
            RegWrite , cllk : in std_logic;
            read_data1, read_data2 : out std_logic_vector (31 downto 0)
          );
  end component ;

  -- Data Memory
  component DataMemory is
    port( address : in std_logic_vector(31 downto 0);
          clk : in std_logic ;
          write_data: in std_logic_vector(31 downto 0);
          MemWrite, MemRead: in std_logic;
          read_data : out std_logic_vector(31 downto 0)
        );
  end component;

  --ALU
  component ALU is
    port( a, b : in std_logic_vector( 31 downto 0);
          alu_control : in std_logic_vector (3 downto 0);
          shamt :in std_logic_vector ( 4 downto 0);
          result : out std_logic_vector(31 downto 0);
          zero : out std_logic );
  end component;

  -- Adder
  component Adder is
    port (  a : in std_logic_vector (31 downto 0);
            b : in std_logic_vector (31 downto 0);
            result : out std_logic_vector (31 downto 0));
  end component;

  -- ALUControl
  component ALUControl is
    port( ALUOp : in std_logic_vector (1 downto 0);
          Funct : in std_logic_vector (5 downto 0);
          jr :out std_logic;
          aluControl : out std_logic_vector(3 downto 0)
        );
  end component;

  signal clk : std_logic;
  signal pc_signal, next_pc, pc_plus_4, sign_extended_shift, branch_offset : std_logic_vector (31 downto 0);
  signal instruction : std_logic_vector (31 downto 0);
  signal opcode,funct : std_logic_vector (5 downto 0);
  signal rs,rt,rd,shamt : std_logic_vector (4 downto 0);
  signal shift : std_logic_vector (15 downto 0);
  signal jump_address : std_logic_vector (25 downto 0);
  signal Branch, MemRead, MemWrite, ALUSrc, RegWrite, Jump, sign_extend_signal, alu_zero : std_logic;
  signal ALUOp, RegDst, MemtoReg : std_logic_vector (1 downto 0);
  signal reg_file_write_reg : std_logic_vector (4 downto 0);
  signal reg_file_write_data, reg_file_read_data1, reg_file_read_data2,alu_input_b,alu_output: std_logic_vector (31 downto 0);
  signal alu_control : std_logic_vector (3 downto 0);
  signal jump_mux_pc : std_logic_vector (31 downto 0);
  signal jump_pc : std_logic_vector (31 downto 0);
  signal not_jr, jr : std_logic;
  signal RegWrite_unless_jr : std_logic;
  signal take_branch : std_logic;
  signal branch_mux_pc : std_logic_vector (31 downto 0);
  signal taken_branch_pc, data_mem_output : std_logic_vector (31 downto 0);

begin
  jump_pc <= pc_plus_4(31) & pc_plus_4(30) & pc_plus_4(29) & pc_plus_4(28) & jump_address & "00";
  take_branch <= Branch and alu_zero;
  not_jr <= not(jr);
  RegWrite_unless_jr <= RegWrite and not_jr;

  mClock : Clock port map (clk);

  mPC : PC port map (next_pc, clk, pc_signal);
  mAdder4: Adder4 port map (pc_signal, pc_plus_4);
  mInstructionMemory : InstructionMemory port map (pc_signal, instruction);
  mDecoder : Decoder port map(instruction, opcode, rs, rt, rd, shamt, funct, shift, jump_address);
  mControl : Control port map (opcode, Branch, MemRead, MemWrite, ALUSrc, RegWrite, sign_extend_signal, Jump, ALUOp, RegDst, MemtoReg);
  reg_dst_Mux_4x1_5bit: Mux_4x1_5bit port map("XXXXX","11111", rd, rt, RegDst, reg_file_write_reg);
  mRegisterFile : RegisterFile port map (rs, rt, reg_file_write_reg, reg_file_write_data, RegWrite_unless_jr, clk, reg_file_read_data1, reg_file_read_data2);
  mALUControl : ALUControl port map(ALUOp, funct, jr, alu_control);
  mSignExtend : SignExtend port map (shift, sign_extend_signal, sign_extended_shift);
  alu_src_Mux_2x1_32bit : Mux_2x1_32bit port map(sign_extended_shift, reg_file_read_data2, ALUSrc, alu_input_b);
  mALU : ALU port map(reg_file_read_data1, alu_input_b, alu_control, shamt, alu_output, alu_zero);
  mDataMemory : DataMemory port map(alu_output, clk, reg_file_read_data2, MemWrite, MemRead, data_mem_output);
  mem_to_reg_Mux_4x1_32bit : Mux_4x1_32bit port map("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", pc_plus_4, data_mem_output, alu_output, MemtoReg, reg_file_write_data);
  mShiftLeft2 : ShiftLeft2 port map(sign_extended_shift, branch_offset);
  branch_Adder : Adder port map (pc_plus_4, branch_offset, taken_branch_pc);
  branch_Mux_2x1_32bit : Mux_2x1_32bit port map (taken_branch_pc, pc_plus_4, take_branch, branch_mux_pc);
  jump_Mux_2x1_32bit : Mux_2x1_32bit port map (jump_pc, branch_mux_pc, Jump, jump_mux_pc);
  jr_Mux_2x1_32bit : Mux_2x1_32bit port map (reg_file_read_data1, jump_mux_pc, jr, next_pc);
end behave;
