// File: tb_async_counter.v
// Testbench for the 4-bit asynchronous counter

`timescale 1ns/1ps

module tb_async_counter;

    // Testbench signals
    reg clk;
    reg reset;
    wire [3:0] Q_out;

    // Instantiate the Unit Under Test (UUT)
    async_counter_4bit uut (
        .clk(clk),
        .reset(reset),
        .Q(Q_out)
    );

    // Clock generation (100 MHz, 10ns period)
    parameter CLK_PERIOD = 10;
    initial begin
        clk = 1'b0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end

    // Stimulus
    initial begin
        // Setup waveform dumping
        $dumpfile("async_counter.vcd");
        $dumpvars(0, tb_async_counter);

        // Print header for console output
        $display("Time | Reset | Clock | Count (Dec) | Count (Bin)");
        $display("-----------------------------------------------------");

        // 1. Apply reset
        reset = 1'b1;
        #(CLK_PERIOD * 2);

        // 2. Release reset and start counting
        reset = 1'b0;

        // Run for 20 clock cycles to see it count 0-15 and wrap around
        repeat (20) @(negedge clk) begin
            // Display values just after the falling edge
            $display("%0tns |   %b   |   %b   |      %2d     |    %4b", 
                     $time, reset, clk, Q_out, Q_out);
        end
        
        // 3. Finish simulation
        $display("-----------------------------------------------------");
        $display("Simulation finished.");
        $finish;
    end

endmodule