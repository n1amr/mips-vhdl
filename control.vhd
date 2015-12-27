library IEEE;
use IEEE.std_logic_1164.ALL ;	  
entity control IS
		  port (opcode :in std_logic_vector (5 downto 0) ;
		  Branch, MemRead, MemWrite, ALUSrc, RegWrite,jump : out std_logic  ;
		  ALUOp, RegDst, MemtoReg : out std_logic_vector(1 downto 0)  );
	  end control ;
	  architecture behave OF control IS						
	  begin 
      process (opcode)	
	  begin 
	-- 	 Rformat  
  if (opcode = "000000"	)
  then  RegDst <= "01" after 10 ns;
        ALUSrc <= '0' after 10 ns;
        MemtoReg <= "00"after 10 ns;
        RegWrite <= '1'after 10 ns;
        MemRead <= '0'after 10 ns;
        MemWrite <= '0'after 10 ns;
        Branch <= '0'after 10 ns;
        ALUOp <= "10"after 10 ns;
          jump <='0'after 10 ns;

  end if  ; 
	-- addi	 
		 if (opcode = "001000"	)
			  then	 RegDst <= "00"after 10 ns;
        ALUSrc <= '1' after 10 ns;
        MemtoReg <= "00" after 10 ns;
        RegWrite <= '1'after 10 ns;
        MemRead <= '0'after 10 ns;
        MemWrite <= '0'after 10 ns;
        Branch <= '0'after 10 ns;
        ALUOp <= "00"after 10 ns;
          jump <='0'after 10 ns;

		 end if  ;
		  -- andi 
  if (opcode = "001100"	)
  then  RegDst <= "00"after 10 ns;
        ALUSrc <= '1'after 10 ns;
        MemtoReg <= "00"after 10 ns;
        RegWrite <= '1'after 10 ns;
        MemRead <= '0'after 10 ns;
        MemWrite <= '0'after 10 ns;
        Branch <= '0'after 10 ns;
        ALUOp <= "11"after 10 ns;
          jump <='0'after 10 ns;

  end if  ;       
  		   -- lw
  if (opcode = "100011"	)
  then  RegDst <= "00"after 10 ns;
        ALUSrc <= '1'after 10 ns;
        MemtoReg <= "01"after 10 ns;
        RegWrite <= '1'after 10 ns;
        MemRead <= '1'after 10 ns;
        MemWrite <= '0'after 10 ns;
        Branch <= '0'after 10 ns;
        ALUOp <= "00"after 10 ns;
        jump <='0'after 10 ns;
  end if  ;  
  		-- sw
  if (opcode = "101011"	)
  then  RegDst <= "XX"after 10 ns;
        ALUSrc <= '1'after 10 ns;
        MemtoReg <= "XX"after 10 ns;
        RegWrite <= '0'after 10 ns;
        MemRead <= '0'after 10 ns;
        MemWrite <= '1'after 10 ns;
        Branch <= '0'after 10 ns;
        ALUOp <= "00"after 10 ns;
        jump <='0'after 10 ns;

  end if  ;	
  		-- beq
  if (opcode = "000100"	)
  then  RegDst <= "XX";
        ALUSrc <= '0' after 10 ns;
        MemtoReg <= "XX" after 10 ns;
        RegWrite <= '0'after 10 ns;
        MemRead <= '0'after 10 ns;
        MemWrite <= '0'after 10 ns;
        Branch <= '1'after 10 ns;
        ALUOp <= "01"after 10 ns;
          jump <='0'after 10 ns;


  end if  ;
  	 -- jal
  if (opcode = "000011"	)
  then  RegDst <= "10"after 10 ns;
        ALUSrc <= 'X'after 10 ns;
        MemtoReg <= "10"after 10 ns;
        RegWrite <= '1'after 10 ns;
        MemRead <= '0'after 10 ns;
        MemWrite <= '0'after 10 ns;
        Branch <= '0'after 10 ns;
        ALUOp <= "XX"after 10 ns;
         jump <='1'after 10 ns;
  end if  ;
      
			  end process;
		  end behave ;