
`include "./include/defines.v"

module MEM_WB (
    input clk,
    input rst,
    input flush_MEM,      
    input [`Vec(`ImmWidth)]    mem_rdata_ex_MEM,
    input [`Vec(`ImmWidth)]	   alu_result_MEM,
    input [`Vec(`SigOpWidth)]  sig_op_MEM,
    input [`Vec(`ImmWidth)]    pc_MEM,
    input [`Vec(`InstWidth)]   inst_MEM,

    output flush_WB,
    output [`Vec(`ImmWidth)]   mem_rdata_ex_WB,
    output [`Vec(`ImmWidth)]	 alu_result_WB,
    output [`Vec(`SigOpWidth)] sig_op_WB,
    output [`Vec(`ImmWidth)]   pc_WB,
    output [`Vec(`InstWidth)]  inst_WB
);
    
 Reg 
 #(
  .WIDTH     (1),
  .RESET_VAL (0)
 )
 flush_WB_reg(
  .clk  (clk  ),
  .rst  (rst  ),
  .din  (flush_MEM),
  .wen  (1'b1),

  .dout (flush_WB)
 );

  Reg
  #(
    .WIDTH     (`ImmWidth),
    .RESET_VAL (0)
  )
  alu_result_MEM_reg(
    .clk  (clk  ),
    .rst  (rst  ),
    .din  (mem_rdata_ex_MEM),
    .wen  (1'b1),

    .dout (mem_rdata_ex_WB)
  );

  Reg
  #(
    .WIDTH     (`ImmWidth),
    .RESET_VAL (0)
  )
  alu_result_MEM_reg(
    .clk  (clk  ),
    .rst  (rst  ),
    .din  (alu_result_MEM),
    .wen  (1'b1),

    .dout (alu_result_WB)
  );


 Reg 
 #(
  .WIDTH     (`SigOpWidth),
  .RESET_VAL (0)
 )
 sig_op_MEM_reg(
  .clk  (clk  ),
  .rst  (rst  ),
  .din  (sig_op_MEM),
  .wen  (1'b1),

  .dout (sig_op_WB)
 );

 Reg 
 #(
  .WIDTH     (`ImmWidth),
  .RESET_VAL (0)
 )
 pc_MEM_reg(
  .clk  (clk  ),
  .rst  (rst  ),
  .din  (pc_MEM),
  .wen  (1'b1),

  .dout (pc_WB)
 );
 
 Reg 
 #(
  .WIDTH     (`InstWidth),
  .RESET_VAL (0)
 )
 inst_MEM_reg(
  .clk  (clk  ),
  .rst  (rst  ),
  .din  (inst_MEM),
  .wen  (1'b1),

  .dout (inst_WB)
 );

endmodule //MEM_WB
