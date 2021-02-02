LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY execution_unit IS
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
END execution_unit;

ARCHITECTURE behavior OF execution_unit IS

	--SIGNAL DECLARATION
	SIGNAL alu_src1_sig : STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL alu_src2_sig : STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL alu_data1 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL alu_data2 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL alu_result_sig : STD_LOGIC_VECTOR(31 DOWNTO 0);
	
	
	--COMPONENT DECLARATION
	COMPONENT mux_4to1 IS
	GENERIC( N	: INTEGER := 32);
	PORT(	
		input1	: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		input2	: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		input3	: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		input4	: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		sel	: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		output	: OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT alu IS
	PORT(	
		data1, data2	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		cmd	: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		result	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT forwarding_unit IS
	PORT(
		rs1_add	: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		rs2_add	: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		rd_add_mem	: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		rd_add_wb		: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		cmd	: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		alu_src1	: OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		alu_src2	: OUT STD_LOGIC_VECTOR(1 DOWNTO 0));
	END COMPONENT;
	
	BEGIN
	
		MUX1 : mux_4to1
		GENERIC MAP (	N => 32)
		PORT MAP (	input1 => read_data1,
						input2 => x"00000000",
						input3 => rd_mem,
						input4 => rd_wb,
						sel => alu_src1_sig,
						output => alu_data1);
						
		MUX2 : mux_4to1
		GENERIC MAP (	N => 32)
		PORT MAP (	input1 => read_data2,
						input2 => imm_gen,
						input3 => rd_mem,
						input4 => rd_wb,
						sel => alu_src2_sig,
						output => alu_data2);
		
		FORWARD_UNIT : forwarding_unit
		PORT MAP (	rs1_add => rs1_add_in,
						rs2_add => rs2_add_in,
						rd_add_mem => rd_add_mem_in,
						rd_add_wb => rd_add_wb_in,
						cmd => fu_cmd,
						alu_src1 => alu_src1_sig,
						alu_src2 => alu_src2_sig);
						
		ALU_COMP : alu
		PORT MAP (	data1 => alu_data1, 
						data2 => alu_data2,
						cmd => alu_cmd,
						result => alu_result_sig);
		
		MUX_OUT : mux_4to1
		PORT MAP (	input1 => alu_result_sig,
						input2 => imm_gen,
						input3 => pc4_offset,
						input4 => x"00000000",
						sel => alu_dest,
						output => add_mem);
		
		data_mem <= read_data2;

END behavior;
