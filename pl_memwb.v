module pl_memwb (clock, resetn,
				 mwreg, mm2reg, mrno, malu, mrn, 
				 wwreg, wm2reg, wrno, walu, wrn);
	input clock, resetn;
	input mwreg, mm2reg;
	input [31:0] mrno, malu;
	input [4:0] mrn;

	output reg wwreg, wm2reg;
	output reg [31:0] wrno, walu;
	output reg [4:0] wrn;

	always @(posedge clock or negedge resetn)
	begin
		if (!resetn)
		begin
			wwreg <= 0;
			wm2reg <= 0;
			wrno <= 0;
			walu <= 0;
			wrn <= 0;
		end
		else 
		begin
			wwreg <= mwreg;
			wm2reg <= mm2reg;
			wrno <= mrno;
			walu <= malu;
			wrn <= mrn;
		end
		
	end
endmodule