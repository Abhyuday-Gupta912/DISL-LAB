`timescale 1ns/1ns
`include "mux16to1.v"
`include "mux4to1_cond.v"

module mux16to1_tb();
    reg [15:0] I;
    reg [3:0] s;
    wire f;

    mux16to1 dut(f, I, s);

    initial begin
        $dumpfile("mux16to1_tb.vcd");
        $dumpvars(0, mux16to1_tb);

        // Assign a unique value to each input for easy verification
        I = 16'hFEDCBA9876543210;

        // Test case 1: Select I[0]
        s = 4'b0000; #20;

        // Test case 2: Select I[5]
        s = 4'b0101; #20;

        // Test case 3: Select I[10]
        s = 4'b1010; #20;

        // Test case 4: Select I[15]
        s = 4'b1111; #20;

        // Test case 5: Select I[7]
        s = 4'b0111; #20;
        
        $display("Test complete");
        $finish;
    end
endmodule

