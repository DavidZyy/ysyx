`include "./include/defines.v"
// 
// module memory (
//     input   clk,
//     input [7:0] pc,
// 
//     output reg [`Vec(`InstWidth)] inst
// );
//     localparam mem_size = 256;
//     // wire [`Vec(`RegWidth)] inst_id;
// 
//     // assign inst_id = (pc - `PcRst)/4;
// 
//     reg [`Vec(`InstWidth)] mem[mem_size-1:0];
// 
//     initial $readmemh("/home/zhuyangyang/project/ysyx-workbench/npc/vsrc/test.hex", mem);
// 
//     always @(negedge clk) begin
//     // always @(posedge clk) begin
//         inst <= mem[pc/4];
//     end
// endmodule //memory
import "DPI-C" function void pmem_read(
  input longint raddr, output longint rdata);
import "DPI-C" function void pmem_write(
  input longint waddr, input longint wdata, input byte wmask);

module memory (
    input   clk,
    input [`Vec(`RegWidth)] pc,
    // input [`Vec(`RegWidth)] raddr,
    input [`Vec(`AddrWidth)] waddr,
    input [`Vec(`RegWidth)] mem_wdata,
    input [7:0] wmask,
    input mem_wen,

    output [`Vec(`InstWidth)] inst
    // output [`Vec(`RegWidth)] rdata
);
    localparam mask = 64'h7;

    wire [`Vec(`RegWidth)] rdata;
    assign inst = (pc & mask) == 0 ? rdata[63:32] : rdata[`Vec(`InstWidth)];

    always @(negedge clk) begin
    // always @(*) begin
      pmem_read(pc, rdata);
      // pmem_read(raddr, rdata);
    end

    always @(negedge clk) begin
      if(mem_wen)
        pmem_write(waddr, mem_wdata, wmask);
      else
        ;
    end

endmodule //memory
