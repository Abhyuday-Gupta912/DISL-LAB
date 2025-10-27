// 4-to-1 Multiplexer using 2-to-1 mux
module mux4to1(w, s, f);
    input [3:0] w;
    input [1:0] s;
    output f;

    wire f1, f2;

    mux2to1_if m0(w[0], w[1], s[0], f1);
    mux2to1_if m1(w[2], w[3], s[0], f2);
    mux2to1_if m2(f1, f2, s[1], f);
endmodule
