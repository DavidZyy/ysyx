
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
    
endmodule //MEM_WB
