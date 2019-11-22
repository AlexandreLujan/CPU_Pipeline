library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity INST_MUX2X1 is
    port ( SEL  : 	in  STD_LOGIC;
           IN_A : 	in  STD_LOGIC_VECTOR (4 downto 0);
		   IN_B : 	in  STD_LOGIC_VECTOR (4 downto 0);
           Q    :	out STD_LOGIC_VECTOR (4 downto 0)
		  );
end INST_MUX2X1;

architecture RTL of INST_MUX2X1 is
begin
    Q <= IN_A when (SEL = '1') else IN_B;
end RTL;