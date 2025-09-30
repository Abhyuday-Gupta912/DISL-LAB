module test(A,B,C,D,f);
	input A,B,C,D;
	output f;
	assign f=(~A&~C&~B&~D)|(A&~C&~D)|(~B&C&~D)|(~A&B&C&D)|(B&~C&D);
endmodule
