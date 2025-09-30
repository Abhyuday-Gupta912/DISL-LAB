`timescale 1ns/1ns
`include "mul3and2.v"
`include "halfadd.v"
`include "fulladd.v"


module mul3and2_tb;
    reg [2:0]a;
    reg [1:0]b;
    wire [4:0]p;
    mul3and2 uut(a,b,p);

initial begin
    $dumpfile("mul3and2_tb.vcd");
    $dumpvars(1,mul3and2_tb);
    a = 3'b000;
    b = 2'b00;
    $display ("test complete");
    end
endmodule