// File: t_ff.v

module t_ff (input T, clk, reset, output reg Q);
    
    always @(posedge clk or posedge reset)
    begin
        if (reset)
            Q <= 1'b0;
        else if (T)
            Q <= ~Q; // Toggle
        else
            Q <= Q;  // Hold
    end

endmodule