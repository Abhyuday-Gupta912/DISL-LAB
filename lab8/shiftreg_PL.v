module shiftreg_PL #(parameter N = 8) (clk, shift, load, Din, Pin, Dout);
input clk, shift, load;
input Din;             // Serial input for shift left
input [N-1:0] Pin;     // Parallel input
output reg [N-1:0] Dout;

always @(posedge clk)
begin
    if (shift == 1'b1)                // No change
        Dout <= Dout;
    else if (load == 1'b1)            // Parallel load
        Dout <= Pin;
    else                              // Shift left
        Dout <= {Dout[N-2:0], Din};
end
endmodule
