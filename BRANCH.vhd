library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity BRANCH is
	port (
			D1 : in  STD_LOGIC;
			D2 : in STD_LOGIC;
			Q  : out STD_LOGIC
		 );
end BRANCH;

architecture RTL of BRANCH is
begin
	Q <= D1 AND D2;
end RTL;