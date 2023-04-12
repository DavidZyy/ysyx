
`include "./include/defines.v"

module EX_MEM (
  input flush_EX,
  input rd_EX,
  input [`Vec(`SigOpWidth)]	sig_op_EX,
  input [`Vec(`WdtTypeCnt)]	wdt_op_EX,
  input [`Vec(`ImmWidth)]	  alu_result_EX,
  input [`Vec(`ImmWidth)]   pc_EX,
  input [`Vec(`InstWidth)]  inst_EX,

  output flush_MEM,
  output rd_MEM,
  output [`Vec(`SigOpWidth)]	sig_op_MEM,
  output [`Vec(`WdtTypeCnt)]	wdt_op_MEM,
  output [`Vec(`ImmWidth)]	  alu_result_MEM,
  output [`Vec(`ImmWidth)]    pc_MEM,
  output [`Vec(`InstWidth)]   inst_MEM,
);

     
 Reg 
 #(
  .WIDTH     (`WdtTypeCnt),
  .RESET_VAL (0)
 )
 wdt_op_MEM_reg(
  .clk  (clk  ),
  .rst  (rst  ),
  .din  (wdt_op_EX),
  .wen  (1'b1),

  .dout (wdt_op_MEM)
 );

 Reg 
 #(
  .WIDTH     (`SigOpWidth),
  .RESET_VAL (0)
 )
 sig_op_MEM_reg(
  .clk  (clk  ),
  .rst  (rst  ),
  .din  (sig_op_EX),
  .wen  (1'b1),

  .dout (sig_op_MEM)
 );

  Reg
  #(
    .WIDTH     (`SigOpWidth),
    .RESET_VAL (0)
  )
  alu_result_MEM_reg(
    .clk  (clk  ),
    .rst  (rst  ),
    .din  (alu_result_EX),
    .wen  (1'b1),

    .dout (alu_result_MEM)
  );

 Reg 
 #(
  .WIDTH     (1),
  .RESET_VAL (0)
 )
 flush_MEM_reg(
  .clk  (clk  ),
  .rst  (rst  ),
  .din  (flush_EX),
  .wen  (1'b1),

  .dout (flush_MEM)
 );

 Reg 
 #(
  .WIDTH     (`RegIdWidth),
  .RESET_VAL (0)
 )
 rd_EX_reg(
  .clk  (clk  ),
  .rst  (rst  ),
  .din  (rd_EX),
  .wen  (1'b1),

  .dout (rd_MEM)
 );   


/* pass for debug (pc and inst) */
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
endmodule //EX_MEM
