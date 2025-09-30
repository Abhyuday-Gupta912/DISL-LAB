`timescale 1ns/1ns
`include "decoder4to16_al.v"
`include "decoder2to4_al.v"


module decoder4to16_al_tb();
    reg [3:0] w;
    reg En;
    wire [15:0] y;

    decoder4to16_al uut (
        .w(w),
        .En(En),
        .y(y)
    );

    integer i;

    initial begin
        $dumpfile("decoder4to16_al_tb.vcd");
        $dumpvars(0, decoder4to16_al_tb);

        En = 1;
        for (i = 0; i < 16; i = i + 1) begin
            w = i;
            #10;
            $display("En=1, w=%b, y=%b", w, y);
        end

        En = 0;
        for (i = 0; i < 16; i = i + 1) begin
            w = i;
            #10;
            $display("En=0, w=%b, y=%b", w, y);
        end

        $display("Test Complete");
        $finish;
    end
endmodule
