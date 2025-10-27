// File: q2_tb.v

`timescale 1ns/1ns

module q2_tb;
    
    reg clk, reset, x;
    wire [1:0] state;

    // Instantiate the Unit Under Test (UUT)
    q2 f (clk, reset, x, state);

    // Clock generation (100 MHz clock with a 10ns period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    // Stimulus generation
    initial begin
        // Initialize and setup waveform dumping
        $dumpfile("q2_tb.vcd");
        $dumpvars(0, q2_tb);

        // Apply reset
        reset = 1; x = 0; #12;
        
        // De-assert reset and provide inputs
        reset = 0; x = 0; #80;
        x = 1; #80;
        x = 0; #40;
        x = 1; #40;

        $finish; // End simulation
    end

endmodule