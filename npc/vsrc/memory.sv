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
    input [`Vec(`WdtTypeCnt)] wdt_op,

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

    /* we need to deal with mem_rdata, because it's 8 bits aligned */
    wire [`Vec(`ImmWidth)] mem_rdata_temp;
    // wire [7:0] slice_7_0   = mem_rdata_temp[63:56];
    // wire [15:0] slice_15_0 = mem_rdata_temp[63:48];
    // wire [31:0] slice_31_0 = mem_rdata_temp[63:32];
    wire [7:0] slice_7_0   = mem_rdata_temp[7:0];
    wire [15:0] slice_15_0 = mem_rdata_temp[15:0];
    wire [31:0] slice_31_0 = mem_rdata_temp[31:0];

    MuxKey
    #(
      .NR_KEY   (4),
      .KEY_LEN  (`WdtTypeCnt),
      .DATA_LEN (`ImmWidth)
    )
    width_mux(
      .out(mem_rdata),
      .key(wdt_op),
      .lut({
      `Wdt8,   `ZEXT(slice_7_0, 8),
      `Wdt16,  `ZEXT(slice_15_0, 16),
      `Wdt32,  `ZEXT(slice_31_0, 32),
      `Wdt64,  mem_rdata_temp
      })
    );

    always @(posedge clk) begin
      if(mem_ren)
        pmem_read(mem_raddr, mem_rdata_temp);
      // else
        // mem_rdata <= 0;
    end

    always @(negedge clk) begin
      if(mem_wen)
        pmem_write(waddr, mem_wdata, wmask);
      else
        ;
    end

endmodule //memory
