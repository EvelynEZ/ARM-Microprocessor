// EE 469 Autumn 2016
// lab 4
// Ruolan Wei, Jiaqi Zhang

//bitslice.sv: calculate results. Based on value of cntrl, select output from 8to1 mux.
`timescale 1ns/10ps
module bitslice (cntrl, A, B, Cin, Cout, result);
	input logic [2:0] cntrl;
	input logic A, B, Cin;
	output logic Cout, result;
	wire add, subtract,AandB, AorB, AxorB;
	wire [7:0] in;
	
	assign in[7] = 1'bx;	      //111
	xor #5 I6 (in[6], A, B);	//110
	or #5 I5 (in[5], A, B);   //101
	and #5 I4 (in[4], A, B);  //100

	adderSubtractor I32 (.Cin(Cin), .Cout(Cout), .Sub(cntrl[0]), .A(A), .B(B), .S(in[3])); //011, 010
	assign in[2] = in[3];
	
	assign in[1] = 1'bx;			//001
	assign in[0] = B;          //000
	
	mux8_1 slice (.out(result), .i(in), .sel(cntrl));
	
endmodule 

