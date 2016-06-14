module pl_exemem (clock, resetn,
				  ewreg, em2reg, ewmem, ealu, eb, ern,  
				  mwreg, mm2reg, mwmem, malu, mb, mrn);
	input clock, resetn;
	input ewreg, em2reg, ewmem;
	input [31:0] ealu, eb;
	input [4:0] ern;

	output reg mwreg, mm2reg, mwmem;
	output reg [31:0] malu, mb;
	output reg [4:0] mrn;

	always @(posedge clock or negedge resetn)
	begin
		if (!resetn)
		begin
			mwreg <= 0;
			mm2reg <= 0;
			mwmem <= 0;
			malu <= 0;
			mb <= 0;
			mrn <= 0;
		end
		else 
		begin
			mwreg <= ewreg;
			mm2reg <= em2reg;
			mwmem <= ewmem;
			malu <= ealu;
			mb <= eb;
			mrn <= ern;
		end
		
	end
endmodule