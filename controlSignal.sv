//EE 469 Autumn 2016
//Lab 4
//Ruolan Wei, Jiaqi Zhang


//This is the control unit.
module controlSignal (instruction, Reg2Loc, Branch, MemRead, MemtoReg, ALUControl, MemWrite, ALUSrc, RegWrite, format, setFlag, cbz, blt, bl, br);
	input logic [31:0] instruction;
	output logic Reg2Loc, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, setFlag, cbz, blt, bl, br;
	output logic [2:0] ALUControl;
	output logic [2:0] format;

	//Format: For SignExtension use.
	//000    B-Type   Branch
	//001    CB-type  Conditional Branch
	//010    R-Type   Register
	//011    I-Type   Immediate
	//100    D-Type   Memory
	

	always @(*) begin
		if(instruction[31:26] == 6'b000101) begin //B
			format = 3'b000; //B 
			setFlag = 1'b0;
			cbz = 1'b0;
			blt = 1'b0;
			bl = 1'b0;
			br = 1'b0;
			MemRead = 1'b0;
			Reg2Loc = 1'bx;
			ALUSrc = 1'bx;
			MemtoReg = 1'bx;
			RegWrite = 1'b0;
			MemWrite = 1'b0;
			Branch = 1'b1;
			ALUControl = 3'bx; //Don't care
		end else if(instruction[31:26] == 6'b100101) begin//BL
			format = 3'b000; //B 
			setFlag = 1'b0;
			cbz = 1'b0;
			blt = 1'b0;
			bl = 1'b1;
			br = 1'b0;
			MemRead = 1'b0;
			Reg2Loc = 1'b1;
			ALUSrc = 1'bx;
			MemtoReg = 1'b0;
			RegWrite = 1'b1;
			MemWrite = 1'b0;
			Branch = 1'b1;
			ALUControl = 3'bx; //Don't care	
		end else if (instruction[31:22] == 10'b1001000100) begin//ADDI
			format = 3'b011; //I
			setFlag = 1'b0;
			cbz = 1'b0;
			blt = 1'b0;
			bl = 1'b0;
			br = 1'b0;
			MemRead = 1'b0;
			Reg2Loc = 1'b0;
			ALUSrc = 1'b1;
			MemtoReg = 1'b0;
			RegWrite = 1'b1;
			MemWrite = 1'b0;
			Branch = 1'b0;
			ALUControl = 3'b010; //add
		end else if(instruction[31:21] == 11'b10101011000) begin //ADDS
			format = 3'b010; //R
			setFlag = 1'b1;
			cbz = 1'b0;
			blt = 1'b0;
			bl = 1'b0;
			br = 1'b0;
			MemRead = 1'b0;
			Reg2Loc = 1'b0;
			ALUSrc = 1'b0;
			MemtoReg = 1'b0;
			RegWrite = 1'b1;
			MemWrite = 1'b0;
			Branch = 1'b0;
			ALUControl = 3'b010; //add 
		end else if(instruction[31:21] == 11'b11101011000) begin //SUBS
			format = 3'b010; //R
			setFlag = 1'b1;
			cbz = 1'b0;
			blt = 1'b0;
			bl = 1'b0;
			br = 1'b0;
			MemRead = 1'b0;
			Reg2Loc = 1'b0;
			ALUSrc = 1'b0;
			MemtoReg = 1'b0;
			RegWrite = 1'b1;
			MemWrite = 1'b0;
			Branch = 1'b0;
			ALUControl = 3'b011; //subtract
		end else if(instruction[31:24] == 8'b01010100  && instruction[4:0] == 5'b01011) begin //B.LT
			format = 3'b001; //CB
			setFlag = 1'b0;
			cbz = 1'b0;
			blt = 1'b1;
			bl = 1'b0;
			br = 1'b0;
			MemRead = 1'b0;
			Reg2Loc = 1'bx;
			ALUSrc = 1'bx;
			MemtoReg = 1'bx;
			RegWrite = 1'b0;
			MemWrite = 1'b0;
			Branch = 1'b1;
			ALUControl = 3'bx; //Don't care
		end else if(instruction[31:24] == 8'b10110100) begin //CBZ
			format = 3'b001; //CB
			setFlag = 1'b0;
			cbz = 1'b1;
			blt = 1'b0;
			bl = 1'b0;
			br = 1'b0;
			MemRead = 1'b0;
			Reg2Loc = 1'b1;
			ALUSrc = 1'b0;
			MemtoReg = 1'bx;
			RegWrite = 1'b0;
			MemWrite = 1'b0;
			Branch = 1'b1; 
			ALUControl = 3'b000; //Pass B
		end else if(instruction[31:21] == 11'b11010110000) begin //BR
			format = 3'b011; //R
			setFlag = 1'b0;
			cbz = 1'b0;
			blt = 1'b0;
			bl = 1'b0;
			br = 1'b1;
			MemRead = 1'b0;
			Reg2Loc = 1'b1;
			ALUSrc = 1'bx;
			MemtoReg = 1'bx;
			RegWrite = 1'b0;
			MemWrite = 1'b0;
			Branch = 1'b0;
			ALUControl = 3'bx; //Don't care
		end else if(instruction[31:21] == 11'b11111000010) begin //LDUR
			format = 3'b100; //D
			setFlag = 1'b0;
			cbz = 1'b0;
			blt = 1'b0;
			bl = 1'b0;
			br = 1'b0;
			MemRead = 1'b1;
			Reg2Loc = 1'bx;
			ALUSrc = 1'b1;
			MemtoReg = 1'b1;
			RegWrite = 1'b1;
			MemWrite = 1'b0;
			Branch = 1'b0;
			ALUControl = 3'b010;//add 
		end else if(instruction[31:21] == 11'b11111000000) begin //STUR
			format = 3'b100; //D
			setFlag = 1'b0;
			cbz = 1'b0;
			blt = 1'b0;
			bl = 1'b0;
			br = 1'b0;
			MemRead = 1'b0;
			Reg2Loc = 1'b1;
			ALUSrc = 1'b1;
			MemtoReg = 1'bx;
			RegWrite = 1'b0;
			MemWrite = 1'b1;
			Branch = 1'b0;
			ALUControl = 3'b010;//add 
		end else begin //Default
			format = 3'bx; 
			setFlag = 1'b0;
			cbz = 1'b0;
			blt = 1'b0;
			bl = 1'b0;
			br = 1'b0;
			MemRead = 1'b0;
			Reg2Loc = 1'bx;
			ALUSrc = 1'bx;
			MemtoReg = 1'bx;
			RegWrite = 1'b0;
			MemWrite = 1'b0;
			Branch = 1'b0;
			ALUControl = 3'bx;
		end
	end   
endmodule

//Sign Extend / Zero Extend
 module extension(format, DataIn, DataOut);
	 input [31:0] DataIn;
	 input [2:0] format;
	 output logic [63:0] DataOut;
	 parameter B = 3'b000, CB = 3'b001, I = 3'b011, D = 3'b100;
	 always_comb begin
		 case(format)
		 B:  DataOut = {{38{DataIn[25]}}, DataIn[25:0]};
		 CB: DataOut = {{45{DataIn[23]}}, DataIn[23:5]};
		 I:  DataOut = {52'b0, DataIn[21:10]};
		 D:  DataOut = {{55{DataIn[20]}}, DataIn[20:12]};
		 default: DataOut = 64'b0;
		 endcase
	end
endmodule














