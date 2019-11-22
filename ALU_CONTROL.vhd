library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity ALU_CONTROL is
	port (
			FUNCT    : in STD_LOGIC_VECTOR (5 downto 0);
			ALUOP    : in STD_LOGIC_VECTOR (2 downto 0);
			ALU_CONT : out STD_LOGIC_VECTOR (2 downto 0);
			JR       : out STD_LOGIC_VECTOR (1 downto 0)
		 );
end ALU_CONTROL;

architecture RTL of ALU_CONTROL is
begin
		
	process(ALUOP, FUNCT)
	begin
		if (ALUOP = "000") then
		ALU_CONT <= "010";
		elsif (ALUOP = "010") then
		ALU_CONT <= "110";
		elsif (ALUOP = "001") then
		ALU_CONT <= "000";
		elsif (ALUOP = "011") then
		ALU_CONT <= "001";
		elsif (ALUOP = "100") then
			if (FUNCT = "100000") then ALU_CONT <= "010";
			elsif (FUNCT = "100000") then ALU_CONT <= "010";
			elsif (FUNCT = "100010") then ALU_CONT <= "110";
			elsif (FUNCT = "100100") then ALU_CONT <= "000";
			elsif (FUNCT = "100101") then ALU_CONT <= "001";
			elsif (FUNCT = "101010") then ALU_CONT <= "111";
			end if;
		end if;
	end process;
	
	process(FUNCT)
	begin
		if (FUNCT = "101010") then
			JR <= "10";
		else 
			JR <= "00";
		end if;
	end process;
	
end RTL;