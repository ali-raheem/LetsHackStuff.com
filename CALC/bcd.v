module bcd(in, out);
	input [4:0]in;
	output [7:0]out;
	
	wire [12:0]w0,w1,w2;
	assign w0 = in<<3;
	add3 (.in(w0), .out(w1));
	add3 (.in(w1<<1), .out(w2));
	assign out[7:0] = w2[11:4]; //Final shift [12:5]
endmodule
