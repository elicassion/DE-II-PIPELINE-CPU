module pl_ifid (clock, resetn, 
				flush, pc4, ins, wpcir, 
				dpc4, inst);
	input clock, resetn, flush;
	input [31:0] pc4, ins;
	input wpcir;
	output reg [31:0] dpc4, inst;

	always @(posedge clock or negedge resetn)
	begin
		if (!resetn)
		begin
			dpc4 <= 0;
			inst <= 0;
		end
		else
		begin
			if (flush)
			begin
				dpc4 <= 0;
				inst <= 0;
			end
			else 
			begin
				if (wpcir)
				begin
					dpc4 <= pc4;
					inst <= ins;
				end
			end
		end
	end
endmodule