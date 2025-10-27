`timescale 1ns/1ns
`include "shiftreg_PL.v"

module shiftreg_PL_TB();
parameter N = 8;
reg clk, shift, load, Din;
reg [N-1:0] Pin;
wire [N-1:0] Dout;

shiftreg_PL #(N) uut (clk, shift, load, Din, Pin, Dout);

initial
begin
    clk = 0;
    forever #10 clk = ~clk;
end

initial
begin
    $dumpfile("shiftreg_PL_TB.vcd");
    $dumpvars(0, shiftreg_PL_TB);

    // Initial conditions
    shift = 0; load = 1; Pin = 8'b10101010; Din = 0;
    #20;  // Load parallel data

    shift = 0; load = 0; Din = 1;  // Shift left
    #20;
    Din = 0;
    #20;

    shift = 1; load = 0;  // No change
    #20;

    shift = 0; load = 1; Pin = 8'b11110000; // Load new data
    #20;

    $display("Simulation complete");
    #50 $finish;
end
endmodule
