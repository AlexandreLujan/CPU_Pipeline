library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity SING_EXT is
	port (
			D    :  	in  STD_LOGIC_VECTOR (15 downto 0);
			Q	 :  	out STD_LOGIC_VECTOR (31 downto 0)
		 );
end SING_EXT;

architecture RTL of SING_EXT is
begin
    Q <= STD_LOGIC_VECTOR(resize(signed(D), Q'length));
end RTL;
