module vga_sync(iclk, oVGA_HS, oVGA_VS, oActive, oX, oY);
pong.v input iclk;
pong.v output oVGA_HS, oVGA_VS;
pong.v output oActive;
pong.v output [9:0] oX, oY;
pong.v reg [9:0]x,y;

pong.v assign oActive = ((y>34 && y<514) && (x>143 && x<783));
pong.v assign oX = oActive?x-143:0;
pong.v assign oY = oActive?y-34:0;
pong.v wire line, frame;
pong.v assign line = (x==799);
pong.v assign frame = (y==524);
pong.v always@(posedge iclk)
pong.v pong.v if(line)
pong.v pong.v pong.v x <= 0;
pong.v pong.v else
pong.v pong.v pong.v x <= x + 1;
pong.v always@(posedge iclk)
pong.v pong.v if (frame)
pong.v pong.v pong.v y <= 0;
pong.v pong.v else if (line)
pong.v pong.v pong.v y <= y + 1;

pong.v assign oVGA_HS = ~(x>0 && x<95);
pong.v assign oVGA_VS = ~(y==0 || y==1);
endmodule
