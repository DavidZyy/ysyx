// Generated by CIRCT firtool-1.43.0
// Standard header to adapt well known macros to our needs.
`ifndef RANDOMIZE
  `ifdef RANDOMIZE_REG_INIT
    `define RANDOMIZE
  `endif // RANDOMIZE_REG_INIT
`endif // not def RANDOMIZE
`ifndef RANDOMIZE
  `ifdef RANDOMIZE_MEM_INIT
    `define RANDOMIZE
  `endif // RANDOMIZE_MEM_INIT
`endif // not def RANDOMIZE

// RANDOM may be set to an expression that produces a 32-bit random unsigned value.
`ifndef RANDOM
  `define RANDOM $random
`endif // not def RANDOM

// Users can define INIT_RANDOM as general code that gets injected into the
// initializer block for modules with registers.
`ifndef INIT_RANDOM
  `define INIT_RANDOM
`endif // not def INIT_RANDOM

// If using random initialization, you can also define RANDOMIZE_DELAY to
// customize the delay used, otherwise 0.002 is used.
`ifndef RANDOMIZE_DELAY
  `define RANDOMIZE_DELAY 0.002
`endif // not def RANDOMIZE_DELAY

// Define INIT_RANDOM_PROLOG_ for use in our modules below.
`ifndef INIT_RANDOM_PROLOG_
  `ifdef RANDOMIZE
    `ifdef VERILATOR
      `define INIT_RANDOM_PROLOG_ `INIT_RANDOM
    `else  // VERILATOR
      `define INIT_RANDOM_PROLOG_ `INIT_RANDOM #`RANDOMIZE_DELAY begin end
    `endif // VERILATOR
  `else  // RANDOMIZE
    `define INIT_RANDOM_PROLOG_
  `endif // RANDOMIZE
`endif // not def INIT_RANDOM_PROLOG_

// Include register initializers in init blocks unless synthesis is set
`ifndef SYNTHESIS
  `ifndef ENABLE_INITIAL_REG_
    `define ENABLE_INITIAL_REG_
  `endif // not def ENABLE_INITIAL_REG_
`endif // not def SYNTHESIS

// Include rmemory initializers in init blocks unless synthesis is set
`ifndef SYNTHESIS
  `ifndef ENABLE_INITIAL_MEM_
    `define ENABLE_INITIAL_MEM_
  `endif // not def ENABLE_INITIAL_MEM_
