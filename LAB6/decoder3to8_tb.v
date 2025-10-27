`timescale 1ns/1ns
`include "decoder3to8.v"
`include "decoder2to4.v"

module decoder3to8_tb();
  reg [2:0] w;
  reg En;
  wire [7:0] y;

  // Instantiate DUT
  decoder3to8 dut(w, En, y);

  initial begin
    $dumpfile("decoder3to8_tb.vcd");
    $dumpvars(0, decoder3to8_tb);

    // Enable ON – cycle through all inputs
    En = 1;
    w = 3'b000; #20;
    w = 3'b001; #20;
    w = 3'b010; #20;
    w = 3'b011; #20;
    w = 3'b100; #20;
    w = 3'b101; #20;
    w = 3'b110; #20;
    w = 3'b111; #20;

    // Enable OFF – outputs should all go zero
    En = 0;
    w = 3'b000; #20;
    w = 3'b111; #20;

    $display("Test Complete");
    $finish;
  end
endmodule
