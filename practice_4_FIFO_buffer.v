module fifo_buffer(x,insert,delete,y,input_ready,output_ready,clk);
input [3:0]x;
input insert,delete,clk;
output [3:0]y;
output input_ready,output_ready;
wire [3:0]a;
wire [3:0]b;
wire [3:0]c;
reg f1_bar_1=1;
wire c1,c2,c3,c4,f1,f1bar,f2,f2bar,f3,f3bar,f4,f4bar;
wire temp=(~delete);
shift_register A(x,c1,a);
shift_register B(a,c2,b);
shift_register C(b,c3,c);
shift_register D(c,c4,y);
sr_ff F1(c1,c2,clk,f1,f1bar);
sr_ff F2(c2,c3,clk,f2,f2bar);
sr_ff F3(c3,c4,clk,f3,f3bar);
sr_ff F4(c4,delete,clk,output_ready,f4bar);
and g1(c1,insert,f1_bar_1);
assign input_ready=f1bar;
and g2(c2,f1,f2bar);
and g3(c3,f2,f3bar);
and g4(c4,f3,temp,f4bar);
endmodule

module shift_register(in,clk,out);
input [3:0]in;
input clk;
output [3:0]out;
wire [3:0]in;
reg [3:0]out;
always @(posedge clk)
	begin
		 out<=in;
	end
endmodule

module sr_ff(S,R,clk,Q,Qbar);
input S,R,clk;
output Q,Qbar;
reg Q,Qbar;
always @(posedge clk)
begin
if(S==1&&R==0)
	begin
		Q=1'b1;
		Qbar=1'b0;
	end
else if(S==0&&R==1)
	begin
		Q=0;
		Qbar=1;
	end
else
	begin
		Q=Q;
		Qbar=Qbar;
	end
end
endmodule

module test_buffer;
reg [3:0]x;
reg insert,delete,clk;
wire [3:0]y;
wire input_ready,output_ready;
fifo_buffer B1(x,insert,delete,y,input_ready,output_ready,clk);
initial
clk=0;
always
#5 clk=!clk; 
initial
begin
insert=1;
delete=0;
end
initial
	begin
		$display("\ttime\tx\tinsert\tdelete\ty\tinput ready\toutput ready");
		$monitor($time,"\t%b\t%b\t%b\t%b\t%b\t%b",x,insert,delete,y,input_ready,output_ready);
		#10 x=4'b1010;insert=1;delete=0;
		#10 x=4'b0110;insert=1;delete=1;
		#10 $finish;
	end
endmodule
/*module test_register;
reg [3:0]in;
reg clk;
wire [3:0]out;
shift_register S1(in,clk,out);
initial
	clk=0;
always
#10 clk=!clk;
initial
	begin
		$monitor($time,"\t%b\t%b",in,out);
		#10 in=4'b0101;
		#20 in=1101;
		#400 $finish;
	end
endmodule*/

/*module test_ff;
reg S,R,clk;
wire Q,Qbar;
sr_ff FF(S,R,clk,Q,Qbar);
initial
clk=0;
always
#10 clk=!clk;
initial 
begin
	$monitor($time,"\t%b\t%b\t%b\t%b\t%b",S,R,clk,Q,Qbar);
	#10 S=0;R=1;
	#10 S=1;R=0;
	#10 $finish;
end
endmodule*/