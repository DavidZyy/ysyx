import "DPI-C" function void pmem_read(
  input int mem_raddr, output int rinst);
// import "DPI-C" function void pmem_write(
//   input int mem_waddr, input int wdata, input byte wmask);

module RomBB (
    input clock,
    input [31:0] addr,
    output [31:0] inst
);

    /* We should read instructions immediately when pc changes. */
    always @(posedge clock) begin
      pmem_read(addr, inst);
    end

endmodule //rom
