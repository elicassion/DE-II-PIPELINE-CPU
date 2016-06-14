`timescale 1 ps/ 1 ps
module pl_computer_tb;
	reg clock;
	reg mem_clock;
	reg resetn;

	wire [31:0]  pc, inst, ealu, malu, walu;
	wire [31:0]  inp0, inp1, inp2, inp3;
	wire [31:0]  otp0, otp1, otp2, otp3;
	assign inp0 = 8'h22222222;
	assign inp1 = 8'h55555555;
	assign inp2 = 8'h88888888;
	assign inp3 = 8'hffffffff;
	initial                                                
	begin
		#0 clock = 0;
		#0 resetn = 0;
		#0 mem_clock = 1;
		#6 resetn = 1;
		$display("Running testbench");
	end
	always #5 clock = ~clock;
	always #5 mem_clock = ~mem_clock;
	pl_cpu u1 (
			.resetn(resetn),
			.clock(clock),
			.mem_clock(mem_clock),
			.pc(pc),
			.ins(inst),
			.ealu(ealu),
			.malu(malu),
			.walu(walu),
			.inp0(inp0), .inp1(inp1), .inp2(inp2), .inp3(inp3),
			.otp0(otp0), .otp1(otp1), .otp2(otp2), .otp3(otp3)
		);                               
endmodule

