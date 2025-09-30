`timescale 1ns/1ns
`include "neg_SR_ff.v"

module neg_SR_ff_tb();
    reg S, R, Clock, Resetn;
    wire Q;

    neg_SR_ff dut(S, R, Clock, Resetn, Q);

    initial begin
        Clock = 0;
        forever #20 Clock = ~Clock;
    end

    initial begin
        $dumpfile("neg_SR_ff_tb.vcd");
        $dumpvars(0, neg_SR_ff_tb);

        Resetn = 0; S = 1; R = 1;
        #45;
        Resetn = 1;

        S = 0; R = 0;
        #40;

        S = 1; R = 0;
        #40;
        
        S = 0; R = 0;
        #40;

        S = 0; R = 1;
        #40;

        S = 1; R = 1;
        #40;
        
        $display("Test complete");
        $finish;
    end
endmodule
