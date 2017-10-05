module jkff_negedge(J,K,clock,Q,Qbar);
input J,K,clock;
output Q,Qbar;
reg Q,Qbar;
always @(negedge clock)
begin
	if({J,K}==0)
		begin
			Q=Q;
			Qbar=Qbar;
		end
	if({J,K}==1)
		begin
			Q=0;
			Qbar=1;
		end;
	 if({J,K}==2)
		begin
			Q=1;
			Qbar=0;
		end
	 if(J==1&&K==1)
		begin
			Q=~Q;
			Qbar=~Q;
		end
end
endmodule

module test_jk;
reg J,K,clock;
wire Q,Qbar;
jkff_negedge FF1(J,K,clock,Q,Qbar);
initial
	begin
		clock=0;J=0;K=0;
	end
always
	#10 clock=!clock;
initial
	begin
		#10 J=0;K=1;
		$display("\t\t\tCLK\tJ\tK\tQ\tQbar");
		$monitor($time,"\t%b\t%b\t%b\t%b\t%b",clock,J,K,Q,Qbar);
		#10 J=1;K=0;
		//$display("\t\t\tCLK\tJ\tK\tQ\tQbar");
		$monitor($time,"\t%b\t%b\t%b\t%b\t%b",clock,J,K,Q,Qbar);
		#10 J=0;K=0;
		//$display("\t\t\tCLK\tJ\tK\tQ\tQbar");
		$monitor($time,"\t%b\t%b\t%b\t%b\t%b",clock,J,K,Q,Qbar);
		#10 J=1;K=1;
		//$display("\t\t\tCLK\tJ\tK\tQ\tQbar");
		$monitor($time,"\t%b\t%b\t%b\t%b\t%b",clock,J,K,Q,Qbar);
	end
initial
	#100 $finish;
endmodule
