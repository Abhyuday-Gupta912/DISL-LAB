module pos_D (D, Clock, Reset, Q);
    input D, Clock, Reset;
    output Q;
    reg Q;

    always @(posedge Clock or posedge Reset)
        if (Reset)
            Q <= 1'b0;
        else
            Q <= D;
endmodule

