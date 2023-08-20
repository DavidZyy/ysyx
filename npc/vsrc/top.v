/* verilator lint_off DECLFILENAME */
/* verilator lint_off UNUSEDSIGNAL */
/* verilator lint_off UNDRIVEN */
module PCReg(
  input         clock,
  input         reset,
  output [31:0] io_cur_pc,
  input         io_ctrl_br,
  input  [31:0] io_addr_target
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] regPC; // @[pc.scala 17:24]
  wire [31:0] _regPC_T_1 = regPC + 32'h4; // @[pc.scala 22:24]
  assign io_cur_pc = regPC; // @[pc.scala 25:15]
  always @(posedge clock) begin
    if (reset) begin // @[pc.scala 17:24]
      regPC <= 32'h80000000; // @[pc.scala 17:24]
    end else if (io_ctrl_br) begin // @[pc.scala 19:23]
      regPC <= io_addr_target; // @[pc.scala 20:15]
    end else begin
      regPC <= _regPC_T_1; // @[pc.scala 22:15]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  regPC = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Rom(
  input         clock,
  input  [31:0] io_addr,
  output [31:0] io_inst
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
  reg [31:0] mem [0:1023]; // @[instmem.scala 20:18]
  wire  mem_io_inst_MPORT_en; // @[instmem.scala 20:18]
  wire [9:0] mem_io_inst_MPORT_addr; // @[instmem.scala 20:18]
  wire [31:0] mem_io_inst_MPORT_data; // @[instmem.scala 20:18]
  wire [31:0] true_addr = io_addr - 32'h80000000; // @[instmem.scala 21:29]
  assign mem_io_inst_MPORT_en = 1'h1;
  assign mem_io_inst_MPORT_addr = true_addr[11:2];
  assign mem_io_inst_MPORT_data = mem[mem_io_inst_MPORT_addr]; // @[instmem.scala 20:18]
  assign io_inst = mem_io_inst_MPORT_data; // @[instmem.scala 23:13]
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1024; initvar = initvar+1)
    mem[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Decoder(
  input  [31:0] io_inst,
  output [31:0] io_out_imm,
  output [3:0]  io_out_rs1,
  output [3:0]  io_out_rs2,
  output [3:0]  io_out_rd,
  output        io_out_ctrl_sig_mem_wen,
  output        io_out_ctrl_sig_reg_wen,
  output [1:0]  io_out_ctrl_sig_src1_op,
  output [1:0]  io_out_ctrl_sig_src2_op,
  output [3:0]  io_out_ctrl_sig_alu_op,
  output [3:0]  io_out_ctrl_sig_lsu_op,
  output [3:0]  io_out_ctrl_sig_bru_op
);
  wire [19:0] _imm_i_T_2 = io_inst[31] ? 20'hfffff : 20'h0; // @[Bitwise.scala 77:12]
  wire [31:0] imm_i = {_imm_i_T_2,io_inst[31:20]}; // @[Cat.scala 33:92]
  wire [31:0] imm_s = {_imm_i_T_2,io_inst[31:25],io_inst[11:7]}; // @[Cat.scala 33:92]
  wire [31:0] imm_b = {_imm_i_T_2,io_inst[7],io_inst[30:25],io_inst[11:8],1'h0}; // @[Cat.scala 33:92]
  wire [31:0] imm_u = {io_inst[31:12],12'h0}; // @[Cat.scala 33:92]
  wire [11:0] _imm_j_T_2 = io_inst[31] ? 12'hfff : 12'h0; // @[Bitwise.scala 77:12]
  wire [32:0] imm_j = {_imm_j_T_2,io_inst[31],io_inst[19:12],io_inst[20],io_inst[30:21],1'h0}; // @[Cat.scala 33:92]
  wire [31:0] decode_info_invInputs = ~io_inst; // @[pla.scala 78:21]
  wire  decode_info_andMatrixInput_0 = io_inst[0]; // @[pla.scala 90:45]
  wire  decode_info_andMatrixInput_1 = io_inst[1]; // @[pla.scala 90:45]
  wire  decode_info_andMatrixInput_2 = decode_info_invInputs[2]; // @[pla.scala 91:29]
  wire  decode_info_andMatrixInput_3 = decode_info_invInputs[3]; // @[pla.scala 91:29]
  wire  decode_info_andMatrixInput_4 = decode_info_invInputs[4]; // @[pla.scala 91:29]
  wire  decode_info_andMatrixInput_5 = decode_info_invInputs[5]; // @[pla.scala 91:29]
  wire  decode_info_andMatrixInput_6 = decode_info_invInputs[6]; // @[pla.scala 91:29]
  wire  decode_info_andMatrixInput_7 = decode_info_invInputs[13]; // @[pla.scala 91:29]
  wire [7:0] _decode_info_T = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,decode_info_andMatrixInput_2,
    decode_info_andMatrixInput_3,decode_info_andMatrixInput_4,decode_info_andMatrixInput_5,decode_info_andMatrixInput_6,
    decode_info_andMatrixInput_7}; // @[Cat.scala 33:92]
  wire  _decode_info_T_1 = &_decode_info_T; // @[pla.scala 98:74]
  wire  decode_info_andMatrixInput_6_1 = decode_info_invInputs[12]; // @[pla.scala 91:29]
  wire [7:0] _decode_info_T_2 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,decode_info_andMatrixInput_2,
    decode_info_andMatrixInput_3,decode_info_andMatrixInput_5,decode_info_andMatrixInput_6,
    decode_info_andMatrixInput_6_1,decode_info_andMatrixInput_7}; // @[Cat.scala 33:92]
  wire  _decode_info_T_3 = &_decode_info_T_2; // @[pla.scala 98:74]
  wire  decode_info_andMatrixInput_7_2 = decode_info_invInputs[14]; // @[pla.scala 91:29]
  wire [7:0] _decode_info_T_4 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,decode_info_andMatrixInput_2,
    decode_info_andMatrixInput_3,decode_info_andMatrixInput_4,decode_info_andMatrixInput_6,
    decode_info_andMatrixInput_6_1,decode_info_andMatrixInput_7_2}; // @[Cat.scala 33:92]
  wire  _decode_info_T_5 = &_decode_info_T_4; // @[pla.scala 98:74]
  wire [7:0] _decode_info_T_6 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,decode_info_andMatrixInput_2,
    decode_info_andMatrixInput_3,decode_info_andMatrixInput_5,decode_info_andMatrixInput_6,
    decode_info_andMatrixInput_6_1,decode_info_andMatrixInput_7_2}; // @[Cat.scala 33:92]
  wire  _decode_info_T_7 = &_decode_info_T_6; // @[pla.scala 98:74]
  wire [8:0] _decode_info_T_8 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,decode_info_andMatrixInput_2,
    decode_info_andMatrixInput_3,decode_info_andMatrixInput_4,decode_info_andMatrixInput_5,decode_info_andMatrixInput_6,
    decode_info_andMatrixInput_6_1,decode_info_andMatrixInput_7_2}; // @[Cat.scala 33:92]
  wire  _decode_info_T_9 = &_decode_info_T_8; // @[pla.scala 98:74]
  wire [7:0] _decode_info_T_10 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,decode_info_andMatrixInput_2
    ,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4,decode_info_andMatrixInput_6,decode_info_andMatrixInput_7
    ,decode_info_andMatrixInput_7_2}; // @[Cat.scala 33:92]
  wire  _decode_info_T_11 = &_decode_info_T_10; // @[pla.scala 98:74]
  wire  decode_info_andMatrixInput_2_6 = io_inst[2]; // @[pla.scala 90:45]
  wire  decode_info_andMatrixInput_4_6 = io_inst[4]; // @[pla.scala 90:45]
  wire [5:0] _decode_info_T_12 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,
    decode_info_andMatrixInput_2_6,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,
    decode_info_andMatrixInput_6}; // @[Cat.scala 33:92]
  wire  _decode_info_T_13 = &_decode_info_T_12; // @[pla.scala 98:74]
  wire [6:0] _decode_info_T_14 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,
    decode_info_andMatrixInput_2_6,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,
    decode_info_andMatrixInput_5,decode_info_andMatrixInput_6}; // @[Cat.scala 33:92]
  wire  _decode_info_T_15 = &_decode_info_T_14; // @[pla.scala 98:74]
  wire  decode_info_andMatrixInput_5_8 = io_inst[5]; // @[pla.scala 90:45]
  wire [8:0] _decode_info_T_16 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,decode_info_andMatrixInput_2
    ,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4,decode_info_andMatrixInput_5_8,
    decode_info_andMatrixInput_6,decode_info_andMatrixInput_6_1,decode_info_andMatrixInput_7_2}; // @[Cat.scala 33:92]
  wire  _decode_info_T_17 = &_decode_info_T_16; // @[pla.scala 98:74]
  wire [7:0] _decode_info_T_18 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,decode_info_andMatrixInput_2
    ,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4,decode_info_andMatrixInput_5_8,
    decode_info_andMatrixInput_7,decode_info_andMatrixInput_7_2}; // @[Cat.scala 33:92]
  wire  _decode_info_T_19 = &_decode_info_T_18; // @[pla.scala 98:74]
  wire [8:0] _decode_info_T_20 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,decode_info_andMatrixInput_2
    ,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4,decode_info_andMatrixInput_5_8,
    decode_info_andMatrixInput_6,decode_info_andMatrixInput_7,decode_info_andMatrixInput_7_2}; // @[Cat.scala 33:92]
  wire  _decode_info_T_21 = &_decode_info_T_20; // @[pla.scala 98:74]
  wire  decode_info_andMatrixInput_10 = decode_info_invInputs[25]; // @[pla.scala 91:29]
  wire  decode_info_andMatrixInput_11 = decode_info_invInputs[26]; // @[pla.scala 91:29]
  wire  decode_info_andMatrixInput_12 = decode_info_invInputs[27]; // @[pla.scala 91:29]
  wire  decode_info_andMatrixInput_13 = decode_info_invInputs[28]; // @[pla.scala 91:29]
  wire  decode_info_andMatrixInput_14 = decode_info_invInputs[29]; // @[pla.scala 91:29]
  wire  decode_info_andMatrixInput_15 = decode_info_invInputs[31]; // @[pla.scala 91:29]
  wire [7:0] decode_info_lo_11 = {decode_info_andMatrixInput_7,decode_info_andMatrixInput_7_2,
    decode_info_andMatrixInput_10,decode_info_andMatrixInput_11,decode_info_andMatrixInput_12,
    decode_info_andMatrixInput_13,decode_info_andMatrixInput_14,decode_info_andMatrixInput_15}; // @[Cat.scala 33:92]
  wire [15:0] _decode_info_T_22 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,
    decode_info_andMatrixInput_2,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,
    decode_info_andMatrixInput_5_8,decode_info_andMatrixInput_6,decode_info_andMatrixInput_6_1,decode_info_lo_11}; // @[Cat.scala 33:92]
  wire  _decode_info_T_23 = &_decode_info_T_22; // @[pla.scala 98:74]
  wire  decode_info_andMatrixInput_12_1 = decode_info_invInputs[30]; // @[pla.scala 91:29]
  wire [6:0] decode_info_lo_12 = {decode_info_andMatrixInput_10,decode_info_andMatrixInput_11,
    decode_info_andMatrixInput_12,decode_info_andMatrixInput_13,decode_info_andMatrixInput_14,
    decode_info_andMatrixInput_12_1,decode_info_andMatrixInput_15}; // @[Cat.scala 33:92]
  wire [13:0] _decode_info_T_24 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,
    decode_info_andMatrixInput_2,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,
    decode_info_andMatrixInput_5_8,decode_info_andMatrixInput_6,decode_info_lo_12}; // @[Cat.scala 33:92]
  wire  _decode_info_T_25 = &_decode_info_T_24; // @[pla.scala 98:74]
  wire [7:0] decode_info_lo_13 = {decode_info_andMatrixInput_7,decode_info_andMatrixInput_10,
    decode_info_andMatrixInput_11,decode_info_andMatrixInput_12,decode_info_andMatrixInput_13,
    decode_info_andMatrixInput_14,decode_info_andMatrixInput_12_1,decode_info_andMatrixInput_15}; // @[Cat.scala 33:92]
  wire [15:0] _decode_info_T_26 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,
    decode_info_andMatrixInput_2,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,
    decode_info_andMatrixInput_5_8,decode_info_andMatrixInput_6,decode_info_andMatrixInput_6_1,decode_info_lo_13}; // @[Cat.scala 33:92]
  wire  _decode_info_T_27 = &_decode_info_T_26; // @[pla.scala 98:74]
  wire  decode_info_andMatrixInput_6_13 = io_inst[6]; // @[pla.scala 90:45]
  wire [7:0] _decode_info_T_28 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,decode_info_andMatrixInput_2
    ,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4,decode_info_andMatrixInput_5_8,
    decode_info_andMatrixInput_6_13,decode_info_andMatrixInput_7}; // @[Cat.scala 33:92]
  wire  _decode_info_T_29 = &_decode_info_T_28; // @[pla.scala 98:74]
  wire [8:0] _decode_info_T_30 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,decode_info_andMatrixInput_2
    ,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4,decode_info_andMatrixInput_5_8,
    decode_info_andMatrixInput_6_13,decode_info_andMatrixInput_6_1,decode_info_andMatrixInput_7}; // @[Cat.scala 33:92]
  wire  _decode_info_T_31 = &_decode_info_T_30; // @[pla.scala 98:74]
  wire [8:0] _decode_info_T_32 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,decode_info_andMatrixInput_3
    ,decode_info_andMatrixInput_4,decode_info_andMatrixInput_5_8,decode_info_andMatrixInput_6_13,
    decode_info_andMatrixInput_6_1,decode_info_andMatrixInput_7,decode_info_andMatrixInput_7_2}; // @[Cat.scala 33:92]
  wire  _decode_info_T_33 = &_decode_info_T_32; // @[pla.scala 98:74]
  wire [9:0] _decode_info_T_34 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,
    decode_info_andMatrixInput_2_6,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4,
    decode_info_andMatrixInput_5_8,decode_info_andMatrixInput_6_13,decode_info_andMatrixInput_6_1,
    decode_info_andMatrixInput_7,decode_info_andMatrixInput_7_2}; // @[Cat.scala 33:92]
  wire  _decode_info_T_35 = &_decode_info_T_34; // @[pla.scala 98:74]
  wire  decode_info_andMatrixInput_3_18 = io_inst[3]; // @[pla.scala 90:45]
  wire [6:0] _decode_info_T_36 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,
    decode_info_andMatrixInput_2_6,decode_info_andMatrixInput_3_18,decode_info_andMatrixInput_4,
    decode_info_andMatrixInput_5_8,decode_info_andMatrixInput_6_13}; // @[Cat.scala 33:92]
  wire  _decode_info_T_37 = &_decode_info_T_36; // @[pla.scala 98:74]
  wire  decode_info_andMatrixInput_6_18 = io_inst[12]; // @[pla.scala 90:45]
  wire [8:0] _decode_info_T_38 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,decode_info_andMatrixInput_2
    ,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4,decode_info_andMatrixInput_6,
    decode_info_andMatrixInput_6_18,decode_info_andMatrixInput_7,decode_info_andMatrixInput_7_2}; // @[Cat.scala 33:92]
  wire  _decode_info_T_39 = &_decode_info_T_38; // @[pla.scala 98:74]
  wire [6:0] decode_info_lo_20 = {decode_info_andMatrixInput_7,decode_info_andMatrixInput_11,
    decode_info_andMatrixInput_12,decode_info_andMatrixInput_13,decode_info_andMatrixInput_14,
    decode_info_andMatrixInput_12_1,decode_info_andMatrixInput_15}; // @[Cat.scala 33:92]
  wire [14:0] _decode_info_T_40 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,
    decode_info_andMatrixInput_2,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,
    decode_info_andMatrixInput_5,decode_info_andMatrixInput_6,decode_info_andMatrixInput_6_18,decode_info_lo_20}; // @[Cat.scala 33:92]
  wire  _decode_info_T_41 = &_decode_info_T_40; // @[pla.scala 98:74]
  wire [9:0] _decode_info_T_42 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,decode_info_andMatrixInput_2
    ,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4,decode_info_andMatrixInput_5_8,
    decode_info_andMatrixInput_6,decode_info_andMatrixInput_6_18,decode_info_andMatrixInput_7,
    decode_info_andMatrixInput_7_2}; // @[Cat.scala 33:92]
  wire  _decode_info_T_43 = &_decode_info_T_42; // @[pla.scala 98:74]
  wire [15:0] _decode_info_T_44 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,
    decode_info_andMatrixInput_2,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,
    decode_info_andMatrixInput_5_8,decode_info_andMatrixInput_6,decode_info_andMatrixInput_6_18,decode_info_lo_13}; // @[Cat.scala 33:92]
  wire  _decode_info_T_45 = &_decode_info_T_44; // @[pla.scala 98:74]
  wire [8:0] _decode_info_T_46 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,decode_info_andMatrixInput_2
    ,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4,decode_info_andMatrixInput_5_8,
    decode_info_andMatrixInput_6_13,decode_info_andMatrixInput_6_18,decode_info_andMatrixInput_7}; // @[Cat.scala 33:92]
  wire  _decode_info_T_47 = &_decode_info_T_46; // @[pla.scala 98:74]
  wire  decode_info_andMatrixInput_8_14 = io_inst[13]; // @[pla.scala 90:45]
  wire [9:0] _decode_info_T_48 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,decode_info_andMatrixInput_2
    ,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4,decode_info_andMatrixInput_5,decode_info_andMatrixInput_6
    ,decode_info_andMatrixInput_6_1,decode_info_andMatrixInput_8_14,decode_info_andMatrixInput_7_2}; // @[Cat.scala 33:92]
  wire  _decode_info_T_49 = &_decode_info_T_48; // @[pla.scala 98:74]
  wire [7:0] _decode_info_T_50 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,decode_info_andMatrixInput_2
    ,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,decode_info_andMatrixInput_5,
    decode_info_andMatrixInput_6,decode_info_andMatrixInput_8_14}; // @[Cat.scala 33:92]
  wire  _decode_info_T_51 = &_decode_info_T_50; // @[pla.scala 98:74]
  wire [8:0] _decode_info_T_52 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,decode_info_andMatrixInput_2
    ,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,decode_info_andMatrixInput_5,
    decode_info_andMatrixInput_6,decode_info_andMatrixInput_8_14,decode_info_andMatrixInput_7_2}; // @[Cat.scala 33:92]
  wire  _decode_info_T_53 = &_decode_info_T_52; // @[pla.scala 98:74]
  wire [9:0] _decode_info_T_54 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,decode_info_andMatrixInput_2
    ,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4,decode_info_andMatrixInput_5_8,
    decode_info_andMatrixInput_6,decode_info_andMatrixInput_6_1,decode_info_andMatrixInput_8_14,
    decode_info_andMatrixInput_7_2}; // @[Cat.scala 33:92]
  wire  _decode_info_T_55 = &_decode_info_T_54; // @[pla.scala 98:74]
  wire [7:0] decode_info_lo_28 = {decode_info_andMatrixInput_7_2,decode_info_andMatrixInput_10,
    decode_info_andMatrixInput_11,decode_info_andMatrixInput_12,decode_info_andMatrixInput_13,
    decode_info_andMatrixInput_14,decode_info_andMatrixInput_12_1,decode_info_andMatrixInput_15}; // @[Cat.scala 33:92]
  wire [15:0] _decode_info_T_56 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,
    decode_info_andMatrixInput_2,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,
    decode_info_andMatrixInput_5_8,decode_info_andMatrixInput_6,decode_info_andMatrixInput_8_14,decode_info_lo_28}; // @[Cat.scala 33:92]
  wire  _decode_info_T_57 = &_decode_info_T_56; // @[pla.scala 98:74]
  wire [8:0] _decode_info_T_58 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,decode_info_andMatrixInput_2
    ,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,decode_info_andMatrixInput_5,
    decode_info_andMatrixInput_6,decode_info_andMatrixInput_6_18,decode_info_andMatrixInput_8_14}; // @[Cat.scala 33:92]
  wire  _decode_info_T_59 = &_decode_info_T_58; // @[pla.scala 98:74]
  wire [7:0] decode_info_lo_30 = {decode_info_andMatrixInput_8_14,decode_info_andMatrixInput_10,
    decode_info_andMatrixInput_11,decode_info_andMatrixInput_12,decode_info_andMatrixInput_13,
    decode_info_andMatrixInput_14,decode_info_andMatrixInput_12_1,decode_info_andMatrixInput_15}; // @[Cat.scala 33:92]
  wire [15:0] _decode_info_T_60 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,
    decode_info_andMatrixInput_2,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,
    decode_info_andMatrixInput_5_8,decode_info_andMatrixInput_6,decode_info_andMatrixInput_6_18,decode_info_lo_30}; // @[Cat.scala 33:92]
  wire  _decode_info_T_61 = &_decode_info_T_60; // @[pla.scala 98:74]
  wire  decode_info_andMatrixInput_8_20 = io_inst[14]; // @[pla.scala 90:45]
  wire [8:0] _decode_info_T_62 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,decode_info_andMatrixInput_2
    ,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4,decode_info_andMatrixInput_5,decode_info_andMatrixInput_6
    ,decode_info_andMatrixInput_7,decode_info_andMatrixInput_8_20}; // @[Cat.scala 33:92]
  wire  _decode_info_T_63 = &_decode_info_T_62; // @[pla.scala 98:74]
  wire [8:0] _decode_info_T_64 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,decode_info_andMatrixInput_2
    ,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,decode_info_andMatrixInput_5,
    decode_info_andMatrixInput_6,decode_info_andMatrixInput_6_1,decode_info_andMatrixInput_8_20}; // @[Cat.scala 33:92]
  wire  _decode_info_T_65 = &_decode_info_T_64; // @[pla.scala 98:74]
  wire [7:0] decode_info_lo_33 = {decode_info_andMatrixInput_8_20,decode_info_andMatrixInput_10,
    decode_info_andMatrixInput_11,decode_info_andMatrixInput_12,decode_info_andMatrixInput_13,
    decode_info_andMatrixInput_14,decode_info_andMatrixInput_12_1,decode_info_andMatrixInput_15}; // @[Cat.scala 33:92]
  wire [15:0] _decode_info_T_66 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,
    decode_info_andMatrixInput_2,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,
    decode_info_andMatrixInput_5_8,decode_info_andMatrixInput_6,decode_info_andMatrixInput_6_1,decode_info_lo_33}; // @[Cat.scala 33:92]
  wire  _decode_info_T_67 = &_decode_info_T_66; // @[pla.scala 98:74]
  wire [15:0] _decode_info_T_68 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,
    decode_info_andMatrixInput_2,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,
    decode_info_andMatrixInput_5_8,decode_info_andMatrixInput_6,decode_info_andMatrixInput_7,decode_info_lo_33}; // @[Cat.scala 33:92]
  wire  _decode_info_T_69 = &_decode_info_T_68; // @[pla.scala 98:74]
  wire [7:0] _decode_info_T_70 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,decode_info_andMatrixInput_2
    ,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4,decode_info_andMatrixInput_5_8,
    decode_info_andMatrixInput_6_13,decode_info_andMatrixInput_8_20}; // @[Cat.scala 33:92]
  wire  _decode_info_T_71 = &_decode_info_T_70; // @[pla.scala 98:74]
  wire [8:0] _decode_info_T_72 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,decode_info_andMatrixInput_2
    ,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4,decode_info_andMatrixInput_5_8,
    decode_info_andMatrixInput_6_13,decode_info_andMatrixInput_6_1,decode_info_andMatrixInput_8_20}; // @[Cat.scala 33:92]
  wire  _decode_info_T_73 = &_decode_info_T_72; // @[pla.scala 98:74]
  wire [9:0] _decode_info_T_74 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,decode_info_andMatrixInput_2
    ,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4,decode_info_andMatrixInput_5,decode_info_andMatrixInput_6
    ,decode_info_andMatrixInput_6_18,decode_info_andMatrixInput_7,decode_info_andMatrixInput_8_20}; // @[Cat.scala 33:92]
  wire  _decode_info_T_75 = &_decode_info_T_74; // @[pla.scala 98:74]
  wire [6:0] decode_info_lo_38 = {decode_info_andMatrixInput_7,decode_info_andMatrixInput_8_20,
    decode_info_andMatrixInput_11,decode_info_andMatrixInput_12,decode_info_andMatrixInput_13,
    decode_info_andMatrixInput_14,decode_info_andMatrixInput_15}; // @[Cat.scala 33:92]
  wire [14:0] _decode_info_T_76 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,
    decode_info_andMatrixInput_2,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,
    decode_info_andMatrixInput_5,decode_info_andMatrixInput_6,decode_info_andMatrixInput_6_18,decode_info_lo_38}; // @[Cat.scala 33:92]
  wire  _decode_info_T_77 = &_decode_info_T_76; // @[pla.scala 98:74]
  wire [7:0] decode_info_lo_39 = {decode_info_andMatrixInput_7,decode_info_andMatrixInput_8_20,
    decode_info_andMatrixInput_11,decode_info_andMatrixInput_12,decode_info_andMatrixInput_13,
    decode_info_andMatrixInput_14,decode_info_andMatrixInput_12_1,decode_info_andMatrixInput_15}; // @[Cat.scala 33:92]
  wire [15:0] _decode_info_T_78 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,
    decode_info_andMatrixInput_2,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,
    decode_info_andMatrixInput_5,decode_info_andMatrixInput_6,decode_info_andMatrixInput_6_18,decode_info_lo_39}; // @[Cat.scala 33:92]
  wire  _decode_info_T_79 = &_decode_info_T_78; // @[pla.scala 98:74]
  wire [7:0] decode_info_lo_40 = {decode_info_andMatrixInput_7,decode_info_andMatrixInput_8_20,
    decode_info_andMatrixInput_10,decode_info_andMatrixInput_11,decode_info_andMatrixInput_12,
    decode_info_andMatrixInput_13,decode_info_andMatrixInput_14,decode_info_andMatrixInput_15}; // @[Cat.scala 33:92]
  wire [15:0] _decode_info_T_80 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,
    decode_info_andMatrixInput_2,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,
    decode_info_andMatrixInput_5_8,decode_info_andMatrixInput_6,decode_info_andMatrixInput_6_18,decode_info_lo_40}; // @[Cat.scala 33:92]
  wire  _decode_info_T_81 = &_decode_info_T_80; // @[pla.scala 98:74]
  wire [9:0] _decode_info_T_82 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,decode_info_andMatrixInput_2
    ,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4,decode_info_andMatrixInput_5_8,
    decode_info_andMatrixInput_6_13,decode_info_andMatrixInput_6_18,decode_info_andMatrixInput_7,
    decode_info_andMatrixInput_8_20}; // @[Cat.scala 33:92]
  wire  _decode_info_T_83 = &_decode_info_T_82; // @[pla.scala 98:74]
  wire [9:0] _decode_info_T_84 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,decode_info_andMatrixInput_2
    ,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4,decode_info_andMatrixInput_5_8,
    decode_info_andMatrixInput_6_13,decode_info_andMatrixInput_6_1,decode_info_andMatrixInput_8_14,
    decode_info_andMatrixInput_8_20}; // @[Cat.scala 33:92]
  wire  _decode_info_T_85 = &_decode_info_T_84; // @[pla.scala 98:74]
  wire [9:0] _decode_info_T_86 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,decode_info_andMatrixInput_2
    ,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4,decode_info_andMatrixInput_5_8,
    decode_info_andMatrixInput_6_13,decode_info_andMatrixInput_6_18,decode_info_andMatrixInput_8_14,
    decode_info_andMatrixInput_8_20}; // @[Cat.scala 33:92]
  wire  _decode_info_T_87 = &_decode_info_T_86; // @[pla.scala 98:74]
  wire  decode_info_andMatrixInput_15_9 = io_inst[30]; // @[pla.scala 90:45]
  wire [7:0] decode_info_lo_44 = {decode_info_andMatrixInput_7_2,decode_info_andMatrixInput_10,
    decode_info_andMatrixInput_11,decode_info_andMatrixInput_12,decode_info_andMatrixInput_13,
    decode_info_andMatrixInput_14,decode_info_andMatrixInput_15_9,decode_info_andMatrixInput_15}; // @[Cat.scala 33:92]
  wire [16:0] _decode_info_T_88 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,
    decode_info_andMatrixInput_2,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,
    decode_info_andMatrixInput_5_8,decode_info_andMatrixInput_6,decode_info_andMatrixInput_6_1,
    decode_info_andMatrixInput_7,decode_info_lo_44}; // @[Cat.scala 33:92]
  wire  _decode_info_T_89 = &_decode_info_T_88; // @[pla.scala 98:74]
  wire [7:0] decode_info_lo_45 = {decode_info_andMatrixInput_7,decode_info_andMatrixInput_8_20,
    decode_info_andMatrixInput_11,decode_info_andMatrixInput_12,decode_info_andMatrixInput_13,
    decode_info_andMatrixInput_14,decode_info_andMatrixInput_15_9,decode_info_andMatrixInput_15}; // @[Cat.scala 33:92]
  wire [15:0] _decode_info_T_90 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,
    decode_info_andMatrixInput_2,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,
    decode_info_andMatrixInput_5,decode_info_andMatrixInput_6,decode_info_andMatrixInput_6_18,decode_info_lo_45}; // @[Cat.scala 33:92]
  wire  _decode_info_T_91 = &_decode_info_T_90; // @[pla.scala 98:74]
  wire [7:0] decode_info_lo_46 = {decode_info_andMatrixInput_8_20,decode_info_andMatrixInput_10,
    decode_info_andMatrixInput_11,decode_info_andMatrixInput_12,decode_info_andMatrixInput_13,
    decode_info_andMatrixInput_14,decode_info_andMatrixInput_15_9,decode_info_andMatrixInput_15}; // @[Cat.scala 33:92]
  wire [16:0] _decode_info_T_92 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,
    decode_info_andMatrixInput_2,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,
    decode_info_andMatrixInput_5_8,decode_info_andMatrixInput_6,decode_info_andMatrixInput_6_18,
    decode_info_andMatrixInput_7,decode_info_lo_46}; // @[Cat.scala 33:92]
  wire  _decode_info_T_93 = &_decode_info_T_92; // @[pla.scala 98:74]
  wire [1:0] _decode_info_orMatrixOutputs_T = {_decode_info_T_17,_decode_info_T_21}; // @[Cat.scala 33:92]
  wire  _decode_info_orMatrixOutputs_T_1 = |_decode_info_orMatrixOutputs_T; // @[pla.scala 114:39]
  wire [5:0] decode_info_orMatrixOutputs_lo = {_decode_info_T_35,_decode_info_T_37,_decode_info_T_41,_decode_info_T_51,
    _decode_info_T_77,_decode_info_T_81}; // @[Cat.scala 33:92]
  wire [11:0] _decode_info_orMatrixOutputs_T_2 = {_decode_info_T_1,_decode_info_T_3,_decode_info_T_7,_decode_info_T_13,
    _decode_info_T_23,_decode_info_T_25,decode_info_orMatrixOutputs_lo}; // @[Cat.scala 33:92]
  wire  _decode_info_orMatrixOutputs_T_3 = |_decode_info_orMatrixOutputs_T_2; // @[pla.scala 114:39]
  wire [4:0] decode_info_orMatrixOutputs_lo_1 = {_decode_info_T_37,_decode_info_T_41,_decode_info_T_51,_decode_info_T_71
    ,_decode_info_T_77}; // @[Cat.scala 33:92]
  wire [10:0] _decode_info_orMatrixOutputs_T_4 = {_decode_info_T_1,_decode_info_T_3,_decode_info_T_5,_decode_info_T_13,
    _decode_info_T_19,_decode_info_T_33,decode_info_orMatrixOutputs_lo_1}; // @[Cat.scala 33:92]
  wire  _decode_info_orMatrixOutputs_T_5 = |_decode_info_orMatrixOutputs_T_4; // @[pla.scala 114:39]
  wire [6:0] decode_info_orMatrixOutputs_lo_2 = {_decode_info_T_33,_decode_info_T_37,_decode_info_T_41,_decode_info_T_51
    ,_decode_info_T_71,_decode_info_T_77,_decode_info_T_81}; // @[Cat.scala 33:92]
  wire [13:0] _decode_info_orMatrixOutputs_T_6 = {_decode_info_T_1,_decode_info_T_3,_decode_info_T_5,_decode_info_T_13,
    _decode_info_T_19,_decode_info_T_23,_decode_info_T_25,decode_info_orMatrixOutputs_lo_2}; // @[Cat.scala 33:92]
  wire  _decode_info_orMatrixOutputs_T_7 = |_decode_info_orMatrixOutputs_T_6; // @[pla.scala 114:39]
  wire [3:0] _decode_info_orMatrixOutputs_T_8 = {_decode_info_T_15,_decode_info_T_29,_decode_info_T_37,_decode_info_T_71
    }; // @[Cat.scala 33:92]
  wire  _decode_info_orMatrixOutputs_T_9 = |_decode_info_orMatrixOutputs_T_8; // @[pla.scala 114:39]
  wire [4:0] decode_info_orMatrixOutputs_lo_4 = {_decode_info_T_35,_decode_info_T_41,_decode_info_T_51,_decode_info_T_77
    ,_decode_info_T_81}; // @[Cat.scala 33:92]
  wire [10:0] _decode_info_orMatrixOutputs_T_10 = {_decode_info_T_1,_decode_info_T_3,_decode_info_T_5,_decode_info_T_11,
    _decode_info_T_23,_decode_info_T_25,decode_info_orMatrixOutputs_lo_4}; // @[Cat.scala 33:92]
  wire  _decode_info_orMatrixOutputs_T_11 = |_decode_info_orMatrixOutputs_T_10; // @[pla.scala 114:39]
  wire [5:0] decode_info_orMatrixOutputs_lo_5 = {_decode_info_T_37,_decode_info_T_59,_decode_info_T_61,_decode_info_T_69
    ,_decode_info_T_71,_decode_info_T_79}; // @[Cat.scala 33:92]
  wire [12:0] _decode_info_orMatrixOutputs_T_12 = {_decode_info_T_1,_decode_info_T_3,_decode_info_T_5,_decode_info_T_13,
    _decode_info_T_19,_decode_info_T_27,_decode_info_T_33,decode_info_orMatrixOutputs_lo_5}; // @[Cat.scala 33:92]
  wire  _decode_info_orMatrixOutputs_T_13 = |_decode_info_orMatrixOutputs_T_12; // @[pla.scala 114:39]
  wire [6:0] _decode_info_orMatrixOutputs_T_14 = {_decode_info_T_53,_decode_info_T_57,_decode_info_T_59,
    _decode_info_T_61,_decode_info_T_89,_decode_info_T_91,_decode_info_T_93}; // @[Cat.scala 33:92]
  wire  _decode_info_orMatrixOutputs_T_15 = |_decode_info_orMatrixOutputs_T_14; // @[pla.scala 114:39]
  wire [3:0] _decode_info_orMatrixOutputs_T_16 = {_decode_info_T_53,_decode_info_T_57,_decode_info_T_65,
    _decode_info_T_67}; // @[Cat.scala 33:92]
  wire  _decode_info_orMatrixOutputs_T_17 = |_decode_info_orMatrixOutputs_T_16; // @[pla.scala 114:39]
  wire [3:0] _decode_info_orMatrixOutputs_T_18 = {_decode_info_T_41,_decode_info_T_45,_decode_info_T_77,
    _decode_info_T_81}; // @[Cat.scala 33:92]
  wire  _decode_info_orMatrixOutputs_T_19 = |_decode_info_orMatrixOutputs_T_18; // @[pla.scala 114:39]
  wire [9:0] _decode_info_orMatrixOutputs_T_20 = {_decode_info_T_1,_decode_info_T_3,_decode_info_T_5,_decode_info_T_19,
    _decode_info_T_33,_decode_info_T_37,_decode_info_T_41,_decode_info_T_51,_decode_info_T_71,_decode_info_T_77}; // @[Cat.scala 33:92]
  wire  _decode_info_orMatrixOutputs_T_21 = |_decode_info_orMatrixOutputs_T_20; // @[pla.scala 114:39]
  wire [12:0] _decode_info_orMatrixOutputs_T_22 = {_decode_info_T_1,_decode_info_T_3,_decode_info_T_5,_decode_info_T_11,
    _decode_info_T_13,_decode_info_T_23,_decode_info_T_25,decode_info_orMatrixOutputs_lo}; // @[Cat.scala 33:92]
  wire  _decode_info_orMatrixOutputs_T_23 = |_decode_info_orMatrixOutputs_T_22; // @[pla.scala 114:39]
  wire [5:0] decode_info_orMatrixOutputs_lo_11 = {_decode_info_T_33,_decode_info_T_41,_decode_info_T_51,
    _decode_info_T_71,_decode_info_T_77,_decode_info_T_81}; // @[Cat.scala 33:92]
  wire [11:0] _decode_info_orMatrixOutputs_T_24 = {_decode_info_T_1,_decode_info_T_3,_decode_info_T_5,_decode_info_T_19,
    _decode_info_T_23,_decode_info_T_25,decode_info_orMatrixOutputs_lo_11}; // @[Cat.scala 33:92]
  wire  _decode_info_orMatrixOutputs_T_25 = |_decode_info_orMatrixOutputs_T_24; // @[pla.scala 114:39]
  wire [2:0] _decode_info_orMatrixOutputs_T_26 = {_decode_info_T_31,_decode_info_T_37,_decode_info_T_73}; // @[Cat.scala 33:92]
  wire  _decode_info_orMatrixOutputs_T_27 = |_decode_info_orMatrixOutputs_T_26; // @[pla.scala 114:39]
  wire [2:0] _decode_info_orMatrixOutputs_T_28 = {_decode_info_T_33,_decode_info_T_83,_decode_info_T_85}; // @[Cat.scala 33:92]
  wire  _decode_info_orMatrixOutputs_T_29 = |_decode_info_orMatrixOutputs_T_28; // @[pla.scala 114:39]
  wire [1:0] _decode_info_orMatrixOutputs_T_30 = {_decode_info_T_47,_decode_info_T_73}; // @[Cat.scala 33:92]
  wire  _decode_info_orMatrixOutputs_T_31 = |_decode_info_orMatrixOutputs_T_30; // @[pla.scala 114:39]
  wire  _decode_info_orMatrixOutputs_T_32 = |_decode_info_T_87; // @[pla.scala 114:39]
  wire [2:0] _decode_info_orMatrixOutputs_T_33 = {_decode_info_T_9,_decode_info_T_43,_decode_info_T_75}; // @[Cat.scala 33:92]
  wire  _decode_info_orMatrixOutputs_T_34 = |_decode_info_orMatrixOutputs_T_33; // @[pla.scala 114:39]
  wire [2:0] _decode_info_orMatrixOutputs_T_35 = {_decode_info_T_21,_decode_info_T_39,_decode_info_T_49}; // @[Cat.scala 33:92]
  wire  _decode_info_orMatrixOutputs_T_36 = |_decode_info_orMatrixOutputs_T_35; // @[pla.scala 114:39]
  wire [1:0] _decode_info_orMatrixOutputs_T_37 = {_decode_info_T_21,_decode_info_T_63}; // @[Cat.scala 33:92]
  wire  _decode_info_orMatrixOutputs_T_38 = |_decode_info_orMatrixOutputs_T_37; // @[pla.scala 114:39]
  wire  _decode_info_orMatrixOutputs_T_39 = |_decode_info_T_55; // @[pla.scala 114:39]
  wire [5:0] decode_info_orMatrixOutputs_lo_lo_8 = {_decode_info_orMatrixOutputs_T_11,_decode_info_orMatrixOutputs_T_9,
    _decode_info_orMatrixOutputs_T_7,_decode_info_orMatrixOutputs_T_5,_decode_info_orMatrixOutputs_T_3,
    _decode_info_orMatrixOutputs_T_1}; // @[Cat.scala 33:92]
  wire [11:0] decode_info_orMatrixOutputs_hi_16 = {3'h0,_decode_info_orMatrixOutputs_T_39,
    _decode_info_orMatrixOutputs_T_38,_decode_info_orMatrixOutputs_T_36,_decode_info_orMatrixOutputs_T_34,
    _decode_info_orMatrixOutputs_T_32,_decode_info_orMatrixOutputs_T_31,_decode_info_orMatrixOutputs_T_29,
    _decode_info_orMatrixOutputs_T_27,_decode_info_orMatrixOutputs_T_25}; // @[Cat.scala 33:92]
  wire [23:0] decode_info_orMatrixOutputs = {decode_info_orMatrixOutputs_hi_16,_decode_info_orMatrixOutputs_T_23,
    _decode_info_orMatrixOutputs_T_21,_decode_info_orMatrixOutputs_T_19,_decode_info_orMatrixOutputs_T_17,
    _decode_info_orMatrixOutputs_T_15,_decode_info_orMatrixOutputs_T_13,decode_info_orMatrixOutputs_lo_lo_8}; // @[Cat.scala 33:92]
  wire  _decode_info_invMatrixOutputs_T_12 = ~decode_info_orMatrixOutputs[11]; // @[pla.scala 123:40]
  wire  _decode_info_invMatrixOutputs_T_14 = ~decode_info_orMatrixOutputs[12]; // @[pla.scala 123:40]
  wire [5:0] decode_info_invMatrixOutputs_lo_lo = {decode_info_orMatrixOutputs[5],decode_info_orMatrixOutputs[4],
    decode_info_orMatrixOutputs[3],decode_info_orMatrixOutputs[2],decode_info_orMatrixOutputs[1],
    decode_info_orMatrixOutputs[0]}; // @[Cat.scala 33:92]
  wire [11:0] decode_info_invMatrixOutputs_lo = {_decode_info_invMatrixOutputs_T_12,decode_info_orMatrixOutputs[10],
    decode_info_orMatrixOutputs[9],decode_info_orMatrixOutputs[8],decode_info_orMatrixOutputs[7],
    decode_info_orMatrixOutputs[6],decode_info_invMatrixOutputs_lo_lo}; // @[Cat.scala 33:92]
  wire [5:0] decode_info_invMatrixOutputs_hi_lo = {decode_info_orMatrixOutputs[17],decode_info_orMatrixOutputs[16],
    decode_info_orMatrixOutputs[15],decode_info_orMatrixOutputs[14],decode_info_orMatrixOutputs[13],
    _decode_info_invMatrixOutputs_T_14}; // @[Cat.scala 33:92]
  wire [23:0] decode_info_invMatrixOutputs = {decode_info_orMatrixOutputs[23],decode_info_orMatrixOutputs[22],
    decode_info_orMatrixOutputs[21],decode_info_orMatrixOutputs[20],decode_info_orMatrixOutputs[19],
    decode_info_orMatrixOutputs[18],decode_info_invMatrixOutputs_hi_lo,decode_info_invMatrixOutputs_lo}; // @[Cat.scala 33:92]
  wire [2:0] inst_type = decode_info_invMatrixOutputs[12:10]; // @[decoder.scala 107:36]
  wire [31:0] _io_out_imm_T_1 = 3'h1 == inst_type ? imm_i : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _io_out_imm_T_3 = 3'h2 == inst_type ? imm_s : _io_out_imm_T_1; // @[Mux.scala 81:58]
  wire [31:0] _io_out_imm_T_5 = 3'h3 == inst_type ? imm_b : _io_out_imm_T_3; // @[Mux.scala 81:58]
  wire [31:0] _io_out_imm_T_7 = 3'h4 == inst_type ? imm_u : _io_out_imm_T_5; // @[Mux.scala 81:58]
  wire [32:0] _io_out_imm_T_9 = 3'h5 == inst_type ? imm_j : {{1'd0}, _io_out_imm_T_7}; // @[Mux.scala 81:58]
  assign io_out_imm = _io_out_imm_T_9[31:0]; // @[decoder.scala 108:16]
  assign io_out_rs1 = io_inst[18:15]; // @[decoder.scala 126:16]
  assign io_out_rs2 = io_inst[23:20]; // @[decoder.scala 127:16]
  assign io_out_rd = io_inst[10:7]; // @[decoder.scala 128:16]
  assign io_out_ctrl_sig_mem_wen = decode_info_invMatrixOutputs[0]; // @[decoder.scala 116:45]
  assign io_out_ctrl_sig_reg_wen = decode_info_invMatrixOutputs[1]; // @[decoder.scala 117:45]
  assign io_out_ctrl_sig_src1_op = decode_info_invMatrixOutputs[5:4]; // @[decoder.scala 119:45]
  assign io_out_ctrl_sig_src2_op = decode_info_invMatrixOutputs[3:2]; // @[decoder.scala 118:45]
  assign io_out_ctrl_sig_alu_op = decode_info_invMatrixOutputs[9:6]; // @[decoder.scala 120:45]
  assign io_out_ctrl_sig_lsu_op = decode_info_invMatrixOutputs[20:17]; // @[decoder.scala 122:45]
  assign io_out_ctrl_sig_bru_op = decode_info_invMatrixOutputs[16:13]; // @[decoder.scala 121:45]
