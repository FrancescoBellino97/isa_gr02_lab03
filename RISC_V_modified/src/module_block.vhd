LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY module_block IS
PORT(
	input	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	result	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END module_block;

ARCHITECTURE behavior OF module_block IS
	SIGNAL tmp : STD_LOGIC_VECTOR(31 DOWNTO 0);
	BEGIN
	
	PROCESS(input) IS
		BEGIN
			IF(input(31)='1') THEN
				tmp <= STD_LOGIC_VECTOR(UNSIGNED(NOT(input)) + x"00000001");
				--tmp <= tmp + x"00000001";
			ELSE
				tmp <= input;
			END IF;
	END PROCESS;
	
	result <= tmp;

END behavior;