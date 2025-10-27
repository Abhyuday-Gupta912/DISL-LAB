module decoder4to16_al (
    input  [3:0] w,
    input        En,        
    output [15:0] y
);
    wire [3:0] en;  

    decoder2to4_al decMSB (
        .w(w[3:2]),
        .En(En),
        .y(en)      
    );
    
    decoder2to4_al dec0 (.w(w[1:0]), .En(~en[0]), .y(y[3:0]));
    decoder2to4_al dec1 (.w(w[1:0]), .En(~en[1]), .y(y[7:4]));
    decoder2to4_al dec2 (.w(w[1:0]), .En(~en[2]), .y(y[11:8]));
    decoder2to4_al dec3 (.w(w[1:0]), .En(~en[3]), .y(y[15:12]));
endmodule
