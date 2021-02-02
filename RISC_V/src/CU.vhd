LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY CU IS
	PORT(	
			opcode	:	IN	STD_LOGIC_VECTOR(6 downto 0);
			func3	:	IN	STD_LOGIC_VECTOR(2 downto 0);
			--extensionImmValue_cntrl:	OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
			alu_cmd_cntrl: out std_logic_vector(2 downto 0);
			fu_cmd_cntrl: out std_logic_vector(1 downto 0);
			alu_dest_cntrl: out std_logic_vector(1 downto 0);
			wb_cntrl: out std_logic;
			mem_wr_cntrl: out std_logic;
			sel_JmpBeq_cntrl: out std_logic;
			wr_RF_cntrl: out std_logic;
			sel_seqJmpPC_cntrl: out std_logic;
			jal_cntrl: out std_logic;
			sel_Rd_or_Z_cntrl: out std_logic
			);
END CU;

ARCHITECTURE Behavior OF CU IS

	--signal extensionImmValue:STD_LOGIC_VECTOR(2 DOWNTO 0);
	signal alu_cmd: std_logic_vector(2 downto 0);
	signal fu_cmd:  std_logic_vector(1 downto 0);
	signal alu_dest:  std_logic_vector(1 downto 0);
	signal wb:  std_logic;
	signal mem_wr:  std_logic;
	signal sel_JmpBeq: std_logic;
	signal wr_RF: std_logic;
	signal sel_seqJmpPC:  std_logic;
	signal jal:  std_logic;
	signal sel_Rd_or_Z: std_logic;
	BEGIN

	
	PROCESS(opcode, func3) IS

		BEGIN
		
		CASE(opcode) IS
		
		--LW
		WHEN "0000011" =>	--extensionImmValue<="000"; --I-type 
								alu_cmd<="000"; --ADD_alu 
								fu_cmd<="01";-- choose operands: op1=RS1 and op2=Value_Immediate
								alu_dest<="00"; --Dato come from ALU
								wb<='0'; -- Sel mux in WB_stage, choose to write into RF the data from  the memory
								mem_wr<='0'; -- not write in memory
								sel_JmpBeq<='0'; -- not is the  instruction Beq
								wr_RF<='1';  --update RF  
								sel_seqJmpPC<='1'; -- propagate in the others stage the PC+4	
								jal<='0';
								sel_Rd_or_Z<='0';
		
		--SW		
		WHEN "0100011" => --extensionImmValue<="100"; --S-type 
								alu_cmd<="000"; --ADD_alu 
								fu_cmd<="01";-- choose operands: op1=RS1 and op2=Value_Immediate
								alu_dest<="00"; --Dato come from ALU
								wb<='1'; -- Sel mux in WB_stage, choose to write into RF the direct data
								mem_wr<='1'; -- write in memory
								sel_JmpBeq<='0'; -- not is the  instruction Beq
								wr_RF<='0';  --no update RF  
								sel_seqJmpPC<='1'; -- propagate in the others stage the PC+4	
								jal<='0';
								sel_Rd_or_Z<='1';
		
		--ADD, XOR, SLT
		WHEN "0110011" =>	CASE(func3) IS
									--ADD
									WHEN "000" =>	--extensionImmValue<="011"; --R-type 
														alu_cmd<="000"; --ADD_alu 
														fu_cmd<="00";-- choose operands: op1=RS1 and op2=Rs2
														alu_dest<="00"; --Dato come from ALU
														wb<='1'; -- Sel mux in WB_stage, choose to write into RF the direct data
														mem_wr<='0'; -- not write in memory
														sel_JmpBeq<='0'; -- not is the  instruction Beq
														wr_RF<='1';  --update RF  
														sel_seqJmpPC<='1'; -- propagate in the others stage the PC+4			
														jal<='0';
														sel_Rd_or_Z<='0';
									
									--XOR
									WHEN "100" =>	--extensionImmValue<="011"; --R-type 
														alu_cmd<="011"; --XOR_alu 
														fu_cmd<="00";-- choose operands: op1=RS1 and op2=RS2
														alu_dest<="00"; --Dato come from ALU
														wb<='1'; -- Sel mux in WB_stage, choose to write into RF the direct data
														mem_wr<='0'; -- not write in memory
														sel_JmpBeq<='0'; -- not is the  instruction Beq
														wr_RF<='1';  --update RF  
														sel_seqJmpPC<='1'; -- propagate in the others stage the PC+4	
														jal<='0';
														sel_Rd_or_Z<='0';
									
									--SLT
									WHEN "010" =>	--extensionImmValue<="011"; --I-type 
														alu_cmd<="101"; --Compare_alu 
														fu_cmd<="00";-- choose operands: op1=RS1 and op2=RS2
														alu_dest<="00"; --Dato come from ALU
														wb<='1'; -- Sel mux in WB_stage, choose to write into RF the direct data
														mem_wr<='0'; -- not write in memory
														sel_JmpBeq<='0'; -- not is the  instruction Beq
														wr_RF<='1';  --update RF  
														sel_seqJmpPC<='1'; -- propagate in the others stage the PC+4	
														jal<='0';
														sel_Rd_or_Z<='0';
														
									WHEN others =>	--extensionImmValue<="111";  
														alu_cmd<="000"; 
														fu_cmd<="11";
														alu_dest<="00"; 
														wb<='0';
														mem_wr<='0';
														sel_JmpBeq<='0'; 
														wr_RF<='0';   
														sel_seqJmpPC<='0'; 
														jal<='0';
														sel_Rd_or_Z<='1';
								END CASE;
		
		--ADDI, ANDI, SRAI
		WHEN "0010011" =>	CASE(func3) IS
									
									--ADDI
									WHEN "000" =>	--extensionImmValue<="000"; --I-type 
														alu_cmd<="000"; --ADD_alu 
														fu_cmd<="01";-- choose operands: op1=RS1 and op2=Value_Immediate
														alu_dest<="00"; --Dato come from ALU
														wb<='1'; -- Sel mux in WB_stage, choose to write into RF the direct data
														mem_wr<='0'; -- not write in memory
														sel_JmpBeq<='0'; -- not is the  instruction Beq
														wr_RF<='1';  --update RF  
														sel_seqJmpPC<='1'; -- propagate in the others stage the PC+4
														jal<='0';
														sel_Rd_or_Z<='0';
									
									--ANDI
									WHEN "111" =>	--extensionImmValue<="000"; --I-type 
														alu_cmd<="010"; --AND_alu 
														fu_cmd<="01";-- choose operands: op1=RS1 and op2=Value_Immediate
														alu_dest<="00"; --Dato come from ALU
														wb<='1'; -- Sel mux in WB_stage, choose to write into RF the direct data
														mem_wr<='0'; -- not write in memory
														sel_JmpBeq<='0'; -- not is the  instruction Beq
														wr_RF<='1';  --update RF  
														sel_seqJmpPC<='1'; -- propagate in the others stage the PC+4
														jal<='0';
														sel_Rd_or_Z<='0';
									
									--SRAI
									WHEN "101" =>	--extensionImmValue<="000"; --I-type 
														alu_cmd<="100"; --SHIFT_R_alu 
														fu_cmd<="01";-- choose operands: op1=RS1 and op2=Value_Immediate
														alu_dest<="00"; --Dato come from ALU
														wb<='1'; -- Sel mux in WB_stage, choose to write into RF the direct data
														mem_wr<='0'; -- not write in memory
														sel_JmpBeq<='0'; -- not is the  instruction Beq
														wr_RF<='1';  --update RF  
														sel_seqJmpPC<='1'; -- propagate in the others stage the PC+4
														jal<='0';
														sel_Rd_or_Z<='0';
								
									WHEN others =>	--extensionImmValue<="111";  
														alu_cmd<="000"; 
														fu_cmd<="00";
														alu_dest<="11"; 
														wb<='0';
														mem_wr<='0';
														sel_JmpBeq<='0'; 
														wr_RF<='0';   
														sel_seqJmpPC<='0'; 
														jal<='0';
														sel_Rd_or_Z<='1';
								
								END CASE;
		
		--AUIPC
		WHEN "0010111" =>	--extensionImmValue<="001"; --U-type 
								alu_cmd<="111"; --No operation with the  ALU
								fu_cmd<="00";-- choose operands: op1=RS1 and op2=RS2 default
								alu_dest<="10"; --Dato to TX is PC+4/offset
								wb<='1'; -- Sel mux in WB_stage, choose to write into RF the direct data
								mem_wr<='0'; -- not write in memory
								sel_JmpBeq<='0'; -- not is the  instruction Beq
								wr_RF<='1';  --update RF  
								sel_seqJmpPC<='0'; -- propagate in the others stage the PC+Immediate	
								jal<='0';
								sel_Rd_or_Z<='0';
		
		--BEQ
		WHEN "1100011" =>	--extensionImmValue<="010"; --SB-type 
								alu_cmd<="111"; --No operation with the  ALU
								fu_cmd<="00";-- choose operands: op1=RS1 and op2=Value_Immediate
								alu_dest<="11"; --Dato to TX is "0"
								wb<='1'; -- Sel mux in WB_stage, choose to write into RF the direct data
								mem_wr<='0'; -- not write in memory
								sel_JmpBeq<='1'; --  is the  instruction Beq
								wr_RF<='0';  -- no update RF  
								sel_seqJmpPC<='1'; -- propagate in the others stage the PC+4
								jal<='0';
								sel_Rd_or_Z<='1';
		
		--LUI
		WHEN "0110111" =>	--extensionImmValue<="001"; --U-type 
								alu_cmd<="111"; --No operation with the  ALU
								fu_cmd<="00";-- choose operands: op1=RS1 and op2=RS2 default
								alu_dest<="01"; --Dato to TX is Immadiate Value
								wb<='1'; -- Sel mux in WB_stage, choose to write into RF the direct data
								mem_wr<='0'; -- not write in memory
								sel_JmpBeq<='0'; -- not is the  instruction Beq
								wr_RF<='1';  --update RF  
								sel_seqJmpPC<='1'; -- propagate in the others stage the PC+4	
								jal<='0';
								sel_Rd_or_Z<='0';
		
		--JAL
		WHEN "1101111" =>	--extensionImmValue<="101"; --UJ-type 
								alu_cmd<="111"; --no op with alu
								fu_cmd<="00";-- choose operands: op1=RS1 and op2=RS2 default
								alu_dest<="10"; --Dato to TX is PC+4/offset
								wb<='1'; -- Sel mux in WB_stage, choose to write into RF the direct data
								mem_wr<='0'; -- not write in memory
								sel_JmpBeq<='0'; -- not is the  instruction Beq
								wr_RF<='1';  --update RF  
								sel_seqJmpPC<='1'; -- propagate in the others stage the PC+4	
								jal<='1';
								sel_Rd_or_Z<='0';
		
		WHEN others =>		--extensionImmValue<="111";  
								alu_cmd<="000"; 
								fu_cmd<="11";
								alu_dest<="00"; 
								wb<='0';
								mem_wr<='0';
								sel_JmpBeq<='0'; 
								wr_RF<='0';   
								sel_seqJmpPC<='0'; 
								jal<='0';
								sel_Rd_or_Z<='1';
		END CASE;
  END PROCESS;
  
	--extensionImmValue_cntrl<=extensionImmValue;
	alu_cmd_cntrl<=alu_cmd;
	fu_cmd_cntrl<=fu_cmd;
	alu_dest_cntrl<=alu_dest;
	wb_cntrl<=wb;
	mem_wr_cntrl<=mem_wr;
	sel_JmpBeq_cntrl<=sel_JmpBeq;
	wr_RF_cntrl<=wr_RF;
	sel_seqJmpPC_cntrl<=sel_seqJmpPC;
	jal_cntrl<=jal;
	sel_Rd_or_Z_cntrl<=sel_Rd_or_Z;
END Behavior;





