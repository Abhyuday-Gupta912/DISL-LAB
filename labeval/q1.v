module q1(A,B,C,D,f);
	input A,B,C,D;
	output f;
	assign f=(~B&~D)|(~A&B&D)|(A&B&~C);
endmodule
