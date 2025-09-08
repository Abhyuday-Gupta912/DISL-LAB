module mul2(a1,a0,b1,b0,p3,p2,p1,p0);
input a1,a0,b1,b0;
output p3,p2,p1,p0;
wire t1,t2,t3;

assign p0 = a0 & b0;
assign t1 = a1 & b0;
assign t2 = a0 & b1;

halfadd h1(t1,t2,p1,t3);
assign p2 = t3 ^ (a1 & b1);
assign p3 = t3 & (a1 & b1);
endmodule
