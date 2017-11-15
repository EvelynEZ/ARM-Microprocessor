//EE 469 Autumn 2016
//Lab 4
//Ruolan Wei, Jiaqi Zhang
//decoder: a 5:32 decoder. Constructed with one 2to4 decoder as the top and three 3to8 decoders.

`timescale 1 ns / 10 ps
module decoder(enable, data_in, data_out);
	input [4:0] data_in;
	input enable;
	output [31:0] data_out;
	
	wire [3:0]selector; //The enable bit for the 3to8 decoders.
	
	decoder_2to4 Q1 (.enable(enable), .i0(data_in[3]), .i1(data_in[4]), .out(selector));
	
	decoder_3to8 Q2 (.enable(selector[0]), .in(data_in[2:0]), .out(data_out[7:0]));
	decoder_3to8 Q3 (.enable(selector[1]), .in(data_in[2:0]), .out(data_out[15:8]));
	decoder_3to8 Q4 (.enable(selector[2]), .in(data_in[2:0]), .out(data_out[23:16]));
	decoder_3to8 Q5 (.enable(selector[3]), .in(data_in[2:0]), .out(data_out[31:24]));
	
endmodule 
 

//2to4 decoder.
module decoder_2to4(enable, i0, i1, out);
	input enable, i1, i0;
	output [3:0] out;
	
	logic i1not, i0not;
	logic [3:0] temp;
	
	 
	not #50 G1 (i1not, i1);
	not #50 G2 (i0not, i0);
		
	and #50 G3  (temp[0], i1not, i0not);
	and #50 G4  (temp[1], i1not, i0);
	and #50 G5  (temp[2], i1, i0not);
	and #50 G6  (temp[3], i1, i0);
		 
	and #50 G7  (out[0], temp[0], enable);
	and #50 G8  (out[1], temp[1], enable);
	and #50 G9  (out[2], temp[2], enable);
	and #50 G10 (out[3], temp[3], enable);
		 
endmodule


//3to8 decoder built based on 2to4 decoders.
module decoder_3to8(enable,in, out);
	input  enable;
	input  [2:0] in;
	output [7:0] out;
	wire   [3:0] w;
	
	not #50 N  (w[2], in[2]);	
	and #50 A1 (w[0], w[2], enable);
	and #50 A2 (w[1], in[2], enable);
	
	decoder_2to4 D1 (.enable(w[0]), .i0(in[0]), .i1(in[1]), .out(out[3:0]));
	decoder_2to4 D2 (.enable(w[1]), .i0(in[0]), .i1(in[1]), .out(out[7:4]));
		
endmodule



module decoder_testbench();
	logic [4:0]data_in;
	logic enable;
	logic [31:0]data_out;

	decoder dut (enable, data_in, data_out);

	initial begin
			enable  = 1;   #50; 
			for (int i = 0; i< 32; i++) begin
				data_in =i; #50;
			end
				
			$stop;
		end 
endmodule