LIBRARY ieee;
USE ieee.std_logic_1164.all;

Entity Risc_V is
	Port (Clk,reset:in std_logic;
			Code_instruction: in std_logic_vector(31 downto 0);
			Data_from_memory: in std_logic_vector(31 downto 0);
			Address_instruction: out std_logic_vector(31  downto 0);
			Address_data: out std_logic_vector(31  downto 0);
			Data_write: out std_logic_vector(31 downto 0);
			Wr_MEM_cntrl: out std_logic);
			
end Risc_V;

Architecture structural of Risc_V is

--declaration of internal signals
	signal jmp_or_seq,ld,MEM,WB,WrRfWb,MEM_o_sgn,WB_o,WrRfWb_o,WB_out3Pipe,MEM_out3Pipe,WrRfWb_out3Pipe: std_logic;
	signal add_jmp,current_Add,instr_code,PC,PC4_offset,Rs1D,Rs2D,immD,dataWB,PC4_offset_o,Rs1D_o,Rs2D_o,immD_o: std_logic_vector(31 downto 0);
   signal Rs1Add,Rs2Add,RdAdd,Rs1Add_o,Rs2Add_o,RdAdd_o,RdAdd_out3Pipe: std_logic_vector(4 downto 0);
	signal aluDest,FuCmd,aluDest_o,FuCmd_o: std_logic_vector(1 downto 0);
	signal aluCmd,aluCmd_o: std_logic_vector(2 downto 0);
	signal Rd_mem,Rd_wb,Add_mem,Data_mem,Add_mem_o,Data_mem_o: std_logic_vector(31 downto 0);
	signal RdAdd_mem,RdAdd_wb,RdAdd_out4Pipe:std_logic_vector(4 downto 0);
	signal WB_out4Pipe,WrRfWb_out4Pipe: std_logic;
	signal Add_mem_out4Pipe,DataMemory_out4Pipe: std_logic_vector(31 downto 0);
	
