LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY xor_block IS
PORT(
	in1, in2	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	result	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END xor_block;

ARCHITECTURE behavior OF xor_block IS

	BEGIN
	
	PROCESS(in1, in2) IS
		BEGIN
		result <= in1 XOR in2;
	END PROCESS;

END behavior;