
// EE 469 Autumn 2016
// Lab 4
// Ruolan Wei, Jiaqi Zhang
// The ALU unit, performs the folling operations based on signals given and set flags.

`timescale 1ns/10ps
// Meaning of signals in and out of the ALU:
// Flags:
// negative: whether the result output is negative if interpreted as 2's comp.
// zero: whether the result output was a 64-bit zero.
// overflow: on an add or subtract, whether the computation overflowed if the inputs are interpreted as 2's comp.
// carry_out: on an add or subtract, whether the computation produced a carry-out.

// cntrl			Operation						Notes:
// 000:			result = B						value of overflow and carry_out unimportant
// 010:			result = A + B
// 011:			result = A - B
// 100:			result = bitwise A & B		value of overflow and carry_out unimportant
// 101:			result = bitwise A | B		value of overflow and carry_out unimportant
// 110:			result = bitwise A XOR B	value of overflow and carry_out unimportant
module alu(A, B, cntrl, result, negative, zero, overflow, carry_out);
	input logic [63:0] A, B;
	input logic [2:0] cntrl;
	output logic [63:0] result;
	output logic zero, overflow, carry_out, negative;
	
	wire [63:0] Cout;

	bitslice b0 (.cntrl(cntrl[2:0]), .A(A[0]), .B(B[0]), .Cin(cntrl[0]), .Cout(Cout[0]), .result(result[0]));

	genvar i;
	generate 
		for ( i = 1; i< 64; i++) begin : res
			bitslice b (.cntrl(cntrl[2:0]), .A(A[i]), .B(B[i]), .Cin(Cout[i-1]), .Cout(Cout[i]), .result(result[i]));
		end
	endgenerate
	testZero t1 (.in(result), .out(zero));
	assign negative = result[63];
	xor #5 G2 (overflow, Cout[62], Cout[63]);
	assign carry_out = Cout[63];
	
	
endmodule
