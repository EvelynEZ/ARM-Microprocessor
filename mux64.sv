//EE 469 Autumn 2016
//Lab 4
//Ruolan Wei, Jiaqi Zhang

// mux64: A 32:1 Multuplexer, each input is 64 bits. Output is one 64-bit data.
`timescale 1ns/10ps
module mux64 (DataIn, DataOut, select, clk);
	input [31:0][63:0] DataIn ;
	input [4:0] select;
	input clk;
	output [63:0] DataOut;
	
	logic [63:0][31:0] Flipped; //The 2D array with column and rows flipped for later use. 
	flip F (.dataIn(DataIn),.dataOut(Flipped));
   
	//The 32:1 mux is called 64 times in order to pass 64 bits.
   genvar i;
	generate
	for (i = 0; i < 64; i = i+1) 
	begin : muxs

		mux32_1 M (.data_in(Flipped[i]), .data_out(DataOut[i]), .select(select));

   end
	endgenerate
	
endmodule

//Get the transpose of a 32*64 2D array. Result is a 64*32 2D array. 
module flip(dataIn, dataOut);
	
   input logic [31:0] [63:0] dataIn;
	output logic [63:0] [31:0] dataOut;
	
	always @(*) begin
		for (int i = 0; i < 64; i = i+1) begin
			 for (int j = 0; j < 32; j = j+1)begin 
				 dataOut[i][j] <= dataIn[j][i];
			 end
		end
	end

endmodule

//32:1 MUX, chooses one bits from 32 one bit datas based on a 5bit selector.
//Built with two 16:1 mux and one 2to1 mux.
module mux32_1 (data_in, data_out, select);
	output data_out;
	input [31:0] data_in;
	input [4:0] select;

	wire [1:0] w;
	mux16_1 m1 (.out(w[1]), .in(data_in[31:16]), .selector(select[3:0]));
	mux16_1 m2 (.out(w[0]), .in(data_in[15:0]), .selector(select[3:0]));

	mux2_1 m (.out(data_out), .i1(w[1]), .i0(w[0]), .sel(select[4]));

endmodule 


//16:1 mux, chooses one bit from 16 one bit datas based on a 4 bit selector.
//Built with five 5:1 mux.
module mux16_1(out, in, selector);
  output  out;
  input  [15:0] in;
  input  [3:0] selector;
 
  wire [3:0] w;
  
  mux4_1 m3 (.out(w[3]), .i(in[15:12]), .sel(selector[1:0]));
  mux4_1 m2 (.out(w[2]), .i(in[11:8]), .sel(selector[1:0]));
  mux4_1 m1 (.out(w[1]), .i(in[7:4]), .sel(selector[1:0]));
  mux4_1 m0 (.out(w[0]), .i(in[3:0]), .sel(selector[1:0]));
  mux4_1 m (.out, .i(w), .sel(selector[3:2]));
  
endmodule
// 8:1 mux, output one 1 bit data, input 8 one bit datas, 3 bit selector.
// Built with two 4to1 mux and one 2to1 mux. 
module mux8_1 (out, i, sel);
	output logic out;
	input logic [7:0] i;
	input logic [2:0] sel;
	wire v2, v3;
	
	mux4_1 m1 (.out(v2), .i(i[3:0]), .sel(sel[1:0]));
	mux4_1 m0 (.out(v3), .i(i[7:4]), .sel(sel[1:0]));
	
	mux2_1 m (.out(out), .i1(v3), .i0(v2), .sel(sel[2]));
	
endmodule

//4:1 mux, output one 1 bit data, input 4 one bit datas, 2 bit selector.
//Built with three 2to1 mux. 
module mux4_1(out, i, sel);
 output logic out;
 input logic [3:0]i;
 input logic [1:0]sel;

 wire v0, v1;

 mux2_1 m1(.out(v1), .i1(i[3]), .i0(i[2]), .sel(sel[0]));
 mux2_1 m0(.out(v0), .i1(i[1]), .i0(i[0]), .sel(sel[0]));
 
 mux2_1 m (.out(out), .i1(v1), .i0(v0), .sel(sel[1]));
endmodule


//2:1 mux, chooses one 1 bit data from two 1bit datas. 1 bit selector. 
module mux2_1(out, i1, i0, sel);
  output logic out;
  input logic i0, i1, sel;

  wire selnot;
  wire temp1, temp2;
  not #5 Q0  (selnot, sel);
  and #5 Q1  (temp1, sel, i1);
  and #5 Q2  (temp2, selnot, i0);
  or  #5 Q3  (out, temp1, temp2);
endmodule

//5 bit input, 2to1 mux
module mux_5(DataIn1, DataIn0, DataOut, Select);
	input Select;
	input[4:0] DataIn1, DataIn0;
	output logic [4:0] DataOut;

	genvar i;
	generate
	for (i = 0; i < 5; i++) begin: eachIn
		mux2_1 M (.out(DataOut[i]), .i1(DataIn1[i]), .i0(DataIn0[i]), .sel(Select));
	end
	endgenerate
endmodule

//64 bit input, 2to1 mux
module mux_64(DataIn1, DataIn0, DataOut, Select);
	input Select;
	input[63:0] DataIn1, DataIn0;
	output[63:0] DataOut;

	genvar i;
	generate
	for (i = 0; i < 64; i++) begin: eachIn
		mux2_1 M (.out(DataOut[i]), .i1(DataIn1[i]), .i0(DataIn0[i]), .sel(Select));
	end
	endgenerate
endmodule

//64 bit input, 4to1 mux.
module mux64_4_1  (out, i3, i2, i1, i0, Selector);
	input logic [63:0] i3, i2, i1, i0;
	input logic [1:0] Selector;
	
	output [63:0] out;
	
	genvar i;
	generate
	for (i = 0; i < 64; i++) begin: eachIn
		mux4_1 M (.out(out[i]), .i({i3[i], i2[i], i1[i], i0[i]}), .sel(Selector));
	end
	endgenerate

endmodule

