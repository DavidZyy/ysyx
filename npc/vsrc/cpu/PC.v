`include "../include/defines.v"

module PC (
    input      clk,
    input      rst,
    input  [`Vec(`RegWidth)] next_pc,
    // input [`Vec(`RegWidth)] JAddr,
    // input jar,
    // input bxx,
    
    output [`Vec(`RegWidth)] pc_IF
    // output [`Vec(`RegWidth)] next_pc
);

/* a multiplexer to choose which is the next pc */
// wire [`Vec(`RegWidth)] next_pc_temp1 = pc_IF + 4;

// assign next_pc = rst ? `PcRst : (pc_IF + 4);

 Reg 
 #(
  .WIDTH     (`RegWidth),
  .RESET_VAL (`PcRst)
 )
 pc_IF_reg(
  .clk  (clk  ),
  .rst  (rst  ),
  .din  (next_pc),
  .wen  (1'b1),

  .dout (pc_IF)
 );


      
endmodule //pc
