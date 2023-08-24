/* verilator lint_off UNUSEDSIGNAL */
/* verilator lint_off BLKSEQ */
import "DPI-C" function void vaddr_read(
  input int raddr, output int rdata);
import "DPI-C" function void vaddr_write(
  input int waddr, input int wdata);
`define DATA_WIDTH 32
`define ADDR_WIDTH 32

// addr is 4 byte aligned
module RamBB (
    input clock,
    input [`ADDR_WIDTH-1:0] addr,
    input mem_wen,
    // input mem_ren,
    input valid,
    input [`DATA_WIDTH-1:0] wdata,
    output reg [`DATA_WIDTH-1:0] rdata,
    output reg [`DATA_WIDTH-1:0] rdata_4_w
);

always @(*) begin
    if (valid) begin
        vaddr_read(addr, rdata_4_w);
    end else begin
        rdata_4_w = 0;
    end
end

// always @(*) begin
always @(negedge clock) begin
  if (valid) begin // 有读写请求时
    vaddr_read(addr, rdata);
    if (mem_wen) begin // 有写请求时
        vaddr_write(addr, wdata);
    end
  end
  else begin
    rdata = 0;
  end
end

endmodule