endmodule
module RegFile(
  input         clock,
  input         reset,
  input  [3:0]  io_in_rs1,
  input  [3:0]  io_in_rs2,
  input  [3:0]  io_in_rd,
  input  [31:0] io_in_wdata,
  input         io_in_reg_wen,
  output [31:0] io_out_rdata1,
  output [31:0] io_out_rdata2
);
  wire  regfile_clock; // @[regfile.scala 48:25]
  wire  regfile_reset; // @[regfile.scala 48:25]
  wire [3:0] regfile_rs1; // @[regfile.scala 48:25]
  wire [3:0] regfile_rs2; // @[regfile.scala 48:25]
  wire [3:0] regfile_rd; // @[regfile.scala 48:25]
  wire [31:0] regfile_wdata; // @[regfile.scala 48:25]
  wire  regfile_reg_wen; // @[regfile.scala 48:25]
  wire [31:0] regfile_rdata1; // @[regfile.scala 48:25]
  wire [31:0] regfile_rdata2; // @[regfile.scala 48:25]
  RegisterFile regfile ( // @[regfile.scala 48:25]
    .clock(regfile_clock),
    .reset(regfile_reset),
    .rs1(regfile_rs1),
    .rs2(regfile_rs2),
    .rd(regfile_rd),
    .wdata(regfile_wdata),
    .reg_wen(regfile_reg_wen),
    .rdata1(regfile_rdata1),
    .rdata2(regfile_rdata2)
  );
  assign io_out_rdata1 = regfile_rdata1; // @[regfile.scala 58:19]
  assign io_out_rdata2 = regfile_rdata2; // @[regfile.scala 59:19]
  assign regfile_clock = clock; // @[regfile.scala 50:24]
  assign regfile_reset = reset; // @[regfile.scala 51:24]
  assign regfile_rs1 = io_in_rs1; // @[regfile.scala 52:24]
  assign regfile_rs2 = io_in_rs2; // @[regfile.scala 53:24]
  assign regfile_rd = io_in_rd; // @[regfile.scala 54:24]
  assign regfile_wdata = io_in_wdata; // @[regfile.scala 55:24]
  assign regfile_reg_wen = io_in_reg_wen; // @[regfile.scala 56:24]
