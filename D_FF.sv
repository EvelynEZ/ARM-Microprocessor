// EE 469, Autumn 2016
// Lab 4
// Ruolan Wei, Jiaqi Zhang
// D_FFs: Standard D-FlipFlops of different sizes.

//D_FF on positve edge.
module D_FF ( q, d, reset, clk);
   output reg q ;
	input d, reset, clk;
	
	always_ff @(posedge clk)
	if (reset)
		q <= 0;  // out = d.
	else 
		q <= d; // otherwise 0.

endmodule

//D_FF on negative edge.
module D_FF_Neg ( q, d, reset, clk);
   output reg q ;
	input d, reset, clk;
	
	always_ff @(negedge clk)
	if (reset)
		q <= 0;  // out = d.
	else 
		q <= d; // otherwise 0.

endmodule

//3 bit positive D_FF
module D_FF_3 (q, d, reset, clk);
    input logic reset, clk;
	input logic [2:0] d; 
	output [2:0] q;
	

	genvar i;
	generate 
		for (i = 0; i < 3; i++) begin: eachDFF3
			D_FF d (.q(q[i]), .d(d[i]),.reset, .clk);
		end
	endgenerate
endmodule

//5 bit positive D_FF
module D_FF_5 (q, d, reset, clk);
    input logic reset, clk;
    input logic [4:0] d;
    output [4:0] q;
	 
	genvar j;
	generate 
		for (j = 0; j < 5; j++) begin: eachDFF5
			D_FF d (.q(q[j]), .d(d[j]),.reset, .clk);
		end
	endgenerate
endmodule
 
//32 bit positive D_FF
module D_FF_32 (q, d, reset, clk);
    input logic reset, clk;
    input logic [31:0] d;
    output [31:0] q;
	 
	genvar k;
	generate 
		for (k = 0; k < 32; k++) begin: eachDFF32
			D_FF d (.q(q[k]), .d(d[k]),.reset, .clk);
		end
	endgenerate
endmodule

//64 bit positive D_FF
module D_FF_64 (q, d, reset, clk);
    input logic reset, clk;
    input logic [63:0] d;
    output [63:0] q;

	genvar h;
	generate 
		for (h = 0; h < 64; h++) begin: eachDFF64
			D_FF d (.q(q[h]), .d(d[h]),.reset, .clk);
		end
	endgenerate
endmodule
