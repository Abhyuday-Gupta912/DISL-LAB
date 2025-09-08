`timescale 1ns/1ns
`include "l1q2.v"

module l1q2_tb;
  reg a, b, c, d;  // Inputs
  wire f, g;       // Outputs

  // Instantiate the l1q2 module
  l1q2 uut (
    .a(a),
    .b(b),
    .c(c),
    .d(d),
    .f(f),
    .g(g)
  );

  // Testbench
  initial begin
    $dumpfile("l1q2_tb.vcd");  // VCD file for waveform
    $dumpvars(0, l1q2_tb);      // Dump variables for the simulation

    // Test all combinations of inputs
    a = 0; b = 0; c = 0; d = 0; #20;
    a = 0; b = 0; c = 0; d = 1; #20;
    a = 0; b = 0; c = 1; d = 0; #20;
    a = 0; b = 0; c = 1; d = 1; #20;
    a = 0; b = 1; c = 0; d = 0; #20;
    a = 0; b = 1; c = 0; d = 1; #20;
    a = 0; b = 1; c = 1; d = 0; #20;
    a = 0; b = 1; c = 1; d = 1; #20;
    a = 1; b = 0; c = 0; d = 0; #20;
    a = 1; b = 0; c = 0; d = 1; #20;
    a = 1; b = 0; c = 1; d = 0; #20;
    a = 1; b = 0; c = 1; d = 1; #20;
    a = 1; b = 1; c = 0; d = 0; #20;
    a = 1; b = 1; c = 0; d = 1; #20;
    a = 1; b = 1; c = 1; d = 0; #20;
    a = 1; b = 1; c = 1; d = 1; #20;

    $display("Test complete");
  end
endmodule