endmodule
module Alu(
  input  [31:0] io_alu_in_src1,
  input  [31:0] io_alu_in_src2,
  input  [3:0]  io_alu_in_alu_op,
  output [31:0] io_alu_out_alu_result
);
  wire [4:0] shamt = io_alu_in_src2[4:0]; // @[alu.scala 32:25]
  wire [31:0] _io_alu_out_alu_result_T_1 = io_alu_in_src1 + io_alu_in_src2; // @[alu.scala 37:42]
  wire [31:0] _io_alu_out_alu_result_T_3 = io_alu_in_src1 - io_alu_in_src2; // @[alu.scala 38:42]
  wire [31:0] _io_alu_out_alu_result_T_4 = io_alu_in_src1 & io_alu_in_src2; // @[alu.scala 39:42]
  wire [31:0] _io_alu_out_alu_result_T_5 = io_alu_in_src1 | io_alu_in_src2; // @[alu.scala 40:42]
  wire [31:0] _io_alu_out_alu_result_T_6 = io_alu_in_src1 ^ io_alu_in_src2; // @[alu.scala 41:42]
  wire  _io_alu_out_alu_result_T_9 = $signed(io_alu_in_src1) < $signed(io_alu_in_src2); // @[alu.scala 42:49]
  wire  _io_alu_out_alu_result_T_10 = io_alu_in_src1 < io_alu_in_src2; // @[alu.scala 43:42]
  wire [62:0] _GEN_0 = {{31'd0}, io_alu_in_src1}; // @[alu.scala 44:42]
  wire [62:0] _io_alu_out_alu_result_T_11 = _GEN_0 << shamt; // @[alu.scala 44:42]
  wire [31:0] _io_alu_out_alu_result_T_12 = io_alu_in_src1 >> shamt; // @[alu.scala 45:42]
  wire [31:0] _io_alu_out_alu_result_T_15 = $signed(io_alu_in_src1) >>> shamt; // @[alu.scala 46:59]
  wire [31:0] _io_alu_out_alu_result_T_19 = 4'h1 == io_alu_in_alu_op ? _io_alu_out_alu_result_T_1 : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _io_alu_out_alu_result_T_21 = 4'h2 == io_alu_in_alu_op ? _io_alu_out_alu_result_T_3 :
    _io_alu_out_alu_result_T_19; // @[Mux.scala 81:58]
  wire [31:0] _io_alu_out_alu_result_T_23 = 4'h3 == io_alu_in_alu_op ? _io_alu_out_alu_result_T_4 :
    _io_alu_out_alu_result_T_21; // @[Mux.scala 81:58]
  wire [31:0] _io_alu_out_alu_result_T_25 = 4'h4 == io_alu_in_alu_op ? _io_alu_out_alu_result_T_5 :
    _io_alu_out_alu_result_T_23; // @[Mux.scala 81:58]
  wire [31:0] _io_alu_out_alu_result_T_27 = 4'h5 == io_alu_in_alu_op ? _io_alu_out_alu_result_T_6 :
    _io_alu_out_alu_result_T_25; // @[Mux.scala 81:58]
  wire [31:0] _io_alu_out_alu_result_T_29 = 4'h6 == io_alu_in_alu_op ? {{31'd0}, _io_alu_out_alu_result_T_9} :
    _io_alu_out_alu_result_T_27; // @[Mux.scala 81:58]
  wire [31:0] _io_alu_out_alu_result_T_31 = 4'h7 == io_alu_in_alu_op ? {{31'd0}, _io_alu_out_alu_result_T_10} :
    _io_alu_out_alu_result_T_29; // @[Mux.scala 81:58]
  wire [62:0] _io_alu_out_alu_result_T_33 = 4'h8 == io_alu_in_alu_op ? _io_alu_out_alu_result_T_11 : {{31'd0},
    _io_alu_out_alu_result_T_31}; // @[Mux.scala 81:58]
  wire [62:0] _io_alu_out_alu_result_T_35 = 4'h9 == io_alu_in_alu_op ? {{31'd0}, _io_alu_out_alu_result_T_12} :
    _io_alu_out_alu_result_T_33; // @[Mux.scala 81:58]
  wire [62:0] _io_alu_out_alu_result_T_37 = 4'ha == io_alu_in_alu_op ? {{31'd0}, _io_alu_out_alu_result_T_15} :
    _io_alu_out_alu_result_T_35; // @[Mux.scala 81:58]
  assign io_alu_out_alu_result = _io_alu_out_alu_result_T_37[31:0]; // @[alu.scala 34:29]
