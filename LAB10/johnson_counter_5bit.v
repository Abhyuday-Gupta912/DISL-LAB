// File: johnson_counter_5bit.v
// 5-bit Johnson Counter

module johnson_counter_5bit (
    input wire clk,      // Clock input
    input wire reset,    // Asynchronous active-high reset
    output wire [4:0] Q  // 5-bit output (Q4 Q3 Q2 Q1 Q0)
);

    // Internal wires for flip-flop outputs and inputs
    wire D0, D1, D2, D3, D4;
    wire Q0, Q1, Q2, Q3, Q4;

    // Connect the outputs to the main output port
    assign Q = {Q4, Q3, Q2, Q1, Q0};

    // Johnson counter feedback: Inverted output of the last FF (Q4) goes to the first FF (D0)
    assign D0 = ~Q4;

    // Shift register connections
    assign D1 = Q0;
    assign D2 = Q1;
    assign D3 = Q2;
    assign D4 = Q3;

    // Instantiate 5 D-Flip Flops
    d_ff ff0 (.D(D0), .clk(clk), .reset(reset), .Q(Q0));
    d_ff ff1 (.D(D1), .clk(clk), .reset(reset), .Q(Q1));
    d_ff ff2 (.D(D2), .clk(clk), .reset(reset), .Q(Q2));
    d_ff ff3 (.D(D3), .clk(clk), .reset(reset), .Q(Q3));
    d_ff ff4 (.D(D4), .clk(clk), .reset(reset), .Q(Q4));

endmodule