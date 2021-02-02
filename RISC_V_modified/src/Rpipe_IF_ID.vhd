LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Rpipe_IF_ID IS
	GENERIC ( N : integer:=32);
	PORT ( Clock,Rst_n,LD : IN std_logic;
			d_in1,d_in2: IN std_logic_vector(N-1 DOWNTO 0);
			d_out1,d_out2: OUT std_logic_vector(N-1 DOWNTO 0)
	);
END Rpipe_IF_ID;

ARCHITECTURE behavior OF Rpipe_IF_ID IS

	BEGIN
	
		PROCESS(Clock,Rst_n)
			BEGIN
			  if (Rst_n = '0') THEN
					d_out1 <= ( others => '0');
					d_out2 <= ( others => '0');

			  elsif (Clock'EVENT AND Clock = '1') THEN
					IF (LD = '1') THEN
						d_out1 <= d_in1;
						d_out2 <= d_in2;
					END IF;
			  END IF;
		END PROCESS;
		
END  behavior;