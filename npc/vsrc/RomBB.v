// import "DPI-C" function void pmem_read(
  // input int raddr, output int rinst);
  // import "DPI-C" function void pmem_read(
  import "DPI-C" function void vaddr_ifetch(
  input int raddr, output int rdata);
// import "DPI-C" function void pmem_write(
//   input int mem_waddr, input int wdata, input byte wmask);

module RomBB (
    // input clock,
    input [31:0] addr,
    output [31:0] inst
);

    /* We should read instructions immediately when pc changes. */
    // always @(posedge clock) begin
    // always @(posedge clock) begin
    always @(*) begin
      vaddr_ifetch(addr, inst);
    end

endmodule //rom
