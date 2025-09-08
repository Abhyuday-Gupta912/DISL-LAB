`timescale 1ns/1ns
`include "additional1.v"    //Name of the Verilog file
module additional1_tb();
reg a,b,c;		//Input
wire f1,f2;			//Output
additional1 ex2(f1,f2,a,b,c);	//Instantiation of the module
initial
begin
	$dumpfile("additional1_tb.vcd");
	$dumpvars(0, additional1_tb);
	a=1'b0; b=1'b0; c=1'b0;
	#20;
	a=1'b0; b=1'b0; c=1'b1;
	#20;
	a=1'b0; b=1'b1; c=1'b0;
	#20;
	a=1'b0; b=1'b1; c=1'b1;
	#20;
	a=1'b1; b=1'b0; c=1'b0;
	#20;
	a=1'b1; b=1'b0; c=1'b1;
	#20;
	a=1'b1; b=1'b1; c=1'b0;
	#20;
	a=1'b1; b=1'b1; c=1'b1;
	#20;
	$display("Test complete");
end
endmodule
