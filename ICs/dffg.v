module d_ffg(clk, d, r, s, q, _q);
input clk,d,r,s;
output q,_q;

wire sr0, sr1, w0, w1, q, q_;
or (sr0, s, d);
and (sr1, sr0, ~r);
nand (w0, sr1, clk);
nand (w1, w0, clk);
nand (q, w0, _q);
nand (_q, w1, q);
endmodule
