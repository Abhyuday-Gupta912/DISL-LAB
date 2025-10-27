// File: t_ff_negedge.v
// A negative-edge-triggered T-Flip Flop with active-high async reset.

module t_ff_negedge (
    input wire T,      // Toggle input
    input wire clk,    // Clock input
    input wire reset,  // Asynchronous reset
    output reg Q       // Output
);

    // This always block is sensitive to the clock's FALLING edge
    // or the reset's RISING edge.
    always @(negedge clk or posedge reset) begin
        if (reset) begin
            Q <= 1'b0; // Reset the flip-flop
        end 
        else if (T) begin
            Q <= ~Q;   // Toggle the output if T is high
        end
        // If T is low, Q holds its previous value (implicit)
    end

endmodule