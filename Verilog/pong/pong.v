module pong(CLOCK_50, VGA_R, VGA_G, VGA_B, VGA_HS, VGA_VS, SW, KEY);
input CLOCK_50;
input [9:0] SW;
input [3:0] KEY;
output [3:0] VGA_R, VGA_G, VGA_B;
output VGA_HS, VGA_VS;
reg clk,clk5;
always@(posedge CLOCK_50)
clk <= ~clk;
reg [31:0] counter;
always@(posedge clk)
if(counter == 50000) begin
counter <= 0;
clk5 <= ~clk5;
end else
counter <= counter + 1;
wire [9:0] x, y;
vga_sync (.iclk(clk), .oVGA_HS(VGA_HS), .oVGA_VS(VGA_VS), .oActive(display), .oX(x), .oY(y));

wire [3:0] ball;
reg [9:0] ballX, ballY;
assign ball = ((x>ballX) && (x<ballX+10) && (y>ballY) && (y<ballY+13))?4'b1111:4'b0;

wire [3:0] paddle;
reg [9:0] paddleX;
assign paddle = ((x>paddleX) && (x<paddleX+100) && (y>450) && (y<475))?4'b1111:4'b0;

always@(posedge clk5)
if(~KEY[0] && paddleX<540)
paddleX <= paddleX + 1;
else if (~KEY[1] && |paddleX)
paddleX <= paddleX - 1;

reg [1:0] v;
always@(posedge clk5) begin
ballX <= v[0]?ballX - 1:ballX + 1;
ballY <= v[1]?ballY - 1:ballY + 1;
end

reg bounceX, bounceY;
always@(posedge clk)
if(ballX == 0 && ~bounceX) begin
v[0] <= 0;
bounceX <= 1;
end else if(ballX >=623 && ~bounceX) begin //640-50 ballwidth
v[0] <= 1;
bounceX <= 1;
end else bounceX <= 0;
always@(posedge clk5)
if(ballY <=0 && ~bounceY) begin
v[1] <= 0;
bounceY <= 1;
end else if(ballY > 447 && ~bounceY && ballX>paddleX && ballX<paddleX+100) begin
v[1] <= 1;
bounceY <= 1;
end else if(ballY > 467 && ~bounceY) begin
v[1] <= 1;
bounceY <= 1;
end else bounceY <= 0;
assign VGA_R = display?{SW[8:6],1'b0}|ball|paddle:0;
assign VGA_G = display?{SW[5:3],1'b0}|ball|paddle:0;
assign VGA_B = display?{SW[2:0],1'b0}|ball|paddle:0;
endmodule
