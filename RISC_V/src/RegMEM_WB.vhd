LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY RegMEM_WB IS
	GENERIC ( N : integer:=32);
	PORT ( Clock,Rst_n, LD : IN std_logic;
			WB,Wr_RF_WB: IN std_logic;
			Add_mem,Data_mem: in std_logic_vector(N-1 downto 0);
			Rd_add: in std_logic_vector(4 downto 0);
			WB_o,Wr_RF_WB_o: out std_logic;
			Add_mem_o,Data_mem_o: out std_logic_vector(N-1 downto 0);
			Rd_add_o: out std_logic_vector(4 downto 0)
	);
END RegMEM_WB;

ARCHITECTURE behavior OF RegMEM_WB IS

	BEGIN
	
		PROCESS(Clock,Rst_n)
			BEGIN
			    if (Rst_n = '0') THEN
						WB_o<='0';
						Wr_RF_WB_o<='0';
						Add_mem_o<=( others => '0');
						Data_mem_o<=( others => '0');
						Rd_add_o<=( others => '0');

			    elsif (Clock'EVENT AND Clock = '1') THEN
					IF (LD = '1') THEN
						WB_o<=WB;
						Wr_RF_WB_o<=Wr_RF_WB;
						Add_mem_o<=Add_mem;
						Data_mem_o<=Data_mem;
						Rd_add_o<=Rd_add;
					END IF;
			    END IF;
		END PROCESS;
		
END  behavior;