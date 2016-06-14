module pl_cpu(
	resetn, clock, mem_clock,
	pc, ins, ealu, malu, walu,
	inp0, inp1, inp2, inp3,
	otp0, otp1, otp2, otp3
	);
	input resetn, clock, mem_clock;
	input [31:0] inp0, inp1, inp2, inp3;
	output [31:0] otp0, otp1, otp2, otp3;
	output [31:0] pc, ins, ealu, malu, walu;

	//-----------------------------------------------------//

	wire [31:0] bpc, jpc, npc, pc4, inst; 			//IF
	wire [1:0] pcsource;

	//-----------------------------------------------------//

	wire [31:0] dpc4, da, db, dimm;						//ID
	wire [4:0] drn;
	wire [3:0] daluc;
	wire dwreg, dm2reg, dwmem, daluimm, dshift, djal, flush;	//ID 

	//-----------------------------------------------------//

	wire [31:0] epc4, ea, eb, eimm;						//EXE
	wire [4:0] ern0, ern;
	wire [3:0] ealuc;
	wire ewreg, em2reg, ewmem, ealuimm, eshift, ejal; 	//EXE 

	//-----------------------------------------------------//

	wire [31:0] mb, mrno;								//MEM
	wire [4:0] mrn;
	wire mwreg, mm2reg, mwmem;							//MEM

	//-----------------------------------------------------//

	wire [31:0] wrno, wdi;								//WB
	wire [4:0] wrn;
	wire wwreg, wm2reg;									//WB

	
	wire wpcir;

	
	
	//WB/IF
	pl_wbif wbif_reg (clock, resetn, npc, wpcir, pc);		
	
	//IF
	pl_if if_stage (mem_clock, pcsource, pc, bpc, da, jpc, npc, pc4, ins);
	
	//IF/ID
	pl_ifid ifid_reg (clock, resetn, 
					  flush, pc4, ins, wpcir, 
					  dpc4, inst);
	
	//ID
	pl_id id_stage (clock, resetn, 
					mrn, mm2reg, mwreg, ern, em2reg, ewreg, dpc4, inst,
					wrn, wdi, ealu, malu, mrno, wwreg,
					dwreg, dm2reg, dwmem, djal, daluc, daluimm, dshift,
					da, db, dimm, drn,
					bpc, jpc, pcsource, wpcir, flush
					);
	
	//ID/EXE
	pl_idexe idexe_reg (clock, resetn,
						dwreg, dm2reg, dwmem, daluc, daluimm, da, db, dimm, drn, dshift,
						djal, dpc4,  ewreg, em2reg, ewmem, ealuc, ealuimm,
						ea, eb, eimm, ern0, eshift, ejal, epc4);

	//EXE
	pl_exe exe_stage (ealuc, ealuimm, ea, eb, eimm, eshift, ern0, epc4, ejal, 
						ern, ealu);

	//EXE/MEM
	pl_exemem exemem_reg (clock, resetn,
						  ewreg, em2reg, ewmem, ealu, eb, ern,  
						  mwreg, mm2reg, mwmem, malu, mb, mrn);

	//MEM
	pl_mem mem_stage (clock, mem_clock, resetn,
					  mwmem, malu, mb, 
					  inp0, inp1, inp2, inp3,
					  otp0, otp1, otp2, otp3,
					  mrno);

	//MEM/WB
	pl_memwb memwb_reg (clock, resetn,
						mwreg, mm2reg, mrno, malu, mrn, 
						wwreg, wm2reg, wrno, walu, wrn);

	//WB
	pl_wb wb_stage (walu, wrno, wm2reg, wdi);
endmodule