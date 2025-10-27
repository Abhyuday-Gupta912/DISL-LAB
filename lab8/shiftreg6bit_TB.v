`timescale 1ns/1ns
`include "shiftreg6bit.v"

module shiftreg6bit_TB();
reg Din, clk;
wire [5:0]Dout;

shiftreg6bit s1(Din, clk, Dout);

initial
begin
	clk = 0;
	forever #10 clk = ~clk;
end

initial
begin
	$dumpfile("shiftreg6bit_TB.vcd");
	$dumpvars(0, shiftreg6bit_TB);

	Din = 1; #20;
	Din = 0; #20;
	Din = 1; #20;
	Din = 1; #20;
	Din = 0; #20;
	Din = 1; #20;

	$display("Simulation Complete");
	#50 $finish;
end
endmodule
