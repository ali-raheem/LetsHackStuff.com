module pong(CLOCK_50, VGA_R, VGA_G, VGA_B, VGA_HS, VGA_VS, SW, KEY, HEX3, HEX2, HEX1, HEX0);
	input CLOCK_50;
	output [0:6] HEX3, HEX2, HEX1, HEX0;
	input [9:0] SW;
	input [3:0] KEY;
	output [3:0] VGA_R, VGA_G, VGA_B;
	output VGA_HS, VGA_VS;
//Generate 25MHz clock for TV
	reg clk,clk5;
	always@(posedge CLOCK_50)
		clk <= ~clk;
//Very slow clock for movement originally intended to be 5Hz but I just changed it until it looked good on screen
	reg [31:0] counter;
	always@(posedge clk)
		if(counter == 50000) begin
			counter <= 0;
			clk5 <= ~clk5;
		end else
			counter <= counter + 1;
//Syncs with the monitor and provides us with x,y and when the display is active
	wire [9:0] x, y;
	vga_sync (.iclk(clk), .oVGA_HS(VGA_HS), .oVGA_VS(VGA_VS), .oActive(display), .oX(x), .oY(y));
//The ball it's actually a square 10:13 cause ratio is funny	
	wire [3:0] ball;
	reg [9:0] ballX, ballY;
//	assign ball = ((x>ballX) && (x<ballX+10) && (y>ballY) && (y<ballY+13))?4'b1111:4'b0;
	assign ball = ((x-ballX)**2 + (y-ballY)**2 < 36)?4'b1111:4'b0;

//Player one paddle
	wire [3:0] paddle;
	reg [9:0] paddleY;
	assign paddle = ((y>paddleY) && (y<paddleY+50) && (x>10) && (x<25))?4'b1111:4'b0;
	always@(posedge clk5)
		if(~KEY[2] && paddleY<430)
			paddleY <= paddleY + 1;
		else if (~KEY[3] && |paddleY)
			paddleY <= paddleY - 1;
//Player two paddle	
	wire [3:0] paddle1;
	reg [9:0] paddleY1;
	assign paddle1 = ((y>paddleY1) && (y<paddleY1+50) && (x>615) && (x<630))?4'b1111:4'b0;		
	always@(posedge clk5)
		if(~KEY[0] && paddleY1<430)
			paddleY1 <= paddleY1 + 1;
		else if (~KEY[1] && |paddleY1)
			paddleY1 <= paddleY1 - 1;
//v = velocity determines movment in x/y fliped in a bounce
	reg [1:0] v;
	always@(posedge clk5)
		if(~miss) begin
			ballX <= v[0]?ballX - 1:ballX + 1;
			ballY <= v[1]?ballY - 1:ballY + 1;
		end else if (SW[9])begin
			ballX <= 320;
			ballY <= 240;
		end
//Detect bounce and sound a miss
	reg bounceX, bounceY, miss;
	always@(posedge CLOCK_50)
		if(ballY == 0 && ~bounceY) begin
			v[1] <= 0;
			bounceY <= 1;
		end else if(ballY >=467 && ~bounceY) begin
			v[1] <= 1;
			bounceY <= 1;
		end else bounceY <= 0;
	reg [3:0] score, score1;
	always@(posedge clk5)
		if(ballX < 25 && ~bounceX && ballY+13>paddleY && ballY<paddleY+50) begin
			v[0] <= 0;
			bounceX <= 1;
		end else if(ballX > 615 && ~bounceX && ballY+13>paddleY1 && ballY<paddleY1+50) begin
			v[0] <= 1;
			bounceX <= 1;
		end else if(ballX > 630 && ~bounceX) begin
			v[0] <= 1;
			bounceX <= 1;
			miss <= 1;
			score1 <= score1 + 1;
		end else if(ballX < 2 && ~bounceX) begin
			v[0] <= 0;
			bounceX <= 1;
			miss <= 1;
			score <= score + 1;
		end else begin
			bounceX <= 0;
			miss <= 0;
		end
//central white line could also make border with this.
	wire [3:0] line;
	assign line = (x>318 && x<322 && y>10 && y<470)?4'b1111:4'b0;
//Display score on 7 seg	
	wire [7:0] wscore, wscore1;
	bcd (.in(score), .out(wscore));
	bcd (.in(score1), .out(wscore1));
	b2seg (.in(wscore[7:4]), .out(HEX3));
	b2seg (.in(wscore[3:0]), .out(HEX2));
	b2seg (.in(wscore1[7:4]), .out(HEX1));
	b2seg (.in(wscore1[3:0]), .out(HEX0));
//Send VGA signals white = 1111 which always wins in |	
	assign VGA_R = display?{SW[8:6],1'b0}|line|ball|paddle|paddle1:0;
	assign VGA_G = display?{SW[5:3],1'b0}|line|ball|paddle|paddle1:0;
	assign VGA_B = display?{SW[2:0],1'b0}|line|ball|paddle|paddle1:0;
//Not needed but makes it a little nicer
	initial begin
		ballX = 320;
		ballY = 240;
		paddleY = 215;
		paddleY1 = 215;
	end
endmodule
