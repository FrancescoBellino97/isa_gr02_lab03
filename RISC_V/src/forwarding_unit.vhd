LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY forwarding_unit IS
PORT(
	rs1_add	: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
	rs2_add	: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
	rd_add_mem	: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
	rd_add_wb		: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
	cmd	: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
	alu_src1	: OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
	alu_src2	: OUT STD_LOGIC_VECTOR(1 DOWNTO 0));
END forwarding_unit;


--FU_CMD		
--	 00	->	ALU WILL USE RS1 AND RS2 (NEED TO CONTROL BOTH)
--	 01	->	ALU WILL USE RS1 AND IMMEDIATE (NEED TO CONTROL RS1)
--	 10	-> ALU WILL USE PC AND RS2 (NEED TO CONTROL RS2) (NOT USED)
--	 11	->	ALU WILL USE PC AND IMMEDIATE (DON'T NEED CONTROL)

--ALU_SRC1		
--	 00		->	ALU WILL USE RS1 (DEFAULT)
--	 01		-> ALU WILL USE PC
--	 10		-> ALU WILL USE RD FROM "MEM" STAGE
--  11		-> ALU WILL USE RD FROM "WB" STAGE

--ALU_SRC2		
--	 00		->	ALU WILL USE RS2 (DEFAULT)
--	 01		-> ALU WILL USE IMMEDIATE
--	 10		-> ALU WILL USE RD FROM "MEM" STAGE
--  11		-> ALU WILL USE RD FROM "WB" STAGE


ARCHITECTURE behavior OF forwarding_unit IS

	BEGIN
	PROCESS(rs1_add, rs2_add, rd_add_mem, rd_add_wb, cmd) IS
		BEGIN
		CASE cmd IS
			WHEN "00" =>
				IF (rs1_add=rd_add_mem AND rd_add_mem/="00000") THEN
					alu_src1 <= "10"; --RD(MEM)
				ELSIF (rs1_add=rd_add_wb AND rd_add_wb/="00000") THEN
					alu_src1 <= "11"; --RD(WB)
				ELSE
					alu_src1 <= "00"; --RS1
				END IF;
				
				IF (rs2_add=rd_add_mem AND rd_add_mem/="00000") THEN
					alu_src2 <= "10"; --RD(MEM)
				ELSIF (rs2_add=rd_add_wb AND rd_add_wb/="00000") THEN
					alu_src2 <= "11"; --RD(WB)
				ELSE
					alu_src2 <= "00"; --RS2
				END IF;
			
			WHEN "01" =>
				IF (rs1_add=rd_add_mem AND rd_add_mem/="00000") THEN
					alu_src1 <= "10"; --RD(MEM)
				ELSIF (rs1_add=rd_add_wb AND rd_add_wb/="00000") THEN
					alu_src1 <= "11"; --RD(WB)
				ELSE
					alu_src1 <= "00"; --RS1
				END IF;
				
				alu_src2 <= "01"; --IMMEDIATE
			
			WHEN "10" =>
				alu_src1 <= "01"; --PC
				
				IF (rs2_add=rd_add_mem AND rd_add_mem/="00000") THEN
					alu_src2 <= "10"; --RD(MEM)
				ELSIF (rs2_add=rd_add_wb AND rd_add_wb/="00000") THEN
					alu_src2 <= "11"; --RD(WB)
				ELSE
					alu_src2 <= "00"; --RS2
				END IF;
			
			WHEN "11" =>
				alu_src1 <= "01"; --PC
				alu_src2 <= "01"; --IMMEDIATE
			
			WHEN others =>
				alu_src1 <= "00"; --RS1
				alu_src2 <= "00"; --RS2
				
		END CASE;
	END PROCESS;

END behavior;