// File: q2.v

module q2 (input clk, reset, x, output [1:0] state);
    
    wire A, B;
    wire TA, TB;

    // Aliases for state bits
    assign A = state[1];
    assign B = state[0];

    // Combinational logic for T-inputs
    assign TA = (~A & B) | (~x & B);
    assign TB = (~B & ~x) | (x & A) | (~A & B & x);

    // Flip-Flop instantiations
    t_ff tfa (TA, clk, reset, state[1]);
    t_ff tfb (TB, clk, reset, state[0]);

endmodule