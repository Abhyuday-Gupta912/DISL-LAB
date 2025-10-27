module mux16to1(f, I, s);
    output f;
    input [15:0] I;
    input [3:0] s;
    
    wire w0, w1, w2, w3;

    // First stage of multiplexers
    mux4to1_cond m0(w0, I[0], I[1], I[2], I[3], s[1:0]);
    mux4to1_cond m1(w1, I[4], I[5], I[6], I[7], s[1:0]);
    mux4to1_cond m2(w2, I[8], I[9], I[10], I[11], s[1:0]);
    mux4to1_cond m3(w3, I[12], I[13], I[14], I[15], s[1:0]);

    // Final stage multiplexer
    mux4to1_cond m4(f, w0, w1, w2, w3, s[3:2]);
endmodule

