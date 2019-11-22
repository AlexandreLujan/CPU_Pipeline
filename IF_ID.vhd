library IEEE; 
use IEEE.STD_LOGIC_1164.ALL;

entity IF_ID is
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
end IF_ID;

architecture RTL of IF_ID is
begin
	process(CLOCK, RESET)
    begin
        if RESET = '1' then
            INST <= "00000000000000000000000000000000";
			OUT_ADD <= "00000000000000000000000000000000";
			OUT_JMS <= "0000";
        elsif rising_edge(CLOCK) then
			INST <= INST_MEM;
			OUT_ADD <= IN_ADD;
			OUT_JMS <= IN_JMS;
        end if;
    end process;
end RTL;