--declaration of the components 

	Component Instruction_Fetch is
		Generic (N: integer:=32);
		Port (Clk,Rst_n,sel_jmp_seq:in std_logic;
			Next_instruction_jmp: in std_logic_vector(N-1 downto 0);
			Address_instruction: out std_logic_vector(N-1 downto 0));
			
	end Component;
	
	Component ID is
		Generic (N: integer:=32);
		Port (Clk:in std_logic;
			reset_n:in std_logic;
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
			
	end Component;
	
	Component execution_unit IS
		PORT(
			pc4_offset	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			read_data1	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			read_data2	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			imm_gen	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			rd_mem	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			rd_wb		: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			alu_dest	: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
			alu_cmd	: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
			fu_cmd	: IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
			rs1_add_in	: IN  STD_LOGIC_VECTOR(4 DOWNTO 0);
			rs2_add_in	: IN  STD_LOGIC_VECTOR(4 DOWNTO 0);
			rd_add_mem_in	: IN  STD_LOGIC_VECTOR(4 DOWNTO 0);
			rd_add_wb_in	: IN  STD_LOGIC_VECTOR(4 DOWNTO 0);
	
			add_mem	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			data_mem	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
	END Component;
	
	Component mux2to1_32bit is
		GENERIC ( N : integer:=32);
		Port ( first_choice, second_choice: in std_logic_vector(N-1 downto 0 );
			 sel: in std_logic;
			dato_chosen: out std_logic_vector( 31 downto 0 ));		
	end Component;
	
	Component Rpipe_IF_ID IS
		GENERIC ( N : integer:=32);
		PORT ( Clock, Rst_n, LD : IN std_logic;
			d_in1,d_in2: IN std_logic_vector(N-1 DOWNTO 0);
			d_out1,d_out2: OUT std_logic_vector(N-1 DOWNTO 0)
		);
	END Component;
		
	Component RegID_EX IS
		GENERIC ( N : integer:=32);
		PORT ( Clock,Rst_n, LD : IN std_logic;
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
	END Component;

	Component RegEX_MEM IS
		GENERIC ( N : integer:=32);
		PORT ( Clock,Rst_n, LD : IN std_logic;
			MEM,WB,Wr_RF_WB: IN std_logic;
			Add_mem,Data_mem: in std_logic_vector(N-1 downto 0);
			Rd_add: in std_logic_vector(4 downto 0);
			MEM_o,WB_o,Wr_RF_WB_o: out std_logic;
			Add_mem_o,Data_mem_o: out std_logic_vector(N-1 downto 0);
			Rd_add_o: out std_logic_vector(4 downto 0)
		);
	END Component;
	
	Component RegMEM_WB IS
		GENERIC ( N : integer:=32);
		PORT ( Clock,Rst_n, LD : IN std_logic;
			WB,Wr_RF_WB: IN std_logic;
			Add_mem,Data_mem: in std_logic_vector(N-1 downto 0);
			Rd_add: in std_logic_vector(4 downto 0);
			WB_o,Wr_RF_WB_o: out std_logic;
			Add_mem_o,Data_mem_o: out std_logic_vector(N-1 downto 0);
			Rd_add_o: out std_logic_vector(4 downto 0)
		);
	END Component;

Begin

ld<='1';

IF_Stage: Instruction_Fetch port map(Clk,reset,jmp_or_seq,add_jmp,current_Add);

--Output Value
Address_instruction<=current_Add;

First_Reg_of_pipe: Rpipe_IF_ID port map(Clk,reset,ld,Code_instruction,current_Add,instr_code,PC);

ID_Stage: ID port map(Clk,reset,instr_code,PC,WrRfWb_out4Pipe,RdAdd_out4Pipe,dataWB,MEM,WB,PC4_offset,Rs1D,Rs2D,immD,aluDest,aluCmd,FuCmd,Rs1Add,Rs2Add,WrRfWb,RdAdd,add_jmp,jmp_or_seq);

Second_Reg_of_pipe: RegID_EX port map(Clk,reset,ld,MEM,WB,WrRfWb,PC4_offset,Rs1D,Rs2D,immD,aluDest,FuCmd,aluCmd,Rs1Add,Rs2Add,RdAdd,MEM_o_sgn,WB_o,WrRfWb_o,PC4_offset_o,Rs1D_o,Rs2D_o,immD_o,aluDest_o,FuCmd_o,aluCmd_o,Rs1Add_o,Rs2Add_o,RdAdd_o);

Execution_Unit_Stage: execution_unit port map(PC4_offset_o,Rs1D_o,Rs2D_o,immD_o,Add_mem_o,dataWB,aluDest_o,aluCmd_o,FuCmd_o,Rs1Add_o,Rs2Add_o,RdAdd_out3Pipe,RdAdd_out4Pipe,Add_mem,Data_mem);

Third_Reg_of_pipe: RegEX_MEM port map(Clk,reset,ld,MEM_o_sgn,WB_o,WrRfWb_o,Add_mem,Data_mem,RdAdd_o,MEM_out3Pipe,WB_out3Pipe,WrRfWb_out3Pipe,Add_mem_o,Data_mem_o,RdAdd_out3Pipe);

--Memory Stage: there are not components but only interface with the exernal memory
--Output Value
Address_data<=Add_mem_o;
Data_write<=Data_mem_o;
Wr_MEM_cntrl<=MEM_out3Pipe;

Fourth_Reg_of_pipe: RegMEM_WB port map(Clk,reset,ld,WB_out3Pipe,WrRfWb_out3Pipe,Add_mem_o,Data_from_memory,RdAdd_out3Pipe,WB_out4Pipe,WrRfWb_out4Pipe,Add_mem_out4Pipe,DataMemory_out4Pipe,RdAdd_out4Pipe);

WB_Stage: mux2to1_32bit port map(DataMemory_out4Pipe,Add_mem_out4Pipe,WB_out4Pipe,dataWB);

End structural;
