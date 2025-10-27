module pos_JK_ff (J, K, Clock, Reset, Q);
    input J, K, Clock, Reset;
    output Q;
    reg Q;

    initial Q = 1'b0;

    always @(posedge Clock)
        if (Reset)
            Q <= 1'b0;
        else
            case ({J,K})
                2'b00: Q <= Q;
                2'b01: Q <= 1'b0;
                2'b10: Q <= 1'b1;
                2'b11: Q <= ~Q;
            endcase
endmodule
