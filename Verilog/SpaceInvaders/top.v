module top(CLOCK_50, VGA_HS, VGA_VS, VGA_R, VGA_G, VGA_B, KEY, SW);
	input CLOCK_50;
	input [8:0] SW;
	input [3:0] KEY;
	output VGA_HS, VGA_VS;
	output [3:0] VGA_R, VGA_B, VGA_G;

//Generate clocks
	reg CLOCK_25, clk;
	always@(posedge CLOCK_50)
		CLOCK_25 <= ~CLOCK_25;
	reg [31:0]counter;
	always@(posedge CLOCK_50)
		if (counter == 50000) begin
			counter <= 0;
			clk <= ~clk;
		end else
			counter <= counter + 1;

//The ship draw
	wire [3:0] ship;
	reg [9:0] shipX;
	always@(posedge clk)
		if(~KEY[1] && |shipX)
			shipX <= shipX - 1;
		else if(~KEY[0] && shipX<615)
			shipX <= shipX + 1;
	assign ship = (x>shipX && x<shipX+25 && y>450 && y<460)?4'b1111:0;
//Draw a bullet
	reg [9:0] bulletX, bulletY;
	reg fire, hit;
	wire [3:0] bullet;
	always@(posedge clk)
		if(~KEY[2] && ~fire) begin
			bulletX <= shipX+12;
			fire <= 1;
		end else if(fire && bulletY>0)
			bulletY <= bulletY - 1;
		else begin
			fire <= 0;
			bulletY <= 450;
		end
	always@(posedge clk)
		if(bulletY>enemyY && bulletY < enemyY+25 && bulletX>enemyX && bulletX < enemyX+25)
			hit <= 1;
		else
			hit <= 0;
	assign bullet = (fire && y>bulletY && y<bulletY+25 && x>bulletX && x<bulletX+3)?4'b1111:0;
//The enemy
	wire [3:0] enemy;
	reg [9:0] enemyX, enemyY;
	reg enemyV, bounce;
	always@(posedge clk)
		enemyX <= enemyV?enemyX - 1:enemyX + 1;
	always@(posedge clk)
		if(enemyX == 0 && ~bounce) begin
			enemyV <= 0;
			bounce <= 1;
		end else if(enemyX == 615 && ~bounce) begin 
			enemyV <= 1;
			bounce <= 1;
		end else bounce <= 0;
	always@(posedge clk)
		if(hit) enemyY <= 0;
		else if(bounce) enemyY <= enemyY + 10;
		else if(enemyY>450)
				enemyY <= 0;
	assign enemy = (x>enemyX && x<enemyX+25 && y>enemyY && y<enemyY+25)?4'b1111:0;
//VGA syncroniser provides Active and x,y and display
	wire [9:0] x,y;
	vga_sync (.iClock(CLOCK_25), .oVGA_HS(VGA_HS), .oVGA_VS(VGA_VS), .oActive(Active), .oX(x), .oY(y));
	assign VGA_R = (Active)?{SW[8:6],1'b0}|ship|bullet|enemy:0;
	assign VGA_G = (Active)?{SW[5:3],1'b0}|ship|bullet|enemy:0;
	assign VGA_B = (Active)?{SW[2:0],1'b0}|ship|bullet|enemy:0;
endmodule
