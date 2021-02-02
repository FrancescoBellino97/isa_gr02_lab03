LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY ROM_instruction IS
PORT(	
	add	:	IN	STD_LOGIC_VECTOR(31 downto 0);
	data_out	:	OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END ROM_instruction;

ARCHITECTURE Behavior OF ROM_instruction IS
	SIGNAL memory : STD_LOGIC_VECTOR(31 DOWNTO 0);
	BEGIN


	PROCESS(add) IS

		BEGIN
		
		CASE add IS
			--start
			WHEN x"00400000" => memory <= x"00700813"; -- addi x16, x0, 0x00000007
			WHEN x"00400004" => memory <= x"0FC10217"; -- auipc x4, 0x0000FC10
			WHEN x"00400008" => memory <= x"FFC20213"; -- addi x4, x4, 0xFFFFFFFC
			WHEN x"0040000C" => memory <= x"0FC10297"; -- auipc x5, 0x0000FC10
			WHEN x"00400010" => memory <= x"01028293"; -- addi x5, x5, 0x00000010
			WHEN x"00400014" => memory <= x"400006B7"; -- lui x13, 0x00040000
			WHEN x"00400018" => memory <= x"FFF68693"; -- addi x13, x13, 0xFFFFFFFF
			
			--loop
			WHEN x"0040001C" => memory <= x"02080463"; -- beq x16, x0, 0x00000014
			WHEN x"00400020" => memory <= x"00022403"; -- lw x8, 0x00000000 (x4)
			WHEN x"00400024" => memory <= x"00000013"; -- addi x0, x0, 0x00000000
			WHEN x"00400028" => memory <= x"0004057F"; -- mod x10, x8
			WHEN x"0040002C" => memory <= x"00D525B3"; -- slt x11, x10, x13
			WHEN x"00400030" => memory <= x"FFF80813"; -- addi x16, x16, 0xFFFFFFFF
			WHEN x"00400034" => memory <= x"00420213"; -- addi x4, x4, 0x00000004
			WHEN x"00400038" => memory <= x"FE0582E3"; -- beq x11, x0, 0xFFFFFFF2
			WHEN x"0040003C" => memory <= x"000506B3"; -- add x13, x10, x0
			WHEN x"00400040" => memory <= x"FDDFF0EF"; -- jal x1, 0xFFFFFFEE
			
			--done
			WHEN x"00400044" => memory <= x"00D2A023"; -- sw x13, 0x00000000 (x5)
			
			--endc
			WHEN x"00400048" => memory <= x"000000EF"; -- jal x1, 0x00000000
			WHEN x"0040004C" => memory <= x"00000013"; -- addi x0, x0, 0x00000000
			
			WHEN others => memory <= x"00000000";
			
		END CASE;
	
  END PROCESS;
  
  data_out <= memory;

END Behavior;





