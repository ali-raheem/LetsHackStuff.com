module calc(SW, KEY, LEDR, LEDG, HEX0, HEX1, HEX2, HEX3);
	input	[9:0]SW;
	input	[3:0]KEY;
	output	[9:0]LEDR;
	output	[7:0]LEDG;
	output	[0:6]HEX0,HEX1,HEX2,HEX3;
	reg	[9:0]out;
	
	assign LEDR = SW;
	assign LEDG = out;
	
	always @(*)
	begin	
		case (KEY)
			4'b0111: out <= SW[9:5] + SW[4:0];
			4'b1011: out <= SW[9:5] - SW[4:0];
			4'b1101: out <= SW[9:5] * SW[4:0];
			4'b1110: out <= SW[9:5] / SW[4:0];
			default: out <= 0;
		endcase
	end

	wire [7:0]bcdw0,bcdw1;
	wire [15:0]bcdw2;
	bcd (.in(SW[9:5]), .out(bcdw0));
	bcd (.in(SW[4:0]), .out(bcdw1));
	bcd10 (.in(out[9:0]), .out(bcdw2));
	
	b2seg (.in((~&KEY)?bcdw2[15:12]:bcdw0[7:4]), .out(HEX3));
	b2seg (.in((~&KEY)?bcdw2[11:8]:bcdw0[3:0]), .out(HEX2));
	b2seg (.in((~&KEY)?bcdw2[7:4]:bcdw1[7:4]), .out(HEX1));
	b2seg (.in((~&KEY)?bcdw2[3:0]:bcdw1[3:0]), .out(HEX0));
endmodule
