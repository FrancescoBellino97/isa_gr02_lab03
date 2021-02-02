LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY RAM_data IS
PORT(	add	:	IN	STD_LOGIC_VECTOR(31 downto 0);
		clk	:	IN	STD_LOGIC;
		wr	: 	IN STD_LOGIC;
		data_in	: 	IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		data_out	:	OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END RAM_data;

ARCHITECTURE Behavior OF RAM_data IS
	
	SIGNAL memory : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL result : STD_LOGIC_VECTOR(31 DOWNTO 0) := x"00000000";
	
	BEGIN

	WRITE_PROCESS : PROCESS(clk) IS
		BEGIN
		IF (clk'EVENT AND clk = '1') THEN
			IF (wr = '1' AND add = x"1001001C") THEN
				result <= data_in;
			END IF;
		END IF;
	
	END PROCESS;
	
	READ_PROCESS : PROCESS(add, result) IS
		BEGIN
		
		CASE add IS
		
			WHEN x"10010000" => memory <= x"0000000A";
			WHEN x"10010004" => memory <= x"FFFFFFD1";
			WHEN x"10010008" => memory <= x"00000016";
			WHEN x"1001000C" => memory <= x"FFFFFFFD";
			WHEN x"10010010" => memory <= x"0000000F";
			WHEN x"10010014" => memory <= x"0000001B";
			WHEN x"10010018" => memory <= x"FFFFFFFC";
			
			WHEN x"1001001C" => memory <= result;
		
			WHEN others => memory <= x"00000000";
		
		END CASE;
		
	END PROCESS;

	data_out <= memory;

END Behavior;