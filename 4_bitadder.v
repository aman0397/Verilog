module add4(s,cy4,cy_in,x,y);
input [3:0]x;
input [3:0]y;
input cy_in;
output cy4;
output [3:0] s;
wire [2:0] cy_out;
add B0(s[0],cy_out[0],x[0],y[0],cy_in);
add B1(s[1],cy_out[1],x[1],y[1],cy_out[0]);
add B2(s[2],cy_out[2],x[2],y[2],cy_out[1]);
add B3(s[3],cy4,x[3],y[3],cy_out[2]);
endmodule

module add(sum,cy_out,a,b,cy_in);
input a,b,cy_in;
output sum,cy_out;
xor g1(sum,a,b,cy_in);
assign cy_out=((a&b)|(b&cy_in)|(cy_in&a));
endmodule

module test_add4;
reg [3:0] x,y;
reg cy_in;
wire [3:0] s;
wire cy_out;
add4 A(s,cy_out,cy_in,x,y);
initial
	begin
		$monitor($time,"\t%b\t%b",s,cy_out);
		#10 x=0000; y=0001; cy_in=0;
		#10 x=0010; y=0100; cy_in=0;
		#10 $finish;
	end
endmodule