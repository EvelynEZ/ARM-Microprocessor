// EE 469 Autumn 2016
// lab 4
// Ruolan Wei, Jiaqi Zhang
// An adder/subtractor built with Full Adders. When sub = 1, compute A-B; when sub = 0, compute A+B.

`timescale 1ns/10ps
module adderSubtractor (Cin, Cout, Sub, A, B, S);
	input Cin, A, B, Sub;
	output Cout, S;
	wire Bi, notB;

	not #5 N (notB, B);	
	mux2_1 m (.out(Bi), .i1(notB), .i0(B), .sel(Sub));
	fullAdder add (.Cin(Cin), .Cout(Cout), .A(A), .B(Bi), .S(S));
endmodule

module fullAdder (Cin, Cout, A, B, S);
	input Cin, A, B;
	output Cout, S;
	wire AxorB, AandB, ABandC;
	xor #5 G1 (AxorB, A, B);
	and #5 G2 (AandB, A, B);
	xor #5 G3 (S, AxorB, Cin);
	and #5 G4 (ABandC,AxorB, Cin);
	or  #5 G5 (Cout, ABandC, AandB);
endmodule


module fullAdder_64 (A, B, S);
   input [63: 0] A, B;
	output [63:0] S;
	logic [63:0] Cout;
	
	fullAdder fulAdd (.Cin(1'b0), .Cout(Cout[0]), .A(A[0]), .B(B[0]), .S(S[0]));
	genvar i;
	generate 
		for ( i = 1; i< 64; i++) begin : eachs
			fullAdder eachFullAdder (.Cin(Cout[i - 1]), .Cout(Cout[i]), .A(A[i]), .B(B[i]), .S(S[i]));
		end
	endgenerate
	endmodule
