module shiftreg6bit(Din, clk, Dout);
input Din, clk;
output [5:0]Dout;

wire [5:0]D;

dff s1(Din, clk, D[5]);
dff s2(D[5], clk, D[4]);
dff s3(D[4], clk, D[3]);
dff s4(D[3], clk, D[2]);
dff s5(D[2], clk, D[1]);
dff s6(D[1], clk, D[0]);

assign Dout = D;

endmodule

module dff (D, Clock, Q);
input D, Clock;
output Q;
reg Q;
always @(posedge Clock)
	Q <= D;
endmodule