endmodule
module Bru(
  input  [31:0] io_bru_in_src1,
  input  [31:0] io_bru_in_src2,
  input  [3:0]  io_bru_in_bru_op,
  output        io_bru_out_ctrl_br
);
  wire  _io_bru_out_ctrl_br_T = io_bru_in_src1 == io_bru_in_src2; // @[bru.scala 36:44]
  wire  _io_bru_out_ctrl_br_T_1 = io_bru_in_src1 != io_bru_in_src2; // @[bru.scala 37:44]
  wire  _io_bru_out_ctrl_br_T_4 = $signed(io_bru_in_src1) < $signed(io_bru_in_src2); // @[bru.scala 38:51]
  wire  _io_bru_out_ctrl_br_T_7 = $signed(io_bru_in_src1) >= $signed(io_bru_in_src2); // @[bru.scala 39:51]
  wire  _io_bru_out_ctrl_br_T_8 = io_bru_in_src1 < io_bru_in_src2; // @[bru.scala 40:51]
  wire  _io_bru_out_ctrl_br_T_9 = io_bru_in_src1 >= io_bru_in_src2; // @[bru.scala 41:51]
  wire  _io_bru_out_ctrl_br_T_15 = 4'h3 == io_bru_in_bru_op ? _io_bru_out_ctrl_br_T : 4'h2 == io_bru_in_bru_op | 4'h1
     == io_bru_in_bru_op; // @[Mux.scala 81:58]
  wire  _io_bru_out_ctrl_br_T_17 = 4'h4 == io_bru_in_bru_op ? _io_bru_out_ctrl_br_T_1 : _io_bru_out_ctrl_br_T_15; // @[Mux.scala 81:58]
  wire  _io_bru_out_ctrl_br_T_19 = 4'h5 == io_bru_in_bru_op ? _io_bru_out_ctrl_br_T_4 : _io_bru_out_ctrl_br_T_17; // @[Mux.scala 81:58]
  wire  _io_bru_out_ctrl_br_T_21 = 4'h6 == io_bru_in_bru_op ? _io_bru_out_ctrl_br_T_7 : _io_bru_out_ctrl_br_T_19; // @[Mux.scala 81:58]
  wire  _io_bru_out_ctrl_br_T_23 = 4'h7 == io_bru_in_bru_op ? _io_bru_out_ctrl_br_T_8 : _io_bru_out_ctrl_br_T_21; // @[Mux.scala 81:58]
  assign io_bru_out_ctrl_br = 4'h8 == io_bru_in_bru_op ? _io_bru_out_ctrl_br_T_9 : _io_bru_out_ctrl_br_T_23; // @[Mux.scala 81:58]
