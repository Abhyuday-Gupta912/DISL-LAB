`timescale 1ns/1ns
`include "pos_JK_ff.v"

module pos_JK_ff_tb();
    reg J, K, Clock, Reset;
    wire Q;

    pos_JK_ff dut(J, K, Clock, Reset, Q);

    initial begin
        Clock = 0;
        forever #20 Clock = ~Clock;
    end

    initial begin
        $dumpfile("pos_JK_ff_tb.vcd");
        $dumpvars(0, pos_JK_ff_tb);

        Reset = 1; J = 1; K = 1;
        #45;
        Reset = 0;

        J = 0; K = 0;
        #40;

        J = 1; K = 0;
        #40;
        
        J = 0; K = 1;
        #40;

        J = 1; K = 1;
        #80;
        
        $display("Test complete");
        $finish;
    end
endmodule
