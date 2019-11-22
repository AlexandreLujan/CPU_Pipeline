library IEEE; 
use IEEE.STD_LOGIC_1164.ALL;

entity CPU_PIPELINE is
	port (
			CLOCK	 : in STD_LOGIC;
			RESET    : in STD_LOGIC;
			REG_A     : out STD_LOGIC_VECTOR (31 downto 0);
			REG_B     : out STD_LOGIC_VECTOR (31 downto 0);
			REG_C     : out STD_LOGIC_VECTOR (31 downto 0);
			REG_D     : out STD_LOGIC_VECTOR (31 downto 0);
			REG_E     : out STD_LOGIC_VECTOR (31 downto 0);
			REG_F     : out STD_LOGIC_VECTOR (31 downto 0);
			REG_G     : out STD_LOGIC_VECTOR (31 downto 0);
			REG_H     : out STD_LOGIC_VECTOR (31 downto 0)
		 );
end CPU_PIPELINE;

architecture RTL of CPU_PIPELINE is

	signal J_ADDRESS, J_REGISTER, S_JCONT, S_MUXPC, PC_MUX2X1, PC_ADDR, ADD_MUX2X1, ADDR_IFID, S_INTS, S_ADD, S_WDATA, S_DATA1, S_DATA2, S_EXT, IDEX_ADD, SHIFT_ADD, ADD_EXMEM, DATA1_ALU, DATA2_ALU, OUT_SEXT, MUX_ALU, ALU_EXMEM, S_ADDRESS, S_WRITE_DATA, EXMEM_ADDR, S_READ_DATA, MEMWB_MUX1, MEMWB_MUX2: STD_LOGIC_VECTOR(31 downto 0);
	signal C_J, S_J1, S_J2, S_JR, S_JA, C_WB, WB_EXMEM,  WB_MEMWB: STD_LOGIC_VECTOR (1 downto 0);
	signal ALUop, C_M, OPALU,  M_EXMEM: STD_LOGIC_VECTOR (2 downto 0);
	signal PCJADD, MS_JADD, MS1_JADD: STD_LOGIC_VECTOR (3 downto 0);
	signal RS, RT, RD, C_EX, S_WRITE_REG, IDEX1, IDEX2, MUX2X1_EXMEM, INST_MEMWB: STD_LOGIC_VECTOR (4 downto 0);
	signal S_CONT, S_FUNCT:STD_LOGIC_VECTOR (5 downto 0);
	signal INT_ADDR : STD_LOGIC_VECTOR (15 downto 0);
	signal ADDR_J, IN_S_J : STD_LOGIC_VECTOR (25 downto 0);
	signal OUT_S_J : STD_LOGIC_VECTOR (27 downto 0);
	signal PCSrc, REGWRITE, REGDST, ALUSrc, ZERO_EXMEM, ZERO_BRANCH, S_BRANCH, MEMREAD, MEMWRITE, MEMTOREG: STD_LOGIC;
	
	component MUX_2X1
	port ( SEL  : 	in  STD_LOGIC;
           IN_A : 	in  STD_LOGIC_VECTOR (31 downto 0);
		   IN_B : 	in  STD_LOGIC_VECTOR (31 downto 0);
           Q    :	out STD_LOGIC_VECTOR (31 downto 0)
		  );
	end component;
	
	component REGISTERS
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
	end component;
	
	component INST_MEM
	port (
			CLOCK 	 : in STD_LOGIC;
			ADDRESS_I: in STD_LOGIC_VECTOR(31 downto 0);
			ADDRESS_O: out STD_LOGIC_VECTOR(31 downto 0)
		 );
	end component;
	
	component DATA_MEM
	port (
			CLOCK 	  : in STD_LOGIC;
			ADDRESS   : in STD_LOGIC_VECTOR(31 downto 0);
			MEM_WRITE : in STD_LOGIC;
			MEM_READ  : in STD_LOGIC;
			WRITE_DATA: in STD_LOGIC_VECTOR(31 downto 0);
			READ_DATA : out STD_LOGIC_VECTOR(31 downto 0)
	     );
	end component;
	
	component IF_ID
	port (
			CLOCK	 : in STD_LOGIC;
			RESET    : in STD_LOGIC;
			INST_MEM : in STD_LOGIC_VECTOR (31 downto 0);
			IN_ADD   : in STD_LOGIC_VECTOR (31 downto 0);
			IN_JMS   : in STD_LOGIC_VECTOR (3 downto 0);
			INST     : out STD_LOGIC_VECTOR (31 downto 0);
			OUT_ADD  : out STD_LOGIC_VECTOR (31 downto 0);
			OUT_JMS  : out STD_LOGIC_VECTOR (3 downto 0)
		 );
	end component;
	
	component ID_EX
	port (
						CLOCK	 : in STD_LOGIC;
			RESET    : in STD_LOGIC;
			IN_WB    : in STD_LOGIC_VECTOR (1 downto 0);
			IN_M     : in STD_LOGIC_VECTOR (2 downto 0);
			IN_EX    : in STD_LOGIC_VECTOR (4 downto 0);
			IN_DATA1 : in STD_LOGIC_VECTOR (31 downto 0);
			IN_DATA2 : in STD_LOGIC_VECTOR (31 downto 0);
			IN_S_EXT : in STD_LOGIC_VECTOR (31 downto 0);
			IN_ADD   : in STD_LOGIC_VECTOR (31 downto 0);
			IN_INST1 : in STD_LOGIC_VECTOR (4 downto 0);
			IN_INST2 : in STD_LOGIC_VECTOR (4 downto 0);
			IN_JIDEX : in STD_LOGIC_VECTOR (1 downto 0);
			IN_JADD  : in STD_LOGIC_VECTOR (25 downto 0);
			IN_JMS1  : in STD_LOGIC_VECTOR (3 downto 0);
			
			OUT_WB    : out STD_LOGIC_VECTOR (1 downto 0);
			OUT_M     : out STD_LOGIC_VECTOR (2 downto 0);
			OUT_EX1   : out STD_LOGIC;
			OUT_EX2   : out STD_LOGIC_VECTOR (2 downto 0);
			OUT_EX3   : out STD_LOGIC;
			OUT_DATA1 : out STD_LOGIC_VECTOR (31 downto 0);
			OUT_DATA2 : out STD_LOGIC_VECTOR (31 downto 0);
			OUT_S_EXT : out STD_LOGIC_VECTOR (31 downto 0);
			OUT_ADD   : out STD_LOGIC_VECTOR (31 downto 0);
			OUT_INST1 : out STD_LOGIC_VECTOR (4 downto 0);
			OUT_INST2 : out STD_LOGIC_VECTOR (4 downto 0);
			OUT_JIDEX : out STD_LOGIC_VECTOR (1 downto 0);
			OUT_JADD  : out STD_LOGIC_VECTOR (25 downto 0);
			OUT_JMS1  : out STD_LOGIC_VECTOR (3 downto 0)
		 );
	end component;
	
	component EX_MEM
	port (
			CLOCK	 : in STD_LOGIC;
			RESET    : in STD_LOGIC;
			IN_WB    : in STD_LOGIC_VECTOR (1 downto 0);
			IN_M     : in STD_LOGIC_VECTOR (2 downto 0);
			IN_ADD_R : in STD_LOGIC_VECTOR (31 downto 0);
			IN_ZERO  : in STD_LOGIC;
			IN_ALU_R : in STD_LOGIC_VECTOR (31 downto 0);
			IN_DATA2 : in STD_LOGIC_VECTOR (31 downto 0);
			IN_INST  : in STD_LOGIC_VECTOR (4 downto 0);
			IN_JEXMEM: in STD_LOGIC_VECTOR (1 downto 0);
			IN_JCONT : in STD_LOGIC_VECTOR (31 downto 0);
			
			OUT_WB    : out STD_LOGIC_VECTOR (1 downto 0);
			OUT_M1    : out STD_LOGIC;
			OUT_M2    : out STD_LOGIC;
			OUT_M3    : out STD_LOGIC;
			OUT_ADD_R : out STD_LOGIC_VECTOR (31 downto 0);
			OUT_ZERO  : out STD_LOGIC;
			OUT_ALU_R : out STD_LOGIC_VECTOR (31 downto 0);
			OUT_DATA2 : out STD_LOGIC_VECTOR (31 downto 0);
			OUT_INST  : out STD_LOGIC_VECTOR (4 downto 0);
			OUT_JEXMEM: out STD_LOGIC_VECTOR (1 downto 0);
			OUT_JCONT : out STD_LOGIC_VECTOR (31 downto 0)
		 );
	end component;
	
	component MEM_WB
	port (
			CLOCK	 : in STD_LOGIC;
			RESET    : in STD_LOGIC;
			IN_WB    : in STD_LOGIC_VECTOR (1 downto 0);
			IN_ADDR  : in STD_LOGIC_VECTOR (31 downto 0);
			IN_INST  : in STD_LOGIC_VECTOR (4 downto 0);
			
			OUT_WB1  : out STD_LOGIC;
			OUT_WB2  : out STD_LOGIC;
			OUT_ADDR : out STD_LOGIC_VECTOR (31 downto 0);
			OUT_INST : out STD_LOGIC_VECTOR (4 downto 0)
		 );
	end component;
	
	component BRANCH
	port (
			D1 : in  STD_LOGIC;
			D2 : in STD_LOGIC;
			Q  : out STD_LOGIC
		 );
	end component;
	
	component SHIFT2
	port (
			D    :  in  STD_LOGIC_VECTOR (31 downto 0);
			Q	 :  out STD_LOGIC_VECTOR (31 downto 0)
		 );
	end component;
	
	component ALU
	port (
			D1    :  in  STD_LOGIC_VECTOR (31 downto 0);
			D2    :  in  STD_LOGIC_VECTOR (31 downto 0);
			OP    :  in  STD_LOGIC_VECTOR (2  downto 0);
			ALU_R :  out STD_LOGIC_VECTOR (31 downto 0);
			ZERO  :  out STD_LOGIC
		 );
	end component;
	
	component ADD_RESULT
	port (
			D1   :  	in  STD_LOGIC_VECTOR (31 downto 0);
			D2   :  	in  STD_LOGIC_VECTOR (31 downto 0);
			Q	 :  	out STD_LOGIC_VECTOR (31 downto 0)
		 );
	end component;
	
	component ADD
	port (
			D   :  	in  STD_LOGIC_VECTOR (31 downto 0);
			Q	 :  	out STD_LOGIC_VECTOR (31 downto 0)
		 );
	end component;
	
	component SING_EXT
	port (
			D    :  	in  STD_LOGIC_VECTOR (15 downto 0);
			Q	 :  	out STD_LOGIC_VECTOR (31 downto 0)
		 );
	end component;

	component ALU_CONTROL
	port (
			FUNCT    : in STD_LOGIC_VECTOR (5 downto 0);
			ALUOP    : in STD_LOGIC_VECTOR (2 downto 0);
			ALU_CONT : out STD_LOGIC_VECTOR (2 downto 0);
			JR       : out STD_LOGIC_VECTOR (1 downto 0)
		 );
	end component;

	component INST_MUX2X1
	port ( SEL  : 	in  STD_LOGIC;
           IN_A : 	in  STD_LOGIC_VECTOR (4 downto 0);
		   IN_B : 	in  STD_LOGIC_VECTOR (4 downto 0);
           Q    :	out STD_LOGIC_VECTOR (4 downto 0)
		  );
	end component;

	component CONTROL
	port (
			CLOCK		: in STD_LOGIC;
			RESET       : in STD_LOGIC;
			INSTRUCTION : in STD_LOGIC_VECTOR (5 downto 0);
			S_WB		: out STD_LOGIC_VECTOR (1 downto 0);
			S_M 		: out STD_LOGIC_VECTOR (2 downto 0);
			S_EX		: out STD_LOGIC_VECTOR (4 downto 0);
			S_J			: out STD_LOGIC_VECTOR (1 downto 0)
	     );
	end component;

	component PC
	port (  
		   RESET  		: in  STD_LOGIC;
		   CLOCK  		: in  STD_LOGIC;
		   D      		: in  STD_LOGIC_VECTOR (31 downto 0);
		   Q      		: out STD_LOGIC_VECTOR (31 downto 0)
		  );
	end component;	  
	
	component SHIFT2_J
	port (
			D    :  in  STD_LOGIC_VECTOR (25 downto 0);
			Q	 :  out STD_LOGIC_VECTOR (27 downto 0)
		 );
	end component;	 
	
	component OR_J
	port (
			D1   :  in  STD_LOGIC_VECTOR (1 downto 0);
			D2   :  in  STD_LOGIC_VECTOR (1 downto 0);
			Q	 :  out STD_LOGIC_VECTOR (1 downto 0)
		 );
	end component;	 
	
	component MUX3X1
	port (
			SEL  :  in  STD_LOGIC_VECTOR (1 downto 0);
			D1   :  in  STD_LOGIC_VECTOR (31 downto 0);
			D2   :  in  STD_LOGIC_VECTOR (31 downto 0);
			D3   :  in  STD_LOGIC_VECTOR (31 downto 0);
			Q	 :  out STD_LOGIC_VECTOR (31 downto 0)
		 );
	end component;	 
	
