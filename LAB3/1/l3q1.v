module l3q1(A,B,C,D,f);
input A,B,C,D;
output f;
wire o1,o2,o3;
nand(b,B,B);
nand(d,D,D);
nand(o1,A,b);
nand(o2,C,d);
nand(o3,o1,o2);
nand(f,o3,o3);
endmodule
