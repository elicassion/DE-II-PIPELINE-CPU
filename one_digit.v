module one_digit(
    input wire [3:0] inD,
    output reg [6:0] outD
    );
	always @(*)
		case(inD)
			0:outD = 7'b1000000;
			1:outD = 7'b1111001;
			2:outD = 7'b0100100;
			3:outD = 7'b0110000;
			4:outD = 7'b0011001;
			5:outD = 7'b0010010;
			6:outD = 7'b0000010;
			7:outD = 7'b1111000;
			8:outD = 7'b0000000;
			9:outD = 7'b0010000;
			default: outD=7'b1111111;
		endcase
endmodule
