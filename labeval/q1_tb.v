`timescale 1ns/1ns
`include "q1.v"    // Include your Verilog file

module q1_tb();
  reg A, B, C, D;   // Inputs
  wire f;            // Output

  // Instantiate the l1q1 module
  q1 uut(A,B,C,D,f);

  // Testbench
  initial begin
    $dumpfile("q1_tb.vcd");  // VCD file for waveform
    $dumpvars(0, q1_tb);      // Dump variables for the simulation

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

