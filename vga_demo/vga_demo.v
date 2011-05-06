module vga_demo(CLOCK_50, VGA_R, VGA_G, VGA_B, VGA_HS, VGA_VS, SW);
input CLOCK_50;
input [9:0]SW;
output [3:0] VGA_R, VGA_G, VGA_B;
output VGA_HS, VGA_VS;
reg clk;
always@(posedge CLOCK_50)
clk <= ~clk;
wire [9:0] x, y;
vga (.clk(clk), .VGA_HS(VGA_HS), .VGA_VS(VGA_VS), .display(display), .oX(x), .oY(y));

assign VGA_R = display?{SW[8:6],1'b0}:0;
assign VGA_G = display?{SW[5:3],1'b0}:0;
assign VGA_B = display?{SW[2:0],1'b0}:0;
endmodule
