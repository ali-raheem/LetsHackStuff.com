module SRAM(
	output wire [17:0] SRAM_ADDR,
	inout wire [15:0] SRAM_DQ,
	output wire SRAM_WE_N, SRAM_OE_N, SRAM_UB_N, SRAM_LB_N, SRAM_CE_N,
	input CLOCK_50,
	input [9:0] SW,
	input [3:0] KEY,
	output wire [9:0]LEDR
	);

		assign SRAM_DQ = (~SW[9])?16'hz:{12'b0,~KEY[3:0]};
		assign SRAM_ADDR = {8'b0, SW[8:0]};		
		assign SRAM_WE_N = ~SW[9];
		assign SRAM_OE_N = 0;
		assign SRAM_UB_N = 0;
		assign SRAM_LB_N = 0;
		assign SRAM_CE_N = 0;
		assign LEDR[9:0] = SRAM_DQ[9:0];
endmodule
