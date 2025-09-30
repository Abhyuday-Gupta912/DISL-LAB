module l3q4(A,B,C,D,f);
input A,B,C,D;
output f;
wire o1,o2,o3;
nand(d,D,D);
nand(o1,A,D);
nand(o2,B,d);
nand(o3,o1,o2);
nand(f,o3,o3);
endmodule
