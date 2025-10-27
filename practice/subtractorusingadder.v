// 4-bit Subtractor using Adder
module subtractor(A, B, Diff);
    input [3:0] A, B;
    output [3:0] Diff;
    wire [3:0] notB;
    wire c1, c2, c3, c4;

    assign notB = ~B; // take 1's complement of B

    full_adder fa0(A[0], notB[0], 1'b1, Diff[0], c1); // add +1 here
    full_adder fa1(A[1], notB[1], c1, Diff[1], c2);
    full_adder fa2(A[2], notB[2], c2, Diff[2], c3);
    full_adder fa3(A[3], notB[3], c3, Diff[3], c4);
endmodule

// 1-bit full adder
module full_adder(input a, b, cin, output sum, cout);
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (a & cin) | (b & cin);
endmodule
