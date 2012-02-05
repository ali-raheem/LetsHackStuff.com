module top (LEDR, SW, CLOCK_50);
output [9:0]LEDR;
input [9:0]SW;
input CLOCK_50;

PWM (.oQ(LEDR[0]), .iData(SW), .iClk(CLOCK_50));

endmodule
