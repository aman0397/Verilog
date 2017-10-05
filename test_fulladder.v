module main;
reg a, b, c;
wire sum, carry;
fulladder add_1(a,b,c,sum,carry);
always @(sum or carry)
begin
 $display("time=%d:%b + %b + %b = %b, carry =%b\n",$time,a,b,c,sum,carry);
end
initial
begin
 a = 0; b = 0; c = 0;
 #5
 a = 0; b = 1; c = 0;
 #5
 a = 1; b = 0; c = 1;
 #5
 a = 1; b = 1; c = 1;
end
endmodule 