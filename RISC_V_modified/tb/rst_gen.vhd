LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;

ENTITY rst_gen IS
	PORT (
    RST_n     : OUT std_logic);
END rst_gen;

ARCHITECTURE beh OF rst_gen IS
  
BEGIN  -- beh

	PROCESS --generazione reset
	BEGIN
		RST_n <= '0';
		WAIT FOR 30 ns;
		RST_n <= '1';
		WAIT;
	END PROCESS;

END beh;
