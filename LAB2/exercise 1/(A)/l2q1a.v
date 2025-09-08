module l2q1a(A,B,C,D,f);
	input A,B,C,D;
	output f;
	assign f=(~A&B)|(~B&C)|(C&D)|(B&(~C)&(~D));
endmodule	