endmodule
module Ram(
  input         clock,
  input         io_ram_in_mem_wen,
  input  [31:0] io_ram_in_addr,
  input  [31:0] io_ram_in_wdata,
  input  [3:0]  io_ram_in_lsu_op,
  output [31:0] io_ram_out_rdata
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
  reg [31:0] mem [0:1023]; // @[datamem.scala 34:18]
  wire  mem_rdata_align_4_en; // @[datamem.scala 34:18]
  wire [9:0] mem_rdata_align_4_addr; // @[datamem.scala 34:18]
  wire [31:0] mem_rdata_align_4_data; // @[datamem.scala 34:18]
  wire [31:0] mem_MPORT_data; // @[datamem.scala 34:18]
  wire [9:0] mem_MPORT_addr; // @[datamem.scala 34:18]
  wire  mem_MPORT_mask; // @[datamem.scala 34:18]
  wire  mem_MPORT_en; // @[datamem.scala 34:18]
  wire [1:0] addr_low_2 = io_ram_in_addr[1:0]; // @[datamem.scala 32:31]
  wire [23:0] _lb_rdata_T_2 = mem_rdata_align_4_data[7] ? 24'hffffff : 24'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _lb_rdata_T_4 = {_lb_rdata_T_2,mem_rdata_align_4_data[7:0]}; // @[Cat.scala 33:92]
  wire [23:0] _lb_rdata_T_7 = mem_rdata_align_4_data[15] ? 24'hffffff : 24'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _lb_rdata_T_9 = {_lb_rdata_T_7,mem_rdata_align_4_data[15:8]}; // @[Cat.scala 33:92]
  wire [23:0] _lb_rdata_T_12 = mem_rdata_align_4_data[23] ? 24'hffffff : 24'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _lb_rdata_T_14 = {_lb_rdata_T_12,mem_rdata_align_4_data[23:16]}; // @[Cat.scala 33:92]
  wire [23:0] _lb_rdata_T_17 = mem_rdata_align_4_data[31] ? 24'hffffff : 24'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _lb_rdata_T_19 = {_lb_rdata_T_17,mem_rdata_align_4_data[31:24]}; // @[Cat.scala 33:92]
  wire [31:0] _lb_rdata_T_21 = 2'h1 == addr_low_2 ? _lb_rdata_T_9 : _lb_rdata_T_4; // @[Mux.scala 81:58]
  wire [31:0] _lb_rdata_T_23 = 2'h2 == addr_low_2 ? _lb_rdata_T_14 : _lb_rdata_T_21; // @[Mux.scala 81:58]
  wire [31:0] lb_rdata = 2'h3 == addr_low_2 ? _lb_rdata_T_19 : _lb_rdata_T_23; // @[Mux.scala 81:58]
  wire [31:0] _lbu_rdata_T_2 = {24'h0,mem_rdata_align_4_data[7:0]}; // @[Cat.scala 33:92]
  wire [31:0] _lbu_rdata_T_5 = {24'h0,mem_rdata_align_4_data[15:8]}; // @[Cat.scala 33:92]
  wire [31:0] _lbu_rdata_T_8 = {24'h0,mem_rdata_align_4_data[23:16]}; // @[Cat.scala 33:92]
  wire [31:0] _lbu_rdata_T_11 = {24'h0,mem_rdata_align_4_data[31:24]}; // @[Cat.scala 33:92]
  wire [31:0] _lbu_rdata_T_13 = 2'h1 == addr_low_2 ? _lbu_rdata_T_5 : _lbu_rdata_T_2; // @[Mux.scala 81:58]
  wire [31:0] _lbu_rdata_T_15 = 2'h2 == addr_low_2 ? _lbu_rdata_T_8 : _lbu_rdata_T_13; // @[Mux.scala 81:58]
  wire [31:0] lbu_rdata = 2'h3 == addr_low_2 ? _lbu_rdata_T_11 : _lbu_rdata_T_15; // @[Mux.scala 81:58]
  wire [15:0] _lh_rdata_T_2 = mem_rdata_align_4_data[15] ? 16'hffff : 16'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _lh_rdata_T_4 = {_lh_rdata_T_2,mem_rdata_align_4_data[15:0]}; // @[Cat.scala 33:92]
  wire [15:0] _lh_rdata_T_7 = mem_rdata_align_4_data[31] ? 16'hffff : 16'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _lh_rdata_T_9 = {_lh_rdata_T_7,mem_rdata_align_4_data[31:16]}; // @[Cat.scala 33:92]
  wire [31:0] _lh_rdata_T_11 = 2'h0 == addr_low_2 ? _lh_rdata_T_4 : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] lh_rdata = 2'h2 == addr_low_2 ? _lh_rdata_T_9 : _lh_rdata_T_11; // @[Mux.scala 81:58]
  wire [31:0] _lhu_rdata_T_2 = {16'h0,mem_rdata_align_4_data[15:0]}; // @[Cat.scala 33:92]
  wire [31:0] _lhu_rdata_T_5 = {16'h0,mem_rdata_align_4_data[31:16]}; // @[Cat.scala 33:92]
  wire [31:0] _lhu_rdata_T_7 = 2'h0 == addr_low_2 ? _lhu_rdata_T_2 : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] lhu_rdata = 2'h2 == addr_low_2 ? _lhu_rdata_T_5 : _lhu_rdata_T_7; // @[Mux.scala 81:58]
  wire [31:0] _io_ram_out_rdata_T_3 = 4'h1 == io_ram_in_lsu_op ? lb_rdata : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _io_ram_out_rdata_T_5 = 4'h4 == io_ram_in_lsu_op ? lbu_rdata : _io_ram_out_rdata_T_3; // @[Mux.scala 81:58]
  wire [31:0] _io_ram_out_rdata_T_7 = 4'h2 == io_ram_in_lsu_op ? lh_rdata : _io_ram_out_rdata_T_5; // @[Mux.scala 81:58]
  wire [31:0] _io_ram_out_rdata_T_9 = 4'h5 == io_ram_in_lsu_op ? lhu_rdata : _io_ram_out_rdata_T_7; // @[Mux.scala 81:58]
  wire [31:0] lw_rdata = mem_rdata_align_4_data; // @[datamem.scala 42:25 68:14]
  wire [15:0] _sb_wmask_T_1 = 2'h1 == addr_low_2 ? 16'hff00 : 16'hff; // @[Mux.scala 81:58]
  wire [23:0] _sb_wmask_T_3 = 2'h2 == addr_low_2 ? 24'hff0000 : {{8'd0}, _sb_wmask_T_1}; // @[Mux.scala 81:58]
  wire [31:0] sb_wmask = 2'h3 == addr_low_2 ? 32'hff000000 : {{8'd0}, _sb_wmask_T_3}; // @[Mux.scala 81:58]
  wire [15:0] _sh_wmask_T_1 = 2'h0 == addr_low_2 ? 16'hffff : 16'h0; // @[Mux.scala 81:58]
  wire [31:0] sh_wmask = 2'h2 == addr_low_2 ? 32'hffff0000 : {{16'd0}, _sh_wmask_T_1}; // @[Mux.scala 81:58]
  wire [31:0] _wmask_T_1 = 4'h6 == io_ram_in_lsu_op ? sb_wmask : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _wmask_T_3 = 4'h7 == io_ram_in_lsu_op ? sh_wmask : _wmask_T_1; // @[Mux.scala 81:58]
  wire [31:0] wmask = 4'h8 == io_ram_in_lsu_op ? 32'hffffffff : _wmask_T_3; // @[Mux.scala 81:58]
  wire [31:0] _T = {{2'd0}, io_ram_in_addr[31:2]}; // @[datamem.scala 104:29]
  wire [5:0] _T_1 = 4'h8 * addr_low_2; // @[datamem.scala 105:35]
  wire [94:0] _GEN_8 = {{63'd0}, io_ram_in_wdata}; // @[datamem.scala 105:27]
  wire [94:0] _T_2 = _GEN_8 << _T_1; // @[datamem.scala 105:27]
  wire [94:0] _GEN_6 = {{63'd0}, wmask}; // @[datamem.scala 105:50]
  wire [94:0] _T_3 = _T_2 & _GEN_6; // @[datamem.scala 105:50]
  wire [31:0] _T_4 = ~wmask; // @[datamem.scala 105:76]
  wire [31:0] _T_5 = mem_rdata_align_4_data & _T_4; // @[datamem.scala 105:74]
  wire [94:0] _GEN_7 = {{63'd0}, _T_5}; // @[datamem.scala 105:58]
  wire [94:0] _T_6 = _T_3 | _GEN_7; // @[datamem.scala 105:58]
  assign mem_rdata_align_4_en = 1'h1;
  assign mem_rdata_align_4_addr = io_ram_in_addr[11:2];
  assign mem_rdata_align_4_data = mem[mem_rdata_align_4_addr]; // @[datamem.scala 34:18]
  assign mem_MPORT_data = _T_6[31:0];
  assign mem_MPORT_addr = _T[9:0];
  assign mem_MPORT_mask = 1'h1;
  assign mem_MPORT_en = io_ram_in_mem_wen;
  assign io_ram_out_rdata = 4'h3 == io_ram_in_lsu_op ? lw_rdata : _io_ram_out_rdata_T_9; // @[Mux.scala 81:58]
  always @(posedge clock) begin
    if (mem_MPORT_en & mem_MPORT_mask) begin
      mem[mem_MPORT_addr] <= mem_MPORT_data; // @[datamem.scala 34:18]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1024; initvar = initvar+1)
    mem[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module top(
  input         clock,
  input         reset,
  output [31:0] io_out_inst,
  output [31:0] io_out_pc
);
  wire  PCReg_i_clock; // @[top.scala 22:29]
  wire  PCReg_i_reset; // @[top.scala 22:29]
  wire [31:0] PCReg_i_io_cur_pc; // @[top.scala 22:29]
  wire  PCReg_i_io_ctrl_br; // @[top.scala 22:29]
  wire [31:0] PCReg_i_io_addr_target; // @[top.scala 22:29]
  wire  Rom_i_clock; // @[top.scala 23:29]
  wire [31:0] Rom_i_io_addr; // @[top.scala 23:29]
  wire [31:0] Rom_i_io_inst; // @[top.scala 23:29]
  wire [31:0] Decoder_i_io_inst; // @[top.scala 24:29]
  wire [31:0] Decoder_i_io_out_imm; // @[top.scala 24:29]
  wire [3:0] Decoder_i_io_out_rs1; // @[top.scala 24:29]
  wire [3:0] Decoder_i_io_out_rs2; // @[top.scala 24:29]
  wire [3:0] Decoder_i_io_out_rd; // @[top.scala 24:29]
  wire  Decoder_i_io_out_ctrl_sig_mem_wen; // @[top.scala 24:29]
  wire  Decoder_i_io_out_ctrl_sig_reg_wen; // @[top.scala 24:29]
  wire [1:0] Decoder_i_io_out_ctrl_sig_src1_op; // @[top.scala 24:29]
  wire [1:0] Decoder_i_io_out_ctrl_sig_src2_op; // @[top.scala 24:29]
  wire [3:0] Decoder_i_io_out_ctrl_sig_alu_op; // @[top.scala 24:29]
  wire [3:0] Decoder_i_io_out_ctrl_sig_lsu_op; // @[top.scala 24:29]
  wire [3:0] Decoder_i_io_out_ctrl_sig_bru_op; // @[top.scala 24:29]
  wire  RegFile_i_clock; // @[top.scala 25:29]
  wire  RegFile_i_reset; // @[top.scala 25:29]
  wire [3:0] RegFile_i_io_in_rs1; // @[top.scala 25:29]
  wire [3:0] RegFile_i_io_in_rs2; // @[top.scala 25:29]
  wire [3:0] RegFile_i_io_in_rd; // @[top.scala 25:29]
  wire [31:0] RegFile_i_io_in_wdata; // @[top.scala 25:29]
  wire  RegFile_i_io_in_reg_wen; // @[top.scala 25:29]
  wire [31:0] RegFile_i_io_out_rdata1; // @[top.scala 25:29]
  wire [31:0] RegFile_i_io_out_rdata2; // @[top.scala 25:29]
  wire [31:0] Alu_i_io_alu_in_src1; // @[top.scala 26:29]
  wire [31:0] Alu_i_io_alu_in_src2; // @[top.scala 26:29]
  wire [3:0] Alu_i_io_alu_in_alu_op; // @[top.scala 26:29]
  wire [31:0] Alu_i_io_alu_out_alu_result; // @[top.scala 26:29]
  wire [31:0] Bru_i_io_bru_in_src1; // @[top.scala 27:29]
  wire [31:0] Bru_i_io_bru_in_src2; // @[top.scala 27:29]
  wire [3:0] Bru_i_io_bru_in_bru_op; // @[top.scala 27:29]
  wire  Bru_i_io_bru_out_ctrl_br; // @[top.scala 27:29]
  wire  Ram_i_clock; // @[top.scala 28:29]
  wire  Ram_i_io_ram_in_mem_wen; // @[top.scala 28:29]
  wire [31:0] Ram_i_io_ram_in_addr; // @[top.scala 28:29]
  wire [31:0] Ram_i_io_ram_in_wdata; // @[top.scala 28:29]
  wire [3:0] Ram_i_io_ram_in_lsu_op; // @[top.scala 28:29]
  wire [31:0] Ram_i_io_ram_out_rdata; // @[top.scala 28:29]
  wire  _is_load_T_1 = Decoder_i_io_out_ctrl_sig_lsu_op == 4'h4; // @[top.scala 48:42]
  wire  _is_load_T_2 = Decoder_i_io_out_ctrl_sig_lsu_op == 4'h1 | _is_load_T_1; // @[top.scala 47:61]
  wire  _is_load_T_3 = Decoder_i_io_out_ctrl_sig_lsu_op == 4'h2; // @[top.scala 49:42]
  wire  _is_load_T_4 = _is_load_T_2 | _is_load_T_3; // @[top.scala 48:62]
  wire  _is_load_T_5 = Decoder_i_io_out_ctrl_sig_lsu_op == 4'h5; // @[top.scala 50:42]
  wire  _is_load_T_6 = _is_load_T_4 | _is_load_T_5; // @[top.scala 49:61]
  wire  _is_load_T_7 = Decoder_i_io_out_ctrl_sig_lsu_op == 4'h3; // @[top.scala 51:42]
  wire  is_load = _is_load_T_6 | _is_load_T_7; // @[top.scala 50:62]
  wire  _is_jump_T_1 = Decoder_i_io_out_ctrl_sig_bru_op == 4'h2; // @[top.scala 55:42]
  wire  is_jump = Decoder_i_io_out_ctrl_sig_bru_op == 4'h1 | _is_jump_T_1; // @[top.scala 54:62]
  wire [31:0] _RegFile_i_io_in_wdata_T_1 = PCReg_i_io_cur_pc + 32'h4; // @[top.scala 60:52]
  wire [31:0] _GEN_0 = is_jump ? _RegFile_i_io_in_wdata_T_1 : Alu_i_io_alu_out_alu_result; // @[top.scala 59:26 60:31 62:31]
  wire [31:0] _GEN_2 = Decoder_i_io_out_ctrl_sig_src1_op == 2'h1 ? PCReg_i_io_cur_pc : 32'h0; // @[top.scala 70:71 71:30 73:30]
  wire [31:0] _GEN_4 = Decoder_i_io_out_ctrl_sig_src2_op == 2'h3 ? Decoder_i_io_out_imm : 32'h0; // @[top.scala 78:72 79:30 81:30]
  PCReg PCReg_i ( // @[top.scala 22:29]
    .clock(PCReg_i_clock),
    .reset(PCReg_i_reset),
    .io_cur_pc(PCReg_i_io_cur_pc),
    .io_ctrl_br(PCReg_i_io_ctrl_br),
    .io_addr_target(PCReg_i_io_addr_target)
  );
  Rom Rom_i ( // @[top.scala 23:29]
    .clock(Rom_i_clock),
    .io_addr(Rom_i_io_addr),
    .io_inst(Rom_i_io_inst)
  );
  Decoder Decoder_i ( // @[top.scala 24:29]
    .io_inst(Decoder_i_io_inst),
    .io_out_imm(Decoder_i_io_out_imm),
    .io_out_rs1(Decoder_i_io_out_rs1),
    .io_out_rs2(Decoder_i_io_out_rs2),
    .io_out_rd(Decoder_i_io_out_rd),
    .io_out_ctrl_sig_mem_wen(Decoder_i_io_out_ctrl_sig_mem_wen),
    .io_out_ctrl_sig_reg_wen(Decoder_i_io_out_ctrl_sig_reg_wen),
    .io_out_ctrl_sig_src1_op(Decoder_i_io_out_ctrl_sig_src1_op),
    .io_out_ctrl_sig_src2_op(Decoder_i_io_out_ctrl_sig_src2_op),
    .io_out_ctrl_sig_alu_op(Decoder_i_io_out_ctrl_sig_alu_op),
    .io_out_ctrl_sig_lsu_op(Decoder_i_io_out_ctrl_sig_lsu_op),
    .io_out_ctrl_sig_bru_op(Decoder_i_io_out_ctrl_sig_bru_op)
  );
  RegFile RegFile_i ( // @[top.scala 25:29]
    .clock(RegFile_i_clock),
    .reset(RegFile_i_reset),
    .io_in_rs1(RegFile_i_io_in_rs1),
    .io_in_rs2(RegFile_i_io_in_rs2),
    .io_in_rd(RegFile_i_io_in_rd),
    .io_in_wdata(RegFile_i_io_in_wdata),
    .io_in_reg_wen(RegFile_i_io_in_reg_wen),
    .io_out_rdata1(RegFile_i_io_out_rdata1),
    .io_out_rdata2(RegFile_i_io_out_rdata2)
  );
  Alu Alu_i ( // @[top.scala 26:29]
    .io_alu_in_src1(Alu_i_io_alu_in_src1),
    .io_alu_in_src2(Alu_i_io_alu_in_src2),
    .io_alu_in_alu_op(Alu_i_io_alu_in_alu_op),
    .io_alu_out_alu_result(Alu_i_io_alu_out_alu_result)
  );
  Bru Bru_i ( // @[top.scala 27:29]
    .io_bru_in_src1(Bru_i_io_bru_in_src1),
    .io_bru_in_src2(Bru_i_io_bru_in_src2),
    .io_bru_in_bru_op(Bru_i_io_bru_in_bru_op),
    .io_bru_out_ctrl_br(Bru_i_io_bru_out_ctrl_br)
  );
  Ram Ram_i ( // @[top.scala 28:29]
    .clock(Ram_i_clock),
    .io_ram_in_mem_wen(Ram_i_io_ram_in_mem_wen),
    .io_ram_in_addr(Ram_i_io_ram_in_addr),
    .io_ram_in_wdata(Ram_i_io_ram_in_wdata),
    .io_ram_in_lsu_op(Ram_i_io_ram_in_lsu_op),
    .io_ram_out_rdata(Ram_i_io_ram_out_rdata)
  );
  assign io_out_inst = Rom_i_io_inst; // @[top.scala 95:17]
  assign io_out_pc = PCReg_i_io_cur_pc; // @[top.scala 96:17]
  assign PCReg_i_clock = clock;
  assign PCReg_i_reset = reset;
  assign PCReg_i_io_ctrl_br = Bru_i_io_bru_out_ctrl_br; // @[top.scala 31:24]
  assign PCReg_i_io_addr_target = Alu_i_io_alu_out_alu_result; // @[top.scala 32:29]
  assign Rom_i_clock = clock;
  assign Rom_i_io_addr = PCReg_i_io_cur_pc; // @[top.scala 35:19]
  assign Decoder_i_io_inst = Rom_i_io_inst; // @[top.scala 38:23]
  assign RegFile_i_clock = clock;
  assign RegFile_i_reset = reset;
  assign RegFile_i_io_in_rs1 = Decoder_i_io_out_rs1; // @[top.scala 42:25]
  assign RegFile_i_io_in_rs2 = Decoder_i_io_out_rs2; // @[top.scala 43:25]
  assign RegFile_i_io_in_rd = Decoder_i_io_out_rd; // @[top.scala 41:25]
  assign RegFile_i_io_in_wdata = is_load ? Ram_i_io_ram_out_rdata : _GEN_0; // @[top.scala 57:19 58:31]
  assign RegFile_i_io_in_reg_wen = Decoder_i_io_out_ctrl_sig_reg_wen; // @[top.scala 44:29]
  assign Alu_i_io_alu_in_src1 = Decoder_i_io_out_ctrl_sig_src1_op == 2'h2 ? RegFile_i_io_out_rdata1 : _GEN_2; // @[top.scala 68:63 69:30]
  assign Alu_i_io_alu_in_src2 = Decoder_i_io_out_ctrl_sig_src2_op == 2'h2 ? RegFile_i_io_out_rdata2 : _GEN_4; // @[top.scala 76:63 77:30]
  assign Alu_i_io_alu_in_alu_op = Decoder_i_io_out_ctrl_sig_alu_op; // @[top.scala 66:28]
  assign Bru_i_io_bru_in_src1 = RegFile_i_io_out_rdata1; // @[top.scala 86:28]
  assign Bru_i_io_bru_in_src2 = RegFile_i_io_out_rdata2; // @[top.scala 87:28]
  assign Bru_i_io_bru_in_bru_op = Decoder_i_io_out_ctrl_sig_bru_op; // @[top.scala 85:28]
  assign Ram_i_clock = clock;
  assign Ram_i_io_ram_in_mem_wen = Decoder_i_io_out_ctrl_sig_mem_wen; // @[top.scala 92:29]
  assign Ram_i_io_ram_in_addr = Alu_i_io_alu_out_alu_result; // @[top.scala 90:27]
  assign Ram_i_io_ram_in_wdata = RegFile_i_io_out_rdata2; // @[top.scala 91:27]
  assign Ram_i_io_ram_in_lsu_op = Decoder_i_io_out_ctrl_sig_lsu_op; // @[top.scala 93:29]
endmodule
