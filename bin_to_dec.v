module bin_to_dec(
    input wire [31:0] inD,
    output wire [3:0] outH,
    output wire [3:0] outL
    );
	assign  outH = inD / 10;
	assign  outL = inD % 10;
endmodule
