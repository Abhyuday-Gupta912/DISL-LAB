// File: tb_johnson_counter_5bit.v
// Testbench for 5-bit Johnson Counter

`timescale 1ns/1ns

module tb_johnson_counter_5bit;

    // Testbench signals (inputs to the UUT)
    reg clk;
    reg reset;

    // Wires to observe the output of the UUT
    wire [4:0] Q_out;

    // Instantiate the Unit Under Test (UUT)
    johnson_counter_5bit uut (
        .clk(clk),
        .reset(reset),
        .Q(Q_out)
    );

    // Clock generation
    parameter CLK_PERIOD = 10; // 10ns period (100 MHz)
    initial begin
        clk = 1'b0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end

    // Test stimulus
    initial begin
        // Setup VCD file for waveform viewing
        $dumpfile("johnson_counter_5bit.vcd");
        $dumpvars(0, tb_johnson_counter_5bit);

        // 1. Initial Reset
        reset = 1'b1;
        # (CLK_PERIOD * 2); // Hold reset for a couple of clock periods

        // 2. De-assert Reset and start counting
        reset = 1'b0;
        $display("Time | Reset | Clock | Q_out");
        $display("------------------------------");

        // Run for more than 2N (10) states to see multiple cycles
        repeat (20) @(posedge clk) begin
            $display("%0tns | %b     | %b     | %b", $time, reset, clk, Q_out);
        end

        // 3. Finish simulation
        $display("------------------------------");
        $display("Simulation finished.");
        $finish;
    end

    // Monitor for changes (optional, but good for debugging)
    // initial begin
    //     $monitor("Time=%0tns, clk=%b, reset=%b, Q_out=%b", $time, clk, reset, Q_out);
    // end

endmodule

To run:
# 1. Compile all Verilog files
iverilog -o johnson_sim d_ff.v johnson_counter_5bit.v tb_johnson_counter_5bit.v

# 2. Run the simulation
vvp johnson_sim

# 3. View the waveforms
gtkwave johnson_counter_5bit.vcd