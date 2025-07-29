`timescale 1ns/1ns
`include "l1q1.v"    // Include your Verilog file

module l1q1_tb();
  reg a, b, c, d;   // Inputs
  wire f;            // Output

  // Instantiate the l1q1 module
  l1q1 uut (
    .a(a), 
    .b(b), 
    .c(c), 
    .d(d), 
    .f(f)
  );

  // Testbench
  initial begin
    $dumpfile("l1q1_tb.vcd");  // VCD file for waveform
    $dumpvars(0, l1q1_tb);      // Dump variables for the simulation

    // Test all combinations of inputs
    a = 1'b0; b = 1'b0; c = 1'b0; d = 1'b0; #20;
    a = 1'b0; b = 1'b0; c = 1'b0; d = 1'b1; #20;
    a = 1'b0; b = 1'b0; c = 1'b1; d = 1'b0; #20;
    a = 1'b0; b = 1'b0; c = 1'b1; d = 1'b1; #20;
    a = 1'b0; b = 1'b1; c = 1'b0; d = 1'b0; #20;
    a = 1'b0; b = 1'b1; c = 1'b0; d = 1'b1; #20;
    a = 1'b0; b = 1'b1; c = 1'b1; d = 1'b0; #20;
    a = 1'b0; b = 1'b1; c = 1'b1; d = 1'b1; #20;
    a = 1'b1; b = 1'b0; c = 1'b0; d = 1'b0; #20;
    a = 1'b1; b = 1'b0; c = 1'b0; d = 1'b1; #20;
    a = 1'b1; b = 1'b0; c = 1'b1; d = 1'b0; #20;
    a = 1'b1; b = 1'b0; c = 1'b1; d = 1'b1; #20;
    a = 1'b1; b = 1'b1; c = 1'b0; d = 1'b0; #20;
    a = 1'b1; b = 1'b1; c = 1'b0; d = 1'b1; #20;
    a = 1'b1; b = 1'b1; c = 1'b1; d = 1'b0; #20;
    a = 1'b1; b = 1'b1; c = 1'b1; d = 1'b1; #20;

    // Display when the test is complete
    $display("Test complete");
  end
endmodule

