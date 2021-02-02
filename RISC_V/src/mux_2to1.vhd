LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY mux_2to1 is
	Port ( first_choice, second_choice: in std_logic;
			 sel: in std_logic;
			dato_chosen: out std_logic);		
end mux_2to1;

ARCHITECTURE behavioural of mux_2to1 is

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