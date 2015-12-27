entity decoder is
  port( instruction :IN bit_vector (31 downto 0 );
        opcode : out bit_vector (5 downto 0);
        rs : out bit_vector (4 downto 0);
        rt : out bit_vector (4 downto 0);
        rd : out bit_vector (4 downto 0);
        shamt : out bit_vector (4 downto 0);
        funct : out bit_vector (5 downto 0);
        shift : out bit_vector (15 downto 0);
        jump_address : out bit_vector (25 downto 0)
      );
end decoder;

architecture behave of decoder is
begin
  process(instruction)
  begin
    opcode <= instruction(31 downto 26) after 10ns;
    rs <= instruction(25 downto 21) after 10ns;
    rt <= instruction(20 downto 16) after 10ns;
    rd <= instruction(15 downto 11) after 10ns;
    shamt <= instruction(10 downto 6) after 10ns;
    funct <= instruction(5 downto 0) after 10ns;
    shift <= instruction(15 downto 0) after 10ns;
    jump_address <= instruction(25 downto 0) after 10ns;
  end process;
end behave;
