module ALU_4bit(f,a,b,op);
input [2:0]op;
input [3:0]a,b;
output [3:0]f;
reg [3:0]f;
always @(a or b or op)
	case(op)
		0:f=a+b;
		1:f=a-b;
		2:f=a*b;
		3:f=a/b;
		4:f=a&b;
		5:f=a|b;
		6:f=a^b;
		7:f=~a;
	endcase
endmodule

module test_ALU;
reg [3:0] a,b;
reg [2:0] op;
wire [3:0]f;
ALU_4bit I1(f,a,b,op);
initial 
	begin
		$display("\t\t\tA\tB\tOP\toutput");
		$monitor($time,"\t%b\t%b\t%b\t%b",a,b,op,f);
		#10 a=0011;b=1010;op=000;
		#10 a=1000;b=0100;op=001;
		#10 a=0100;b=0010;op=010;
		#10 a=1000;b=0001;op=011;
		#10 a=1101;b=1100;op=100;
		#10 a=1101;b=0011;op=101;
		#10 a=1001;b=1010;op=110;
		#10 a=1001;b=1111;op=111;
		#10 $finish;
	end
endmodule