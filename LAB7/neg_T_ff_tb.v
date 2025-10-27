`timescale 1ns/1ns
`include "neg_T_ff.v"

module neg_T_ff_tb();
    reg T, Clock, Resetn;
    wire Q;

    neg_T_ff dut(T, Clock, Resetn, Q);

    initial begin
        Clock = 0;
        forever #20 Clock = ~Clock;
    end

    initial begin
        $dumpfile("neg_T_ff_tb.vcd");
        $dumpvars(0, neg_T_ff_tb);

        Resetn = 0; T = 1;
        #30;
        Resetn = 1;
        #20;
        
        T = 1;
        #80; 

        T = 0;
        #80;

        T = 1;
        #40;

        Resetn = 0;
        #30;
        Resetn = 1;
        #20;
        
        $display("Test complete");
        $finish;
    end
endmodule
