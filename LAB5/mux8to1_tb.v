`timescale 1ns/1ns
`include "mux8to1.v"

module mux8to1_tb();
    reg [7:0] w;
    reg [2:0] s;
    wire f;

    mux8to1 m(w, s, f);

    initial begin
        $dumpfile("mux8to1_tb.vcd");
        $dumpvars(0, mux8to1_tb);

        w=8'b11001010;
        s=3'b000; #10;
        s=3'b001; #10;
        s=3'b010; #10;
        s=3'b011; #10;
        s=3'b100; #10;
        s=3'b101; #10;
        s=3'b110; #10;
        s=3'b111; #10;

        $display("MUX 8:1 test complete");
    end
endmodule
