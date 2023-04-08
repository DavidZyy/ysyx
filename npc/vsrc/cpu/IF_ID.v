`include "../include/defines.v"
/* regs between instrction fetch and instruction decode */
module IF_ID (
    input clk,
    input rst,
    input [`Vec(`ImmWidth)] current_pc,
    input [`Vec(`InstWidth)]	inst,
    input flush,

    output [`Vec(`ImmWidth)] IF_ID_pc,
    output [`Vec(`InstWidth)]	IF_ID_inst
);


    wire [`Vec(`InstWidth)]	din_inst = flush ? inst : NOP;

 Reg 
 #(
  .WIDTH     (`ImmWidth),
  .RESET_VAL (0)
 )
 Pc_Reg_pc(
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
 Pc_Reg_inst(
  .clk  (clk  ),
  .rst  (rst  ),
  .din  (din_inst),
  .wen  (1'b1),

  .dout (IF_ID_inst)
 );



endmodule //IF_ID
