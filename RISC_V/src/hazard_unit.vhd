LIBRARY ieee;
USE ieee.std_logic_1164.all;


ENTITY hazard_unit IS
	PORT(
			rs1_address, rs2_address, wbRd_address: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
			--beq: in std_logic;
			Rs1_Or_Wb, Rs2_Or_Wb: out std_logic);
END hazard_unit;

ARCHITECTURE behavior OF hazard_unit IS

	BEGIN
	
	PROCESS(rs1_address, rs2_address, wbRd_address) IS
		BEGIN
		--if (beq = '1') then
		IF (rs1_address = wbRd_address) THEN
			Rs1_Or_Wb<= '1';
		ELSE
			Rs1_Or_Wb <= '0';
		END IF;
		IF (rs2_address = wbRd_address) THEN
			Rs2_Or_Wb<= '1';
		ELSE
			Rs2_Or_Wb <= '0';
		END IF;
		--else
			--Rs1_Or_Wb<= '0';
		--end if;
			
	END PROCESS;

END behavior;