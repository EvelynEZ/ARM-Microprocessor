//EE 469 Autumn 2016
//Lab 4
//Ruolan Wei, Jiaqi Zhang

//This module updates flags on SUBS/ADDS instruction
module flagUpdate (in1, in0, out, setFlag, clk, reset);
	input logic setFlag, clk, reset;
	input logic [3:0] in1, in0;
	output logic [3:0] out;
	logic [3:0] temp;
	genvar k;
	generate 
		for (k = 0; k < 4; k++) begin: eachFlag
			mux2_1 sel (.out(temp[k]), .i1(in1[k]), .i0(in0[k]), .sel(setFlag));
		end
	endgenerate

	genvar i;
	generate 
		for (i = 0; i < 4; i++) begin: eachNewFlag
				D_FF_Neg set (.q(out[i]), .d(temp[i]),.reset(reset), .clk(clk));
		end
	endgenerate
endmodule



