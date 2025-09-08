module l3q3(A,B,C,D,f);
input A,B,C,D;
output f;
nor(d,D,D);
nor(o1,A,d);
nor(o2,C,d);
nor(o3,o2,o1);
nor(f,o3,o3);
endmodule
