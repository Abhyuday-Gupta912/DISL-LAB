module l3q2(A,B,C,D,f);
input A,B,C,D;
output f;
nor(d,D,D);
assign o1=~(A|C|d);
nor(o2,B,C);
nor(o3,B,D);
assign o4=~(o3|o2|o1);
nor(f,o4,o4);
endmodule
