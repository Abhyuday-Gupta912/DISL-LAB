module a1(A, B, C, D, F);
  input A, B, C, D;
  output F;
  nand(a, A, A); // A'
  nand(d, D, D); // D'
  assign o1=~(A&~B&~C)
  nand(o2, a, d); // (A'D')'
  nand(o3, B, d); // (BD')'
  nand(o4, C, d); // (CD')'
  assign o5= ~(o1&o2&o3&o4);
  nand(f,o5,o5);
  endmodule
