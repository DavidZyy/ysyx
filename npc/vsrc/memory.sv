`include "./include/defines.v"

import "DPI-C" function void pmem_read(
  input longint mem_raddr, output longint rinst);
import "DPI-C" function void pmem_write(
  input longint waddr, input longint wdata, input byte wmask);

module memory (
    input   clk,
    input [`Vec(`RegWidth)] pc,
    input [`Vec(`RegWidth)] mem_raddr,
    input [`Vec(`AddrWidth)] waddr,
    input [`Vec(`RegWidth)] mem_wdata,
    input [7:0] wmask,
    input mem_wen,
    input mem_ren,

    output [`Vec(`InstWidth)] inst,
    output [`Vec(`ImmWidth)] mem_rdata
);
    localparam mask = 64'h7;

    wire [`Vec(`RegWidth)] rinst;
    assign inst = (pc & mask) == 0 ? rinst[`Vec(`InstWidth)] : rinst[63:32];

    /* We should read instructions immediately when pc changes. */
    always @(*) begin
      pmem_read(pc, rinst);
    end

    // always @(posedge clk) begin
    always @(*) begin
      if(mem_ren)
        pmem_read(mem_raddr, mem_rdata);
      else
        ;
    end

    always @(negedge clk) begin
      if(mem_wen)
        pmem_write(waddr, mem_wdata, wmask);
      else
        ;
    end

endmodule //memory
