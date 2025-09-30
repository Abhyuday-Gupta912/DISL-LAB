module decoder3to8_for(w,En,y);
input [2:0]w;
input En;
output reg [7:0]y;
integer k;
always @(*) begin
    for(k=0;k<8;k=k+1) begin
        if((w==k)&&(En==1))
            y[k]=1;
        else
            y[k]=0;
    end
end
endmodule
