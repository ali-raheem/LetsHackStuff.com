module top(KEY, LEDG);
	input [3:0] KEY;
	output [4:0] LEDG;
	LFSR (.iClk(~KEY[0]),.oData(LEDG[3:0]));
endmodule
