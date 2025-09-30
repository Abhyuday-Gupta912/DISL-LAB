`timescale 1ns/1ns
`include "l3q1.v"

module l3q1_tb; // Add this line to define the testbench module
  reg A, B, C, D;    // Inputs
  wire f;             // Output
  l3q1 uut(A,B,C,D,f);

  // Testbench
  initial begin
    $dumpfile("l3q1_tb.vcd");  // VCD file for waveform
    $dumpvars(0, l3q1_tb);      // Dump variables for the simulation

    // Test all combinations of inputs
    A = 1'b0; B = 1'b0; C = 1'b0; D = 1'b0; #20;
    A = 1'b0; B = 1'b0; C = 1'b0; D = 1'b1; #20;
    A = 1'b0; B = 1'b0; C = 1'b1; D = 1'b0; #20;
    A = 1'b0; B = 1'b0; C = 1'b1; D = 1'b1; #20;
    A = 1'b0; B = 1'b1; C = 1'b0; D = 1'b0; #20;
    A = 1'b0; B = 1'b1; C = 1'b0; D = 1'b1; #20;
    A = 1'b0; B = 1'b1; C = 1'b1; D = 1'b0; #20;
    A = 1'b0; B = 1'b1; C = 1'b1; D = 1'b1; #20;
    A = 1'b1; B = 1'b0; C = 1'b0; D = 1'b0; #20;
    A = 1'b1; B = 1'b0; C = 1'b0; D = 1'b1; #20;
    A = 1'b1; B = 1'b0; C = 1'b1; D = 1'b0; #20;
    A = 1'b1; B = 1'b0; C = 1'b1; D = 1'b1; #20;
    A = 1'b1; B = 1'b1; C = 1'b0; D = 1'b0; #20;
    A = 1'b1; B = 1'b1; C = 1'b0; D = 1'b1; #20;
    A = 1'b1; B = 1'b1; C = 1'b1; D = 1'b0; #20;
    A = 1'b1; B = 1'b1; C = 1'b1; D = 1'b1; #20;

    // Display when the test is complete
    $display("Test complete");
  end
endmodule
