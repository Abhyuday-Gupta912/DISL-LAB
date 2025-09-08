`timescale 1ns/1ns
`include "addsub4.v"
`include "fulladd.v"

module tb3();
reg m,x3,x2,x1,x0,y3,y2,y1,y0;
wire s3,s2,s1,s0,carryout;

addsub4 dut(m,x3,x2,x1,x0,y3,y2,y1,y0,s3,s2,s1,s0,carryout);

initial begin
    $dumpfile("tb3.vcd");
    $dumpvars(0,tb3);

    m=0; x3=0;x2=1;x1=0;x0=1; y3=0;y2=0;y1=1;y0=1; #10;
    m=1; x3=0;x2=1;x1=0;x0=1; y3=0;y2=0;y1=1;y0=1; #10;
    m=0; x3=1;x2=1;x1=1;x0=1; y3=0;y2=0;y1=0;y0=1; #10;

    $display("Test complete");
end
endmodule
