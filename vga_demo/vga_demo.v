module vga_demo(CLOCK_50, VGA_R, VGA_G, VGA_B, VGA_HS, VGA_VS, SW);
input CLOCK_50;
input [9:0]SW;
output [3:0] VGA_R, VGA_G, VGA_B;
output VGA_HS, VGA_VS;
reg clk;
always@(posedge CLOCK_50)
	clk <= ~clk;
//sync + x,y + display
wire [9:0] x, y;
vga (.clk(clk), .VGA_HS(VGA_HS), .VGA_VS(VGA_VS), .display(display), .oX(x), .oY(y));
//1005opacity
wire [3:0] box;
assign box = (x>100 && x<200 && y>100 && y<200)?4'b1111:4'b0;
//50% opacity not perfect, might need slower clock? Or is it faster?
wire [3:0] box50;
assign box50 = (x>300 && x<400 && y>100 && y<200)?(CLOCK_50)?4'b1111:4'b0:4'b0;
//Display white things trump all else in |. SW's control colour
assign VGA_R = display?{SW[8:6],1'b0}|box|box50:0;
assign VGA_G = display?{SW[5:3],1'b0}|box|box50:0;
assign VGA_B = display?{SW[2:0],1'b0}|box|box50:0;
endmodule
