module pl_wb (walu, wrno, wm2reg, 
			  wdi);
	input [31:0] walu, wrno;
	input wm2reg;
	output [31:0] wdi;

	mux2x32 result (wm2reg, walu, wrno, wdi);

endmodule