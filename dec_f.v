module dec_f (ewreg, ern, em2reg, mm2reg, mrn, mwreg, r, 
			  fout);
	input ewreg;
	input [4:0] ern;
	input em2reg, mm2reg;
	input [4:0] mrn;
	input mwreg;
	input [4:0] r;
	output reg [1:0] fout;

	always @(*)
	begin
		fout = 2'b00;
		if (ewreg & (ern != 0 ) & (ern == r) & ~em2reg)
		begin
			fout = 2'b01;
		end
		else 
		begin
			if (mwreg & (mrn != 0) & (mrn == r) & ~mm2reg)
			begin
				fout = 2'b10;		
			end	
			else 
			begin
				if (mwreg & (mrn != 0) & (mrn == r) & mm2reg)
				begin
					fout = 2'b11;
				end	
			end
		end
	end
endmodule