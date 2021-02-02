LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY mux_8to1 IS
GENERIC( N	: INTEGER := 32);
PORT(	
	input1	: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	input2	: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	input3	: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	input4	: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	input5	: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	input6	: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	input7	: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	input8	: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	sel	: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
	output	: OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
END mux_8to1;

ARCHITECTURE behavior OF mux_8to1 IS

	BEGIN
	
	PROCESS(sel, input1, input2, input3, input4, input5, input6, input7, input8) IS
		BEGIN
		
		CASE sel IS
			WHEN "000" => output <= input1;
			WHEN "001" => output <= input2;
			WHEN "010" => output <= input3;
			WHEN "011" => output <= input4;
			WHEN "100" => output <= input5;
			WHEN "101" => output <= input6;
			WHEN "110" => output <= input7;
			WHEN "111" => output <= input8;
			WHEN others => output <= (others => '0');
		END CASE;
	
	END PROCESS;

END behavior;
