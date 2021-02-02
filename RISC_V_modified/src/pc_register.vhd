library IEEE;
use IEEE.STD_LOGIC_1164.all;

ENTITY pc_register IS
	GENERIC ( N : integer:=32);
	PORT ( nextIstruction: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			Clock,RestAsy_n,Load:IN STD_LOGIC;
			CurrentIstruction: OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
END pc_register;

ARCHITECTURE Behavior OF pc_register IS

BEGIN

	PROCESS (Clock,RestAsy_n)
	BEGIN
		IF (RestAsy_n= '0') THEN
			CurrentIstruction<=  x"00400000";
		ELSif (Clock'EVENT AND Clock = '1') THEN
			if (Load = '1') then
				CurrentIstruction<= nextIstruction;
			end if;
		END IF;
	END PROCESS;
END Behavior;

