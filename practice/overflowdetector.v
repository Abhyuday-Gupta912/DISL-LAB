// 4-bit Adder with Overflow Detection
module adder_overflow(A, B, Sum, Overflow);
    input [3:0] A, B;
    output [3:0] Sum;
    output Overflow;
    wire c1, c2, c3, c4;

    full_adder fa0(A[0], B[0], 1'b0, Sum[0], c1);
    full_adder fa1(A[1], B[1], c1,   Sum[1], c2);
    full_adder fa2(A[2], B[2], c2,   Sum[2], c3);
    full_adder fa3(A[3], B[3], c3,   Sum[3], c4);

    assign Overflow = c3 ^ c4; // detect signed overflow
endmodule
