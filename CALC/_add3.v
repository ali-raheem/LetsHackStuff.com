module _add3(in, out);
	input [21:0]in;
	output [21:0]out;
	reg [21:0]out;
	
	always@(*)
	begin
		out = in;
		if(in[21:18]>4) out[21:18] = in[21:18] + 3;
		if(in[17:14]>4) out[17:14] = in[17:14] + 3;
		if(in[13:10]>4) out[13:10] = in[13:10] + 3;
	end
endmodule
