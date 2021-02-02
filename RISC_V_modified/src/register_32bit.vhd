LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY register_32bit IS
	GENERIC ( N : integer:=32);
	PORT ( Clock, LD : IN std_logic;
			d_in: IN std_logic_vector(N-1 DOWNTO 0);
			d_out: OUT std_logic_vector(N-1 DOWNTO 0)
	);
END register_32bit;

ARCHITECTURE behavior OF register_32bit IS

	BEGIN
	
		PROCESS(Clock)
			BEGIN
				IF (Clock'EVENT AND Clock = '1') THEN
					IF (LD = '1') THEN
						d_out <= d_in;
					END IF;
				END IF;
		END PROCESS;
		
END  behavior;