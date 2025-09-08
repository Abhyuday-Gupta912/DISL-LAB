module l1q1(f,a,b,c,d);
input a,b,c,d;
output f;
wire o1, o2, o3, o4, o5, o6, o7;
and(o1,a,b);
and(o2,a,b);
or(o3,o1,c);
or(o4,o2,c);
not(o5,o3);
and(o6,o5,d);
or(o7,d,o4);
and(f,o6,o7);
endmodule

