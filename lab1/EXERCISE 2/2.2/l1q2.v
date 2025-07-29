module l1q2(a,b,c,d,f,g);
  input a,b,c,d;
  output f,g;
  wire o1;
 
  assign o1=~(a&b);
  assign f=(o1^(c^d));
  assign g=~(b|c|d);
endmodule

