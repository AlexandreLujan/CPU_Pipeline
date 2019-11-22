library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity REGISTERS is
	port (
			READ_REG1 	: in STD_LOGIC_VECTOR (4 downto 0);
			READ_REG2	: in STD_LOGIC_VECTOR (4 downto 0);
			WRITE_REG  	: in STD_LOGIC_VECTOR (4 downto 0);
			WIRTE_DATA  : in STD_LOGIC_VECTOR (31 downto 0);
			REG_WRITE  	: in STD_LOGIC;
			CLOCK  		: in STD_LOGIC;
			RESET  		: in STD_LOGIC;
			READ_DATA1 	: out STD_LOGIC_VECTOR (31 downto 0);
			READ_DATA2	: out STD_LOGIC_VECTOR (31 downto 0);
			OUT_RA      : out STD_LOGIC_VECTOR (31 downto 0); 
			OUT_RB      : out STD_LOGIC_VECTOR (31 downto 0); 
			OUT_RC      : out STD_LOGIC_VECTOR (31 downto 0); 
			OUT_RD      : out STD_LOGIC_VECTOR (31 downto 0); 
			OUT_RE      : out STD_LOGIC_VECTOR (31 downto 0); 
			OUT_RF      : out STD_LOGIC_VECTOR (31 downto 0); 
			OUT_RG      : out STD_LOGIC_VECTOR (31 downto 0); 
			OUT_RH      : out STD_LOGIC_VECTOR (31 downto 0)
		 );
end REGISTERS;

architecture RTL of REGISTERS is

	signal ENABLE_A, ENABLE_B, ENABLE_C, ENABLE_D, ENABLE_E, ENABLE_F, ENABLE_G, ENABLE_H: STD_LOGIC;
	signal QA, QB, QC, QD, QE, QF, QG, QH: STD_LOGIC_VECTOR(31 downto 0);
	
	component MUX8X1
	port ( SEL 	: 		in  STD_LOGIC_VECTOR (4  downto 0);
           IN_A : 		in  STD_LOGIC_VECTOR (31 downto 0);
		   IN_B : 		in  STD_LOGIC_VECTOR (31 downto 0);
		   IN_C : 		in  STD_LOGIC_VECTOR (31 downto 0);
		   IN_D : 		in  STD_LOGIC_VECTOR (31 downto 0);
		   IN_E : 		in  STD_LOGIC_VECTOR (31 downto 0);
		   IN_F : 		in  STD_LOGIC_VECTOR (31 downto 0);
		   IN_G : 		in  STD_LOGIC_VECTOR (31 downto 0);
		   IN_H : 		in  STD_LOGIC_VECTOR (31 downto 0);
           Q 	:		out STD_LOGIC_VECTOR (31 downto 0)
		  );
	end component;
	
	component UN_REGISTER
	port ( ENABLE 		: in  STD_LOGIC; 
		   RESET  		: in  STD_LOGIC;
		   CLOCK  		: in  STD_LOGIC;
		   D      		: in  STD_LOGIC_VECTOR (31 downto 0);
		   REG_WRITE  	: in STD_LOGIC;
		   Q      		: out STD_LOGIC_VECTOR (31 downto 0)
		 );
	end component;
	
	component DEMUX8X1
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
	end component;
	
begin

	MUX8X1_1:MUX8X1
	port map  (
				SEL  => READ_REG1,
				IN_A => QA,
				IN_B => QB,
				IN_C => QC,	
				IN_D => QD,
				IN_E => QE,
				IN_F => QF,
				IN_G => QG,
				IN_H => QH,
				Q 	 => READ_DATA1
			  );
			  
	MUX8X1_2:MUX8X1
	port map  (
				SEL  => READ_REG2,
				IN_A => QA,
				IN_B => QB,
				IN_C => QC,	
				IN_D => QD,
				IN_E => QE,
				IN_F => QF,
				IN_G => QG,
				IN_H => QH,
				Q 	 => READ_DATA2
			  );		  
	
	REGA:UN_REGISTER
	port map (
				ENABLE => ENABLE_A,
				RESET  => RESET,
				CLOCK  => CLOCK,
				D      => WIRTE_DATA,
				REG_WRITE => REG_WRITE,
				Q      => QA
			 );
			 
	REGB:UN_REGISTER
	port map (
				ENABLE => ENABLE_B,
				RESET  => RESET,
				CLOCK  => CLOCK,
				D      => WIRTE_DATA,
				REG_WRITE => REG_WRITE,
				Q      => QB
			 );	

	REGC:UN_REGISTER
	port map (
				ENABLE => ENABLE_C,
				RESET  => RESET,
				CLOCK  => CLOCK,
				D      => WIRTE_DATA,
				REG_WRITE => REG_WRITE,
				Q      => QC
			 );

	REGD:UN_REGISTER
	port map (
				ENABLE => ENABLE_D,
				RESET  => RESET,
				CLOCK  => CLOCK,
				D      => WIRTE_DATA,
				REG_WRITE => REG_WRITE,
				Q      => QD
			 );
			 
	REGE:UN_REGISTER
	port map (
				ENABLE => ENABLE_E,
				RESET  => RESET,
				CLOCK  => CLOCK,
				D      => WIRTE_DATA,
				REG_WRITE => REG_WRITE,
				Q      => QE
			 );

	REGF:UN_REGISTER
	port map (
				ENABLE => ENABLE_F,
				RESET  => RESET,
				CLOCK  => CLOCK,
				D      => WIRTE_DATA,
				REG_WRITE => REG_WRITE,
				Q      => QF
			 );
			 
	REGG:UN_REGISTER
	port map (
				ENABLE => ENABLE_G,
				RESET  => RESET,
				CLOCK  => CLOCK,
				D      => WIRTE_DATA,
				REG_WRITE => REG_WRITE,
				Q      => QG
			 );		 
			 
	REGH:UN_REGISTER
	port map (
				ENABLE => ENABLE_H,
				RESET  => RESET,
				CLOCK  => CLOCK,
				D      => WIRTE_DATA,
				REG_WRITE => REG_WRITE,
				Q      => QH
			 );		 
			 
	UN_DEMUX8X1:DEMUX8X1
	port map (
				SEL   => WRITE_REG,
				REG_A => ENABLE_A,
				REG_B => ENABLE_B,
				REG_C => ENABLE_C,
				REG_D => ENABLE_D,
				REG_E => ENABLE_E,
				REG_F => ENABLE_F,
				REG_G => ENABLE_G,
				REG_H => ENABLE_H
			 );	

	OUT_RA <= QA;
	OUT_RB <= QB;
	OUT_RC <= QC;
	OUT_RD <= QD;
	OUT_RE <= QE;
	OUT_RF <= QF;
	OUT_RG <= QG;
	OUT_RH <= QH;
	
end RTL;			 