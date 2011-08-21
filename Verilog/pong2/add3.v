module add3(in, out);
	input [12:0]in;
	output [12:0]out;
	reg [12:0]out;
	
	always@(*)
	begin
		out = in;
		if(in[12:9]>4) out[12:9] = in[12:9] + 3;
		if(in[8:5]>4) out[8:5] = in[8:5] + 3;
	end
endmodule
