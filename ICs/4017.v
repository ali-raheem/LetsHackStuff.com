module ic4017(clk, r, o, ce, co);
input clk,r,ce;
output co;
output reg [9:0]o;
initial o = 1;
always@(posedge clk)
begin
if(r) o <= 1;
else if (!ce) o <= (|(o<<1))?o<<1:1;
end
assign co = o<=16; //2^5
endmodule