begin
	UN_OR_J : OR_J
	port map (
				D1 => S_JA,
				D2 => S_JR,
				Q  => S_J1
			 );

	UN_MUX3X1 : MUX3X1
	port map (
				SEL  => S_J2,
				D1   => PC_MUX2X1,
				D2   => J_REGISTER,
				D3   => J_ADDRESS,
				Q    => S_MUXPC
			 );
			  
	UN_PC : PC
	port map (
				RESET => RESET,
				CLOCK => CLOCK,
				D     => S_MUXPC,
				Q     => PC_ADDR
			 );
	
	UN_ADD : ADD
	port map (
				D => PC_ADDR,
				Q => ADD_MUX2X1
			 );
			 
	PC_MUX_2X1 : MUX_2X1	
	port map (
				SEL  => PCSrc,
				IN_A => ADD_MUX2X1,
				IN_B => EXMEM_ADDR,
				Q    => PC_MUX2X1
			 );
			 
	UN_INST_MEM : INST_MEM
	port map (
				CLOCK 	  => CLOCK,
				ADDRESS_I => PC_ADDR,
				ADDRESS_O => ADDR_IFID
			 );
	
	PCJADD <= PC_ADDR(31 downto 28);
		
	UN_IF_ID : IF_ID
	port map (
				CLOCK	 => CLOCK,
				RESET    => RESET,
				INST_MEM => ADDR_IFID,
				IN_ADD   => ADD_MUX2X1,
				IN_JMS   => PCJADD,
				INST     => S_INTS,
				OUT_ADD  => S_ADD,
				OUT_JMS  => MS_JADD
			 );

	RT <= S_INTS(20 downto 16);
	RD <= S_INTS(15 downto 11);
	
	UN_REGISTERS : REGISTERS
	port map (
				READ_REG1 	=> RT,
				READ_REG2	=> RD,
				WRITE_REG  	=> S_WRITE_REG,
				WIRTE_DATA  => S_WDATA,
				REG_WRITE  	=> REGWRITE,
				CLOCK  		=> CLOCK,
				RESET  		=> RESET,
				READ_DATA1 	=> S_DATA1,
				READ_DATA2	=> S_DATA2,
				OUT_RA      => REG_A,
				OUT_RB      => REG_B,
				OUT_RC      => REG_C,
				OUT_RD      => REG_D,
				OUT_RE      => REG_E,
				OUT_RF      => REG_F,
				OUT_RG      => REG_G,
				OUT_RH      => REG_H
			 );
	
	S_CONT <= S_INTS(31 downto 26);
	
	UN_CONTROL : CONTROL
	port map (
				CLOCK		=> CLOCK,
				RESET       => RESET,
				INSTRUCTION => S_CONT,
				S_WB		=> C_WB,
				S_M 		=> C_M,
				S_EX		=> C_EX,
				S_J         => C_J
			 );
			 
	INT_ADDR <= S_INTS(15 downto 0);
			 
	UN_SING_EXT : SING_EXT
	port map (
				D  => INT_ADDR,
				Q	=> S_EXT
			 );
	
	ADDR_J <= S_INTS(25 downto 0);
	RS <= S_INTS(25 downto 21);
	
	UN_ID_EX : ID_EX
	port map (
				CLOCK	 => CLOCK,
				RESET    => RESET,
				IN_WB    => C_WB,
				IN_M     => C_M,
				IN_EX    => C_EX,
				IN_DATA1 => S_DATA1,
				IN_DATA2 => S_DATA2,
				IN_S_EXT => S_EXT,
				IN_ADD   => S_ADD,
				IN_INST1 => RS,
				IN_INST2 => RT,
				IN_JIDEX => C_J,
				IN_JADD  => ADDR_J,
				IN_JMS1  => MS_JADD,
			
				OUT_WB    => WB_EXMEM,
				OUT_M     => M_EXMEM,
				OUT_EX1   => REGDST,
				OUT_EX2   => ALUop,
				OUT_EX3   => ALUSrc,
				OUT_DATA1 => DATA1_ALU,
				OUT_DATA2 => DATA2_ALU,
				OUT_S_EXT => OUT_SEXT,
				OUT_ADD   => IDEX_ADD,
				OUT_INST1 => IDEX1,
				OUT_INST2 => IDEX2,
				OUT_JIDEX => S_JA,
				OUT_JADD  => IN_S_J,
				OUT_JMS1  => MS1_JADD
			 );
			 
	UN_SHIFTL_J : SHIFT2_J
	port map (
				D  => IN_S_J,
				Q  => OUT_S_J
			 );
	
	S_JCONT <= MS1_JADD & OUT_S_J;
	
	UN_INST_MUX2X1 : INST_MUX2X1
	port map (
				SEL  => REGDST,
				IN_A => IDEX1,
				IN_B => IDEX2,
				Q    => MUX2X1_EXMEM
			 );
			 
	UN_ADD_RESULT : ADD_RESULT
	port map (
				D1  => IDEX_ADD,
				D2  => SHIFT_ADD,
				Q	=> ADD_EXMEM
			 );
	
	
	
	UN_SHIFTL : SHIFT2
	port map (
				D => OUT_SEXT,
				Q => SHIFT_ADD
			 );
	
	MUXALU : MUX_2X1
	port map (
				SEL  => ALUSrc,
				IN_A => DATA2_ALU,
				IN_B => OUT_SEXT,
				Q    => MUX_ALU
			 );
			 
	S_FUNCT <= OUT_SEXT(31 downto 26);
	
	UN_ALU_CONTROL : ALU_CONTROL		 
	port map (
				FUNCT    => S_FUNCT,
				ALUOP    => ALUop,
				ALU_CONT => OPALU,
				JR       => S_JR
			 );
	
	UN_ALU : ALU
	port map (
				D1    => DATA1_ALU,
				D2    => MUX_ALU,
				OP    => OPALU,
				ALU_R => ALU_EXMEM,
				ZERO  => ZERO_EXMEM
			 );
	
	UN_EX_MEM : EX_MEM
	port map (
				CLOCK	 => CLOCK,
				RESET    => RESET,
				IN_WB    => WB_EXMEM,
				IN_M     => M_EXMEM,
				IN_ADD_R => ADD_EXMEM,
				IN_ZERO  => ZERO_EXMEM,
				IN_ALU_R => ALU_EXMEM,
				IN_DATA2 => DATA2_ALU,
				IN_INST  => MUX2X1_EXMEM,
				IN_JEXMEM=> S_J1,
				IN_JCONT => S_JCONT,
			
				OUT_WB   => WB_MEMWB,
				OUT_M1   => S_BRANCH,
				OUT_M2   => MEMREAD,
				OUT_M3   => MEMWRITE,
				OUT_ADD_R=> EXMEM_ADDR,
				OUT_ZERO => ZERO_BRANCH,
				OUT_ALU_R=> S_ADDRESS,
				OUT_DATA2=> S_WRITE_DATA,
				OUT_INST => INST_MEMWB,
				OUT_JEXMEM => S_J2,
				OUT_JCONT  => J_ADDRESS
			 );
	
	J_REGISTER <= S_ADDRESS;
	
	UN_BRANCH : BRANCH
	port map (
				D1 => S_BRANCH,
				D2 => ZERO_BRANCH,
				Q  => PCSrc
			 );
		 
	UN_DATA_MEM : DATA_MEM
	port map (
				CLOCK			=> CLOCK,
				ADDRESS 		=> S_ADDRESS,
				MEM_WRITE	=> MEMWRITE,
				MEM_READ    => MEMREAD,
				WRITE_DATA  => S_WRITE_DATA,
				READ_DATA   => S_READ_DATA
			 );
	
	UN_MEM_WB : MEM_WB
	port map (
				CLOCK	 => CLOCK,
				RESET    => RESET,
				IN_WB    => WB_MEMWB,
				IN_ADDR  => S_ADDRESS,
				IN_INST  => INST_MEMWB,
			
				OUT_WB1  => REGWRITE,
				OUT_WB2  => MEMTOREG,
				OUT_ADDR => MEMWB_MUX2,
				OUT_INST => S_WRITE_REG
			 );
			 
	UN_MUX2X1_MEMWB : MUX_2X1	 
	port map (
				SEL  => MEMTOREG,
				IN_A => MEMWB_MUX2,
				IN_B => S_READ_DATA,
				Q    => S_WDATA
			 );
	
end RTL;