module neg_SR_ff (S, R, Clock, Resetn, Q);
    input S, R, Clock, Resetn;
    output Q;
    reg Q;

    initial Q = 1'b0;

    always @(negedge Clock)
        if (!Resetn)
            Q <= 1'b0;
        else
            case ({S,R})
                2'b00: Q <= Q;
                2'b01: Q <= 1'b0;
                2'b10: Q <= 1'b1;
                2'b11: Q <= 1'bx; // Invalid state
            endcase
endmodule
