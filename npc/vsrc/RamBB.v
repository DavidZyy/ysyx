/* verilator lint_off UNUSEDSIGNAL */
/* verilator lint_off BLKSEQ */
import "DPI-C" function void vaddr_read(
  input int raddr, output int rdata);
import "DPI-C" function void vaddr_write(
  input int waddr, input int wdata, input byte wmask);
`define DATA_WIDTH 32
`define ADDR_WIDTH 32

// addr is 4 byte aligned
module RamBB (
    input clock,
    input [`ADDR_WIDTH-1:0] addr,
    input mem_wen,
    input valid,
    input [`DATA_WIDTH-1:0] wdata,
    input [4-1:0] wmask,
    output reg [`DATA_WIDTH-1:0] rdata
);

  wire [8-1:0] wmask_new;
  assign wmask_new[3:0] = wmask;
  assign wmask_new[7:4] = 0;

// always @(*) begin
always @(negedge clock) begin
  // $display("wmask = %b", wmask);
  // $display("wmask_new = %b", wmask_new);
  if (valid) begin // 有读写请求时
    if (mem_wen) begin // 有写请求时
      vaddr_write(addr, wdata, wmask_new);
    end
    else begin
      vaddr_read(addr, rdata);
    end
  end
  else begin
    rdata = rdata;
  end
end

endmodule
