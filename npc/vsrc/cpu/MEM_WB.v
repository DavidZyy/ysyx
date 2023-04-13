
`include "./include/defines.v"

module MEM_WB (
    input      clk,
    input      rst,
    input [`Vec(`ImmWidth)]   pc_MEM,
    input [`Vec(`InstWidth)]  inst_MEM,

    output [`Vec(`ImmWidth)]   pc_WB,
    output [`Vec(`InstWidth)]  inst_WB
);
    
endmodule //MEM_WB
