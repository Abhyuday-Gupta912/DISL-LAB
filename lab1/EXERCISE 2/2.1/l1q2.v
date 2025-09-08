module l1q2(a,b,c,d,f,g);
  input a,b,c,d;
  output f,g;
  wire o1;
  
  nand(o1,a,b);    // NAND gate
  xor(f,o1,c,d);   // XOR gate
  nor(g,b,c,d);    // NOR gate
endmodule

