module decoder4to16(w,En,y);
input [3:0]w;
input En;
output [15:0]y;

decoder3to8_for d1(w[2:0],(En&(~w[3])),y[7:0]);
decoder3to8_for d2(w[2:0],(En&(w[3])),y[15:8]);

endmodule