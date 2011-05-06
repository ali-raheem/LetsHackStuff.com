module d_ff(clk, d, r, s, q, _q);
4017.v input clk,d,r,s;
4017.v output q,_q;
4017.v reg q;
4017.v 
4017.v always@(posedge clk) begin
4017.v 4017.v if(r) q <= 0;
4017.v 4017.v else if (s) q<= 1;
4017.v 4017.v else q <= d;
4017.v end
4017.v assign _q = ~q;
endmodule
