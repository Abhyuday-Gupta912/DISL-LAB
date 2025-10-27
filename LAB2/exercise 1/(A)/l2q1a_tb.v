`timescale 1ns/1ns
`include "l2q1a.v"    // Include your Verilog file

module l2q1a_tb();
  reg A, B, C, D;   // Inputs
  wire f;            // Output

  // Instantiate the l1q1 module
  l2q1a uut(A,B,C,D,f);

  // Testbench
  initial begin
    $dumpfile("l2q1a_tb.vcd");  // VCD file for waveform
    $dumpvars(0, l2q1a_tb);      // Dump variables for the simulation

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

