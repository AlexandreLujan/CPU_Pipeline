library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.NUMERIC_STD.all;

entity ADD is
	port (
			D   :  	in  STD_LOGIC_VECTOR (31 downto 0);
			Q	 :  	out STD_LOGIC_VECTOR (31 downto 0)
		 );
end ADD;

architecture RTL of ADD is
begin
	
	Q <= D+"0100";
	
end RTL;