module add1(A,B,C,D,f);
	input A,B,C,D;
	output f;
	assign f=(A|~B|C|~D)&(~A|D)&(~C|D)
endmodule
