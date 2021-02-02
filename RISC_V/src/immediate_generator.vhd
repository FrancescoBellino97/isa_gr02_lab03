LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY immediate_generator IS
	PORT(	
			--instruction_type:	IN	STD_LOGIC_VECTOR(2 downto 0);
			immediate: in std_logic_vector(31 downto 0);
			data_immediate:	OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END immediate_generator;

ARCHITECTURE Behavior OF immediate_generator IS

	signal imm : STD_LOGIC_VECTOR(31 DOWNTO 0);
	--signal imm_out: STD_LOGIC_VECTOR(31 DOWNTO 0);
	
	BEGIN

	--imm<= immediate;
	
	--PROCESS(instruction_type,imm) IS7
	PROCESS(immediate) IS

		BEGIN
		
--		CASE instruction_type IS
--			--I-type
--			WHEN "000" => imm_out<= imm(31)&imm(31)&imm(31)&imm(31)&imm(31)&imm(31)&imm(31)&imm(31)&imm(31)&imm(31)&imm(31)&imm(31)&imm(31)&imm(31)&imm(31)&imm(31)&imm(31)&imm(31)&imm(31)&imm(31) &imm(31 downto 20);
--			--U-type
--			WHEN "001" => imm_out<= imm(31 downto 12)&"000000000000";
--			-- SB_type
--			WHEN "010" => imm_out<= imm(31)&imm(31)&imm(31)&imm(31)&imm(31)&imm(31)&imm(31)&imm(31)&imm(31)&imm(31)&imm(31)&imm(31)&imm(31)&imm(31)&imm(31)&imm(31)&imm(31)&imm(31)&imm(31)& imm(31)& imm(7)&imm(30 downto 25)&imm(11 downto 8)&'0';
--			-- R-type
--			WHEN "011" => imm_out<= x"00000000"; --  R-type no immediate value
--			--S--type
--			WHEN "100" => imm_out<=imm(31)&imm(31)&imm(31)&imm(31)&imm(31)&imm(31)&imm(31)&imm(31)&imm(31)&imm(31)&imm(31)&imm(31)&imm(31)&imm(31)&imm(31)&imm(31)&imm(31)&imm(31)&imm(31)&imm(31)&imm(31 downto 25)&imm(11 downto 7);
--			--UJ-type
--			WHEN "101" => imm_out<= imm(31)&imm(31)&imm(31)&imm(31)&imm(31)&imm(31)&imm(31)&imm(31)&imm(31)&imm(31)&imm(31)&imm(31)&imm(19 downto 12)&imm(20)&imm(30 downto 21)&'0';
--			
--			WHEN others => imm_out<= x"00000000"; -- no immediate value
--			
--		END CASE;

	CASE(immediate(6 DOWNTO 0)) IS
		
		--LW
		WHEN "0000011" =>	imm <= (others => immediate(31));
								imm (11 DOWNTO 0) <= immediate(31 DOWNTO 20);
		
		--SW
		WHEN "0100011" =>	imm <= (others => immediate(31));
								imm (11 DOWNTO 0) <= immediate(31 DOWNTO 25) & immediate(11 DOWNTO 7);
		
		--ADD, XOR, SLT
		WHEN "0110011" =>	imm <= (others => '0');
		
		--ADDI, ANDI, SRAI
		WHEN "0010011" =>	imm <= (others => immediate(31));
								imm (11 DOWNTO 0) <= immediate(31 DOWNTO 20);
		
		--AUIPC
		WHEN "0010111" =>	imm <= (others => '0');
								imm (31 DOWNTO 12) <= immediate(31 DOWNTO 12);
		
		--BEQ
		WHEN "1100011" =>	imm <= (others => immediate(31));
								imm (12 DOWNTO 0) <= immediate(31) & immediate(7) & immediate(30 DOWNTO 25) & immediate(11 DOWNTO 8) & '0';
		
		--LUI
		WHEN "0110111" =>	imm <= (others => '0');
								imm (31 DOWNTO 12) <= immediate(31 DOWNTO 12);
		
		--JAL
		WHEN "1101111" =>	imm <= (others => immediate(31));
								imm (20 DOWNTO 0)<= immediate(31) & immediate(19 DOWNTO 12) & immediate(20) & immediate(30 DOWNTO 21) & '0';
		
		WHEN others => imm <= (others => '0');
	
	END CASE;

	
	
  END PROCESS;
  
  --data_immediate <= imm_out;
  data_immediate <= imm;

END Behavior;





