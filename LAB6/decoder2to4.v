module decoder2to4(w, En, y);
  input [1:0] w;
  input En;
  output reg [3:0] y;

  always @(*) begin
    if (En)
      y = 4'b0001 << w;
    else
      y = 4'b0000;
  end
endmodule
