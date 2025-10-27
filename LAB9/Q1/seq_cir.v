// File: seq_cir.v

module seq_cir (E, x, clk, rst, Qa, Qb);
    input E, x, clk, rst;
    output Qa, Qb;

    wire Ja, Ka, Jb, Kb;
    wire t1, t2;

    // Combinational logic for FF inputs
    assign t1 = E & x & Qb;
    assign t2 = E & ~x & ~Qb;

    assign Ja = t1 | t2;
    assign Ka = t1 | t2;
    
    assign Jb = E;
    assign Kb = E;

    // Instantiating the flip-flops
    JK_FF ffa (Ja, Ka, clk, rst, Qa);
    JK_FF ffb (Jb, Kb, clk, rst, Qb);
    
endmodule