// 4-bit 2's Complement using Adder
module twos_complement(input [3:0] A, output [3:0] Y);

    wire [3:0] notA;
    wire c1, c2, c3, c4;

    // Step 1: Take bitwise NOT
    assign notA = ~A;

    // Step 2: Add 1 using ripple-carry adder
    full_adder fa0(notA[0], 1'b1, 1'b0, Y[0], c1);
    full_adder fa1(notA[1], 1'b0, c1,   Y[1], c2);
    full_adder fa2(notA[2], 1'b0, c2,   Y[2], c3);
    full_adder fa3(notA[3], 1'b0, c3,   Y[3], c4);

endmodule

// 1-bit Full Adder
module full_adder(input a, b, cin, output sum, cout);
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (a & cin) | (b & cin);
endmodule

`timescale 1ns/1ns
`include "twos_complement.v"

module twos_complement_tb();
    reg [3:0] A;
    wire [3:0] Y;

    twos_complement tc(A, Y);

    initial begin
        $dumpfile("twos_complement_tb.vcd");
        $dumpvars(0, twos_complement_tb);

        A = 4'b0000; #10; // 0 → 0
        A = 4'b0001; #10; // 1 → 1111 (-1)
        A = 4'b0010; #10; // 2 → 1110 (-2)
        A = 4'b0101; #10; // 5 → 1011 (-5)
        A = 4'b1111; #10; // -1 (1111) → 0001

        $display("2's complement test complete");
        $finish;
    end
endmodule
