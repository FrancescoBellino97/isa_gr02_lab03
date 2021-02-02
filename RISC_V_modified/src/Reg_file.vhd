LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE IEEE.NUMERIC_STD.all;
USE IEEE.std_logic_unsigned.all;


Entity Reg_file is
	GENERIC ( N : integer:=32);
	PORT (Clock,Cntrl_Wr_data, rst_n:IN STD_LOGIC;
			Add_Rs1,Add_Rs2,Add_Rd: in std_logic_vector(4 downto 0);
			Data_to_Wr: in std_logic_vector(N-1 downto 0);
			Rd_data1,Rd_data2: out std_logic_vector(N-1 DOWNTO 0));
End Reg_file;

Architecture behavioural of Reg_file is

	type data_info is array(N-1 downto 0) of std_logic_vector(N-1 downto 0);
	signal Register_file: data_info:=(others=>(others=>'0'));
	
Begin

	
	
	--Syncronous write
	
	clk_rst_proc: Process(Clock)
		Begin
			IF (rst_n='0') THEN
				Register_file(0) <= (others => '0');
				Register_file(1) <= (others => '0');
				Register_file(2) <= (others => '0');
				Register_file(3) <= (others => '0');
				Register_file(4) <= (others => '0');
				Register_file(5) <= (others => '0');
				Register_file(6) <= (others => '0');
				Register_file(7) <= (others => '0');
				Register_file(8) <= (others => '0');
				Register_file(9) <= (others => '0');
				Register_file(10) <= (others => '0');
				Register_file(11) <= (others => '0');
				Register_file(12) <= (others => '0');
				Register_file(13) <= (others => '0');
				Register_file(14) <= (others => '0');
				Register_file(15) <= (others => '0');
				Register_file(16) <= (others => '0');
				Register_file(17) <= (others => '0');
				Register_file(18) <= (others => '0');
				Register_file(19) <= (others => '0');
				Register_file(20) <= (others => '0');
				Register_file(21) <= (others => '0');
				Register_file(22) <= (others => '0');
				Register_file(23) <= (others => '0');
				Register_file(24) <= (others => '0');
				Register_file(25) <= (others => '0');
				Register_file(26) <= (others => '0');
				Register_file(27) <= (others => '0');
				Register_file(28) <= (others => '0');
				Register_file(29) <= (others => '0');
				Register_file(30) <= (others => '0');
				Register_file(31) <= (others => '0');
			ELSIF (Clock'EVENT AND Clock = '1') THEN
				If (Cntrl_Wr_data='1') then
					Register_file(to_integer(unsigned(Add_Rd)))<=Data_to_Wr;
					--Rd_data1<=Register_file(to_integer(unsigned(Add_Rs1)));
					--Rd_data2<=Register_file(to_integer(unsigned(Add_Rs2)));
				end if;
			end if;
		End Process;
	
	--Asyncronous read
	Read_reg_Rs1_RS2: Process(Add_Rs1,Add_Rs2,Register_file)
		Begin
			Rd_data1<=Register_file(to_integer(unsigned(Add_Rs1)));
			Rd_data2<=Register_file(to_integer(unsigned(Add_Rs2)));
		End Process;
	

	End behavioural;

	