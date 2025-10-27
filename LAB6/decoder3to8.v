module decoder3to8(w,En,y);
input [2:0]w;
input En;
output [7:0]y;
decoder2to4 d1(w[1:0],(En&(~w[2])),y[3:0]);
decoder2to4 d2(w[1:0],(En&w[2]),y[7:4]);
endmodule