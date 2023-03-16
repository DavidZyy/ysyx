`include "./include/defines.v"

module memory (
    input   clk,
    input [7:0] pc,

    output reg [`Vec(`InstWidth)] inst
);
    localparam mem_size = 256;
    // wire [`Vec(`RegWidth)] inst_id;

    // assign inst_id = (pc - `PcRst)/4;

    reg [`Vec(`InstWidth)] mem[mem_size-1:0];

    initial $readmemh("/home/zhuyangyang/project/ysyx-workbench/npc/vsrc/test.hex", mem);

    always @(negedge clk) begin
        inst <= mem[pc/4];
    end
endmodule //memory
