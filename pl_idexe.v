module pl_idexe (clock, resetn,
				 dwreg, dm2reg, dwmem, daluc, daluimm, da, db, dimm, drn, dshift, djal, dpc4,
				 ewreg, em2reg, ewmem, ealuc, ealuimm, ea, eb, eimm, ern0, eshift, ejal, epc4);

	input clock, resetn;
	input dwreg, dm2reg, dwmem;
	input [3:0] daluc;
	input daluimm;
	input [31:0] da, db, dimm;
	input [4:0] drn;
	input dshift, djal;
	input [31:0] dpc4;

	output reg ewreg, em2reg, ewmem;
	output reg [3:0] ealuc;
	output reg ealuimm;
	output reg [31:0] ea, eb, eimm;
	output reg [4:0] ern0;
	output reg eshift, ejal;
	output reg [31:0] epc4;

	always @(posedge clock or negedge resetn)
	begin
		if (!resetn)
		begin
			ewreg <= 0;
			em2reg <= 0;
			ewmem <= 0;
			ealuc <= 0;
			ealuimm <= 0;
			ea <= 0;
			eb <= 0;
			eimm <= 0;
			ern0 <= 0;
			eshift <= 0;
			ejal <= 0;
			epc4 <= 0;
		end
		else 
		begin
			ewreg <= dwreg;
			em2reg <= dm2reg;
			ewmem <= dwmem;
			ealuc <= daluc;
			ealuimm <= daluimm;
			ea <= da;
			eb <= db;
			eimm <= dimm;
			ern0 <= drn;
			eshift <= dshift;
			ejal <= djal;
			epc4 <= dpc4;
		end
	end
endmodule