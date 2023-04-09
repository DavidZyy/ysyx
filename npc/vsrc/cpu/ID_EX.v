
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
    
    output      [`Vec(`AluopWidth)]  alu_op_EX,
    output      [`Vec(`WdtTypeCnt)]  wdt_op_EX,
    output      [`Vec(`SigOpWidth)]  sig_op_EX,
    output      [`Vec(`ImmWidth)]	   imm_EX,
    output      [`Vec(`ImmWidth)]	   rdata_1_EX,
    output      [`Vec(`ImmWidth)]	   rdata_2_EX,
    output      [`Vec(`ImmWidth)]    pc_EX,
    output      [`Vec(`InstWidth)]   inst_EX
);
    
endmodule //ID_EX
