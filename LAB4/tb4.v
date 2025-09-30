`timescale 1ns/1ns
`include "mul2.v"
`include "halfadd.v"

module tb4();
reg a1,a0,b1,b0;
wire p3,p2,p1,p0;

mul2 dut(a1,a0,b1,b0,p3,p2,p1,p0);

initial begin
    $dumpfile("tb4.vcd");
    $dumpvars(0,tb4);

    a1=0;a0=0; b1=0;b0=0; #10;
    a1=0;a0=1; b1=1;b0=0; #10;
    a1=1;a0=1; b1=1;b0=1; #10;
    a1=1;a0=0; b1=0;b0=1; #10;

    $display("Test complete");
end
endmodule
