LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY shift_block IS
PORT(
	in1, in2	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	result	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END shift_block;

ARCHITECTURE behavior OF shift_block IS

	BEGIN
	
	PROCESS(in1, in2) IS
		BEGIN
		
		CASE in2(4 DOWNTO 0) IS
			WHEN "00000" => result <= in1;
			WHEN "00001" => result <= (others => in1(31)); result(30 DOWNTO 0) <= in1(31 DOWNTO 1);
			WHEN "00010" => result <= (others => in1(31)); result(29 DOWNTO 0) <= in1(31 DOWNTO 2);
			WHEN "00011" => result <= (others => in1(31)); result(28 DOWNTO 0) <= in1(31 DOWNTO 3);
			WHEN "00100" => result <= (others => in1(31)); result(27 DOWNTO 0) <= in1(31 DOWNTO 4);
			WHEN "00101" => result <= (others => in1(31)); result(26 DOWNTO 0) <= in1(31 DOWNTO 5);
			WHEN "00110" => result <= (others => in1(31)); result(25 DOWNTO 0) <= in1(31 DOWNTO 6);
			WHEN "00111" => result <= (others => in1(31)); result(24 DOWNTO 0) <= in1(31 DOWNTO 7);
			WHEN "01000" => result <= (others => in1(31)); result(23 DOWNTO 0) <= in1(31 DOWNTO 8);
			WHEN "01001" => result <= (others => in1(31)); result(22 DOWNTO 0) <= in1(31 DOWNTO 9);
			WHEN "01010" => result <= (others => in1(31)); result(21 DOWNTO 0) <= in1(31 DOWNTO 10);
			WHEN "01011" => result <= (others => in1(31)); result(20 DOWNTO 0) <= in1(31 DOWNTO 11);
			WHEN "01100" => result <= (others => in1(31)); result(19 DOWNTO 0) <= in1(31 DOWNTO 12);
			WHEN "01101" => result <= (others => in1(31)); result(18 DOWNTO 0) <= in1(31 DOWNTO 13);
			WHEN "01110" => result <= (others => in1(31)); result(17 DOWNTO 0) <= in1(31 DOWNTO 14);
			WHEN "01111" => result <= (others => in1(31)); result(16 DOWNTO 0) <= in1(31 DOWNTO 15);
			WHEN "10000" => result <= (others => in1(31)); result(15 DOWNTO 0) <= in1(31 DOWNTO 16);
			WHEN "10001" => result <= (others => in1(31)); result(14 DOWNTO 0) <= in1(31 DOWNTO 17);
			WHEN "10010" => result <= (others => in1(31)); result(13 DOWNTO 0) <= in1(31 DOWNTO 18);
			WHEN "10011" => result <= (others => in1(31)); result(12 DOWNTO 0) <= in1(31 DOWNTO 19);
			WHEN "10100" => result <= (others => in1(31)); result(11 DOWNTO 0) <= in1(31 DOWNTO 20);
			WHEN "10101" => result <= (others => in1(31)); result(10 DOWNTO 0) <= in1(31 DOWNTO 21);
			WHEN "10110" => result <= (others => in1(31)); result(9 DOWNTO 0) <= in1(31 DOWNTO 22);
			WHEN "10111" => result <= (others => in1(31)); result(8 DOWNTO 0) <= in1(31 DOWNTO 23);
			WHEN "11000" => result <= (others => in1(31)); result(7 DOWNTO 0) <= in1(31 DOWNTO 24);
			WHEN "11001" => result <= (others => in1(31)); result(6 DOWNTO 0) <= in1(31 DOWNTO 25);
			WHEN "11010" => result <= (others => in1(31)); result(5 DOWNTO 0) <= in1(31 DOWNTO 26);
			WHEN "11011" => result <= (others => in1(31)); result(4 DOWNTO 0) <= in1(31 DOWNTO 27);
			WHEN "11100" => result <= (others => in1(31)); result(3 DOWNTO 0) <= in1(31 DOWNTO 28);
			WHEN "11101" => result <= (others => in1(31)); result(2 DOWNTO 0) <= in1(31 DOWNTO 29);
			WHEN "11110" => result <= (others => in1(31)); result(1 DOWNTO 0) <= in1(31 DOWNTO 30);
			WHEN "11111" => result <= (others => in1(31));
			WHEN others => result <= (others => '0');
		END CASE;
	END PROCESS;

END behavior;