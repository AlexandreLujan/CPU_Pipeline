library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_SIGNED.all;
use IEEE.NUMERIC_STD.all;

entity ALU is
	port (
			D1    :  in  STD_LOGIC_VECTOR (31 downto 0);
			D2    :  in  STD_LOGIC_VECTOR (31 downto 0);
			OP    :  in  STD_LOGIC_VECTOR (2  downto 0);
			ALU_R :  out STD_LOGIC_VECTOR (31 downto 0);
			ZERO  :  out STD_LOGIC
		 );
end ALU;

architecture RTL of ALU is

signal S_ALU_R: STD_LOGIC_VECTOR(31 downto 0);

begin
	process(OP, D1, D2)
	begin
		case OP is
			when "000" => S_ALU_R <= D1 AND D2;
			when "001" => S_ALU_R <= D1 OR D2;
			when "010" => S_ALU_R <= std_logic_vector(signed(D1) + signed(D2));
			when "110" => S_ALU_R <= std_logic_vector(signed(D1) - signed(D2));
			when "111" => S_ALU_R <= D1;
			when others => S_ALU_R <= "00000000000000000000000000000000";
		end case;
	end process;
	
	ALU_R <= S_ALU_R;
	
	process(OP, S_ALU_R)
	begin
		if ((S_ALU_R = "00000000000000000000000000000000") AND (OP = "110")) then ZERO <= '1';
			else ZERO <= '0';
		end if;
	end process;
	
end RTL;