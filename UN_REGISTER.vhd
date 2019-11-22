library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity UN_REGISTER is
	port ( ENABLE 		: in  STD_LOGIC; 
		   RESET  		: in  STD_LOGIC;
		   CLOCK  		: in  STD_LOGIC;
		   D      		: in  STD_LOGIC_VECTOR (31 downto 0);
		   REG_WRITE  	: in STD_LOGIC;
		   Q      		: out STD_LOGIC_VECTOR (31 downto 0)
		  );
	end UN_REGISTER ;
	
architecture RTL of UN_REGISTER is

BEGIN
    process(CLOCK, RESET)
    begin
        if RESET = '1' then
            Q <= "00000000000000000000000000000000";
        elsif rising_edge(CLOCK) then
            if (ENABLE = '1' AND REG_WRITE = '1') then
                Q <= D;
            end if;
        end if;
    end process;	
	
end RTL ;
