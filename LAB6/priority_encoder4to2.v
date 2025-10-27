module priority_encoder4to2(
    input  [3:0] d,    // 4-bit input
    output reg [1:0] y, // 2-bit output
    output reg valid     
);

    always @(*) begin
        valid = |d; 

        casex(d)
            4'b1xxx: y = 2'b11; 
            4'b01xx: y = 2'b10; 
            4'b001x: y = 2'b01; 
            4'b0001: y = 2'b00; 
            default: y = 2'b00; 
        endcase
    end

endmodule
