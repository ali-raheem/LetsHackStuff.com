module b2seg(in, out);
	input [3:0]in;
	output [6:0]out;
	reg [6:0]out;
	
	always @(*)
	begin
		case (in)
			0: out = 7'b0000001;
			1: out = 7'b1001111;
			2: out = 7'b0010010;
			3: out = 7'b0000110;
			4: out = 7'b1001100;
			5: out = 7'b0100100;
			6: out = 7'b0100000;
			7: out = 7'b0001111;
			8: out = 7'b0000000;
			9: out = 7'b0001100;
			10: out = 7'b0001000;
			11: out = 7'b1100000;
			12: out = 7'b0110001;
			13: out = 7'b1000010;
			14: out = 7'b0110000;
			15: out = 7'b0111000;
			default: out = 7'b1111111;
		endcase
	end

endmodule
