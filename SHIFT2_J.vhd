library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.NUMERIC_STD.all;

entity SHIFT2_J is
	port (
			D    :  in  STD_LOGIC_VECTOR (25 downto 0);
			Q	 :  out STD_LOGIC_VECTOR (27 downto 0)
		 );
end SHIFT2_J;

architecture RTL of SHIFT2_J is

signal IMED: STD_LOGIC_VECTOR(1 downto 0);
signal AUX : STD_LOGIC_VECTOR(27 downto 0);

begin
	
	IMED <= "10";
	AUX <= "00" & D;
	Q <= to_stdlogicvector(to_bitvector(AUX) sll to_integer(unsigned(IMED)));

end RTL;