module pc_choose (rsrtequ, inst, 
				  pcsource);
	input rsrtequ;
	input [31:0] inst;
	output [1:0] pcsource;
	
	wire [5:0] func, op;
	wire r_type;
	assign op = inst[31:26];
	assign r_type = ~|op;
	assign func = inst[5:0];

	wire i_j    = ~op[5] & ~op[4] & ~op[3] & ~op[2] & op[1] & ~op[0];
	wire i_jal  = ~op[5] & ~op[4] & ~op[3] & ~op[2] & op[1] & op[0];
	wire i_jr   = r_type & ~func[5] & ~func[4] & func[3] & ~func[2] & ~func[1] & ~func[0];
	wire i_beq  = ~op[5] & ~op[4] & ~op[3] & op[2] & ~op[1] & ~op[0];
    wire i_bne  = ~op[5] & ~op[4] & ~op[3] & op[2] & ~op[1] & op[0];
    
	assign pcsource[1] = i_jr | i_j | i_jal;
	assign pcsource[0] = ( i_beq & rsrtequ ) | (i_bne & rsrtequ) | i_j | i_jal;
endmodule