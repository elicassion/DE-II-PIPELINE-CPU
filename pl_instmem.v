module pl_instmem (clock, addr,
					inst);
   input  [31:0] addr;
   input         clock;
   output [31:0] inst;    
   
   lpm_rom_irom irom (addr[7:2], clock, inst);
   

endmodule