LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY mux2to1_32bit is
	GENERIC ( N : integer:=32);
	Port ( first_choice, second_choice: in std_logic_vector(N-1 downto 0 );
			 sel: in std_logic;
			dato_chosen: out std_logic_vector( N-1 downto 0 ));		
end mux2to1_32bit;

ARCHITECTURE behavioural of mux2to1_32bit is

	BEGIN
		PROCESS ( sel,first_choice, second_choice)
			BEGIN
				IF (sel = '0') THEN
					dato_chosen <= first_choice;
				ELSE
					dato_chosen <= second_choice;
				END IF;
		END PROCESS;
		
END behavioural;