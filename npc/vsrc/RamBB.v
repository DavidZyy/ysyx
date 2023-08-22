
// import "DPI-C" function void pmem_read(
//   input int raddr, output int rdata);
import "DPI-C" function void pmem_write(
  input int waddr, input int wdata);
`define DATA_WIDTH 32
`define ADDR_WIDTH 32

module RamBB (
    input [`ADDR_WIDTH-1:0] addr,
    input mem_wen,
    // input mem_ren,
    input valid,
    input [`DATA_WIDTH-1:0] wdata,
    output [`DATA_WIDTH-1:0] rdata
);

// wire [63:0] rdata;
always @(*) begin
  if (valid) begin // 有读写请求时
    pmem_read(addr, rdata);
    if (mem_wen) begin // 有写请求时
        pmem_write(addr, wdata);
    //   pmem_write(waddr, wdata, wmask);
    end
  end
  else begin
    // rdata = 0;
    ;
  end
end

// always @(*) begin
//     if(mem_ren) begin
//         pmem_read(addr, rdata);
//     end else begin
//         rdata = 0;
//     end
// end
// 
// // always @(posedge clock) begin
// always @(*) begin
//     if(mem_wen) begin
//         pmem_write(addr, wdata);
//     end
// end

endmodule
