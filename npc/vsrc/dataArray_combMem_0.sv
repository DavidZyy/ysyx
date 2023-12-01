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

// VCS coverage exclude_file
module dataArray_combMem_0(	// src/main/scala/rv32e/cache/dcache.scala:30:33
  input  [6:0]  R0_addr,
  input         R0_en,
                R0_clk,
  input  [6:0]  R1_addr,
  input         R1_en,
                R1_clk,
  input  [6:0]  W0_addr,
  input         W0_en,
                W0_clk,
  input  [31:0] W0_data,
  input  [6:0]  W1_addr,
  input         W1_en,
                W1_clk,
  input  [31:0] W1_data,
  output [31:0] R0_data,
                R1_data
);

  reg [31:0] Memory[0:127];	// src/main/scala/rv32e/cache/dcache.scala:30:33
  reg        _GEN;	// src/main/scala/rv32e/cache/dcache.scala:30:33
  reg [6:0]  _GEN_0;	// src/main/scala/rv32e/cache/dcache.scala:30:33
  always @(posedge R0_clk) begin	// src/main/scala/rv32e/cache/dcache.scala:30:33
    _GEN <= R0_en;	// src/main/scala/rv32e/cache/dcache.scala:30:33
    _GEN_0 <= R0_addr;	// src/main/scala/rv32e/cache/dcache.scala:30:33
  end // always @(posedge)
  reg        _GEN_1;	// src/main/scala/rv32e/cache/dcache.scala:30:33
  reg [6:0]  _GEN_2;	// src/main/scala/rv32e/cache/dcache.scala:30:33
  always @(posedge R1_clk) begin	// src/main/scala/rv32e/cache/dcache.scala:30:33
    _GEN_1 <= R1_en;	// src/main/scala/rv32e/cache/dcache.scala:30:33
    _GEN_2 <= R1_addr;	// src/main/scala/rv32e/cache/dcache.scala:30:33
  end // always @(posedge)
  always @(posedge W0_clk) begin	// src/main/scala/rv32e/cache/dcache.scala:30:33
    if (W0_en)	// src/main/scala/rv32e/cache/dcache.scala:30:33
      Memory[W0_addr] <= W0_data;	// src/main/scala/rv32e/cache/dcache.scala:30:33
    if (W1_en)	// src/main/scala/rv32e/cache/dcache.scala:30:33
      Memory[W1_addr] <= W1_data;	// src/main/scala/rv32e/cache/dcache.scala:30:33
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_MEM_	// src/main/scala/rv32e/cache/dcache.scala:30:33
    `ifdef RANDOMIZE_REG_INIT	// src/main/scala/rv32e/cache/dcache.scala:30:33
      reg [31:0] _RANDOM;	// src/main/scala/rv32e/cache/dcache.scala:30:33
    `endif // RANDOMIZE_REG_INIT
    reg [31:0] _RANDOM_MEM;	// src/main/scala/rv32e/cache/dcache.scala:30:33
    initial begin	// src/main/scala/rv32e/cache/dcache.scala:30:33
      `INIT_RANDOM_PROLOG_	// src/main/scala/rv32e/cache/dcache.scala:30:33
      `ifdef RANDOMIZE_MEM_INIT	// src/main/scala/rv32e/cache/dcache.scala:30:33
        for (logic [7:0] i = 8'h0; i < 8'h80; i += 8'h1) begin
          _RANDOM_MEM = `RANDOM;	// src/main/scala/rv32e/cache/dcache.scala:30:33
          Memory[i[6:0]] = _RANDOM_MEM;	// src/main/scala/rv32e/cache/dcache.scala:30:33
        end	// src/main/scala/rv32e/cache/dcache.scala:30:33
      `endif // RANDOMIZE_MEM_INIT
      `ifdef RANDOMIZE_REG_INIT	// src/main/scala/rv32e/cache/dcache.scala:30:33
        _RANDOM = {`RANDOM};	// src/main/scala/rv32e/cache/dcache.scala:30:33
        _GEN = _RANDOM[0];	// src/main/scala/rv32e/cache/dcache.scala:30:33
        _GEN_0 = _RANDOM[7:1];	// src/main/scala/rv32e/cache/dcache.scala:30:33
        _GEN_1 = _RANDOM[8];	// src/main/scala/rv32e/cache/dcache.scala:30:33
        _GEN_2 = _RANDOM[15:9];	// src/main/scala/rv32e/cache/dcache.scala:30:33
      `endif // RANDOMIZE_REG_INIT
    end // initial
  `endif // ENABLE_INITIAL_MEM_
  assign R0_data = _GEN ? Memory[_GEN_0] : 32'bx;	// src/main/scala/rv32e/cache/dcache.scala:30:33
  assign R1_data = _GEN_1 ? Memory[_GEN_2] : 32'bx;	// src/main/scala/rv32e/cache/dcache.scala:30:33
endmodule

