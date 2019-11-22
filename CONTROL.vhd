library IEEE; 
use IEEE.STD_LOGIC_1164.ALL;

entity CONTROL is
	port (
			CLOCK		: in STD_LOGIC;
			RESET       : in STD_LOGIC;
			INSTRUCTION : in STD_LOGIC_VECTOR (5 downto 0);
			S_WB		: out STD_LOGIC_VECTOR (1 downto 0);
			S_M 		: out STD_LOGIC_VECTOR (2 downto 0);
			S_EX		: out STD_LOGIC_VECTOR (4 downto 0);
			S_J			: out STD_LOGIC_VECTOR (1 downto 0)
	     );
end CONTROL;

architecture RTL of CONTROL is
begin
	--RegWrite, MenToReg
	process(INSTRUCTION)
	begin
		case INSTRUCTION is
			when "101011" => S_WB <= "11";
			when "100011" => S_WB <= "00";
			when "011011" => S_WB <= "10";
			when "010011" => S_WB <= "10";
			when "001011" => S_WB <= "10";
			when "000011" => S_WB <= "10";
			when "000100" => S_WB <= "10";
			when "000010" => S_WB <= "00";
			when "000000" => S_WB <= "00";
			when others => S_WB <= "00";
		end case;
	end process;
	
	--Branch, MemRead, MemWrtie
	process(INSTRUCTION)
	begin
		case INSTRUCTION is
			when "101011" => S_M <= "010";
			when "100011" => S_M <= "001";
			when "011011" => S_M <= "000";
			when "010011" => S_M <= "000";
			when "001011" => S_M <= "000";
			when "000011" => S_M <= "000";
			when "000100" => S_M <= "100";
			when "000010" => S_M <= "000";
			when "000000" => S_M <= "000";
			when others => S_M <= "000";
		end case;
	end process;
	
	--RegDst, ALUop(3bits), ALUsr
	process(INSTRUCTION)
	begin
		case INSTRUCTION is
			when "101011" => S_EX <= "00001";
			when "100011" => S_EX <= "00001";
			when "011011" => S_EX <= "10001";
			when "010011" => S_EX <= "10101";
			when "001011" => S_EX <= "10011";
			when "000011" => S_EX <= "10111";
			when "000100" => S_EX <= "00100";
			when "000010" => S_EX <= "00000";
			when "000000" => S_EX <= "11000";
			when others => S_EX <= "00000";
		end case;
	end process;
	
	--J
	process(INSTRUCTION)
	begin
		case INSTRUCTION is
			when "101011" => S_J <= "00";
			when "100011" => S_J <= "00";
			when "011011" => S_J <= "00";
			when "010011" => S_J <= "00";
			when "001011" => S_J <= "00";
			when "000011" => S_J <= "00";
			when "000100" => S_J <= "00";
			when "000010" => S_J <= "01";
			when "000000" => S_J <= "00";
			when others => S_J <= "00";
		end case;
	end process;
	
end RTL;