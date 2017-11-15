//EE 469, Autumn 2016
//Lab 4
//Ruolan Wei, Jiaqi Zhang
//regfile.sv: Constructs a 32 by 64 register file for ARM. Register 31 is hardwired to have output
//0.

`timescale 1ns/10ps
module regfile (ReadData1, ReadData2, WriteData, ReadRegister1, ReadRegister2, WriteRegister,RegWrite, clk);
	
	input RegWrite, clk;
	input [4:0] ReadRegister1, ReadRegister2, WriteRegister;
	input [63:0]	WriteData;
	output [63:0]	ReadData1, ReadData2;
	
	
	logic [31:0] EnableRegister; //Output from decoder, used as the enable bit for the registers.
	logic[31:0][63:0] RegisterOut; //Output from 32 registers, used as the input for the mux.
	
	//5:32 Decoder
	decoder D (.enable(RegWrite), .data_in(WriteRegister), .data_out(EnableRegister));
	
	
	//Creates 32 Registers, each contains 64 bits.
	genvar i;
	generate
		for (i = 0; i < 31; i = i+1) 
		begin : x
			register R (.DataIn(WriteData), .DataOut(RegisterOut[i][63:0]), .enable(EnableRegister[i]), .clk(clk));
		end
		//Register X31 is also set to 0.
		register x31 (.DataIn(64'b0),.DataOut(RegisterOut[31]), .enable(1'b1), .clk(clk));
	endgenerate
	
	//32:1 Multiplexer. Each input is 64 bits.
	mux64 M1 (.DataIn(RegisterOut), .DataOut(ReadData1), .select(ReadRegister1), .clk(clk));
	mux64 M2 (.DataIn(RegisterOut), .DataOut(ReadData2), .select(ReadRegister2), .clk(clk));

	
	
endmodule

// Test bench for Register file - TA version
`timescale 1ns/10ps

module regstim();

	parameter ClockDelay = 512000;

	logic	[4:0] 	ReadRegister1, ReadRegister2, WriteRegister;
	logic [63:0]	WriteData;
	logic 			RegWrite, clk;
	logic [63:0]	ReadData1, ReadData2;

	integer i;

	regfile dut (.ReadData1, .ReadData2, .WriteData, .ReadRegister1, .ReadRegister2, .WriteRegister, .RegWrite, .clk);

	// Force %t's to print in a nice format.
	initial $timeformat(-9, 2, " ns", 10);

	initial begin // Set up the clock
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end

	initial begin
		// Try to write the value 0xA0 into register 31.
		// Register 31 should always be at the value of 0.
		RegWrite <= 5'd0;
		ReadRegister1 <= 5'd31;
		ReadRegister2 <= 5'd31;
		WriteRegister <= 5'd31;
		WriteData <= 64'h000000000000A0;
		@(posedge clk);
		
		$display("%t Attempting overwrite of register 31, which should always be 0", $time);
		RegWrite <= 1;
		@(posedge clk);
		RegWrite <= 0;
		@(posedge clk);
		assert(ReadData1 == '0 && ReadData1 == '0);

		$display("%t Writing pattern to all registers.", $time);
		// Write a value into each  register.
		for (i=0; i<31; i=i+1) begin
			RegWrite <= 0;
			ReadRegister1 <= i-1;
			ReadRegister2 <= i;
			WriteRegister <= i;
			WriteData <= 'x;
			@(posedge clk);
			
			RegWrite <= 1; WriteData <= i*64'h0000010204080001;
			@(posedge clk);
		end
		
		// Go back and verify that the registers
		// retained the data.
		for (i=0; i<32; i=i+1) begin
			RegWrite <= 0;
			ReadRegister1 <= i-1;
			ReadRegister2 <= i;
			WriteRegister <= i;
			WriteData <= i*64'h0000000000000100+i;
			@(posedge clk);
			assert((i == 0 && ReadData1 == '0) || (i != 0 && ReadData1 == (i-1)*64'h0000010204080001));
			assert((i == 31 && ReadData2 == '0) || (i != 31 && ReadData2 == i*64'h0000010204080001));
		end

		$stop;
	end
endmodule

