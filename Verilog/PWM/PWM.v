module PWM(oQ, iData, iClk);
output oQ;
input [9:0]iData;
input iClk;

reg [9:0]counter;

always@(posedge iClk)
	if(counter < 1024)
		counter <= counter + 1;
	else
		counter <= 0;

assign oQ = (counter < iData)?1:0;
		
endmodule
