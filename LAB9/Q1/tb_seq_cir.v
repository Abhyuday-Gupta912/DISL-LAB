// File: tb_seq_cir.v

`timescale 1ns/1ps

module Q1_tb;

    // Inputs
    reg E, x, clk, rst;

    // Outputs
    wire Qa, Qb;
    wire [1:0] state;

    // Connect state wires to FF outputs for easier waveform viewing
    assign state = {Qa, Qb};

    // Instantiate the Unit Under Test (UUT)
    seq_cir circ (E, x, clk, rst, Qa, Qb);

    parameter period = 10;

    // Clock generation
    initial begin
        clk = 1'b0;
        forever #(period/2) clk = ~clk;
    end

    // Stimulus generation
    initial begin
        // Initialize and dump signals for waveform viewer
        $dumpfile("Q1_tb.vcd");
        $dumpvars(0, Q1_tb);

        // Apply reset
        E = 0; x = 0; rst = 1'b1;
        #(period * 2);

        // De-assert reset and start stimulus
        rst = 1'b0;
        E = 0; x = 1;
        repeat (2) @(posedge clk);

        E = 1; x = 1;
        repeat (4) @(posedge clk);

        E = 1; x = 0;
        repeat (4) @(posedge clk);

        $finish; // End simulation
    end
    
endmodule