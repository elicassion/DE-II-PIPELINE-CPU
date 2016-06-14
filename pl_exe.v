module pl_exe (ealuc, ealuimm, ea, eb, eimm, eshift, ern0, epc4, ejal, 
				ern, ealu);
	input [3:0] ealuc;
	input ealuimm;
	input [31:0] ea, eb, eimm;
	input eshift;
	input [4:0] ern0;
	input [31:0] epc4;
	input ejal;

	output [4:0] ern;
	output [31:0] ealu;

	wire [31:0] alua, alub, s, epc8;
	assign ern = ern0 | {5{ejal}};							//  31 or ern0
	assign epc8 = epc4 + 32'h4;

	alu calc (alua, alub, ealuc, s);
	mux2x32 mux_alua(eshift, ea, eimm, alua);
	mux2x32 mux_alub(ealuimm, eb, eimm, alub);
	mux2x32 link(ejal, s, epc8, ealu);
endmodule