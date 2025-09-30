module decoder2to4_al (
    input  [1:0] w,
    input        En,
    output reg [3:0] y
);
    always @(*) begin
        if (En) begin
            case (w)
                2'b00: y = 4'b1110; 
                2'b01: y = 4'b1101; 
                2'b10: y = 4'b1011; 
                2'b11: y = 4'b0111; 
                default: y = 4'b1111;
            endcase
        end else begin
            y = 4'b1111;  ss
        end
    end
endmodule
