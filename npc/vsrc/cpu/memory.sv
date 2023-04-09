/* move instructions to rom, this module act like ram */
`include "./include/defines.v"

import "DPI-C" function void pmem_read(
  input longint mem_raddr, output longint rinst);
import "DPI-C" function void pmem_write(
  input longint waddr, input longint wdata, input byte wmask);

module memory (
    input   clk,
    // input [`Vec(`RegWidth)] pc,
    input [`Vec(`RegWidth)] mem_raddr,
    input [`Vec(`AddrWidth)] waddr,
    input [`Vec(`RegWidth)] mem_wdata,
    // input [7:0] wmask,
    input mem_wen,
    input mem_ren,
    input [`Vec(`WdtTypeCnt)] wdt_op_ID,

    // output [`Vec(`InstWidth)] inst,
    output [`Vec(`ImmWidth)] mem_rdata
);
//     localparam mask = 64'h7;
// 
//     wire [`Vec(`RegWidth)] rinst;
//     assign inst = (pc & mask) == 0 ? rinst[`Vec(`InstWidth)] : rinst[63:32];
// 
//     /* We should read instructions immediately when pc changes. */
//     always @(*) begin
//       pmem_read(pc, rinst);
//     end

    always @(posedge clk) begin
    // always @(*) begin
      if(mem_ren)
        pmem_read(mem_raddr, width_64_out);
      // else
        // mem_rdata = 0;
    end

    wire [7:0] wmask;

    MuxKey
    #(
      .NR_KEY   (4),
      .KEY_LEN  (`WdtTypeCnt),
      .DATA_LEN (8)
    )
    wmask_mux(
      .out(wmask),
      .key(wdt_op_ID),
      .lut({
        `Wdt8,   8'h01,
        `Wdt16,  8'h03,
        `Wdt32,  8'h0f,
        `Wdt64,  8'hff
      })
    );

    always @(negedge clk) begin
      if(mem_wen)
        pmem_write(waddr, mem_wdata, wmask);
      else
        ;
    end


    /* we need to deal with mem_rdata, because it's 8 bits aligned */
    /* lw has two cases: 63:32, 31:0, lh has four cases and lb has eight cases */

    wire [7:0] slice_7_0     = width_64_out[7:0];
    wire [7:0] slice_15_8    = width_64_out[15:8];
    wire [7:0] slice_23_16   = width_64_out[23:16];
    wire [7:0] slice_31_24   = width_64_out[31:24];
    wire [7:0] slice_39_32   = width_64_out[39:32];
    wire [7:0] slice_47_40   = width_64_out[47:40];
    wire [7:0] slice_55_48   = width_64_out[55:48];
    wire [7:0] slice_63_56   = width_64_out[63:56];

    wire [15:0] slice_15_0  = width_64_out[15:0];
    wire [15:0] slice_31_16 = width_64_out[31:16];
    wire [15:0] slice_47_32 = width_64_out[47:32];
    wire [15:0] slice_63_48 = width_64_out[63:48];

    wire [31:0] slice_31_0  = width_64_out[31:0];
    wire [31:0] slice_63_32 = width_64_out[63:32];

    wire [`Vec(`ImmWidth)] width_8_out;
    wire [`Vec(`ImmWidth)] width_16_out;
    wire [`Vec(`ImmWidth)] width_32_out;
    wire [`Vec(`ImmWidth)] width_64_out;

    MuxKey
    #(
      .NR_KEY   (8),
      .KEY_LEN  (3),
      .DATA_LEN (`ImmWidth)
    )
    width_8_mux(
      .out(width_8_out),
      .key(mem_raddr[2:0] & 3'b111),
      .lut({
        3'b000, `ZEXT(slice_7_0,   8),
        3'b001, `ZEXT(slice_15_8,  8),
        3'b010, `ZEXT(slice_23_16, 8),
        3'b011, `ZEXT(slice_31_24, 8),
        3'b100, `ZEXT(slice_39_32, 8),
        3'b101, `ZEXT(slice_47_40, 8),
        3'b110, `ZEXT(slice_55_48, 8),
        3'b111, `ZEXT(slice_63_56, 8)
      })
    );

    MuxKey
    #(
      .NR_KEY   (4),
      .KEY_LEN  (3),
      .DATA_LEN (`ImmWidth)
    )
    width_16_mux(
      .out(width_16_out),
      .key(mem_raddr[2:0] & 3'b111),
      .lut({
        3'b000, `ZEXT(slice_15_0,   16),
        3'b010, `ZEXT(slice_31_16,  16),
        3'b100, `ZEXT(slice_47_32,  16),
        3'b110, `ZEXT(slice_63_48,  16)
      })
    );

    MuxKey
    #(
      .NR_KEY   (2),
      .KEY_LEN  (3),
      .DATA_LEN (`ImmWidth)
    )
    width_32_mux(
      .out(width_32_out),
      .key(mem_raddr[2:0] & 3'b111),
      .lut({
        3'b000, `ZEXT(slice_31_0,  32),
        3'b100, `ZEXT(slice_63_32, 32)
      })
    );


  /* choose the true memory read data acording to width */
    MuxKey
    #(
      .NR_KEY   (4),
      .KEY_LEN  (`WdtTypeCnt),
      .DATA_LEN (`ImmWidth)
    )
    rdata_mux(
      .out(mem_rdata),
      .key(wdt_op_ID),
      .lut({
        `Wdt8,   width_8_out,
        `Wdt16,  width_16_out,
        `Wdt32,  width_32_out,
        `Wdt64,  width_64_out
      })
    );


endmodule //memory
