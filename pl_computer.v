module pl_computer(
	input  wire resetn,
	input  wire clock,
	//output wire [31:0] pc, 
	//output wire [31:0] inst, 
	//output wire [31:0] ealu, 
	//output wire [31:0] malu, 
	//output wire [31:0] walu,
	input  wire [17:0] sw,
	output wire [6:0] out_dig0_h,
	output wire [6:0] out_dig0_l,
	output wire [6:0] out_dig1_h,
	output wire [6:0] out_dig1_l,
	output wire [6:0] out_dig2_h,
	output wire [6:0] out_dig2_l,
	output wire [6:0] out_dig3_h,
	output wire [6:0] out_dig3_l
	);
	
	wire mem_clock;
	wire [31:0] otp0, otp1, otp2, otp3;
	wire [31:0] inp0, inp1, inp2, inp3;
	wire [3:0]  out_0_h;
	wire [3:0]  out_0_l;
	wire [3:0]  out_1_h;
	wire [3:0]  out_1_l;
	wire [3:0]  out_2_h;
	wire [3:0]  out_2_l;
	wire [3:0]  out_3_h;
	wire [3:0]  out_3_l;
	
	assign mem_clock = ~clock;
	
	bin_to_dec BTD0 (otp0, out_0_h, out_0_l);
	bin_to_dec BTD1 (otp1, out_1_h, out_1_l);
	bin_to_dec BTD2 (otp2, out_2_h, out_2_l);
	bin_to_dec BTD3 (otp3, out_3_h, out_3_l);

	one_digit D0h  (out_0_h, out_dig0_h);
	one_digit D0l  (out_0_l, out_dig0_l);
	one_digit D1h  (out_1_h, out_dig1_h);
	one_digit D1l  (out_1_l, out_dig1_l);
	one_digit D2h  (out_2_h, out_dig2_h);
	one_digit D2l  (out_2_l, out_dig2_l);
	one_digit D3h  (out_3_h, out_dig3_h);
	one_digit D3l  (out_3_l, out_dig3_l);
	
	assign inp0 = {27'b0, sw[17:13]};
	assign inp1 = {27'b0, sw[12:8]};
	assign inp2 = {27'b0, sw[7:3]};
	assign inp3 = {29'b0, sw[2:0]};
	
	wire [31:0] pc;
	wire [31:0] inst;
	wire [31:0] ealu;
	wire [31:0] malu;
	wire [31:0] walu;

	pl_cpu cpu (resetn, clock, mem_clock,
				pc, inst, ealu, malu, walu,
				inp0, inp1, inp2, inp3,
				otp0, otp1, otp2, otp3);
endmodule 