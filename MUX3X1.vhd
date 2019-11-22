library IEEE; 
use IEEE.STD_LOGIC_1164.all;

entity MUX3X1 is
	port (
			SEL  :  in  STD_LOGIC_VECTOR (1 downto 0);
			D1   :  in  STD_LOGIC_VECTOR (31 downto 0);
			D2   :  in  STD_LOGIC_VECTOR (31 downto 0);
			D3   :  in  STD_LOGIC_VECTOR (31 downto 0);
			Q	 :  out STD_LOGIC_VECTOR (31 downto 0)
		 );
end MUX3X1;

architecture RTL of MUX3X1 is
begin
	process(SEL, D1, D2, D3)
	begin
		case SEL is
			when "00" => Q <= D1;
			when "01" => Q <= D3;
			when "10" => Q <= D2;
			when others => Q <= "00000000000000000000000000000000";
		end case;
	end process;			
end RTL;