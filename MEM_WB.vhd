library IEEE; 
use IEEE.STD_LOGIC_1164.ALL;

entity MEM_WB is
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
end MEM_WB;

architecture RTL of MEM_WB is
begin
	process(CLOCK, RESET)
    begin
        if RESET = '1' then
			OUT_WB1   <= '0';
			OUT_WB2   <= '0';
			OUT_ADDR  <= "00000000000000000000000000000000";
			OUT_INST  <= "00000";
        elsif rising_edge(CLOCK) then
			OUT_WB1   <= IN_WB(1);
			OUT_WB2   <= IN_WB(0);
			OUT_ADDR  <= IN_ADDR;
			OUT_INST  <= IN_INST;
        end if;
    end process;
end RTL;