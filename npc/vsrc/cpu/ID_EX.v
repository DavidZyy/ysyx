
`include "./include/defines.v"

module ID_EX (
    input      clk,
    input      rst,
    input  [`Vec(`AluopWidth)] alu_op,
    input  [`Vec(`WdtTypeCnt)] wdt_op,
    input  [`Vec(`SigOpWidth)] sig_op_ID,
    input  [`Vec(`ImmWidth)]	 imm,
    
);
    
endmodule //ID_EX
