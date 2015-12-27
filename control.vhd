library IEEE;
use IEEE.std_logic_1164.ALL ;

entity control IS
  port( opcode :in std_logic_vector (5 downto 0);
        Branch, MemRead, MemWrite, ALUSrc, RegWrite , SignExtend: out std_logic;
        ALUOp, RegDst, MemtoReg : out std_logic_vector(1 downto 0)
      );
end control;

architecture behave OF control IS
begin
  process (opcode)
  begin
    -- Rformat
    if (opcode = "000000") then
      RegDst <= "01";
      ALUSrc <= '0';
      MemtoReg <= "00";
      RegWrite <= '1';
      MemRead <= '0';
      MemWrite <= '0';
      Branch <= '0';
      ALUOp <= "10";
      SignExtend <= '1';
    end if;
    -- addi
    if (opcode = "001000") then
      RegDst <= "00";
      ALUSrc <= '1';
      MemtoReg <= "00";
      RegWrite <= '1';
      MemRead <= '0';
      MemWrite <= '0';
      Branch <= '0';
      ALUOp <= "00";
      SignExtend <= '1';
    end if;
    -- andi
    if (opcode = "001100") then
      RegDst <= "00";
      ALUSrc <= '1';
      MemtoReg <= "00";
      RegWrite <= '1';
      MemRead <= '0';
      MemWrite <= '0';
      Branch <= '0';
      ALUOp <= "11";
      SignExtend <= '0';
    end if;

    -- lw
    if (opcode = "100011") then
      RegDst <= "00";
      ALUSrc <= '1';
      MemtoReg <= "01";
      RegWrite <= '1';
      MemRead <= '1';
      MemWrite <= '0';
      Branch <= '0';
      ALUOp <= "00";
      SignExtend <= '1';
    end if;
    -- sw
    if (opcode = "101011") then
      RegDst <= "XX";
      ALUSrc <= '1';
      MemtoReg <= "XX";
      RegWrite <= '0';
      MemRead <= '0';
      MemWrite <= '1';
      Branch <= '0';
      ALUOp <= "00";
      SignExtend <= '1';
    end if;
    -- beq
    if (opcode = "000100") then
      RegDst <= "XX";
      ALUSrc <= '0';
      MemtoReg <= "XX";
      RegWrite <= '0';
      MemRead <= '0';
      MemWrite <= '0';
      Branch <= '1';
      ALUOp <= "01";
      SignExtend <= '1';
    end if;
    -- jal
    if (opcode = "000011") then
      RegDst <= "10";
      ALUSrc <= 'X';
      MemtoReg <= "10";
      RegWrite <= '1';
      MemRead <= '0';
      MemWrite <= '0';
      Branch <= '0';
      ALUOp <= "XX";
      SignExtend <= '1';
    end if;
  end process;
end behave;
