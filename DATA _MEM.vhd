 library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.NUMERIC_STD.all; 

entity DATA_MEM is
port (
		CLOCK 	  : in STD_LOGIC;
        ADDRESS   : in STD_LOGIC_VECTOR(31 downto 0);
        MEM_WRITE : in STD_LOGIC;
		MEM_READ  : in STD_LOGIC;
        WRITE_DATA: in STD_LOGIC_VECTOR(31 downto 0);
        READ_DATA : out STD_LOGIC_VECTOR(31 downto 0)
     );
end DATA_MEM;

architecture RTL of DATA_MEM is

type ram_t is array (0 to 31) of STD_LOGIC_VECTOR(31 downto 0);
signal ram : ram_t := 
		   ("00000000000000000000000000000011",  -- end 0
            "00110011001100110011001100110011",  -- end 1
            "11001100110011001100110011001100",  -- end 2
            "10101010101010101010101010101010",  -- end 3
            "01010101010101010101010101010101",  -- end 4
            "11110000111100001111000011110000",  -- end 5
            "00001111000011110000111100001111",  -- end 6
            "00000000000000000000000000000000",  -- end 7
            "00000000000000000000000000000000",  -- end 8
            "00000000000000000000000000000000",  -- end 9
            "00000000000000000000000000000000",  -- end 10
            "00000000000000000000000000000000",  -- end 11
            "00000000000000000000000000000000",  -- end 12
            "00000000000000000000000000000000",  -- end 13
            "00000000000000000000000000000000",  -- end 14
            "00000000000000000000000000000000",  -- end 15
            "00000000000000000000000000000000",  -- end 16
            "00000000000000000000000000000000",  -- end 17
            "00000000000000000000000000000000",  -- end 18
            "00000000000000000000000000000000",  -- end 19
            "00000000000000000000000000000000",  -- end 20
            "00000000000000000000000000000000",  -- end 21
            "00000000000000000000000000000000",  -- end 22
            "00000000000000000000000000000000",  -- end 23
            "00000000000000000000000000000000",  -- end 24
            "00000000000000000000000000000000",  -- end 25
            "00000000000000000000000000000000",  -- end 26
            "00000000000000000000000000000000",  -- end 27
            "00000000000000000000000000000000",  -- end 28
            "00000000000000000000000000000000",  -- end 29
            "00000000000000000000000000000000",  -- end 30
            "00000000000000000000000000000000"   -- end 31
 );
--signal ram : ram_t := (others => (others => '0'));

begin

	process(CLOCK)
	begin
		if(rising_edge(CLOCK)) then
			if(MEM_WRITE = '1') then
				ram(to_integer(unsigned(ADDRESS(31 downto 0)))) <= WRITE_DATA;
			end if;
			if(MEM_READ = '1') then
				READ_DATA <= ram(to_integer(unsigned(ADDRESS(31 downto 0))));
			end if;			
		end if;
	end process;

end RTL;