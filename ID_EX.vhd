library IEEE; 
use IEEE.STD_LOGIC_1164.ALL;

entity ID_EX is
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
end ID_EX;

architecture RTL of ID_EX is
begin
	process(CLOCK, RESET)
    begin
        if RESET = '1' then
		    OUT_WB    <= "00";
			OUT_M     <= "000";
			OUT_EX1   <= '0';
			OUT_EX2   <= "000";
			OUT_EX3   <= '0';
			OUT_DATA1 <= "00000000000000000000000000000000";
			OUT_DATA2 <= "00000000000000000000000000000000";
			OUT_S_EXT <= "00000000000000000000000000000000";
			OUT_ADD   <= "00000000000000000000000000000000";
			OUT_INST1 <= "00000";
			OUT_INST2 <= "00000";
			OUT_JIDEX <= "00";
			OUT_JADD  <= "00000000000000000000000000";
			OUT_JMS1  <= "0000";
        elsif rising_edge(CLOCK) then
			OUT_WB    <= IN_WB;
			OUT_M     <= IN_M;
			OUT_EX1   <= IN_EX(4);
			OUT_EX2   <= IN_EX(3 downto 1);
			OUT_EX3   <= IN_EX(0);
			OUT_DATA1 <= IN_DATA1;
			OUT_DATA2 <= IN_DATA2;
			OUT_S_EXT <= IN_S_EXT;
			OUT_ADD   <= IN_ADD;
			OUT_INST1 <= IN_INST1;
			OUT_INST2 <= IN_INST2;
			OUT_JIDEX <= IN_JIDEX;
			OUT_JADD  <= IN_JADD;
			OUT_JMS1  <= IN_JMS1;
        end if;
    end process;
end RTL;