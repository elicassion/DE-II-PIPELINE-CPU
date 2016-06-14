module pl_mem(clock, mem_clock, resetn,
			  we, addr, datain, 
			  inp0, inp1, inp2, inp3,
			  otp0, otp1, otp2, otp3,
			  dataout);
	input clock, mem_clock, resetn;
	input we;
	input [31:0] addr, datain;
	input [31:0] inp0, inp1, inp2, inp3;
	output [31:0] otp0, otp1, otp2, otp3;
	output [31:0] dataout;

	wire 		write_enable; 
	wire		write_datamem_enable;
	wire		write_io_output_reg_enable;
	wire [31:0] mem_dataout;
	wire [31:0] io_read_data;

	assign write_enable = we & ~clock;
	assign write_datamem_enable = write_enable & (~addr[7]);
	assign write_io_output_reg_enable = write_enable & (addr[7]);

	mux2x32 mem_io_dataout_mux (addr[7], mem_dataout, io_read_data, dataout);

	lpm_ram_dq_dram  dram(addr[6:2], mem_clock, datain, write_datamem_enable, mem_dataout );

	io_output_reg io_output_regx4(addr, datain, write_io_output_reg_enable,
								  clock, resetn, 
								  otp0, otp1, otp2, otp3);
											
	io_input_reg io_input_regx4(addr, mem_clock, io_read_data, 
								inp0, inp1, inp2, inp3);
endmodule