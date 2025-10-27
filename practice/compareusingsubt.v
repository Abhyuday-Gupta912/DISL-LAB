// 4-bit Comparator using Subtractor
module comparator(A, B, lt, gt, eq);
    input [3:0] A, B;
    output lt, gt, eq;
    wire [3:0] Diff;

    subtractor sub1(A, B, Diff);

    assign eq = (A == B);
    assign gt = (A > B);
    assign lt = (A < B);
endmodule
