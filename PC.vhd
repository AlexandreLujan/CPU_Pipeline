library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity PC is
	port (  
		   RESET  		: in  STD_LOGIC;
		   CLOCK  		: in  STD_LOGIC;
		   D      		: in  STD_LOGIC_VECTOR (31 downto 0);
		   Q      		: out STD_LOGIC_VECTOR (31 downto 0)
		  );
	end PC ;
	
architecture RTL of PC is

BEGIN
    process(CLOCK, RESET)
    begin
        if RESET = '1' then
            Q <= "00000000000000000000000000000000";
        elsif rising_edge(CLOCK) then
                Q <= D;
        end if;
    end process;	
	
end RTL ;