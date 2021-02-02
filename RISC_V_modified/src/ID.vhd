LIBRARY ieee;
USE ieee.std_logic_1164.all;

Entity ID is
	Generic (N: integer:=32);
	Port (Clk:in std_logic;
			reset_n: in STD_LOGIC;
			Instr_code: in std_logic_vector(N-1 downto 0);
			PC_address: in std_logic_vector(N-1 downto 0);
			Wr_WB: in std_logic;
			Add_WB: in std_logic_vector(4 downto 0);
			Data_WB: in std_logic_vector(N-1 downto 0);
			MEM: out std_logic;
			WB: out std_logic;
			PC_4_offset: out std_logic_vector(N-1 downto 0);
			Rs1: out std_logic_vector(N-1 downto 0);
			Rs2: out std_logic_vector(N-1 downto 0);
			Imm_D: out std_logic_vector(N-1 downto 0);
			Alu_dest: out std_logic_vector(1 downto 0);
			Alu_cmd: out std_logic_vector(2 downto 0);
			Fu_cmd: out std_logic_vector(1 downto 0);
			Rs1_add: out std_logic_vector(4 downto 0);
			Rs2_add: out std_logic_vector(4 downto 0);
			Wr_RF_WB: out std_logic;
			RD_add: out std_logic_vector(4 downto 0);
			PC_offset_toIF: out std_logic_vector(N-1 downto 0);
			sel_jmp_seq: out std_logic);
			
end ID;

Architecture structural of ID is

--declaration of internal signals
	signal instruction,imm_value,pcPlus_offset,pcPlus_four,Rs1D,Rs2D,D_WB,Rs1_out, Rs2_out: std_logic_vector(N-1 downto 0);
	--signal four: std_logic_vector(N-1 downto 0):= "00000000000000000000000000000100";
	--signal no_jmp: std_logic:='0';
	signal instr_type_cntrl: std_logic_vector(2 downto 0);
	signal sel_pc,jal,beq,selRs1_or_WB, selRs2_or_WB,Eq,isBeq: std_logic;
	signal add_cu: std_logic_vector(5 downto 0);
	signal add_Rs1,add_Rs2,add_Rd,addWB: std_logic_vector(4 downto 0);
	signal rd_sel : std_logic;
--declaration of the components

	Component Check_jmp IS
		PORT(
		in1, in2	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		beq: out std_logic);
	END Component;
	
	Component CU IS
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
	END Component;
	 
	Component hazard_unit IS
		PORT(
				rs1_address, rs2_address, wbRd_address: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
				Rs1_Or_Wb, Rs2_Or_Wb: out std_logic);
	END Component;

	 
	Component immediate_generator IS
		PORT(	
			--instruction_type:	IN	STD_LOGIC_VECTOR(2 downto 0);
			immediate: in std_logic_vector(31 downto 0);
			data_immediate:	OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
	END Component;
	
	Component mux_2to1 is
		Port ( first_choice, second_choice: in std_logic;
			 sel: in std_logic;
			dato_chosen: out std_logic);		
	end Component;
	
	Component Reg_file is
		GENERIC ( N : integer:=32);
		PORT (Clock,Cntrl_Wr_data,rst_n:IN STD_LOGIC;
			Add_Rs1,Add_Rs2,Add_Rd: in std_logic_vector(4 downto 0);
			Data_to_Wr: in std_logic_vector(N-1 downto 0);
			Rd_data1,Rd_data2: out std_logic_vector(N-1 DOWNTO 0));
	End Component;
	
	Component adder_32bit IS
		GENERIC ( N : integer:=32);
		PORT(
		in1, in2	: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		result	: OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
	END Component;
	
	Component mux2to1_32bit is
		GENERIC ( N : integer:=32);
		Port ( first_choice, second_choice: in std_logic_vector(N-1 downto 0 );
			 sel: in std_logic;
			dato_chosen: out std_logic_vector( N-1 downto 0 ));		
	end Component;

Begin

instruction<=Instr_code;
add_Rs1<=instruction(19 downto 15);
add_Rs2<=instruction(24 downto 20);
D_WB<=Data_WB;
addWB<=Add_WB;

--add_cu<= instruction(6 downto 4)&instruction(2)&instruction(14 downto 13);

--Immediate_Generator_unit: immediate_generator port map(instr_type_cntrl,instruction,imm_value);
Immediate_Generator_unit: immediate_generator port map(instruction,imm_value);

--Control_Unit:  CU port map(instruction(6 DOWNTO 0), instruction(14 DOWNTO 12), instr_type_cntrl,Alu_cmd,Fu_cmd,Alu_dest,Wb,MEM,beq,Wr_RF_WB,sel_pc,jal,rd_sel);
Control_Unit:  CU port map(instruction(6 DOWNTO 0), instruction(14 DOWNTO 12),Alu_cmd,Fu_cmd,Alu_dest,Wb,MEM,beq,Wr_RF_WB,sel_pc,jal,rd_sel);

PC_plus_offset: adder_32bit port map(imm_value,PC_address,pcPlus_offset);

PC_plus_four: adder_32bit port map(PC_address,x"00000004",pcPlus_four);

Register_FIle: Reg_file port map(Clk,Wr_WB,reset_n,add_Rs1,add_Rs2,addWB,D_WB,Rs1D,Rs2D);

Hzard_Detection_Unit: hazard_unit port map(add_Rs1, add_Rs2, addWB,selRs1_or_WB, selRs2_or_WB);

Choose_RS1_or_WB: mux2to1_32bit port map(Rs1D,D_WB,selRs1_or_WB,Rs1_out);

Choose_RS2_or_WB: mux2to1_32bit port map(Rs2D,D_WB,selRs2_or_WB,Rs2_out);

CompareRs1_Rs2_for_beqInstruction: Check_jmp port map(Rs1_out,Rs2_out,Eq);

Choose_if_is_or_not_BeqInstr: mux_2to1 port map('0',Eq,beq,isBeq);

Choose_Rd_or_x0: mux2to1_32bit generic map (N => 5) port map (instruction(11 downto 7),"00000",rd_sel,add_Rd);

--Output values
Choose_PCseq_or_PCjmp:  mux2to1_32bit port map(pcPlus_offset,pcPlus_four,sel_pc,PC_4_offset);

Imm_D<=imm_value;

PC_offset_toIF<=pcPlus_offset;

sel_jmp_seq<= isBeq or  jal;

Rs1<=Rs1_out;
Rs2<=Rs2_out;
Rs1_add<=add_Rs1;
Rs2_add<=add_Rs2;
RD_add<=add_Rd;

End structural;