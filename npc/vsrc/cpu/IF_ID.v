`include "./include/defines.v"
/* regs between instrction fetch and instruction decode */
module IF_ID (
    input clk,
    input rst,
    input [`Vec(`ImmWidth)] pc_IF,
    input [`Vec(`InstWidth)]	din_inst,

    output [`Vec(`ImmWidth)] IF_ID_pc,
    output [`Vec(`InstWidth)]	IF_ID_inst
);

 Reg 
 #(
  .WIDTH     (`ImmWidth),
  .RESET_VAL (0)
 )
 Pc_Reg_pc(
  .clk  (clk  ),
  .rst  (rst  ),
  .din  (pc_IF),
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
