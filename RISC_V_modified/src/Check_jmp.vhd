LIBRARY ieee;
USE ieee.std_logic_1164.all;


ENTITY Check_jmp IS
	PORT(
		in1, in2	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		beq: out std_logic);
END Check_jmp;

ARCHITECTURE behavior OF Check_jmp IS

	BEGIN
	
	PROCESS(in1, in2) IS
		BEGIN
			IF (in1 = in2) THEN
				beq<='1';
			ELSE
				beq<='0';
			END IF;
	END PROCESS;

END behavior;