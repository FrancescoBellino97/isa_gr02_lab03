LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY adder_32bit IS
	GENERIC ( N : integer:=32);
	PORT(
		in1, in2	: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		result	: OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
END adder_32bit;

ARCHITECTURE behavior OF adder_32bit IS

	BEGIN
	
	PROCESS(in1, in2) IS
		BEGIN
		result <= STD_LOGIC_VECTOR(UNSIGNED(in1) + UNSIGNED(in2));
	END PROCESS;

END behavior;