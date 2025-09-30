`timescale 1ns/1ns
`include "halfadd.v"
`include "fulladd.v"

module tb1();
reg a,b,cin;
wire s1,c1,s2,c2;

halfadd h1(a,b,s1,c1);
fulladd f1(cin,a,b,s2,c2);

initial begin
    $dumpfile("tb1.vcd");
    $dumpvars(0,tb1);

    a=0;b=0;cin=0; #10;
    a=0;b=1;cin=1; #10;
    a=1;b=0;cin=0; #10;
    a=1;b=1;cin=1; #10;

    $display("Test complete");
end
endmodule
