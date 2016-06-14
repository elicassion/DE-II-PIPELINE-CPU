module pl_if (mem_clock, 
		      pcsource, pc, bpc, da, jpc, 
		      npc, pc4, ins);
	input mem_clock;
	input [1:0] pcsource;
	input [31:0] pc, bpc, da, jpc;
	output [31:0] npc, pc4, ins;

	assign pc4 = pc + 32'h4;

	mux4x32 next_pc (pcsource, pc4, bpc, da, jpc, npc);
	//00 pc4
	//01 branch pc
	//10 jr
	//11 j jal

	pl_instmem imem (mem_clock, pc, ins);

endmodule