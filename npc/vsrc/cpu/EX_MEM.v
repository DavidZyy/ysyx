
`include "./include/defines.v"

module EX_MEM (
  input [`Vec(`SigOpWidth)]	sig_op_EX,
  input [`Vec(`WdtTypeCnt)]	wdt_op_EX,
  input [`Vec(`ImmWidth)]	alu_result_EX,

  output [`Vec(`SigOpWidth)]	sig_op_MEM,
  output [`Vec(`WdtTypeCnt)]	wdt_op_MEM,
  output [`Vec(`ImmWidth)]	alu_result_MEM
);
    
endmodule //EX_MEM
