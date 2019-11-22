library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity OR_J is
	port (
			D1   :  in  STD_LOGIC_VECTOR (1 downto 0);
			D2   :  in  STD_LOGIC_VECTOR (1 downto 0);
			Q	 :  out STD_LOGIC_VECTOR (1 downto 0)
		 );
end OR_J;

architecture RTL of OR_J is
begin
	
	Q <= D1 OR D2;

end RTL;