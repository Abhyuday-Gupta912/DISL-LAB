
// File: d_ff.v
// Basic D-Flip Flop with asynchronous active-high reset

module d_ff (
    input wire D,        // Data input
    input wire clk,      // Clock input
    input wire reset,    // Asynchronous active-high reset
    output reg Q         // Output
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            Q <= 1'b0; // Reset to 0
        end else begin
            Q <= D;    // On clock edge, Q takes value of D
        end
    end

endmodule