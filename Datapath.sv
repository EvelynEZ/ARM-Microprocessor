//EE 469 Autumn 2016
//Lab 4
//Ruolan Wei, Jiaqi Zhang
//This is the top module, the pipelined CPU datapath

`timescale 1ns/10ps
module Datapath (reset, clk);
	input reset, clk;
	logic [31:0] instruction;

   //For Control Unit.
	logic Reg2Loc, ALUSrc, MemToReg, RegWrite, MemWrite, Branch, BranchFinal, Branch_LT, MemRead, setFlag, cbz, blt, bl, br;
	logic [2:0] ALUControl; 
	logic [2:0] format;

   //For Regfile
	//Read Register1(Rn), Read Register2(Rm), Write Register(Rd), mux(Rm, Rd), mux(Rd, x30).
   logic [4:0] register1, register2, registerWrite, newRegister2, registerWrite_BL;
   //ReadData1, ReadData2, mux(ReadData2, SE(instr)).
   logic [63:0] readData1, readData2, newReadData2_EXE;

   //For Addresses
   //PC, 4, SE(instr), shifted(SE), PC+4, PC+shifted, mux(PC+4, PC+shifted), mux(newPC, ReadData2), fullAdder Cout/Cin.
	logic [63:0] PC, four, newAddress, shiftedAddress, PC0, PC1_Decode, newPC, newPC_BR, Cout0, Cout1;
	
	//Logics
	//Buffer1
	logic [31:0]instruction_Decode;
	logic [63:0]PC_Decode, PC0_Decode;
	//Buffer 2
	logic MemRead_EXE, MemtoReg_EXE, MemWrite_EXE, ALUSrc_EXE, RegWrite_EXE, setFlag_EXE, bl_EXE;
	logic [2:0]	ALUControl_EXE;
	logic [4:0] Aw_EXE;
	logic [63:0] PC0_EXE, readData1_EXE, readData2_EXE, newAddress_EXE;
	logic [63:0] address_EXE, address_BL_EXE;
	//Buffer 3
	logic [63:0] address_BL_MEM, readData2_MEM;
	logic  MemWrite_MEM, MemRead_MEM, MemtoReg_MEM, RegWrite_MEM;
	logic [4:0] Aw_MEM;
	logic [63:0] writeData_MEM;
	// mux memToReg
	logic [63:0] newWriteData_MEM;
	//Buffer 4
	logic MemtoReg_WR;
	logic [63:0] newWriteData_WR;
	logic [4:0] Aw_WR;
	logic RegWrite_WR; 
	
	
	assign four = 64'b100;
	fullAdder_64 fullAdder0 (.A(PC), .B(four), .S(PC0));
   // Set PC Address//
	D_FF_64 setPC (.q(PC), .d(newPC_BR), .reset, .clk);
	//Fetch Instruction//
	instructmem imen (.address(PC), .instruction, .clk);

	/////////////////////////////////Buffer 1: IF to Reg/Dec Buffer/////////////////////////////////////////
	IF_To_DEC Buffer_1 (.instruction_out(instruction_Decode), .instruction_in(instruction),  .PC_in(PC), .PC_out(PC_Decode), .PC0, .PC0_Decode, .reset, .clk);
	////////////////////////////////////////////////////////////////////////////////////////////////////////
 	assign register1 = instruction_Decode[9:5];
	assign register2 = instruction_Decode[20:16];
	assign registerWrite = instruction_Decode[4:0]; 
   //Control Unit//
	controlSignal control (.instruction(instruction_Decode), .Reg2Loc, .Branch, .MemRead,.MemtoReg(MemToReg), .ALUControl, 
			.MemWrite, .ALUSrc, .RegWrite, .format, .setFlag, .cbz, .blt, .bl, .br);
	//BL: x30 = PC+4
   mux_5 BLregister (.DataIn1(5'b11110), .DataIn0(registerWrite), .DataOut(registerWrite_BL), .Select(bl)); // use bl
	//Regfile//
	mux_5 reg2loc (.DataIn1(registerWrite_BL),.DataIn0(register2), .DataOut(newRegister2), .Select(Reg2Loc)); // use Reg2Loc
   regfile mreg (.ReadData1(readData1), .ReadData2(readData2), .WriteData(newWriteData_WR), .ReadRegister1(register1), 
		.ReadRegister2(newRegister2), .WriteRegister(Aw_WR), .RegWrite(RegWrite_WR), .clk);
	
	//////////////////////////////////Forwarding Unit//////////////////////////////////////////////////////
	logic [1:0] RnForwardSelect, RmForwardSelect;
	logic [63:0] Rn, Rm;
	forwardingUnit F(.RnForwardSelect, .RmForwardSelect, .Register1(register1), .Register2(newRegister2), .Aw_EXE, .Aw_MEM, .RegWrite_EXE, .RegWrite_MEM);
	mux64_4_1 selectRn (.out(Rn), .i3(64'b0), .i2(readData1), .i1(newWriteData_MEM), .i0(address_EXE),.Selector(RnForwardSelect));
	mux64_4_1 selectRm (.out(Rm), .i3(64'b0), .i2(readData2), .i1(newWriteData_MEM), .i0(address_EXE),.Selector(RmForwardSelect));
		
	extension extend (.format(format), .DataIn(instruction_Decode), .DataOut(newAddress)); // use format //Extend instruction to address(Sign/Zero Extension)//
	assign shiftedAddress = {newAddress[61:0], 2'b0};
	fullAdder_64 fullAdder1 (.A(PC_Decode), .B(shiftedAddress), .S(PC1_Decode)); //PC += shift(SE(imm))	

   //B.LT: if(Negative ^ Overflow) PC+= SE, use the flags from the last cycle 
	logic lt, z;
	logic [3:0] flags;
	xor #5 G (lt, flags[1], flags[2]);
	mux2_1 BLT (.out(Branch_LT), .i1(lt), .i0(Branch), .sel(blt));
	
	/////////////////////////////////Accelerated Branch//////////////////////////////////////////////////////
   //CBZ: if(Zero) PC+=SE
	testZero takeCBZ (.in(Rm), .out(z));
	mux2_1 chooseCBZ (.out(BranchFinal), .i1(z), .i0(Branch_LT), .sel(cbz));
	
	// accelerate branch, assign PC
	mux_64 Final_beforeBR (.DataIn1(PC1_Decode), .DataIn0(PC0), .DataOut(newPC), .Select(BranchFinal));
	mux_64 BR (.DataIn1(Rm), .DataIn0(newPC), .DataOut(newPC_BR), .Select(br)); // MUX with BR:  PC = Reg(Rd)


	
	////////////////////////////////Buffer 2: Reg/Dec to EXE Buffer//////////////////////////////////////
	DEC_To_EXE Buffer_2 (.clk, .reset,.PC0_in(PC0_Decode), .Aw(registerWrite_BL), .readData1(Rn), .readData2(Rm), .newAddress, .MemRead, .MemtoReg(MemToReg), .MemWrite, .ALUSrc, .RegWrite, .setFlag,.bl,.ALUControl, //don't need PC1?
	                  .PC0_out(PC0_EXE), .Aw_EXE, .readData1_EXE, .readData2_EXE, .newAddress_EXE, .MemRead_EXE, .MemtoReg_EXE, .MemWrite_EXE, .ALUSrc_EXE, .RegWrite_EXE, .setFlag_EXE, .bl_EXE, .ALUControl_EXE);
	/////////////////////////////////////////////////////////////////////////////////////////////////////


	mux_64 mux64_ALU (.DataIn1(newAddress_EXE), .DataIn0(readData2_EXE), .DataOut(newReadData2_EXE), .Select(ALUSrc_EXE)); // use ALUSrc
	// ALU //
   //zeroFlag, negFlag, overFlag, carryFlag;
	logic [3:0] ALUFlags_EXE;
	// ALU would produce ALUFlags
	alu mALU (.A(readData1_EXE), .B(newReadData2_EXE), .cntrl(ALUControl_EXE), .result(address_EXE), .negative(ALUFlags_EXE[1]), .zero(ALUFlags_EXE[0]),
		.overflow(ALUFlags_EXE[2]), .carry_out(ALUFlags_EXE[3]));
		
	//Update flag for SUBS and ADDS, otherwise maintain old value.
	flagUpdate setFlags (.in1(ALUFlags_EXE), .in0(flags), .out(flags), .setFlag(setFlag_EXE), .clk, .reset(1'b0)); // use setFlag
	
	//BL x30 = pc+4
	mux_64 BLaddress (.DataIn1(PC0_EXE), .DataIn0(address_EXE), .DataOut(address_BL_EXE), .Select(bl_EXE)); //use bl

	//////////////////////////////////Buffer 3: EXE to MEM Buffer/////////////////////////////////////////
	EXE_To_MEM Buffer_3 (.clk, .reset,.Aw_EXE, .address_BL_EXE, .readData2_EXE, .MemWrite_EXE, .MemRead_EXE, .MemtoReg_EXE, .RegWrite_EXE, 
									 .Aw_MEM, .address_BL_MEM, .readData2_MEM, .MemWrite_MEM, .MemRead_MEM, .MemtoReg_MEM, .RegWrite_MEM);
	/////////////////////////////////////////////////////////////////////////////////////////////////////
	//Data Memory//
	datamem mmem (.address(address_BL_MEM), .write_enable(MemWrite_MEM), .read_enable(MemRead_MEM), .write_data(readData2_MEM), .clk, .xfer_size(4'b1000), .read_data(writeData_MEM)); //use MemRead, MemWrite
	//mux(Dout, address)
	mux_64 memtoReg (.DataIn1(writeData_MEM), .DataIn0(address_BL_MEM), .DataOut(newWriteData_MEM), .Select(MemtoReg_MEM)); //use MemtoReg
	
	///////////////////////////////////Buffer 4: MEM to WR buffer///////////////////////////////////////
	MEM_TO_WR Buffer_4 (.clk, .reset, .Aw_MEM, .RegWrite_MEM,.newWriteData_MEM,.Aw_WR,.RegWrite_WR, .newWriteData_WR);
	/////////////////////////////////////////////////////////////////////////////////////////////////////
 
endmodule

//Testbench
module Datapath_testbench();
	parameter ClockDelay = 5000;
	logic  reset, clk;
	Datapath dut (reset, clk);
	
	initial begin // Set up the clock
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end
	
	initial begin 
		reset <= 1'b1;@(posedge clk);
		reset <= 1'b0;@(posedge clk);
	end
endmodule


