`include "./include/defines.v"

module memory (
    input   clk,
    input [`Vec(`RegWidth)] pc,

    output reg [`Vec(`InstWidth)] inst
);
    localparam mem_size = 256;
    wire [`Vec(`RegWidth)] inst_id;

    assign inst_id = (pc - `PcRst)/4;

    reg [`Vec(`InstWidth)] mem[mem_size-1:0];

    initial $readmemh("./test.hex", mem);

    always @(negedge clk) begin
        inst <= mem[inst_id[7:0]];
    end
endmodule //memory
