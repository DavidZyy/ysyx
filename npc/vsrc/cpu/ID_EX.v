
`include "./include/defines.v"

module ID_EX (
    input      clk,
    input      rst,
    input      [`Vec(`AluopWidth)] alu_op_ID,
    input      [`Vec(`WdtTypeCnt)] wdt_op_ID,
    input      [`Vec(`SigOpWidth)] sig_op_ID,
    input      [`Vec(`ImmWidth)]	 imm_ID,
    input      [`Vec(`ImmWidth)]	 rdata_1_ID,
    input      [`Vec(`ImmWidth)]	 rdata_2_ID,
    input      [`Vec(`ImmWidth)]   pc_ID,
    input      [`Vec(`InstWidth)]  inst_ID,
    input      flush_ID,
    input      [`Vec(`RegIdWidth)] rd_ID,
    
    output      [`Vec(`AluopWidth)]  alu_op_EX,
    output      [`Vec(`WdtTypeCnt)]  wdt_op_EX,
    output      [`Vec(`SigOpWidth)]  sig_op_EX,
    output      [`Vec(`ImmWidth)]	   imm_EX,
    output      [`Vec(`ImmWidth)]	   rdata_1_EX,
    output      [`Vec(`ImmWidth)]	   rdata_2_EX,
    output      [`Vec(`ImmWidth)]    pc_EX,
    output      [`Vec(`InstWidth)]   inst_EX,
    output      flush_EX,
    output      [`Vec(`RegIdWidth)]  rd_EX
);

 Reg 
 #(
  .WIDTH     (`AluopWidth),
  .RESET_VAL (0)
 )
 alu_op_EX_reg(
  .clk  (clk  ),
  .rst  (rst  ),
  .din  (alu_op_ID),
  .wen  (1'b1),

  .dout (alu_op_EX)
 );
    
 Reg 
 #(
  .WIDTH     (`WdtTypeCnt),
  .RESET_VAL (0)
 )
 wdt_op_EX_reg(
  .clk  (clk  ),
  .rst  (rst  ),
  .din  (wdt_op_ID),
  .wen  (1'b1),

  .dout (wdt_op_EX)
 );

 Reg 
 #(
  .WIDTH     (`SigOpWidth),
  .RESET_VAL (0)
 )
 sig_op_EX_reg(
  .clk  (clk  ),
  .rst  (rst  ),
  .din  (sig_op_ID),
  .wen  (1'b1),

  .dout (sig_op_EX)
 );
 
 Reg 
 #(
  .WIDTH     (`ImmWidth),
  .RESET_VAL (0)
 )
 imm_EX_reg(
  .clk  (clk  ),
  .rst  (rst  ),
  .din  (imm_ID),
  .wen  (1'b1),

  .dout (imm_EX)
 );

 Reg 
 #(
  .WIDTH     (`ImmWidth),
  .RESET_VAL (0)
 )
 rdata_1_EX_reg(
  .clk  (clk  ),
  .rst  (rst  ),
  .din  (rdata_1_ID),
  .wen  (1'b1),

  .dout (rdata_1_EX)
 );
 
 Reg 
 #(
  .WIDTH     (`ImmWidth),
  .RESET_VAL (0)
 )
 rdata_2_EX_reg(
  .clk  (clk  ),
  .rst  (rst  ),
  .din  (rdata_2_ID),
  .wen  (1'b1),

  .dout (rdata_2_EX)
 );
 
 Reg 
 #(
  .WIDTH     (`ImmWidth),
  .RESET_VAL (0)
 )
 pc_EX_reg(
  .clk  (clk  ),
  .rst  (rst  ),
  .din  (pc_ID),
  .wen  (1'b1),

  .dout (pc_EX)
 );
 
 Reg 
 #(
  .WIDTH     (`InstWidth),
  .RESET_VAL (0)
 )
 inst_EX_reg(
  .clk  (clk  ),
  .rst  (rst  ),
  .din  (inst_ID),
  .wen  (1'b1),

  .dout (inst_EX)
 );
 
 Reg 
 #(
  .WIDTH     (1),
  .RESET_VAL (0)
 )
 flush_EX_reg(
  .clk  (clk  ),
  .rst  (rst  ),
  .din  (flush_ID),
  .wen  (1'b1),

  .dout (flush_EX)
 );

 Reg 
 #(
  .WIDTH     (`RegIdWidth),
  .RESET_VAL (0)
 )
 rd_EX_reg(
  .clk  (clk  ),
  .rst  (rst  ),
  .din  (rd_ID),
  .wen  (1'b1),

  .dout (rd_EX)
 );


endmodule //ID_EX
