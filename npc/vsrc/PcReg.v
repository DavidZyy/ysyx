`include "./include/defines.v"

module PcReg (
    input      clk,
    input      rst,
    input [`RegWidth-1:0] next_pc,
    
    output [`RegWidth-1:0] current_pc
);

 Reg 
 #(
  .WIDTH     (`RegWidth),
  .RESET_VAL (`PcRst)
 )
 u_Reg(
 	.clk  (clk  ),
  .rst  (rst  ),
  .din  (next_pc),
  .wen  (1'b1),

  .dout (current_pc)
 );
      
endmodule //pc
