LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY compare_block IS
PORT(
	in1, in2	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	result	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END compare_block;

ARCHITECTURE behavior OF compare_block IS

	BEGIN
	
	PROCESS(in1, in2) IS
		BEGIN
		IF (SIGNED(in1)<SIGNED(in2)) THEN
			result <= x"00000001";
		ELSE
			result <= x"00000000";
		END IF;
	END PROCESS;

END behavior;