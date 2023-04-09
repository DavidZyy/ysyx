`include "./include/defines.v"
/* regs between instrction fetch and instruction decode */
module IF_ID (
    input clk,
    input rst,
    input [`Vec(`ImmWidth)]     pc_IF,
    input [`Vec(`InstWidth)]	inst_IF,

    output [`Vec(`ImmWidth)]    pc_ID,
    output [`Vec(`InstWidth)]	inst_ID
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

  .dout (pc_ID)
 );

 Reg 
 #(
  .WIDTH     (`InstWidth),
  .RESET_VAL (0)
 )
 Pc_Reg_inst(
  .clk  (clk  ),
  .rst  (rst  ),
  .din  (inst_IF),
  .wen  (1'b1),

  .dout (inst_ID)
 );



endmodule //IF_ID
