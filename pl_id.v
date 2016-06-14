module pl_id (clock, resetn, 
			  mrn, mm2reg, mwreg, ern, em2reg, ewreg, dpc4, inst,
			  wrn, wdi, ealu, malu, mrno, wwreg,
			  dwreg, dm2reg, dwmem, djal, daluc, daluimm, dshift,
			  da, db, dimm, drn,
			  bpc, jpc, pcsource, wpcir, flush
			  );
	input clock, resetn;
	input [4:0] mrn;
	input mm2reg, mwreg;
	input [4:0] ern;
	input em2reg, ewreg;
	input [31:0] dpc4, inst;
	input [4:0] wrn;
	input [31:0] wdi, ealu, malu, mrno;							// wdi: write reg data
	input wwreg;

	output dwreg, dm2reg, dwmem, djal;
	output [3:0] daluc;
	output daluimm, dshift;
	output [31:0] da, db, dimm;
	output [4:0] drn;											// write which reg
	output [31:0] bpc, jpc;
	output [1:0] pcsource;
	output wpcir, flush;												// write pc ir

	wire [31:0] q1, q2;											// reg read out

	wire rsrtequ;												// branch test result 
																// 1:branch 0:no
	wire regrt, sext;
	wire [1:0] fwda, fwdb;

	wire [31:0]   sa; 					// extend to 32 bits from sa for shift instruction
	wire          e;          				// positive or negative sign at sext signal
	wire [15:0]   sign_comp;                					// high 16 sign bit
	wire [31:0]   offset;   	//offset(include sign extend)
	wire [31:0]   imm; 						// sign extend to high 16

	
	assign sa 			= {27'b0, inst[10:6]}; 					// extend to 32 bits from sa for shift instruction
	assign e 			= sext & inst[15];          				// positive or negative sign at sext signal
	assign sign_comp 	= {16{e}};                					// high 16 sign bit
	assign offset 		= {sign_comp[13:0], inst[15:0], 1'b0, 1'b0};   	//offset(include sign extend)
	assign bpc	 		= dpc4 + offset;     								// branch pc
	assign imm 			= {sign_comp, inst[15:0]}; 						// sign extend to high 16
	assign jpc  		= {dpc4[31:28], inst[25:0], 2'b00}; 				// j pc


	pl_cu cu (inst[31:26], inst[5:0], dwmem, dwreg, regrt, dm2reg,
                        daluc, dshift, daluimm, djal, sext);

	regfile rf (clock, resetn,
				inst[25:21], inst[20:16], wdi, wrn, wwreg, 
				q1, q2);

	branch_test bt  (da, db, inst[31:26], rsrtequ);
	pc_choose pc_ch (rsrtequ, inst, pcsource);
	dec_f dfa		(ewreg, ern, em2reg, mm2reg, mrn, mwreg, inst[25:21], fwda);
	dec_f dfb		(ewreg, ern, em2reg, mm2reg, mrn, mwreg, inst[20:16], fwdb);
	mux4x32 f_da	(fwda, q1, ealu, malu, mrno, da);
	mux4x32 f_db	(fwdb, q2, ealu, ealu, mrno, db);
	mux2x5 reg_wn	(regrt, inst[15:11], inst[20:16], drn);
	mux2x32 sa_imm	(dshift, imm, sa, dimm);
	hazard_deal hd  (em2reg, ern, inst[25:21], inst[20:16], wpcir);
	ifid_flush fl 	(rsrtequ, inst, flush);

endmodule