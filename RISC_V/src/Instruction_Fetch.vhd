LIBRARY ieee;
USE ieee.std_logic_1164.all;

Entity Instruction_Fetch is
	Generic (N: integer:=32);
	Port (Clk,Rst_n,sel_jmp_seq:in std_logic;
			Next_instruction_jmp: in std_logic_vector(N-1 downto 0);
			Address_instruction: out std_logic_vector(N-1 downto 0));
			
end Instruction_Fetch;

Architecture structural of Instruction_Fetch is

--declaration of internal signals
	--signal seq_step: std_logic_vector(N-1 downto 0):= "00000000000000000000000000000100";
	signal Current_address,next_address,pc_address:  std_logic_vector(N-1 downto 0);
	--signal ld_pc: std_logic:= '1';
	--signal ld_reg: std_logic:= '1';

--declaration of the components

	Component pc_register IS
		GENERIC ( N : integer:=32);
		PORT ( nextIstruction: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			Clock,RestAsy_n,Load:IN STD_LOGIC;
			CurrentIstruction: OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
	END Component;
	
--	Component register_32bit IS
--		GENERIC ( N : integer:=32);
--		PORT ( Clock, LD : IN std_logic;
--			d_in: IN std_logic_vector(N-1 DOWNTO 0);
--			d_out: OUT std_logic_vector(N-1 DOWNTO 0)
--		);
--	END Component;
	
	Component mux2to1_32bit is
		GENERIC ( N : integer:=32);
		Port (first_choice, second_choice: in std_logic_vector(N-1 downto 0 );
				sel: in std_logic;
				dato_chosen: out std_logic_vector( 31 downto 0 ));		
	end Component;
	
	Component adder_32bit IS
		GENERIC ( N : integer:=32);
		PORT(
			in1, in2	: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			result	: OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
	END Component;
	
Begin

--	Address_instruction<=new_address;
--	
--	PC:  pc_register port map(next_address,Clk,Rst_n,'1',Current_address);
--
--	Adder_Plus_4: adder_32bit  port map(Current_address,x"00000004",seq_address);
--
--	Register_delay: register_32bit port map(Clk,'1',seq_address,new_address);
--
--	Mux_jmp_or_seq: mux2to1_32bit  port map(new_address,Next_instruction_jmp,sel_jmp_seq,next_address);

	PC:  pc_register port map(next_address,Clk,Rst_n,'1',Current_address);
	
	Adder_Plus_4: adder_32bit  port map(pc_address,x"00000004",next_address);
	
	Mux_jmp_or_seq1: mux2to1_32bit  port map(Current_address,Next_instruction_jmp,sel_jmp_seq,pc_address);
	
	Mux_jmp_or_seq2: mux2to1_32bit  port map(Current_address,Next_instruction_jmp,sel_jmp_seq,Address_instruction);
	
	
	
End structural;