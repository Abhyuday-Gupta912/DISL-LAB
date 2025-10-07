`timescale 1ns/1ns
`include "regN.v"

module regN_TB();
parameter N = 8;
reg [N-1:0] I;
reg clk;
wire [N-1:0] A;

regN #(N) uut (I, clk, A);

initial
begin
	clk = 0;
	forever #10 clk = ~clk;
end

initial
begin
	$dumpfile("regN_TB.vcd");
	$dumpvars(0, regN_TB);

	I = 8'b10101010; #20;
	I = 8'b11110000; #20;
	I = 8'b00001111; #20;
	I = 8'b01010101; #20;

	$display("Simulation complete");
	#50 $finish;
end
endmodule
