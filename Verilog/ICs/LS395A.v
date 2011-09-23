module icLS395A(iClk, iClr, iOC, iLDSH, iSER, iData, oData, oCarry);
input iClk;
input iClr;
input iOC;
input iLDSH;
input iSER;
input [3:0] iData;
output [3:0] oData;
output oCarry;

reg [3:0] Data;

always@(negedge iClk) begin
	if(iClr)
		Data <= 4'b0000;
	else if(iLDSH)
		Data <= iData;
	else begin
		Data <= Data<<1;
		Data[0] <= iSER;
	end
end
assign oData = iOC? 4'bzzzz : Data;
assign oCarry = Data[3];
endmodule

