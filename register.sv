// EE 469, Autumn 2016
// Lab 4
// Ruolan Wei, Jiaqi Zhang
// register: Constructs one 64 bit register. Each register is an array of 64 D flip-flops with
// enables. Registers are synchronized with the clock input.

`timescale 1ns/10ps
module register (DataIn, DataOut, enable, clk);
	input [63:0] DataIn;
	input clk, enable;
	output [63:0] DataOut;
	
   genvar i;
	generate
		
	wire [63:0]trueInput;
	
	for (i = 0; i < 64; i = i+1) 
	begin : dffs
		mux2_1 M (.out(trueInput[i]), .i1(DataIn[i]), .i0(DataOut[i]), .sel(enable));
		D_FF_Neg d (.q(DataOut[i]), .d(trueInput[i]), .reset(1'b0), .clk(clk));
   end
	endgenerate
endmodule


module register_testbench();

	logic [63:0]DataIn;
	logic clk, enable;
	logic [63:0] DataOut;

	parameter ClockDelay = 5000;

	register dut (DataIn, DataOut, enable, clk);
	initial begin // Set up the clock
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end

	initial begin 
	enable <= 0;
	enable <= 1;
	DataIn <= 32'b1; @(posedge clk);
	DataIn <= 32'b10; @(posedge clk);
	DataIn <= 32'b100; @(posedge clk);
	DataIn <= 32'b1000; @(posedge clk);
	DataIn <= 32'b10000; @(posedge clk);
	DataIn <= 32'b1000000; @(posedge clk);
	 $stop;
	 end
endmodule
 
	