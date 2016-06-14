module mux2x32 (source, a0, a1,
				y);

   input        source;
   input [31:0] a0,a1;
      
   output [31:0] y;
   
   assign y = source ? a1 : a0;
   
endmodule