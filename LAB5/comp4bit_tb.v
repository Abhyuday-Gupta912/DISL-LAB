`timescale 1ns/1ns
`include "comp4bit.v"

module comp4bit_tb();
    reg [3:0] a, b;
    wire lt, gt, eq;

    comp4bit c1(a, b, lt, gt, eq);

    initial begin
        $dumpfile("comp4bit_tb.vcd");
        $dumpvars(0, comp4bit_tb);

        a=4'b0101; b=4'b0110; #10;
        a=4'b1001; b=4'b0110; #10;
        a=4'b1010; b=4'b1010; #10;

        $display("Comparator test complete");
    end
endmodule
