module io_input_reg (addr, io_clk, io_read_data,
					 in_port0, in_port1, in_port2, in_port3);
	
	input  [31:0] addr;
	input 		  io_clk;
	input  [31:0] in_port0, in_port1, in_port2, in_port3;
	output [31:0] io_read_data;
	//////////////////////////////////////////////////
	reg [31:0] in_reg0;
	reg [31:0] in_reg1;
	reg [31:0] in_reg2;
	reg [31:0] in_reg3;

	io_input_mux io_input_mux4x32 (in_reg0, in_reg1, in_reg2, in_reg3,
									addr[7:2], io_read_data);

	always @(posedge io_clk)
	begin
		in_reg0 <= in_port0;
		in_reg1 <= in_port1;
		in_reg2 <= in_port2;
		in_reg3 <= in_port3;
	end
endmodule 