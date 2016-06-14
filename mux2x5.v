module mux2x5 (sourse, a0, a1, 
				y);
	input       sourse;
	input [4:0] a0,a1;

	output [4:0] y;

	assign y = sourse ? a1 : a0;
	
endmodule