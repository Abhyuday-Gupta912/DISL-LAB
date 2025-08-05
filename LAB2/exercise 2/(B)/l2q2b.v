module l2q2b(A,B,C,D,f);
	input A,B,C,D;
	output f;
	assign f=(~A|B|C)&(~A|B|~D)&(A|~C|D)&(~B|C|D);
endmodule
