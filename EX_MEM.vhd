library IEEE; 
use IEEE.STD_LOGIC_1164.ALL;

entity EX_MEM is
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
end EX_MEM;

architecture RTL of EX_MEM is
begin
	process(CLOCK, RESET)
    begin
        if RESET = '1' then
		    OUT_WB    <= "00";
			OUT_M1    <= '0';
			OUT_M2    <= '0';
			OUT_M3    <= '0';
			OUT_ADD_R <= "00000000000000000000000000000000";
			OUT_ZERO  <= '0';
			OUT_ALU_R <= "00000000000000000000000000000000";
			OUT_DATA2 <= "00000000000000000000000000000000";
			OUT_INST  <= "00000";
			OUT_JEXMEM<= "00";
			OUT_JCONT <= "00000000000000000000000000000000";
        elsif rising_edge(CLOCK) then
			OUT_WB    <= IN_WB;
			OUT_M1    <= IN_M(2);
			OUT_M2    <= IN_M(1);
			OUT_M3    <= IN_M(0);
			OUT_ADD_R <= IN_ADD_R;
			OUT_ZERO  <= IN_ZERO;
			OUT_ALU_R <= IN_ALU_R;
			OUT_DATA2 <= IN_DATA2;
			OUT_INST  <= IN_INST;
			OUT_JEXMEM<= IN_JEXMEM;
			OUT_JCONT <= IN_JCONT;
        end if;
    end process;
end RTL;