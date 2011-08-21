module LFSR( oData, iClk);
	output wire [3:0] oData;
	input	iClk;
	
	reg [3:0] data;
	reg newBit;
	always@(posedge iClk)begin
		newBit <= data[2] ^ data[1];
		data[3] <= newBit;
		data[2:0] <= data[3:1];
	end
	assign oData = data;
	initial begin
		data = 4'b0001;
		newBit = 1;
	end
endmodule
