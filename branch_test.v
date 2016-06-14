module branch_test (q1, q2, op, 
					zero);
	input [31:0] q1, q2;
	input [5:0] op;
	output reg zero;

	wire [31:0] s = q1 - q2;
	always @(*)
	begin
		case (op)
			6'b000100: zero = s ? 1'b0 : 1'b1;
			6'b000101: zero = s ? 1'b1 : 1'b0;
			default: zero = 1'b0;
		endcase
	end
endmodule