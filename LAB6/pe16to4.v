module pe16to4(
    input  [15:0] d,    
    output reg [3:0] y, 
    output reg valid    
);

    integer i;
    reg found;

    always @(*) begin
        valid = 0;
        y = 4'b0000;
        found = 0;
        for (i = 15; i >= 0; i = i - 1) begin
            if (!found && d[i]) begin
                y = i[3:0]; 
                valid = 1;
                found = 1;   
            end
        end
    end

endmodule
