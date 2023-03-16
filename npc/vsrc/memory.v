`include "./include/defines.v"

module memory (
    input   clk,
    input [`Vec(`RegWidth)] PC,

    output [`Vec(`InstWidth)] inst
);
    localparam mem_size = 256;
    localparam inst_id = (PC - `PcRst)/4;

    reg [`Vec(`RegWidth)] mem[mem_size-1:0];

    initial $readmemh("./test.hex", mem);

    always @(*negedge) begin
        Inst <= mem[inst_id];
    end
endmodule //memory
