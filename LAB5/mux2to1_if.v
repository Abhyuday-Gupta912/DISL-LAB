module mux2to1_if(w0, w1, s, f);
    input w0, w1, s;
    output reg f;

    always @(*) begin
        if (s == 0)
            f = w0;
        else
            f = w1;
    end
endmodule
