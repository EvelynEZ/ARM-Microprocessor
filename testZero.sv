//EE 469 Autumn 2016
//Lab 4
//Ruolan Wei, Jiaqi Zhang
//Output 1 if all 64 bits of the input are 0s. Written as 72 - 27- 9 'or gates' in order to eliminate delay.
`timescale 1ns/10ps
module testZero (in, out);
	input logic [63:0]  in;
	output logic out;
	wire [2:0] finalOut;
	or24 O1 (.in(in[23:0]), .out(finalOut[0]));
	or24 O2 (.in(in[47:24]), .out(finalOut[1]));
	or24 O3 (.in({8'b0, in[63:48]}), .out(finalOut[2]));
	nor #5 o4 (out, finalOut[0], finalOut[1], finalOut[2]);
endmodule

module or24 (in, out);
	input logic [23:0] in;
	output logic out;
	wire [2:0] secondOut;
	or9 o5 (.in(in[8:0]), .out(secondOut[0]));
	or9 o6 (.in(in[17:9]), .out(secondOut[1]));
	or9 o7 (.in({2'b0, in[23:17]}), .out(secondOut[2]));
	or #5 o8 (out, secondOut[0], secondOut[1], secondOut[2]);
endmodule

module or9 (in, out);
	input logic [8:0] in;
	output logic out;
	wire [3:0] thirdOut;
	or #5 o9 (thirdOut[0], in[0], in[1], in[2]);
	or #5 o10 (thirdOut[1], in[3], in[4], in[5]);
	or #5 o11 (thirdOut[2], in[6], in[7], in[8]);
	or #5 o12 (out, thirdOut[0], thirdOut[1], thirdOut[2]);
endmodule
