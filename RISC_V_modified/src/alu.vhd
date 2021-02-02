LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY alu IS
PORT(	
	data1, data2	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	cmd	: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
	result	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END alu;

ARCHITECTURE behavior OF alu IS

	SIGNAL sum_result : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL sub_result : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL and_result : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL xor_result : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL shift_result : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL compare_result : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL module_result : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL mux_out : STD_LOGIC_VECTOR (31 DOWNTO 0);
	
	--component declaration
	COMPONENT mux_8to1 IS
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
	END COMPONENT;
	
	COMPONENT sum_block IS
	PORT(
		in1, in2	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		result	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT sub_block IS
	PORT(	
		in1, in2	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		result	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT and_block IS
	PORT(
		in1, in2	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		result	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT xor_block IS
	PORT(
		in1, in2	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		result	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT shift_block IS
	PORT(
		in1, in2	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		result	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT compare_block IS
	PORT(
		in1, in2	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		result	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT module_block IS
	PORT(
		input	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		result	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
	END COMPONENT;
	
	
	BEGIN
	
	--component instance
	ADDER : sum_block
	PORT MAP(	in1 => data1,
					in2 => data2,
					result => sum_result);
	
	SUBTRACTOR : sub_block
	PORT MAP(	in1 => data1,
					in2 => data2,
					result => sub_result);
	
	AND_COMP : and_block
	PORT MAP(	in1 => data1,
					in2 => data2,
					result => and_result);
	
	XOR_COMP : xor_block
	PORT MAP(	in1 => data1,
					in2 => data2,
					result => xor_result);
	
	SHIFT : shift_block
	PORT MAP(	in1 => data1,
					in2 => data2,
					result => shift_result);
	
	COMPARE : compare_block
	PORT MAP(	in1 => data1,
					in2 => data2,
					result => compare_result);
	
	MODULE : module_block
	PORT MAP(	input => data1,
					result => module_result);
	
	
	MUX : mux_8to1
	GENERIC MAP ( N => 32 )
	PORT MAP (	input1 => sum_result,
					input2 => sub_result,
					input3 => and_result,
					input4 => xor_result,
					input5 => shift_result,
					input6 => compare_result,
					input7 => module_result,
					input8 => x"00000000",
					sel => cmd,
					output => mux_out);
	

	
	--output
	result <= mux_out;

END behavior;