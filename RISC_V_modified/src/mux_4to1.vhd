LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY mux_4to1 IS
GENERIC( N	: INTEGER := 32);
PORT(	
	input1	: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	input2	: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	input3	: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	input4	: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	sel	: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
	output	: OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
END mux_4to1;

ARCHITECTURE behavior OF mux_4to1 IS

	BEGIN
	
	PROCESS(sel, input1, input2, input3, input4) IS
		BEGIN
		
		CASE sel IS
			WHEN "00" => output <= input1;
			WHEN "01" => output <= input2;
			WHEN "10" => output <= input3;
			WHEN "11" => output <= input4;
			WHEN others => output <= (others => '0');
		END CASE;
	
	END PROCESS;

END behavior;