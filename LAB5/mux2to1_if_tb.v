`timescale 1ns/1ns
`include "mux2to1_if.v"

module mux2to1_if_tb();
    reg w0, w1, s;
    wire f;

    mux2to1_if m1(w0, w1, s, f);

    initial begin
        $dumpfile("mux2to1_if_tb.vcd");
        $dumpvars(0, mux2to1_if_tb);

        s=0; w0=0; w1=0; #10;
        s=0; w0=1; w1=0; #10;
        s=1; w0=0; w1=1; #10;
        s=1; w0=1; w1=1; #10;

        $display("MUX 2:1 test complete");
    end
endmodule
