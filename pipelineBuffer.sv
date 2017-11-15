//EE 469 Autumn 2016
//Lab 4
//Ruolan Wei, Jiaqi Zhang
//Buffers for pipelined CPU. Stores registers through cycles.

//Buffer 1: from Ifetch to Reg/Dec.
module IF_To_DEC (instruction_out, instruction_in, PC_in, PC_out, PC0, PC0_Decode, reset, clk); 
	input logic [31:0] instruction_in;
	input logic [63:0] PC_in, PC0;
	output [31:0] instruction_out;
	output [63:0] PC_out, PC0_Decode;
	input reset, clk;
	
	D_FF_32 instr_Keep (.q(instruction_out), .d(instruction_in), .reset, .clk);
	D_FF_64 PC_Keep (.q(PC_out), .d(PC_in), .reset, .clk);
	D_FF_64 PC0_Keep (.q(PC0_Decode), .d(PC0), .reset, .clk);
endmodule

//Buffer 2: from Reg/Dec to Exec
module DEC_To_EXE (clk, reset, PC0_in, Aw, readData1, readData2,newAddress, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, setFlag,  bl,  ALUControl, 
   PC0_out, Aw_EXE, readData1_EXE, readData2_EXE, newAddress_EXE, MemRead_EXE, MemtoReg_EXE, MemWrite_EXE, ALUSrc_EXE, RegWrite_EXE, setFlag_EXE,  bl_EXE, ALUControl_EXE);

	input logic MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, setFlag, bl, clk, reset;
	input logic [2:0] ALUControl;
	input logic [4:0] Aw;
	input logic [63:0] PC0_in, readData1, readData2, newAddress;
	
	output MemRead_EXE, MemtoReg_EXE, MemWrite_EXE, ALUSrc_EXE, RegWrite_EXE, setFlag_EXE, bl_EXE;
	output [2:0] ALUControl_EXE;
	output [4:0] Aw_EXE;
	output [63:0] PC0_out, readData1_EXE, readData2_EXE, newAddress_EXE;
	
	D_FF MemRead_Keep (.q(MemRead_EXE), .d(MemRead), .reset, .clk);
	D_FF MemtoReg_Keep (.q(MemtoReg_EXE), .d(MemtoReg), .reset, .clk);
	D_FF MemWrite_Keep (.q(MemWrite_EXE), .d(MemWrite), .reset, .clk);
	D_FF ALUSrc_Keep (.q(ALUSrc_EXE), .d(ALUSrc), .reset, .clk);
	D_FF RegWrite_Keep (.q(RegWrite_EXE), .d(RegWrite), .reset, .clk);
	D_FF setFlag_Keep (.q(setFlag_EXE), .d(setFlag), .reset, .clk);
	D_FF bl_Keep (.q(bl_EXE), .d(bl), .reset, .clk);
	D_FF_3 ALUControl_Keep (.q(ALUControl_EXE), .d(ALUControl), .reset, .clk);
	D_FF_5 Aw_Keep (.q(Aw_EXE), .d(Aw), .reset, .clk);
	D_FF_64 PC0_Keep (.q(PC0_out), .d(PC0_in), .reset, .clk);
	D_FF_64 readData1_Keep (.q(readData1_EXE), .d(readData1), .reset, .clk);
	D_FF_64 readData2_Keep (.q(readData2_EXE), .d(readData2), .reset, .clk);
	D_FF_64 newAddress_Keep (.q(newAddress_EXE), .d(newAddress), .reset, .clk);
endmodule

//Buffer 3: from Exec to Mem
module EXE_To_MEM (clk, reset, Aw_EXE, address_BL_EXE, readData2_EXE, MemWrite_EXE, MemRead_EXE, MemtoReg_EXE, RegWrite_EXE,
  Aw_MEM, address_BL_MEM, readData2_MEM, MemWrite_MEM, MemRead_MEM, MemtoReg_MEM, RegWrite_MEM);

    input logic clk, reset, MemWrite_EXE, MemRead_EXE, MemtoReg_EXE, RegWrite_EXE;
	 input logic [4:0] Aw_EXE;
    input logic [63:0] address_BL_EXE, readData2_EXE;

    output MemWrite_MEM, MemRead_MEM, MemtoReg_MEM, RegWrite_MEM;
	 output [4:0] Aw_MEM;
    output [63:0] address_BL_MEM, readData2_MEM;

    D_FF MemWrite_Keep (.q(MemWrite_MEM), .d(MemWrite_EXE), .reset, .clk);
    D_FF MemRead_Keep (.q(MemRead_MEM), .d(MemRead_EXE), .reset, .clk);
    D_FF MemtoReg_Keep (.q(MemtoReg_MEM), .d(MemtoReg_EXE), .reset, .clk);
    D_FF RegWrite_Keep (.q(RegWrite_MEM), .d(RegWrite_EXE), .reset, .clk);
	 D_FF_5 Aw_Keep (.q(Aw_MEM), .d(Aw_EXE), .reset, .clk);
    D_FF_64 address_Keep (.q(address_BL_MEM), .d(address_BL_EXE), .reset, .clk);
    D_FF_64 readData2_Keep (.q(readData2_MEM), .d(readData2_EXE), .reset, .clk);

endmodule

//Buffer 4: from Mem to WR
module MEM_TO_WR (clk, reset, Aw_MEM, RegWrite_MEM, newWriteData_MEM, Aw_WR, RegWrite_WR,newWriteData_WR);

	input logic clk, reset, RegWrite_MEM;
	input logic [63:0] newWriteData_MEM;
	input logic [4:0] Aw_MEM;

	output RegWrite_WR;
	output [63:0] newWriteData_WR;
	output [4:0] Aw_WR;

	D_FF RegWrite_Keep (.q(RegWrite_WR), .d(RegWrite_MEM), .reset, .clk);
	D_FF_5 Aw_Keep (.q(Aw_WR), .d(Aw_MEM), .reset, .clk);
	D_FF_64 writeData_Keep (.q(newWriteData_WR), .d(newWriteData_MEM), .reset, .clk);

endmodule






