library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity TESTBENCH is
	port ( CLOCK : out STD_LOGIC );
end TESTBENCH;


architecture RTL of TESTBENCH is
   
	signal clock_gen, reset_gen: STD_LOGIC;
	signal S_A, S_B, S_C, S_D, S_E, S_F, S_G, S_H: STD_LOGIC_VECTOR(31 downto 0);
	
	component CPU_PIPELINE
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
	end component;
	
begin	
	
	UN_CPU_PIPELINE : CPU_PIPELINE
	port map (
			    CLOCK  =>  clock_gen,
				RESET  =>  reset_gen,
				REG_A  =>  S_A,
				REG_B  =>  S_B,
				REG_C  =>  S_C,
				REG_D  =>  S_D,
				REG_E  =>  S_E,
				REG_F  =>  S_F,
				REG_G  =>  S_G,
				REG_H  =>  S_H
			);

	process
	begin
		clock_gen <= '0';
		wait for 10 ns;
		clock_gen <= '1';
		wait for 10 ns;
	end process;

	process
	begin
		reset_gen <= '1';
		wait for 5 ns;
		reset_gen <= '0';
		wait for 1000000000 ns;
	end process;
		 
end RTL;
