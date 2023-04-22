/* move instructions to rom, this module act like ram */
`include "../include/defines.v"

import "DPI-C" function void pmem_read(
  input longint mem_raddr, output longint rinst);
import "DPI-C" function void pmem_write(
  input longint mem_waddr, input longint wdata, input byte wmask);

module memory (
    input clk,
    input [`Vec(`RegWidth)]  mem_raddr,
    input [`Vec(`AddrWidth)] mem_waddr,
    /* verilator lint_off UNUSEDSIGNAL */
    input [`Vec(`RegWidth)]  mem_wdata,
    input mem_wen,
    input mem_ren,
    input [`Vec(`WdtTypeCnt)] wdt_op,

    output [`Vec(`ImmWidth)]  mem_rdata
);

    /* check  if aligned */
    always @(posedge clk) begin
      if(mem_ren) begin
          if( wdt_op == `Wdt16 ) begin
            if(mem_raddr[0]) begin
              $display("-----------------Not aligned 2  bytes-----------------");
              $display("%x", mem_raddr);
            end
          end

          if( wdt_op == `Wdt32 ) begin
            if(mem_raddr % 4 != 0) begin
              $display("-----------------Not aligned 4  bytes-----------------");
              $display("%x", mem_raddr);
            end
          end
          
          if( wdt_op == `Wdt64 ) begin
            if(mem_raddr % 8 != 0) begin
              $display("-----------------Not aligned 8  bytes-----------------");
              $display("%x", mem_raddr);
            end
          end
      end
    end


    localparam  addr_width = 8;
    localparam  mem_size   = (2**addr_width);
    /* verilator lint_off UNDRIVEN */
    reg [31:0]  ram_mem[mem_size-1:0];

    initial begin
        $readmemh("/home/zhuyangyang/project/ysyx-workbench/am-kernels/tests/cpu-tests/build/hello-str-riscv64-npc.ram.hex", ram_mem);
        // $readmemh("/home/zhuyangyang/project/ysyx-workbench/am-kernels/tests/cpu-tests/build/test_store_load-riscv64-npc.ram.hex", ram_mem);
    end
/********************************** read data ****************************************/
    wire [`Vec(`RegWidth)] sub_raddr   = mem_raddr - `RamAddr;
    /* align to 4 bytes */
    wire [`Vec(`RegWidth)] shift_raddr = sub_raddr >> 2;

    localparam mask = 64'h1;
    /* align to 8 bytes */
    /* verilator lint_off UNUSEDSIGNAL */
    wire [`Vec(`RegWidth)] ram_raddr = shift_raddr & ~mask;


    always @(posedge clk) begin
      if(mem_ren)
        pmem_read(mem_raddr, width_64_out);
    end

    // always @(posedge clk) begin
    //     if(mem_ren) begin
    //       width_64_out[31:0]  <= ram_mem[ram_raddr[addr_width-1:0]][31:0];
    //       width_64_out[63:32] <= ram_mem[ram_raddr[addr_width-1:0] + 1][31:0];
    //     end
    // end

    wire [7:0] wmask;

    MuxKey
    #(
      .NR_KEY   (4),
      .KEY_LEN  (`WdtTypeCnt),
      .DATA_LEN (8)
    )
    wmask_mux(
      .out(wmask),
      .key(wdt_op),
      .lut({
        `Wdt8,   8'h01,
        `Wdt16,  8'h03,
        `Wdt32,  8'h0f,
        `Wdt64,  8'hff
      })
    );


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
    // wire [`Vec(`ImmWidth)] width_64_out;
    /* verilator lint_off BLKSEQ */
    reg  [`Vec(`ImmWidth)] width_64_out;

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
      .key(wdt_op),
      .lut({
        `Wdt8,   width_8_out,
        `Wdt16,  width_16_out,
        `Wdt32,  width_32_out,
        `Wdt64,  width_64_out
      })
    );

/************************************ write data ***************************************/
    wire [`Vec(`RegWidth)] sub_waddr   = mem_waddr - `RamAddr;
    wire [`Vec(`RegWidth)] shift_waddr = sub_waddr >> 2;

    // always @(negedge clk) begin
    always @(posedge clk) begin
      if(mem_wen)
        pmem_write(mem_waddr, mem_wdata, wmask);
      else
        ;
    end

    // always @(negedge clk) begin
    always @(posedge clk) begin
      if(mem_wen) begin
        if(wdt_op == `Wdt8) begin
          /* 11, 10, 01, 00*/
          if(mem_waddr[1] & mem_waddr[0])
            ram_mem[shift_waddr[addr_width-1:0]][31:24] <= mem_wdata[7:0];
          else if(mem_waddr[1])
            ram_mem[shift_waddr[addr_width-1:0]][23:16] <= mem_wdata[7:0];
          else if(mem_waddr[0])
            ram_mem[shift_waddr[addr_width-1:0]][15:8] <= mem_wdata[7:0];
          else 
            ram_mem[shift_waddr[addr_width-1:0]][7:0] <= mem_wdata[7:0];
        end

        if(wdt_op == `Wdt16) begin
          /* 10, 00*/
          if(mem_waddr[1])
            ram_mem[shift_waddr[addr_width-1:0]][31:16] <= mem_wdata[15:0];
          else
            ram_mem[shift_waddr[addr_width-1:0]][15:0] <= mem_wdata[15:0];
        end

        if(wdt_op == `Wdt32) begin
            ram_mem[shift_waddr[addr_width-1:0]][31:0] <= mem_wdata[31:0];
        end

        if(wdt_op == `Wdt64) begin
            ram_mem[shift_waddr[addr_width-1:0]][31:0] <= mem_wdata[31:0];
            ram_mem[shift_waddr[addr_width-1:0] + 1][31:0] <= mem_wdata[63:32];
        end
      end
    end

    reg  [`Vec(`ImmWidth)] width_64_out_1;
    reg  [`Vec(`ImmWidth)] width_64_out_2;
    wire [`Vec(`RegWidth)] ram_waddr = shift_waddr & ~mask;

    /* check if write correct */
    always @(negedge clk) begin
        if(mem_wen) begin
          width_64_out_1[31:0]  = ram_mem[ram_waddr[addr_width-1:0]][31:0];
          width_64_out_1[63:32] = ram_mem[ram_waddr[addr_width-1:0] + 1][31:0];
          pmem_read(mem_waddr, width_64_out_2);
          if(width_64_out_1 != width_64_out_2)
            exit_code();
        end
    end
endmodule //memory
