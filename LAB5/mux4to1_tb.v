`timescale 1ns/1ns
`include "mux2to1_if.v"
`include "mux4to1.v"

module mux4to1_tb();
    reg [3:0] w;
    reg [1:0] s;
    wire f;

    mux4to1 m(w, s, f);

    initial begin
        $dumpfile("mux4to1_tb.vcd");
        $dumpvars(0, mux4to1_tb);

        w=4'b1010; s=2'b00; #10;
        w=4'b1010; s=2'b01; #10;
        w=4'b1010; s=2'b10; #10;
        w=4'b1010; s=2'b11; #10;

        $display("MUX 4:1 test complete");
    end
endmodule

