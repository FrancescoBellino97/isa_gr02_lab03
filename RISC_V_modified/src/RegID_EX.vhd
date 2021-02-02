LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY RegID_EX IS
	GENERIC ( N : integer:=32);
	PORT ( Clock, Rst_n,LD : IN std_logic;
			 MEM,WB,wr_RF_WB: in std_logic;
			 PC_4_offset,Rs1D,Rs2D,Imm_D: in std_logic_vector(N-1 DOWNTO 0);
			 aluDest,fuCmd: in std_logic_vector(1 downto 0);
			 alu_cmd: in std_logic_vector(2 downto 0);
			 Rs1_add,Rs2_add,RD_add: in std_logic_vector(4 downto 0);
			 MEM_o,WB_o,wr_RF_WB_o: out std_logic;
			 PC_4_offset_o,Rs1D_o,Rs2D_o,Imm_D_o: out std_logic_vector(N-1 DOWNTO 0);
			 aluDest_o,fuCmd_o: out std_logic_vector(1 downto 0);
			 alu_cmd_o: out std_logic_vector(2 downto 0);
			 Rs1_add_o,Rs2_add_o,RD_add_o: out std_logic_vector(4 downto 0)
	);
END RegID_EX;

ARCHITECTURE behavior OF RegID_EX IS

	BEGIN
	
		PROCESS(Clock,Rst_n)
			BEGIN
			   if (Rst_n = '0') THEN
						MEM_o<='0';
						WB_o<='0';
						wr_RF_WB_o<='0';
						PC_4_offset_o<=( others => '0');
						Rs1D_o<=( others => '0');
						Rs2D_o<=( others => '0');
						Imm_D_o<=( others => '0');
						aluDest_o<=( others => '0');
						fuCmd_o<=( others => '0');
						alu_cmd_o<=( others => '0');
						Rs1_add_o<=( others => '0');
						Rs2_add_o<=( others => '0');
						RD_add_o<=( others => '0');
			    elsif (Clock'EVENT AND Clock = '1') THEN
					IF (LD = '1') THEN
						MEM_o<=MEM;
						WB_o<=WB;
						wr_RF_WB_o<=wr_RF_WB;
						PC_4_offset_o<=PC_4_offset;
						Rs1D_o<=Rs1D;
						Rs2D_o<=Rs2D;
						Imm_D_o<=Imm_D;
						aluDest_o<=aluDest;
						fuCmd_o<=fuCmd;
						alu_cmd_o<=alu_cmd;
						Rs1_add_o<=Rs1_add;
						Rs2_add_o<=Rs2_add;
						RD_add_o<=RD_add;
					END IF;
			   END IF;
		END PROCESS;
		
END  behavior;