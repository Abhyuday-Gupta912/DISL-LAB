module l1q1(f,a,b,c,d);
input a,b,c,d;
output f;
wire o1, o2, o3, o4, o5, o6, o7;

assign o1 = a & b;
assign o2 = a & b;
assign o3 = o1 | c;
assign o4 = o2 | c;
assign o5 = ~o3;
assign o6 = o5 & d;
assign o7 = d | o4;
assign f = o6 & o7;

endmodule

