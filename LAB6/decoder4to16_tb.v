`timescale 1ns/1ns
`include "decoder3to8_for.v"
`include "decoder4to16.v"

module decoder4to16_tb;
    reg [3:0] w;
    reg En;
    wire [15:0] y;

    // Instantiate DUT
    decoder4to16 uut(w, En, y);

    integer i, j;

    initial begin
        $dumpfile("decoder4to16_tb.vcd");
        $dumpvars(0, decoder4to16_tb);

        // Loop through all possible En and w combinations
        for (j = 0; j < 2; j = j + 1) begin  // En = 0,1
            En = j;
            for (i = 0; i < 16; i = i + 1) begin  // w = 0..15
                w = i;
                #10;  // small delay to observe output
                $display("Time=%0t | En=%b | w=%b (%0d) | y=%016b",
                          $time, En, w, w, y);
            end
        end

        $finish;
    end
endmodule
