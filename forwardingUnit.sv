//EE 469 Autumn 2016
//Lab 4
//Ruolan Wei, Jiaqi Zhang
//Forwarding Unit: If either Register1 or Register2 of the third instruction is the same as the output
// from the second intruction, the forwarding unit chooses value written in the
module forwardingUnit (RnForwardSelect, RmForwardSelect, Register1, Register2, Aw_EXE, Aw_MEM, RegWrite_EXE, RegWrite_MEM);
  input logic[4:0] Register1, Register2;
  input logic RegWrite_EXE, RegWrite_MEM;
  input logic [4:0] Aw_EXE, Aw_MEM;
  

  output reg [1:0] RnForwardSelect;
  output reg [1:0] RmForwardSelect;
  
    // for Register1
  always @(*) begin
    // Forward value from the EXE stage to Rn
     if (RegWrite_EXE && (Aw_EXE == Register1) && (Aw_EXE != 5'b11111)) 
	     RnForwardSelect = 2'b00;
	 // Forward value from the MEM stage to Rn
     else if (RegWrite_MEM && (Aw_MEM == Register1) && (Aw_MEM != 5'b11111)) 
	     RnForwardSelect = 2'b01;
	 else
        RnForwardSelect = 2'b10;
  end
  
  
  // for Register2
  always @(*) begin
     if (RegWrite_EXE && (Aw_EXE == Register2) && (Aw_EXE != 5'b11111)) // Forward value from the EXE stage to Rn
	     RmForwardSelect <= 2'b00;
     else if (RegWrite_MEM && (Aw_MEM == Register2) && (Aw_MEM != 5'b11111)) // Forward value from the MEM stage to Rn
	     RmForwardSelect <= 2'b01;
	 else
        RmForwardSelect <= 2'b10;
  end
  
endmodule
