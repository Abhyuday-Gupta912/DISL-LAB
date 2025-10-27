`timescale 1ns/1ns
`include "pos_D.v" // Name of the Verilog design file

module pos_D_tb();
    // Inputs to the DUT are declared as reg
    reg D, Clock, Reset;
    // Output from the DUT is declared as wire
    wire Q;

    // Instantiation of the module
    pos_D f1(D, Clock, Reset, Q);

    // Clock generation block
    initial begin
        Clock = 0;
        // Generate a clock with a 40ns period
        forever #20 Clock = ~Clock;
    end

    // Stimulus block
    initial begin
        // Setup waveform dumping
        $dumpfile("pos_D_tb.vcd");
        $dumpvars(0, pos_D_tb);

        // Test sequence
        D = 1; Reset = 1; // Start with reset asserted
        #30;
        Reset = 0; // De-assert reset
        #20;
        D = 0;
        #40;
        D = 1;
        #40;
        Reset = 1; // Assert reset again asynchronously
        #30;
        Reset = 0;
        #20;
        
        $display("Test complete");
        $finish; // End the simulation
    end
endmodule
