<<<<<<< HEAD
`include "adder4.v"
`include "fulladd.v"
=======
>>>>>>> 4e14cbe5670a17618c3a80777d0ac37318682f46
module tb5;
reg cin,x3,x2,x1,x0,y3,y2,y1,y0;
wire s3,s2,s1,s0,cout;

bcdadd dut(cin,x3,x2,x1,x0,y3,y2,y1,y0,s3,s2,s1,s0,cout);

initial begin
  $dumpfile("tb5.vcd");
  $dumpvars(0,tb5);

  cin=0;

  // Example testcases: BCD(5)+BCD(4)=BCD(9)
  {x3,x2,x1,x0} = 4'b0101; {y3,y2,y1,y0} = 4'b0100; #10;

  // Example testcases: BCD(7)+BCD(6)=13 -> output=0011 carry=1
  {x3,x2,x1,x0} = 4'b0111; {y3,y2,y1,y0} = 4'b0110; #10;

  // Example testcases: BCD(9)+BCD(9)=18 -> output=1000 carry=1
  {x3,x2,x1,x0} = 4'b1001; {y3,y2,y1,y0} = 4'b1001; #10;

  // Example testcases: BCD(2)+BCD(3)=5
  {x3,x2,x1,x0} = 4'b0010; {y3,y2,y1,y0} = 4'b0011; #10;

  $finish;
end
endmodule
