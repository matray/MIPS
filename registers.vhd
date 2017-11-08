library IEEE;
use IEEE.STD_LOGIC_1164.ALL, IEEE.NUMERIC_STD.ALL;

entity registers is
  port(RR1,RR2,WR:in std_logic_vector(4 downto 0);
       WD:in std_logic_vector(31 downto 0);
       Clk,RegWrite:in std_logic;
       RD1,RD2:out std_logic_vector(31 downto 0));
end registers;

architecture Behavioral of registers is

type regFile_Type is array(0 to 31) of std_logic_vector(31 downto 0);
signal regFile: regFile_Type;

begin

process(RR1, RR2, WR, WD, Clk, RegWrite)
variable check_begin:boolean := true;



begin

if(check_begin) then
	regFile(0) <= "00000000000000000000000000000000";
	regFile(8) <= "00000000000000000000000000000100";
	regFile(18) <= "00000000000000000000000000001101";
	regFile(19) <= "00000000000000000000000000000100";
	check_begin := false;
end if;

if clk='1' and clk'event then
	if RegWrite = '1' then
		if(not(WR = "00000") or not(WR="UUUUU")) then --The fact that != does not mean not equal annoys me.
			regFile(to_integer(unsigned(WR))) <= WD;
		end if;
	end if;
end if;

	RD1 <= regFile(to_integer(unsigned(RR1)));
	RD2 <= regFile(to_integer(unsigned(RR2)));

end process;

end Behavioral;