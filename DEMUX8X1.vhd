library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity DEMUX8X1 is
    port ( SEL 	 : 		in   STD_LOGIC_VECTOR (4  downto 0);
           REG_A : 		out  STD_LOGIC;
		   REG_B : 		out  STD_LOGIC;
		   REG_C : 		out  STD_LOGIC;
		   REG_D : 		out  STD_LOGIC;
		   REG_E : 		out  STD_LOGIC;
		   REG_F : 		out  STD_LOGIC;
		   REG_G : 		out  STD_LOGIC;
		   REG_H : 		out  STD_LOGIC
		  );
end DEMUX8X1;

architecture RTL of DEMUX8X1 is

begin
	REG_A	<= '1' when (SEL = "00000") else '0';
	REG_B	<= '1' when (SEL = "00001") else '0';
	REG_C	<= '1' when (SEL = "00010") else '0';
	REG_D	<= '1' when (SEL = "00011") else '0';
	REG_E	<= '1' when (SEL = "00100") else '0';
	REG_F	<= '1' when (SEL = "00101") else '0';
	REG_G	<= '1' when (SEL = "00110") else '0';
	REG_H	<= '1' when (SEL = "00111") else '0';
	
end RTL;
			