LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;

ENTITY clock_gen IS
	PORT (
		CLK     : OUT STD_LOGIC);
END clock_gen;

ARCHITECTURE beh OF clock_gen IS

  CONSTANT Ts : time := 10 ns;
  
  SIGNAL CLK_i : std_logic;
  
BEGIN  -- beh

	PROCESS -- generazione clock
		BEGIN
		IF (CLK_i = 'U') THEN
			CLK_i <= '1';
		ELSE
			CLK_i <= NOT(CLK_i);
		END IF;
		WAIT FOR Ts/2;
	END PROCESS;
	
	CLK <= clk_i;

END beh;