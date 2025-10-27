module regN #(parameter N = 8) (I, clk, A);
input [N-1:0] I;
input clk;
output [N-1:0] A;

genvar i;
generate
	for (i = 0; i < N; i = i + 1)
	begin : register_bits
		dff d1 (I[i], clk, A[i]);
	end
endgenerate
endmodule


module dff (D, Clock, Q);
input D, Clock;
output Q;
reg Q;
always @(posedge Clock)
	Q <= D;
endmodule
