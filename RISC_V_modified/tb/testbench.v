//`timescale 1ns

module testbench ();

// DICHIARAZIONE SIGNAL
	wire clk_t;
	wire rst_n_t;
	wire [31:0] instr_add_t;
	wire [31:0] instr_code_t;
	wire [31:0] data_add_t;
	wire [31:0] data_write_t;
	wire [31:0] data_out_t;
	wire write_sgn_t;


	clock_gen CG(.CLK(clk_t));

	rst_gen RG(.RST_n(rst_n_t));

	ROM_instruction ROM(.add(instr_add_t),
						.data_out(instr_code_t));
					

	RAM_data RAM(	.add(data_add_t),
					.clk(clk_t),
					.wr(write_sgn_t),
					.data_in(data_write_t),
					.data_out(data_out_t));

	Risc_V DUT(	.Clk(clk_t),
				.reset(rst_n_t),
				.Code_instruction(instr_code_t),
				.Data_from_memory(data_out_t),
				.Address_instruction(instr_add_t),
				.Address_data(data_add_t),
				.Data_write(data_write_t),
				.Wr_MEM_cntrl(write_sgn_t));

endmodule