`endif // not def SYNTHESIS

module sram_axi_rw(	// <stdin>:2955:10, :3453:10
  input         clock,	// <stdin>:2956:11, :3454:11
                reset,	// <stdin>:2957:11, :3455:11
                axi_ar_valid,	// src/main/scala/rv32e/dev/sram_Axi.scala:86:17
  input  [31:0] axi_ar_bits_addr,	// src/main/scala/rv32e/dev/sram_Axi.scala:86:17
  input  [7:0]  axi_ar_bits_len,	// src/main/scala/rv32e/dev/sram_Axi.scala:86:17
  input         axi_r_ready,	// src/main/scala/rv32e/dev/sram_Axi.scala:86:17
                axi_aw_valid,	// src/main/scala/rv32e/dev/sram_Axi.scala:86:17
  input  [31:0] axi_aw_bits_addr,	// src/main/scala/rv32e/dev/sram_Axi.scala:86:17
  input  [7:0]  axi_aw_bits_len,	// src/main/scala/rv32e/dev/sram_Axi.scala:86:17
  input  [1:0]  axi_aw_bits_burst,	// src/main/scala/rv32e/dev/sram_Axi.scala:86:17
  input         axi_w_valid,	// src/main/scala/rv32e/dev/sram_Axi.scala:86:17
  input  [31:0] axi_w_bits_data,	// src/main/scala/rv32e/dev/sram_Axi.scala:86:17
  input  [3:0]  axi_w_bits_strb,	// src/main/scala/rv32e/dev/sram_Axi.scala:86:17
  output        axi_ar_ready,	// src/main/scala/rv32e/dev/sram_Axi.scala:86:17
                axi_r_valid,	// src/main/scala/rv32e/dev/sram_Axi.scala:86:17
  output [31:0] axi_r_bits_data,	// src/main/scala/rv32e/dev/sram_Axi.scala:86:17
  output        axi_r_bits_last,	// src/main/scala/rv32e/dev/sram_Axi.scala:86:17
                axi_aw_ready,	// src/main/scala/rv32e/dev/sram_Axi.scala:86:17
                axi_w_ready	// src/main/scala/rv32e/dev/sram_Axi.scala:86:17
);

  reg         delay;	// src/main/scala/rv32e/dev/sram_Axi.scala:89:24
  reg  [7:0]  reg_AxLen;	// src/main/scala/rv32e/dev/sram_Axi.scala:92:28
  reg  [31:0] reg_addr;	// src/main/scala/rv32e/dev/sram_Axi.scala:93:28
  reg  [1:0]  reg_burst;	// src/main/scala/rv32e/dev/sram_Axi.scala:94:28
  reg  [2:0]  state_sram;	// src/main/scala/rv32e/dev/sram_Axi.scala:99:29
  wire        _axi_aw_ready_output = state_sram == 3'h0;	// src/main/scala/rv32e/dev/sram_Axi.scala:99:29, :100:25
  wire        _GEN = state_sram == 3'h2;	// src/main/scala/rv32e/dev/sram_Axi.scala:99:29, :100:25, :120:34
  wire        _GEN_0 = state_sram == 3'h3;	// src/main/scala/rv32e/dev/sram_Axi.scala:99:29, :100:25, :120:34
  wire        _GEN_1 = state_sram == 3'h5;	// src/main/scala/rv32e/dev/sram_Axi.scala:99:29, :100:25, :139:28
  wire        _GEN_2 = state_sram == 3'h6;	// src/main/scala/rv32e/dev/sram_Axi.scala:99:29, :100:25, :146:31
  wire        _axi_r_valid_output = _GEN_0 | _GEN;	// src/main/scala/chisel3/util/Mux.scala:77:13, src/main/scala/rv32e/dev/sram_Axi.scala:100:25
  wire        _axi_w_ready_output = (&state_sram) | _GEN_2 | _GEN_1;	// src/main/scala/chisel3/util/Mux.scala:77:13, src/main/scala/rv32e/dev/sram_Axi.scala:99:29, :100:25
  always @(posedge clock) begin	// <stdin>:2956:11, :3454:11
    if (reset) begin	// <stdin>:2956:11, :3454:11
      delay <= 1'h0;	// <stdin>:2955:10, :3453:10, src/main/scala/rv32e/dev/sram_Axi.scala:89:24
      reg_AxLen <= 8'h0;	// src/main/scala/rv32e/dev/sram_Axi.scala:92:28, :120:45
      reg_addr <= 32'h0;	// src/main/scala/rv32e/dev/sram_Axi.scala:93:28
      reg_burst <= 2'h3;	// src/main/scala/rv32e/dev/sram_Axi.scala:94:28
      state_sram <= 3'h0;	// src/main/scala/rv32e/dev/sram_Axi.scala:99:29
    end
    else begin	// <stdin>:2956:11, :3454:11
      automatic logic             _GEN_3;	// src/main/scala/chisel3/util/Decoupled.scala:52:35
      automatic logic             _GEN_4;	// src/main/scala/chisel3/util/Decoupled.scala:52:35
      automatic logic             _GEN_5;	// src/main/scala/rv32e/dev/sram_Axi.scala:120:45
      automatic logic             _GEN_6;	// src/main/scala/rv32e/dev/sram_Axi.scala:127:42
      automatic logic             _GEN_7 = axi_r_ready & _axi_r_valid_output;	// src/main/scala/chisel3/util/Decoupled.scala:52:35, src/main/scala/chisel3/util/Mux.scala:77:13
      automatic logic [7:0]       _GEN_8;	// src/main/scala/rv32e/dev/sram_Axi.scala:128:53
      automatic logic [31:0]      _GEN_9;	// src/main/scala/rv32e/dev/sram_Axi.scala:130:53
      automatic logic             _GEN_10;	// src/main/scala/chisel3/util/Mux.scala:77:13
      automatic logic             _GEN_11;	// src/main/scala/rv32e/dev/sram_Axi.scala:100:25
      automatic logic             _GEN_12 = _axi_w_ready_output & axi_w_valid;	// src/main/scala/chisel3/util/Decoupled.scala:52:35, src/main/scala/chisel3/util/Mux.scala:77:13
      automatic logic             _GEN_13;	// src/main/scala/rv32e/dev/sram_Axi.scala:92:28, :100:25
      automatic logic [7:0]       _GEN_14;	// src/main/scala/rv32e/dev/sram_Axi.scala:92:28, :100:25
      automatic logic [31:0]      _GEN_15;	// src/main/scala/rv32e/dev/sram_Axi.scala:93:28, :100:25
      automatic logic [7:0][7:0]  _GEN_16;	// src/main/scala/rv32e/dev/sram_Axi.scala:92:28, :100:25, :104:32, :128:25
      automatic logic [7:0][31:0] _GEN_17;	// src/main/scala/rv32e/dev/sram_Axi.scala:93:28, :100:25, :104:32, :129:25
      automatic logic [7:0][2:0]  _GEN_18;	// src/main/scala/rv32e/dev/sram_Axi.scala:99:29, :100:25, :104:32, :119:34, :127:25, :134:24, :137:34, :146:25, :149:25, :157:24
      _GEN_3 = _axi_aw_ready_output & axi_ar_valid;	// src/main/scala/chisel3/util/Decoupled.scala:52:35, src/main/scala/rv32e/dev/sram_Axi.scala:100:25
      _GEN_4 = _axi_aw_ready_output & axi_aw_valid;	// src/main/scala/chisel3/util/Decoupled.scala:52:35, src/main/scala/rv32e/dev/sram_Axi.scala:100:25
      _GEN_5 = reg_AxLen == 8'h0;	// src/main/scala/rv32e/dev/sram_Axi.scala:92:28, :120:45
      _GEN_6 = reg_AxLen == 8'h1;	// src/main/scala/rv32e/dev/sram_Axi.scala:92:28, :127:42
      _GEN_8 = reg_AxLen - 8'h1;	// src/main/scala/rv32e/dev/sram_Axi.scala:92:28, :128:53
      _GEN_9 = reg_addr + 32'h4;	// src/main/scala/rv32e/dev/sram_Axi.scala:93:28, :130:53
      _GEN_10 = reg_burst == 2'h1;	// <stdin>:2955:10, :3453:10, src/main/scala/chisel3/util/Mux.scala:77:13, src/main/scala/rv32e/dev/sram_Axi.scala:94:28
      _GEN_11 = state_sram == 3'h4;	// src/main/scala/rv32e/dev/sram_Axi.scala:99:29, :100:25, :110:28
      _GEN_13 = _GEN_0 | _GEN_11 | _GEN_1;	// src/main/scala/rv32e/dev/sram_Axi.scala:92:28, :100:25
      _GEN_14 = _GEN_13 | ~(_GEN_2 & _GEN_12) ? reg_AxLen : _GEN_8;	// src/main/scala/chisel3/util/Decoupled.scala:52:35, src/main/scala/rv32e/dev/sram_Axi.scala:92:28, :100:25, :128:53, :151:{25,31}
      _GEN_15 = _GEN_13 | ~(_GEN_2 & _GEN_10 & _GEN_12) ? reg_addr : _GEN_9;	// src/main/scala/chisel3/util/Decoupled.scala:52:35, src/main/scala/chisel3/util/Mux.scala:77:13, src/main/scala/rv32e/dev/sram_Axi.scala:92:28, :93:28, :100:25, :130:53, :152:25, :153:30
      delay <=
        ~_axi_aw_ready_output
        & (state_sram == 3'h1 | ~(_GEN | _GEN_0 | ~_GEN_11) ? delay - 1'h1 : delay);	// src/main/scala/rv32e/dev/sram_Axi.scala:89:24, :99:29, :100:25, :102:19, :105:28, :124:{19,28}
      _GEN_16 =
        {{_GEN_14},
         {_GEN_14},
         {reg_AxLen},
         {reg_AxLen},
         {reg_AxLen},
         {_GEN_7 ? _GEN_8 : reg_AxLen},
         {reg_AxLen},
         {_GEN_3 ? axi_ar_bits_len : _GEN_4 ? axi_aw_bits_len : reg_AxLen}};	// src/main/scala/chisel3/util/Decoupled.scala:52:35, src/main/scala/rv32e/dev/sram_Axi.scala:92:28, :100:25, :104:32, :106:28, :109:39, :111:28, :128:{25,31,53}
      reg_AxLen <= _GEN_16[state_sram];	// src/main/scala/rv32e/dev/sram_Axi.scala:92:28, :99:29, :100:25, :104:32, :128:25
      _GEN_17 =
        {{_GEN_15},
         {_GEN_15},
         {reg_addr},
         {reg_addr},
         {reg_addr},
         {_GEN_10 & _GEN_7 ? _GEN_9 : reg_addr},
         {reg_addr},
         {_GEN_3 ? axi_ar_bits_addr : _GEN_4 ? axi_aw_bits_addr : reg_addr}};	// src/main/scala/chisel3/util/Decoupled.scala:52:35, src/main/scala/chisel3/util/Mux.scala:77:13, src/main/scala/rv32e/dev/sram_Axi.scala:93:28, :100:25, :104:32, :107:28, :109:39, :112:28, :129:25, :130:{30,53}
      reg_addr <= _GEN_17[state_sram];	// src/main/scala/rv32e/dev/sram_Axi.scala:93:28, :99:29, :100:25, :104:32, :129:25
      if (_axi_aw_ready_output) begin	// src/main/scala/rv32e/dev/sram_Axi.scala:100:25
        if (_GEN_3)	// src/main/scala/chisel3/util/Decoupled.scala:52:35
          reg_burst <= 2'h1;	// <stdin>:2955:10, :3453:10, src/main/scala/rv32e/dev/sram_Axi.scala:94:28
        else if (_GEN_4)	// src/main/scala/chisel3/util/Decoupled.scala:52:35
          reg_burst <= axi_aw_bits_burst;	// src/main/scala/rv32e/dev/sram_Axi.scala:94:28
      end
      _GEN_18 =
        {{3'h0},
         {{2'h3, _GEN_6}},
         {{2'h3, _GEN_5}},
         {{2'h2, ~delay}},
         {3'h0},
         {{2'h1, _GEN_6}},
         {delay ? 3'h1 : {2'h1, _GEN_5}},
         {_GEN_3 ? 3'h1 : {_GEN_4, 2'h0}}};	// <stdin>:2955:10, :3453:10, src/main/scala/chisel3/util/Decoupled.scala:52:35, src/main/scala/rv32e/dev/sram_Axi.scala:89:24, :94:28, :99:29, :100:25, :104:32, :105:28, :109:39, :110:28, :115:28, :119:{25,34}, :120:{28,34,45}, :122:28, :127:{25,31,42}, :134:24, :137:34, :139:28, :141:28, :146:{25,31}, :149:{25,31}, :157:24
      state_sram <= _GEN_18[state_sram];	// src/main/scala/rv32e/dev/sram_Axi.scala:99:29, :100:25, :104:32, :119:34, :127:25, :134:24, :137:34, :146:25, :149:25, :157:24
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_	// <stdin>:2955:10, :3453:10
    `ifdef FIRRTL_BEFORE_INITIAL	// <stdin>:2955:10, :3453:10
      `FIRRTL_BEFORE_INITIAL	// <stdin>:2955:10, :3453:10
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin	// <stdin>:2955:10, :3453:10
      automatic logic [31:0] _RANDOM[0:1];	// <stdin>:2955:10, :3453:10
      `ifdef INIT_RANDOM_PROLOG_	// <stdin>:2955:10, :3453:10
        `INIT_RANDOM_PROLOG_	// <stdin>:2955:10, :3453:10
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT	// <stdin>:2955:10, :3453:10
        for (logic [1:0] i = 2'h0; i < 2'h2; i += 2'h1) begin
          _RANDOM[i[0]] = `RANDOM;	// <stdin>:2955:10, :3453:10
        end	// <stdin>:2955:10, :3453:10
        delay = _RANDOM[1'h0][0];	// <stdin>:2955:10, :3453:10, src/main/scala/rv32e/dev/sram_Axi.scala:89:24
        reg_AxLen = _RANDOM[1'h0][8:1];	// <stdin>:2955:10, :3453:10, src/main/scala/rv32e/dev/sram_Axi.scala:89:24, :92:28
        reg_addr = {_RANDOM[1'h0][31:9], _RANDOM[1'h1][8:0]};	// <stdin>:2955:10, :3453:10, src/main/scala/rv32e/dev/sram_Axi.scala:89:24, :93:28
        reg_burst = _RANDOM[1'h1][10:9];	// <stdin>:2955:10, :3453:10, src/main/scala/rv32e/dev/sram_Axi.scala:93:28, :94:28
        state_sram = _RANDOM[1'h1][13:11];	// <stdin>:2955:10, :3453:10, src/main/scala/rv32e/dev/sram_Axi.scala:93:28, :99:29
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL	// <stdin>:2955:10, :3453:10
      `FIRRTL_AFTER_INITIAL	// <stdin>:2955:10, :3453:10
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  RamBB RamBB_i1 (	// src/main/scala/rv32e/dev/sram_Axi.scala:161:26
    .clock   (clock),
    .addr    (reg_addr),	// src/main/scala/rv32e/dev/sram_Axi.scala:93:28
    .mem_wen ((&state_sram) | _GEN_2),	// src/main/scala/chisel3/util/Mux.scala:77:13, src/main/scala/rv32e/dev/sram_Axi.scala:99:29, :100:25
    .valid   ((&state_sram) | _GEN_2 | _GEN_0 | _GEN),	// src/main/scala/chisel3/util/Mux.scala:77:13, src/main/scala/rv32e/dev/sram_Axi.scala:99:29, :100:25
    .wdata   (axi_w_bits_data),
    .wmask   (axi_w_bits_strb),
    .rdata   (axi_r_bits_data)
  );
  assign axi_ar_ready = _axi_aw_ready_output;	// <stdin>:2955:10, :3453:10, src/main/scala/rv32e/dev/sram_Axi.scala:100:25
  assign axi_r_valid = _axi_r_valid_output;	// <stdin>:2955:10, :3453:10, src/main/scala/chisel3/util/Mux.scala:77:13
  assign axi_r_bits_last = _GEN_0;	// <stdin>:2955:10, :3453:10, src/main/scala/rv32e/dev/sram_Axi.scala:100:25
  assign axi_aw_ready = _axi_aw_ready_output;	// <stdin>:2955:10, :3453:10, src/main/scala/rv32e/dev/sram_Axi.scala:100:25
  assign axi_w_ready = _axi_w_ready_output;	// <stdin>:2955:10, :3453:10, src/main/scala/chisel3/util/Mux.scala:77:13
endmodule

