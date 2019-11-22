library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.NUMERIC_STD.all;

entity SHIFT2 is
	port (
			D    :  in  STD_LOGIC_VECTOR (31 downto 0);
			Q	 :  out STD_LOGIC_VECTOR (31 downto 0)
		 );
end SHIFT2;

architecture RTL of SHIFT2 is

signal IMED: STD_LOGIC_VECTOR(1 downto 0);

begin
	
	IMED <= "10";
	Q <= to_stdlogicvector(to_bitvector(D) sll to_integer(unsigned(IMED)));

end RTL;