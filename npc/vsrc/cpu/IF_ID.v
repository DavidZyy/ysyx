`include "./include/defines.v"
/* regs between instrction fetch and instruction decode */
module IF_ID (
    input clk,
    input rst,
    input [`Vec(`ImmWidth)] current_pc,
    input [`Vec(`InstWidth)]	inst,

    output [`Vec(`ImmWidth)] IF_ID_pc,
    output [`Vec(`InstWidth)]	IF_ID_inst
);

 Reg 
 #(
  .WIDTH     (`ImmWidth),
  .RESET_VAL (0)
 )
 Pc_Reg(
  .clk  (clk  ),
  .rst  (rst  ),
  .din  (current_pc),
  .wen  (1'b1),

  .dout (IF_ID_pc)
 );

 Reg 
 #(
  .WIDTH     (`InstWidth),
  .RESET_VAL (0)
 )
 Pc_Reg(
  .clk  (clk  ),
  .rst  (rst  ),
  .din  (inst),
  .wen  (1'b1),

  .dout (IF_ID_inst)
 );

endmodule //IF_ID
