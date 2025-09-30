module mul3and2(a,b,p);
input [2:0]a;
input [1:0]b;
output [4:0]p;
wire t1,t2,t3,t4,c1,c2;

assign t1=a[1]&b[0];
assign t2=a[0]&b[1];

assign t3=a[2]&b[0];

assign t4=a[1]&b[1];


assign p[0]=a[0]&b[0];
halfadd ha(t1,t2,p[1],c1);
fulladd fa(c1,t3,t4,p[2],c2);

assign p[3]=c2^(a[2]&b[1]);

assign p[4]=c2&(a[2]&b[1]);

endmodule
