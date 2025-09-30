module bcdadd(carryin,x3,x2,x1,x0,y3,y2,y1,y0,s3,s2,s1,s0,carryout);
input carryin,x3,x2,x1,x0,y3,y2,y1,y0;
output s3,s2,s1,s0,carryout;
wire z3,z2,z1,z0,c1;
wire w3,w2,w1,w0,c2;
wire cfix;

adder4 a1(carryin,x3,x2,x1,x0,y3,y2,y1,y0,z3,z2,z1,z0,c1);

assign cfix = c1 | (z3 & (z2 | z1));

adder4 a2(0, z3, z2, z1, z0, 0, cfix, cfix, 0, w3, w2, w1, w0, c2);

assign s3=w3; assign s2=w2; assign s1=w1; assign s0=w0;
assign carryout = c1 | c2;
endmodule
