`timescale 1ns/1ns
`include "adder4.v"
`include "fulladd.v"

module tb2();
reg carryin,x3,x2,x1,x0,y3,y2,y1,y0;
wire s3,s2,s1,s0,carryout;

adder4 dut(carryin,x3,x2,x1,x0,y3,y2,y1,y0,s3,s2,s1,s0,carryout);

initial begin
    $dumpfile("tb2.vcd");
    $dumpvars(0,tb2);

    carryin=0; x3=0;x2=0;x1=0;x0=1; y3=0;y2=0;y1=0;y0=1; #10;
    carryin=0; x3=1;x2=0;x1=1;x0=1; y3=0;y2=1;y1=0;y0=0; #10;
    carryin=1; x3=1;x2=1;x1=0;x0=0; y3=0;y2=0;y1=1;y0=1; #10;

    $display("Test complete");
end
endmodule
