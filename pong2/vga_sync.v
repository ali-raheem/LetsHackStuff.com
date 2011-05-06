module vga_sync(iclk, oVGA_HS, oVGA_VS, oActive, oX, oY);
	input iclk;
	output oVGA_HS, oVGA_VS;
	output oActive;
	output [9:0] oX, oY;
	reg [9:0]x,y;

	assign oActive = ((y>34 && y<514) && (x>143 && x<783));
	assign oX = oActive?x-143:0;
	assign oY = oActive?y-34:0;
	wire line, frame;
	assign line = (x==799);
	assign frame = (y==524);
	always@(posedge iclk)
		if(line)
			x <= 0;
		else
			x <= x + 1;
	always@(posedge iclk)
		if (frame)
			y <= 0;
		else if (line)
			y <= y + 1;

	assign oVGA_HS = ~(x>0 && x<95);
	assign oVGA_VS = ~(y==0 || y==1);
endmodule
