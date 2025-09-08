module adder4(carryin,x3,x2,x1,x0,y3,y2,y1,y0,s3,s2,s1,s0,carryout);
input carryin,x3,x2,x1,x0,y3,y2,y1,y0;
output s3,s2,s1,s0,carryout;
wire c1,c2,c3;

fulladd f0(carryin,x0,y0,s0,c1);
fulladd f1(c1,x1,y1,s1,c2);
fulladd f2(c2,x2,y2,s2,c3);
fulladd f3(c3,x3,y3,s3,carryout);
endmodule
