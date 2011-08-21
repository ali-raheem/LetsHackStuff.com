module bcd10(in, out);
	input [9:0]in;
	output [11:0]out;
	
	wire [21:0]w0,w1,w2,w3,w4,w5,w6,w7;
	assign w0 = in<<3;
	_add3 (.in(w0), .out(w1));
	_add3 (.in(w1<<1), .out(w2));
	_add3 (.in(w2<<1), .out(w3));
	_add3 (.in(w3<<1), .out(w4));
	_add3 (.in(w4<<1), .out(w5));
	_add3 (.in(w5<<1), .out(w6));
	_add3 (.in(w6<<1), .out(w7));
	assign out[11:0] = w7[20:9];
endmodule
