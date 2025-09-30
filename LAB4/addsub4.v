module addsub4(m,x3,x2,x1,x0,y3,y2,y1,y0,s3,s2,s1,s0,carryout);
input m,x3,x2,x1,x0,y3,y2,y1,y0;
output s3,s2,s1,s0,carryout;
wire c1,c2,c3,c4;
wire y0m,y1m,y2m,y3m;

assign y0m = y0 ^ m;
assign y1m = y1 ^ m;
assign y2m = y2 ^ m;
assign y3m = y3 ^ m;

fulladd f0(m,x0,y0m,s0,c1);
fulladd f1(c1,x1,y1m,s1,c2);
fulladd f2(c2,x2,y2m,s2,c3);
fulladd f3(c3,x3,y3m,s3,carryout);
endmodule
