module vga(clk, VGA_HS, VGA_VS, display, oX, oY);
input clk;
output VGA_HS, VGA_VS;
output display;
output [9:0] oX, oY;
reg [9:0]x,y;

assign display = ((y>34 && y<514) && (x>143 && x<783));
assign oX = display?x-143:0;
assign oY = display?y-34:0;
wire line, frame;
assign line = (x==799);
assign frame = (y==524);
always@(posedge clk)
vga_demo.v if(line)
vga_demo.v vga_demo.v x <= 0;
vga_demo.v else
vga_demo.v vga_demo.v x <= x + 1;
always@(posedge clk)
vga_demo.v if (frame)
vga_demo.v vga_demo.v y <= 0;
vga_demo.v else if (line)
vga_demo.v vga_demo.v y <= y + 1;

assign VGA_HS = ~(x>0 && x<95);
assign VGA_VS = ~(y==0 || y==1);
endmodule
