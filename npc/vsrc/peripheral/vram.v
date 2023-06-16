// vga ram

`include "../include/defines.v"

module vram (
    input clk,
    input [`Vec(`AddrWidth)] mem_waddr,
    /* verilator lint_off UNUSEDSIGNAL */
    input [`Vec(`RegWidth)]  mem_wdata,
    input mem_wen
);

    localparam  addr_width = 9;
    // localparam  addr_width = 16;
    localparam  vmem_size   = (2**addr_width);
    /* verilator lint_off UNDRIVEN */
    reg [31:0]  vram_mem[vmem_size-1:0];


    wire [`Vec(`RegWidth)] sub_waddr   = mem_waddr - `FB_ADDR;
    wire [`Vec(`RegWidth)] shift_waddr = sub_waddr >> 2;

    always @(posedge clk) begin
      if (`InMem(mem_waddr, `FB_ADDR, `VRAM_LEN))
      if (mem_wen) begin
        vram_mem[shift_waddr[addr_width-1:0]][31:0] <= mem_wdata[31:0];
      end
    end
endmodule //vram
