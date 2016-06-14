module hazard_deal (em2reg, ern, ifidrs, ifidrt, 
					wpcir);
	input em2reg;
	input [4:0] ern, ifidrs, ifidrt;

	output reg wpcir;

	always @(*)
	begin
		wpcir = 1;
		if (em2reg & 
			((ern == ifidrs) | (ern == ifidrt))
			)
		begin
			wpcir = 0;
		end
		else begin
			wpcir = 1;
		end
	end
endmodule