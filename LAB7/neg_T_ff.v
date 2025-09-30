module neg_T_ff (T, Clock, Resetn, Q);
    input T, Clock, Resetn;
    output Q;
    reg Q;

    initial Q = 1'b0;

    always @(negedge Clock or negedge Resetn)
        if (!Resetn)
            Q <= 1'b0;
        else if (T)
            Q <= ~Q;
endmodule
