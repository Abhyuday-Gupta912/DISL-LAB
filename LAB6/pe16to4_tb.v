`timescale 1ns/1ns
`include "pe16to4.v"

module pe16to4_tb();
    reg [15:0] d;
    wire [3:0] y;
    wire valid;
    pe16to4 uut (
        .d(d),
        .y(y),
        .valid(valid)
    );

    integer i;

    initial begin
        $dumpfile("pe16to4_tb.vcd");
        $dumpvars(0, pe16to4_tb);
        $display("Testing one-hot inputs (single 1 at a time):");
        for (i = 0; i < 16; i = i + 1) begin
            d = 16'b0;
            d[i] = 1'b1;
            #10;
            $display("d=%b, y=%b, valid=%b", d, y, valid);
        end

        $display("\nTesting multiple-bit inputs to verify priority:");

        d = 16'b0000_0000_0000_1010; 
        #10; $display("d=%b, y=%b, valid=%b", d, y, valid);

        d = 16'b1000_0000_0000_0011; 
        #10; $display("d=%b, y=%b, valid=%b", d, y, valid);

        d = 16'b0000_0000_0000_0000;
        #10; $display("d=%b, y=%b, valid=%b", d, y, valid);

        $display("\nTest Complete");
        $finish;
    end
endmodule
