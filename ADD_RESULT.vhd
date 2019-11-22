library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.NUMERIC_STD.all;

entity ADD_RESULT is
	port (
			D1   :  	in  STD_LOGIC_VECTOR (31 downto 0);
			D2   :  	in  STD_LOGIC_VECTOR (31 downto 0);
			Q	 :  	out STD_LOGIC_VECTOR (31 downto 0)
		 );
end ADD_RESULT;

architecture RTL of ADD_RESULT is
begin
	
	Q <= D1+D2;
	
end RTL;