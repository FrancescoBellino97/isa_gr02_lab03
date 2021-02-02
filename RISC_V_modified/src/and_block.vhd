LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY and_block IS
PORT(
	in1, in2	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	result	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END and_block;

ARCHITECTURE behavior OF and_block IS

	BEGIN
	
	PROCESS(in1, in2) IS
		BEGIN
		result <= in1 AND in2;
	END PROCESS;

END behavior;
