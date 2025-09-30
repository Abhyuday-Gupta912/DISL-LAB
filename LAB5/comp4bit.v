module comp4bit(a,b,lt,et,gt);
input [3:0]a,b;
output lt, et, gt;
assign lt=(a<b);
assign et=(a==b);
assign gt=(a>b);
endmodule
