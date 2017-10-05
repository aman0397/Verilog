module priority_encoder(in,code);
input [0:3]in;
output [0:1]code;
reg [0:1]code;
always @(in)
	begin
		if(in[0]==1)
			code=00;
		else if(in[1])
			code=01;
		else if(in[2])
			code=10;
		else if(in[3])
			code=11;
	end
endmodule

module test_p_encoder;
	reg [0:3]in_p;
	wire [0:1]out_p;
	priority_encoder p1(in_p,out_p);
	initial
		begin
			$display("\t\t\t time\tinput\tcode");
			$monitor("\t",$time,"\t%b\t %b",in_p,out_p);
			#10 in_p=1000;
			#10 in_p=1010;
			#10 in_p=0100;
			#10 in_p=0010;
			#10 in_p=0110;
			#10 in_p=0001;
			#10 $finish;
		end
endmodule