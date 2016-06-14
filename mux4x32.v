module mux4x32 (sourse, a0, a1, a2, a3,
                  y);

   input [31:0]  a0, a1, a2, a3;
   input [1:0]   sourse;
   
   output reg [31:0] y;
   always @(*)
   case (sourse)
      2'b00: y = a0;
      2'b01: y = a1;
      2'b10: y = a2;
      2'b11: y = a3;
      default: y = a0;
   endcase
endmodule 