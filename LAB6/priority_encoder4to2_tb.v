`timescale 1ns/1ns
`include "priority_encoder4to2.v"

module priority_encoder4to2_tb();

    reg [3:0] d;
    wire [1:0] y;
    wire valid;

    // Instantiate the priority encoder
    priority_encoder4to2 uut (
        .d(d),
        .y(y),
        .valid(valid)
    );

    integer i;

    initial begin
        $dumpfile("priority_encoder4to2_tb.vcd");
        $dumpvars(0, priority_encoder4to2_tb);

        // Test all 16 input combinations
        for (i = 0; i < 16; i = i + 1) begin
            d = i;
            #10; // wait 10ns for output to settle
            $display("d=%b, y=%b, valid=%b", d, y, valid);
        end

        $display("Test Complete");
        $finish;
    end

endmodule
