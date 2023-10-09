/* verilator lint_off DECLFILENAME */
/* verilator lint_off UNUSEDSIGNAL */
/* verilator lint_off UNDRIVEN */
/* verilator lint_off UNOPTFLAT */
/* verilator lint_off WIDTHEXPAND */
module IFU(
  input         clock,
  input         reset,
  input         io_in_ctrl_br,
  input  [31:0] io_in_addr_target,
  input         io_in_ctrl_csr,
  input  [31:0] io_in_excpt_addr,
  output [31:0] io_out_cur_pc,
  output [31:0] to_IDU_bits_inst
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire [31:0] RomBB_i1_addr; // @[IFU.scala 44:26]
  wire [31:0] RomBB_i1_inst; // @[IFU.scala 44:26]
  reg [31:0] reg_PC; // @[IFU.scala 46:26]
  wire [31:0] _next_PC_T_1 = reg_PC + 32'h4; // @[IFU.scala 53:27]
  RomBB RomBB_i1 ( // @[IFU.scala 44:26]
    .addr(RomBB_i1_addr),
    .inst(RomBB_i1_inst)
  );
  assign io_out_cur_pc = reg_PC; // @[IFU.scala 60:25]
  assign to_IDU_bits_inst = RomBB_i1_inst; // @[IFU.scala 62:25]
  assign RomBB_i1_addr = reg_PC; // @[IFU.scala 59:25]
  always @(posedge clock) begin
    if (reset) begin // @[IFU.scala 46:26]
      reg_PC <= 32'h80000000; // @[IFU.scala 46:26]
    end else if (io_in_ctrl_br) begin // @[IFU.scala 48:26]
      reg_PC <= io_in_addr_target; // @[IFU.scala 49:17]
    end else if (io_in_ctrl_csr) begin // @[IFU.scala 50:34]
      reg_PC <= io_in_excpt_addr; // @[IFU.scala 51:17]
    end else begin
      reg_PC <= _next_PC_T_1; // @[IFU.scala 53:17]
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
  reg_PC = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module IDU(
  output [31:0] io_out_imm,
  output [4:0]  io_out_rs1,
  output [4:0]  io_out_rs2,
  output [4:0]  io_out_rd,
  output        io_out_ctrl_sig_mem_wen,
  output        io_out_ctrl_sig_reg_wen,
  output        io_out_ctrl_sig_is_ebreak,
  output        io_out_ctrl_sig_not_impl,
  output [1:0]  io_out_ctrl_sig_src1_op,
  output [1:0]  io_out_ctrl_sig_src2_op,
  output [3:0]  io_out_ctrl_sig_alu_op,
  output [2:0]  io_out_ctrl_sig_fu_op,
  output [3:0]  io_out_ctrl_sig_lsu_op,
  output [3:0]  io_out_ctrl_sig_bru_op,
  output [2:0]  io_out_ctrl_sig_csr_op,
  output [3:0]  io_out_ctrl_sig_mdu_op,
  input  [31:0] from_IFU_bits_inst
);
  wire [19:0] _imm_i_T_2 = from_IFU_bits_inst[31] ? 20'hfffff : 20'h0; // @[Bitwise.scala 77:12]
  wire [31:0] imm_i = {_imm_i_T_2,from_IFU_bits_inst[31:20]}; // @[Cat.scala 33:92]
  wire [31:0] imm_s = {_imm_i_T_2,from_IFU_bits_inst[31:25],from_IFU_bits_inst[11:7]}; // @[Cat.scala 33:92]
  wire [31:0] imm_b = {_imm_i_T_2,from_IFU_bits_inst[7],from_IFU_bits_inst[30:25],from_IFU_bits_inst[11:8],1'h0}; // @[Cat.scala 33:92]
  wire [31:0] imm_u = {from_IFU_bits_inst[31:12],12'h0}; // @[Cat.scala 33:92]
  wire [11:0] _imm_j_T_2 = from_IFU_bits_inst[31] ? 12'hfff : 12'h0; // @[Bitwise.scala 77:12]
  wire [32:0] imm_j = {_imm_j_T_2,from_IFU_bits_inst[31],from_IFU_bits_inst[19:12],from_IFU_bits_inst[20],
    from_IFU_bits_inst[30:21],1'h0}; // @[Cat.scala 33:92]
  wire [31:0] decode_info_invInputs = ~from_IFU_bits_inst; // @[pla.scala 78:21]
  wire  decode_info_andMatrixInput_0 = from_IFU_bits_inst[0]; // @[pla.scala 90:45]
  wire  decode_info_andMatrixInput_1 = from_IFU_bits_inst[1]; // @[pla.scala 90:45]
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
  wire  decode_info_andMatrixInput_4_6 = from_IFU_bits_inst[4]; // @[pla.scala 90:45]
  wire [7:0] _decode_info_T_12 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,decode_info_andMatrixInput_2
    ,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,decode_info_andMatrixInput_5,
    decode_info_andMatrixInput_6,decode_info_andMatrixInput_6_1}; // @[Cat.scala 33:92]
  wire  _decode_info_T_13 = &_decode_info_T_12; // @[pla.scala 98:74]
  wire  decode_info_andMatrixInput_2_7 = from_IFU_bits_inst[2]; // @[pla.scala 90:45]
  wire [5:0] _decode_info_T_14 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,
    decode_info_andMatrixInput_2_7,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,
    decode_info_andMatrixInput_6}; // @[Cat.scala 33:92]
  wire  _decode_info_T_15 = &_decode_info_T_14; // @[pla.scala 98:74]
  wire [6:0] _decode_info_T_16 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,
    decode_info_andMatrixInput_2_7,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,
    decode_info_andMatrixInput_5,decode_info_andMatrixInput_6}; // @[Cat.scala 33:92]
  wire  _decode_info_T_17 = &_decode_info_T_16; // @[pla.scala 98:74]
  wire  decode_info_andMatrixInput_5_9 = from_IFU_bits_inst[5]; // @[pla.scala 90:45]
  wire [8:0] _decode_info_T_18 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,decode_info_andMatrixInput_2
    ,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4,decode_info_andMatrixInput_5_9,
    decode_info_andMatrixInput_6,decode_info_andMatrixInput_6_1,decode_info_andMatrixInput_7_2}; // @[Cat.scala 33:92]
  wire  _decode_info_T_19 = &_decode_info_T_18; // @[pla.scala 98:74]
  wire [7:0] _decode_info_T_20 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,decode_info_andMatrixInput_2
    ,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4,decode_info_andMatrixInput_5_9,
    decode_info_andMatrixInput_7,decode_info_andMatrixInput_7_2}; // @[Cat.scala 33:92]
  wire  _decode_info_T_21 = &_decode_info_T_20; // @[pla.scala 98:74]
  wire [8:0] _decode_info_T_22 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,decode_info_andMatrixInput_2
    ,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4,decode_info_andMatrixInput_5_9,
    decode_info_andMatrixInput_6,decode_info_andMatrixInput_7,decode_info_andMatrixInput_7_2}; // @[Cat.scala 33:92]
  wire  _decode_info_T_23 = &_decode_info_T_22; // @[pla.scala 98:74]
  wire  decode_info_andMatrixInput_10 = decode_info_invInputs[25]; // @[pla.scala 91:29]
  wire  decode_info_andMatrixInput_11 = decode_info_invInputs[26]; // @[pla.scala 91:29]
  wire  decode_info_andMatrixInput_12 = decode_info_invInputs[27]; // @[pla.scala 91:29]
  wire  decode_info_andMatrixInput_13 = decode_info_invInputs[28]; // @[pla.scala 91:29]
  wire  decode_info_andMatrixInput_14 = decode_info_invInputs[29]; // @[pla.scala 91:29]
  wire  decode_info_andMatrixInput_15 = decode_info_invInputs[31]; // @[pla.scala 91:29]
  wire [7:0] decode_info_lo_12 = {decode_info_andMatrixInput_7,decode_info_andMatrixInput_7_2,
    decode_info_andMatrixInput_10,decode_info_andMatrixInput_11,decode_info_andMatrixInput_12,
    decode_info_andMatrixInput_13,decode_info_andMatrixInput_14,decode_info_andMatrixInput_15}; // @[Cat.scala 33:92]
  wire [15:0] _decode_info_T_24 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,
    decode_info_andMatrixInput_2,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,
    decode_info_andMatrixInput_5_9,decode_info_andMatrixInput_6,decode_info_andMatrixInput_6_1,decode_info_lo_12}; // @[Cat.scala 33:92]
  wire  _decode_info_T_25 = &_decode_info_T_24; // @[pla.scala 98:74]
  wire  decode_info_andMatrixInput_11_1 = decode_info_invInputs[30]; // @[pla.scala 91:29]
  wire [5:0] decode_info_lo_13 = {decode_info_andMatrixInput_11,decode_info_andMatrixInput_12,
    decode_info_andMatrixInput_13,decode_info_andMatrixInput_14,decode_info_andMatrixInput_11_1,
    decode_info_andMatrixInput_15}; // @[Cat.scala 33:92]
  wire [12:0] _decode_info_T_26 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,
    decode_info_andMatrixInput_2,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,
    decode_info_andMatrixInput_5_9,decode_info_andMatrixInput_6,decode_info_lo_13}; // @[Cat.scala 33:92]
  wire  _decode_info_T_27 = &_decode_info_T_26; // @[pla.scala 98:74]
  wire [6:0] decode_info_lo_14 = {decode_info_andMatrixInput_10,decode_info_andMatrixInput_11,
    decode_info_andMatrixInput_12,decode_info_andMatrixInput_13,decode_info_andMatrixInput_14,
    decode_info_andMatrixInput_11_1,decode_info_andMatrixInput_15}; // @[Cat.scala 33:92]
  wire [13:0] _decode_info_T_28 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,
    decode_info_andMatrixInput_2,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,
    decode_info_andMatrixInput_5_9,decode_info_andMatrixInput_6,decode_info_lo_14}; // @[Cat.scala 33:92]
  wire  _decode_info_T_29 = &_decode_info_T_28; // @[pla.scala 98:74]
  wire [7:0] decode_info_lo_15 = {decode_info_andMatrixInput_7,decode_info_andMatrixInput_10,
    decode_info_andMatrixInput_11,decode_info_andMatrixInput_12,decode_info_andMatrixInput_13,
    decode_info_andMatrixInput_14,decode_info_andMatrixInput_11_1,decode_info_andMatrixInput_15}; // @[Cat.scala 33:92]
  wire [15:0] _decode_info_T_30 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,
    decode_info_andMatrixInput_2,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,
    decode_info_andMatrixInput_5_9,decode_info_andMatrixInput_6,decode_info_andMatrixInput_6_1,decode_info_lo_15}; // @[Cat.scala 33:92]
  wire  _decode_info_T_31 = &_decode_info_T_30; // @[pla.scala 98:74]
  wire  decode_info_andMatrixInput_6_15 = from_IFU_bits_inst[6]; // @[pla.scala 90:45]
  wire [7:0] _decode_info_T_32 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,decode_info_andMatrixInput_2
    ,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4,decode_info_andMatrixInput_5_9,
    decode_info_andMatrixInput_6_15,decode_info_andMatrixInput_7}; // @[Cat.scala 33:92]
  wire  _decode_info_T_33 = &_decode_info_T_32; // @[pla.scala 98:74]
  wire [8:0] _decode_info_T_34 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,decode_info_andMatrixInput_2
    ,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4,decode_info_andMatrixInput_5_9,
    decode_info_andMatrixInput_6_15,decode_info_andMatrixInput_6_1,decode_info_andMatrixInput_7}; // @[Cat.scala 33:92]
  wire  _decode_info_T_35 = &_decode_info_T_34; // @[pla.scala 98:74]
  wire [8:0] _decode_info_T_36 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,decode_info_andMatrixInput_3
    ,decode_info_andMatrixInput_4,decode_info_andMatrixInput_5_9,decode_info_andMatrixInput_6_15,
    decode_info_andMatrixInput_6_1,decode_info_andMatrixInput_7,decode_info_andMatrixInput_7_2}; // @[Cat.scala 33:92]
  wire  _decode_info_T_37 = &_decode_info_T_36; // @[pla.scala 98:74]
  wire [9:0] _decode_info_T_38 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,
    decode_info_andMatrixInput_2_7,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4,
    decode_info_andMatrixInput_5_9,decode_info_andMatrixInput_6_15,decode_info_andMatrixInput_6_1,
    decode_info_andMatrixInput_7,decode_info_andMatrixInput_7_2}; // @[Cat.scala 33:92]
  wire  _decode_info_T_39 = &_decode_info_T_38; // @[pla.scala 98:74]
  wire  decode_info_andMatrixInput_3_20 = from_IFU_bits_inst[3]; // @[pla.scala 90:45]
  wire [6:0] _decode_info_T_40 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,
    decode_info_andMatrixInput_2_7,decode_info_andMatrixInput_3_20,decode_info_andMatrixInput_4,
    decode_info_andMatrixInput_5_9,decode_info_andMatrixInput_6_15}; // @[Cat.scala 33:92]
  wire  _decode_info_T_41 = &_decode_info_T_40; // @[pla.scala 98:74]
  wire  decode_info_andMatrixInput_7_18 = decode_info_invInputs[7]; // @[pla.scala 91:29]
  wire  decode_info_andMatrixInput_8_10 = decode_info_invInputs[8]; // @[pla.scala 91:29]
  wire  decode_info_andMatrixInput_9_5 = decode_info_invInputs[9]; // @[pla.scala 91:29]
  wire  decode_info_andMatrixInput_10_4 = decode_info_invInputs[10]; // @[pla.scala 91:29]
  wire  decode_info_andMatrixInput_11_4 = decode_info_invInputs[11]; // @[pla.scala 91:29]
  wire  decode_info_andMatrixInput_15_2 = decode_info_invInputs[15]; // @[pla.scala 91:29]
  wire  decode_info_andMatrixInput_16 = decode_info_invInputs[16]; // @[pla.scala 91:29]
  wire  decode_info_andMatrixInput_17 = decode_info_invInputs[17]; // @[pla.scala 91:29]
  wire  decode_info_andMatrixInput_18 = decode_info_invInputs[18]; // @[pla.scala 91:29]
  wire  decode_info_andMatrixInput_19 = decode_info_invInputs[19]; // @[pla.scala 91:29]
  wire  decode_info_andMatrixInput_20 = decode_info_invInputs[21]; // @[pla.scala 91:29]
  wire  decode_info_andMatrixInput_21 = decode_info_invInputs[22]; // @[pla.scala 91:29]
  wire  decode_info_andMatrixInput_22 = decode_info_invInputs[23]; // @[pla.scala 91:29]
  wire  decode_info_andMatrixInput_23 = decode_info_invInputs[24]; // @[pla.scala 91:29]
  wire [14:0] decode_info_lo_21 = {decode_info_andMatrixInput_16,decode_info_andMatrixInput_17,
    decode_info_andMatrixInput_18,decode_info_andMatrixInput_19,decode_info_andMatrixInput_20,
    decode_info_andMatrixInput_21,decode_info_andMatrixInput_22,decode_info_andMatrixInput_23,decode_info_lo_14}; // @[Cat.scala 33:92]
  wire [7:0] decode_info_hi_lo_20 = {decode_info_andMatrixInput_8_10,decode_info_andMatrixInput_9_5,
    decode_info_andMatrixInput_10_4,decode_info_andMatrixInput_11_4,decode_info_andMatrixInput_6_1,
    decode_info_andMatrixInput_7,decode_info_andMatrixInput_7_2,decode_info_andMatrixInput_15_2}; // @[Cat.scala 33:92]
  wire [30:0] _decode_info_T_42 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,
    decode_info_andMatrixInput_2,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,
    decode_info_andMatrixInput_5_9,decode_info_andMatrixInput_6_15,decode_info_andMatrixInput_7_18,decode_info_hi_lo_20,
    decode_info_lo_21}; // @[Cat.scala 33:92]
  wire  _decode_info_T_43 = &_decode_info_T_42; // @[pla.scala 98:74]
  wire  decode_info_andMatrixInput_20_1 = decode_info_invInputs[20]; // @[pla.scala 91:29]
  wire [7:0] decode_info_lo_lo_19 = {decode_info_andMatrixInput_23,decode_info_andMatrixInput_10,
    decode_info_andMatrixInput_11,decode_info_andMatrixInput_12,decode_info_andMatrixInput_13,
    decode_info_andMatrixInput_14,decode_info_andMatrixInput_11_1,decode_info_andMatrixInput_15}; // @[Cat.scala 33:92]
  wire [15:0] decode_info_lo_22 = {decode_info_andMatrixInput_16,decode_info_andMatrixInput_17,
    decode_info_andMatrixInput_18,decode_info_andMatrixInput_19,decode_info_andMatrixInput_20_1,
    decode_info_andMatrixInput_20,decode_info_andMatrixInput_21,decode_info_andMatrixInput_22,decode_info_lo_lo_19}; // @[Cat.scala 33:92]
  wire [31:0] _decode_info_T_44 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,
    decode_info_andMatrixInput_2,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,
    decode_info_andMatrixInput_5_9,decode_info_andMatrixInput_6_15,decode_info_andMatrixInput_7_18,decode_info_hi_lo_20,
    decode_info_lo_22}; // @[Cat.scala 33:92]
  wire  _decode_info_T_45 = &_decode_info_T_44; // @[pla.scala 98:74]
  wire  decode_info_andMatrixInput_6_22 = from_IFU_bits_inst[12]; // @[pla.scala 90:45]
  wire [8:0] _decode_info_T_46 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,decode_info_andMatrixInput_2
    ,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4,decode_info_andMatrixInput_6,
    decode_info_andMatrixInput_6_22,decode_info_andMatrixInput_7,decode_info_andMatrixInput_7_2}; // @[Cat.scala 33:92]
  wire  _decode_info_T_47 = &_decode_info_T_46; // @[pla.scala 98:74]
  wire [6:0] decode_info_lo_24 = {decode_info_andMatrixInput_7,decode_info_andMatrixInput_11,
    decode_info_andMatrixInput_12,decode_info_andMatrixInput_13,decode_info_andMatrixInput_14,
    decode_info_andMatrixInput_11_1,decode_info_andMatrixInput_15}; // @[Cat.scala 33:92]
  wire [13:0] _decode_info_T_48 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,
    decode_info_andMatrixInput_2,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,
    decode_info_andMatrixInput_6,decode_info_andMatrixInput_6_22,decode_info_lo_24}; // @[Cat.scala 33:92]
  wire  _decode_info_T_49 = &_decode_info_T_48; // @[pla.scala 98:74]
  wire [14:0] _decode_info_T_50 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,
    decode_info_andMatrixInput_2,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,
    decode_info_andMatrixInput_5,decode_info_andMatrixInput_6,decode_info_andMatrixInput_6_22,decode_info_lo_24}; // @[Cat.scala 33:92]
  wire  _decode_info_T_51 = &_decode_info_T_50; // @[pla.scala 98:74]
  wire [9:0] _decode_info_T_52 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,decode_info_andMatrixInput_2
    ,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4,decode_info_andMatrixInput_5_9,
    decode_info_andMatrixInput_6,decode_info_andMatrixInput_6_22,decode_info_andMatrixInput_7,
    decode_info_andMatrixInput_7_2}; // @[Cat.scala 33:92]
  wire  _decode_info_T_53 = &_decode_info_T_52; // @[pla.scala 98:74]
  wire [15:0] _decode_info_T_54 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,
    decode_info_andMatrixInput_2,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,
    decode_info_andMatrixInput_5_9,decode_info_andMatrixInput_6,decode_info_andMatrixInput_6_22,decode_info_lo_15}; // @[Cat.scala 33:92]
  wire  _decode_info_T_55 = &_decode_info_T_54; // @[pla.scala 98:74]
  wire [8:0] _decode_info_T_56 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,decode_info_andMatrixInput_2
    ,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4,decode_info_andMatrixInput_5_9,
    decode_info_andMatrixInput_6_15,decode_info_andMatrixInput_6_22,decode_info_andMatrixInput_7}; // @[Cat.scala 33:92]
  wire  _decode_info_T_57 = &_decode_info_T_56; // @[pla.scala 98:74]
  wire [8:0] _decode_info_T_58 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,decode_info_andMatrixInput_2
    ,decode_info_andMatrixInput_3,decode_info_andMatrixInput_5_9,decode_info_andMatrixInput_6_15,
    decode_info_andMatrixInput_6_22,decode_info_andMatrixInput_7,decode_info_andMatrixInput_7_2}; // @[Cat.scala 33:92]
  wire  _decode_info_T_59 = &_decode_info_T_58; // @[pla.scala 98:74]
  wire [9:0] _decode_info_T_60 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,decode_info_andMatrixInput_2
    ,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,decode_info_andMatrixInput_5_9,
    decode_info_andMatrixInput_6_15,decode_info_andMatrixInput_6_22,decode_info_andMatrixInput_7,
    decode_info_andMatrixInput_7_2}; // @[Cat.scala 33:92]
  wire  _decode_info_T_61 = &_decode_info_T_60; // @[pla.scala 98:74]
  wire  decode_info_andMatrixInput_8_20 = from_IFU_bits_inst[13]; // @[pla.scala 90:45]
  wire [9:0] _decode_info_T_62 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,decode_info_andMatrixInput_2
    ,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4,decode_info_andMatrixInput_5,decode_info_andMatrixInput_6
    ,decode_info_andMatrixInput_6_1,decode_info_andMatrixInput_8_20,decode_info_andMatrixInput_7_2}; // @[Cat.scala 33:92]
  wire  _decode_info_T_63 = &_decode_info_T_62; // @[pla.scala 98:74]
  wire [7:0] _decode_info_T_64 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,decode_info_andMatrixInput_2
    ,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,decode_info_andMatrixInput_5,
    decode_info_andMatrixInput_6,decode_info_andMatrixInput_8_20}; // @[Cat.scala 33:92]
  wire  _decode_info_T_65 = &_decode_info_T_64; // @[pla.scala 98:74]
  wire [8:0] _decode_info_T_66 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,decode_info_andMatrixInput_2
    ,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,decode_info_andMatrixInput_5,
    decode_info_andMatrixInput_6,decode_info_andMatrixInput_8_20,decode_info_andMatrixInput_7_2}; // @[Cat.scala 33:92]
  wire  _decode_info_T_67 = &_decode_info_T_66; // @[pla.scala 98:74]
  wire [9:0] _decode_info_T_68 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,decode_info_andMatrixInput_2
    ,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4,decode_info_andMatrixInput_5_9,
    decode_info_andMatrixInput_6,decode_info_andMatrixInput_6_1,decode_info_andMatrixInput_8_20,
    decode_info_andMatrixInput_7_2}; // @[Cat.scala 33:92]
  wire  _decode_info_T_69 = &_decode_info_T_68; // @[pla.scala 98:74]
  wire [7:0] decode_info_lo_35 = {decode_info_andMatrixInput_7_2,decode_info_andMatrixInput_10,
    decode_info_andMatrixInput_11,decode_info_andMatrixInput_12,decode_info_andMatrixInput_13,
    decode_info_andMatrixInput_14,decode_info_andMatrixInput_11_1,decode_info_andMatrixInput_15}; // @[Cat.scala 33:92]
  wire [15:0] _decode_info_T_70 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,
    decode_info_andMatrixInput_2,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,
    decode_info_andMatrixInput_5_9,decode_info_andMatrixInput_6,decode_info_andMatrixInput_8_20,decode_info_lo_35}; // @[Cat.scala 33:92]
  wire  _decode_info_T_71 = &_decode_info_T_70; // @[pla.scala 98:74]
  wire [9:0] _decode_info_T_72 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,decode_info_andMatrixInput_2
    ,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,decode_info_andMatrixInput_5_9,
    decode_info_andMatrixInput_6_15,decode_info_andMatrixInput_6_1,decode_info_andMatrixInput_8_20,
    decode_info_andMatrixInput_7_2}; // @[Cat.scala 33:92]
  wire  _decode_info_T_73 = &_decode_info_T_72; // @[pla.scala 98:74]
  wire [8:0] _decode_info_T_74 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,decode_info_andMatrixInput_2
    ,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,decode_info_andMatrixInput_5,
    decode_info_andMatrixInput_6,decode_info_andMatrixInput_6_22,decode_info_andMatrixInput_8_20}; // @[Cat.scala 33:92]
  wire  _decode_info_T_75 = &_decode_info_T_74; // @[pla.scala 98:74]
  wire [7:0] decode_info_lo_38 = {decode_info_andMatrixInput_8_20,decode_info_andMatrixInput_10,
    decode_info_andMatrixInput_11,decode_info_andMatrixInput_12,decode_info_andMatrixInput_13,
    decode_info_andMatrixInput_14,decode_info_andMatrixInput_11_1,decode_info_andMatrixInput_15}; // @[Cat.scala 33:92]
  wire [15:0] _decode_info_T_76 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,
    decode_info_andMatrixInput_2,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,
    decode_info_andMatrixInput_5_9,decode_info_andMatrixInput_6,decode_info_andMatrixInput_6_22,decode_info_lo_38}; // @[Cat.scala 33:92]
  wire  _decode_info_T_77 = &_decode_info_T_76; // @[pla.scala 98:74]
  wire  decode_info_andMatrixInput_8_27 = from_IFU_bits_inst[14]; // @[pla.scala 90:45]
  wire [8:0] _decode_info_T_78 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,decode_info_andMatrixInput_2
    ,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4,decode_info_andMatrixInput_5,decode_info_andMatrixInput_6
    ,decode_info_andMatrixInput_7,decode_info_andMatrixInput_8_27}; // @[Cat.scala 33:92]
  wire  _decode_info_T_79 = &_decode_info_T_78; // @[pla.scala 98:74]
  wire [8:0] _decode_info_T_80 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,decode_info_andMatrixInput_2
    ,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,decode_info_andMatrixInput_5,
    decode_info_andMatrixInput_6,decode_info_andMatrixInput_6_1,decode_info_andMatrixInput_8_27}; // @[Cat.scala 33:92]
  wire  _decode_info_T_81 = &_decode_info_T_80; // @[pla.scala 98:74]
  wire [7:0] decode_info_lo_41 = {decode_info_andMatrixInput_8_27,decode_info_andMatrixInput_10,
    decode_info_andMatrixInput_11,decode_info_andMatrixInput_12,decode_info_andMatrixInput_13,
    decode_info_andMatrixInput_14,decode_info_andMatrixInput_11_1,decode_info_andMatrixInput_15}; // @[Cat.scala 33:92]
  wire [15:0] _decode_info_T_82 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,
    decode_info_andMatrixInput_2,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,
    decode_info_andMatrixInput_5_9,decode_info_andMatrixInput_6,decode_info_andMatrixInput_6_1,decode_info_lo_41}; // @[Cat.scala 33:92]
  wire  _decode_info_T_83 = &_decode_info_T_82; // @[pla.scala 98:74]
  wire [15:0] _decode_info_T_84 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,
    decode_info_andMatrixInput_2,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,
    decode_info_andMatrixInput_5_9,decode_info_andMatrixInput_6,decode_info_andMatrixInput_7,decode_info_lo_41}; // @[Cat.scala 33:92]
  wire  _decode_info_T_85 = &_decode_info_T_84; // @[pla.scala 98:74]
  wire [7:0] _decode_info_T_86 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,decode_info_andMatrixInput_2
    ,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4,decode_info_andMatrixInput_5_9,
    decode_info_andMatrixInput_6_15,decode_info_andMatrixInput_8_27}; // @[Cat.scala 33:92]
  wire  _decode_info_T_87 = &_decode_info_T_86; // @[pla.scala 98:74]
  wire [8:0] _decode_info_T_88 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,decode_info_andMatrixInput_2
    ,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4,decode_info_andMatrixInput_5_9,
    decode_info_andMatrixInput_6_15,decode_info_andMatrixInput_6_1,decode_info_andMatrixInput_8_27}; // @[Cat.scala 33:92]
  wire  _decode_info_T_89 = &_decode_info_T_88; // @[pla.scala 98:74]
  wire [9:0] _decode_info_T_90 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,decode_info_andMatrixInput_2
    ,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4,decode_info_andMatrixInput_5,decode_info_andMatrixInput_6
    ,decode_info_andMatrixInput_6_22,decode_info_andMatrixInput_7,decode_info_andMatrixInput_8_27}; // @[Cat.scala 33:92]
  wire  _decode_info_T_91 = &_decode_info_T_90; // @[pla.scala 98:74]
  wire [6:0] decode_info_lo_46 = {decode_info_andMatrixInput_7,decode_info_andMatrixInput_8_27,
    decode_info_andMatrixInput_11,decode_info_andMatrixInput_12,decode_info_andMatrixInput_13,
    decode_info_andMatrixInput_14,decode_info_andMatrixInput_15}; // @[Cat.scala 33:92]
  wire [14:0] _decode_info_T_92 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,
    decode_info_andMatrixInput_2,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,
    decode_info_andMatrixInput_5,decode_info_andMatrixInput_6,decode_info_andMatrixInput_6_22,decode_info_lo_46}; // @[Cat.scala 33:92]
  wire  _decode_info_T_93 = &_decode_info_T_92; // @[pla.scala 98:74]
  wire [7:0] decode_info_lo_47 = {decode_info_andMatrixInput_7,decode_info_andMatrixInput_8_27,
    decode_info_andMatrixInput_11,decode_info_andMatrixInput_12,decode_info_andMatrixInput_13,
    decode_info_andMatrixInput_14,decode_info_andMatrixInput_11_1,decode_info_andMatrixInput_15}; // @[Cat.scala 33:92]
  wire [15:0] _decode_info_T_94 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,
    decode_info_andMatrixInput_2,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,
    decode_info_andMatrixInput_5,decode_info_andMatrixInput_6,decode_info_andMatrixInput_6_22,decode_info_lo_47}; // @[Cat.scala 33:92]
  wire  _decode_info_T_95 = &_decode_info_T_94; // @[pla.scala 98:74]
  wire [7:0] decode_info_lo_48 = {decode_info_andMatrixInput_7,decode_info_andMatrixInput_8_27,
    decode_info_andMatrixInput_10,decode_info_andMatrixInput_11,decode_info_andMatrixInput_12,
    decode_info_andMatrixInput_13,decode_info_andMatrixInput_14,decode_info_andMatrixInput_15}; // @[Cat.scala 33:92]
  wire [15:0] _decode_info_T_96 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,
    decode_info_andMatrixInput_2,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,
    decode_info_andMatrixInput_5_9,decode_info_andMatrixInput_6,decode_info_andMatrixInput_6_22,decode_info_lo_48}; // @[Cat.scala 33:92]
  wire  _decode_info_T_97 = &_decode_info_T_96; // @[pla.scala 98:74]
  wire [9:0] _decode_info_T_98 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,decode_info_andMatrixInput_2
    ,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4,decode_info_andMatrixInput_5_9,
    decode_info_andMatrixInput_6_15,decode_info_andMatrixInput_6_22,decode_info_andMatrixInput_7,
    decode_info_andMatrixInput_8_27}; // @[Cat.scala 33:92]
  wire  _decode_info_T_99 = &_decode_info_T_98; // @[pla.scala 98:74]
  wire [9:0] _decode_info_T_100 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,
    decode_info_andMatrixInput_2,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4,
    decode_info_andMatrixInput_5_9,decode_info_andMatrixInput_6_15,decode_info_andMatrixInput_6_1,
    decode_info_andMatrixInput_8_20,decode_info_andMatrixInput_8_27}; // @[Cat.scala 33:92]
  wire  _decode_info_T_101 = &_decode_info_T_100; // @[pla.scala 98:74]
  wire [9:0] _decode_info_T_102 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,
    decode_info_andMatrixInput_2,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4,
    decode_info_andMatrixInput_5_9,decode_info_andMatrixInput_6_15,decode_info_andMatrixInput_6_22,
    decode_info_andMatrixInput_8_20,decode_info_andMatrixInput_8_27}; // @[Cat.scala 33:92]
  wire  _decode_info_T_103 = &_decode_info_T_102; // @[pla.scala 98:74]
  wire [15:0] decode_info_lo_52 = {decode_info_andMatrixInput_16,decode_info_andMatrixInput_17,
    decode_info_andMatrixInput_18,decode_info_andMatrixInput_19,from_IFU_bits_inst[20],decode_info_andMatrixInput_20,
    decode_info_andMatrixInput_21,decode_info_andMatrixInput_22,decode_info_lo_lo_19}; // @[Cat.scala 33:92]
  wire [31:0] _decode_info_T_104 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,
    decode_info_andMatrixInput_2,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,
    decode_info_andMatrixInput_5_9,decode_info_andMatrixInput_6_15,decode_info_andMatrixInput_7_18,decode_info_hi_lo_20,
    decode_info_lo_52}; // @[Cat.scala 33:92]
  wire  _decode_info_T_105 = &_decode_info_T_104; // @[pla.scala 98:74]
  wire  decode_info_andMatrixInput_7_50 = from_IFU_bits_inst[25]; // @[pla.scala 90:45]
  wire [6:0] decode_info_lo_53 = {decode_info_andMatrixInput_7_50,decode_info_andMatrixInput_11,
    decode_info_andMatrixInput_12,decode_info_andMatrixInput_13,decode_info_andMatrixInput_14,
    decode_info_andMatrixInput_11_1,decode_info_andMatrixInput_15}; // @[Cat.scala 33:92]
  wire [13:0] _decode_info_T_106 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,
    decode_info_andMatrixInput_2,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,
    decode_info_andMatrixInput_5_9,decode_info_andMatrixInput_6,decode_info_lo_53}; // @[Cat.scala 33:92]
  wire  _decode_info_T_107 = &_decode_info_T_106; // @[pla.scala 98:74]
  wire [14:0] _decode_info_T_108 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,
    decode_info_andMatrixInput_2,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,
    decode_info_andMatrixInput_5_9,decode_info_andMatrixInput_6,decode_info_andMatrixInput_6_1,decode_info_lo_53}; // @[Cat.scala 33:92]
  wire  _decode_info_T_109 = &_decode_info_T_108; // @[pla.scala 98:74]
  wire [7:0] decode_info_lo_55 = {decode_info_andMatrixInput_7,decode_info_andMatrixInput_7_50,
    decode_info_andMatrixInput_11,decode_info_andMatrixInput_12,decode_info_andMatrixInput_13,
    decode_info_andMatrixInput_14,decode_info_andMatrixInput_11_1,decode_info_andMatrixInput_15}; // @[Cat.scala 33:92]
  wire [15:0] _decode_info_T_110 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,
    decode_info_andMatrixInput_2,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,
    decode_info_andMatrixInput_5_9,decode_info_andMatrixInput_6,decode_info_andMatrixInput_6_22,decode_info_lo_55}; // @[Cat.scala 33:92]
  wire  _decode_info_T_111 = &_decode_info_T_110; // @[pla.scala 98:74]
  wire [7:0] decode_info_lo_56 = {decode_info_andMatrixInput_8_20,decode_info_andMatrixInput_7_50,
    decode_info_andMatrixInput_11,decode_info_andMatrixInput_12,decode_info_andMatrixInput_13,
    decode_info_andMatrixInput_14,decode_info_andMatrixInput_11_1,decode_info_andMatrixInput_15}; // @[Cat.scala 33:92]
  wire [15:0] _decode_info_T_112 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,
    decode_info_andMatrixInput_2,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,
    decode_info_andMatrixInput_5_9,decode_info_andMatrixInput_6,decode_info_andMatrixInput_6_1,decode_info_lo_56}; // @[Cat.scala 33:92]
  wire  _decode_info_T_113 = &_decode_info_T_112; // @[pla.scala 98:74]
  wire [7:0] decode_info_lo_57 = {decode_info_andMatrixInput_7_2,decode_info_andMatrixInput_7_50,
    decode_info_andMatrixInput_11,decode_info_andMatrixInput_12,decode_info_andMatrixInput_13,
    decode_info_andMatrixInput_14,decode_info_andMatrixInput_11_1,decode_info_andMatrixInput_15}; // @[Cat.scala 33:92]
  wire [16:0] _decode_info_T_114 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,
    decode_info_andMatrixInput_2,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,
    decode_info_andMatrixInput_5_9,decode_info_andMatrixInput_6,decode_info_andMatrixInput_6_22,
    decode_info_andMatrixInput_8_20,decode_info_lo_57}; // @[Cat.scala 33:92]
  wire  _decode_info_T_115 = &_decode_info_T_114; // @[pla.scala 98:74]
  wire [7:0] decode_info_lo_58 = {decode_info_andMatrixInput_8_27,decode_info_andMatrixInput_7_50,
    decode_info_andMatrixInput_11,decode_info_andMatrixInput_12,decode_info_andMatrixInput_13,
    decode_info_andMatrixInput_14,decode_info_andMatrixInput_11_1,decode_info_andMatrixInput_15}; // @[Cat.scala 33:92]
  wire [15:0] _decode_info_T_116 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,
    decode_info_andMatrixInput_2,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,
    decode_info_andMatrixInput_5_9,decode_info_andMatrixInput_6,decode_info_andMatrixInput_6_1,decode_info_lo_58}; // @[Cat.scala 33:92]
  wire  _decode_info_T_117 = &_decode_info_T_116; // @[pla.scala 98:74]
  wire [15:0] _decode_info_T_118 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,
    decode_info_andMatrixInput_2,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,
    decode_info_andMatrixInput_5_9,decode_info_andMatrixInput_6,decode_info_andMatrixInput_7,decode_info_lo_58}; // @[Cat.scala 33:92]
  wire  _decode_info_T_119 = &_decode_info_T_118; // @[pla.scala 98:74]
  wire [16:0] _decode_info_T_120 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,
    decode_info_andMatrixInput_2,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,
    decode_info_andMatrixInput_5_9,decode_info_andMatrixInput_6,decode_info_andMatrixInput_6_22,
    decode_info_andMatrixInput_8_20,decode_info_lo_58}; // @[Cat.scala 33:92]
  wire  _decode_info_T_121 = &_decode_info_T_120; // @[pla.scala 98:74]
  wire  decode_info_andMatrixInput_21_3 = from_IFU_bits_inst[21]; // @[pla.scala 90:45]
  wire  decode_info_andMatrixInput_28_3 = from_IFU_bits_inst[28]; // @[pla.scala 90:45]
  wire  decode_info_andMatrixInput_29_3 = from_IFU_bits_inst[29]; // @[pla.scala 90:45]
  wire [7:0] decode_info_lo_lo_58 = {decode_info_andMatrixInput_23,decode_info_andMatrixInput_10,
    decode_info_andMatrixInput_11,decode_info_andMatrixInput_12,decode_info_andMatrixInput_28_3,
    decode_info_andMatrixInput_29_3,decode_info_andMatrixInput_11_1,decode_info_andMatrixInput_15}; // @[Cat.scala 33:92]
  wire [15:0] decode_info_lo_61 = {decode_info_andMatrixInput_16,decode_info_andMatrixInput_17,
    decode_info_andMatrixInput_18,decode_info_andMatrixInput_19,decode_info_andMatrixInput_20_1,
    decode_info_andMatrixInput_21_3,decode_info_andMatrixInput_21,decode_info_andMatrixInput_22,decode_info_lo_lo_58}; // @[Cat.scala 33:92]
  wire [31:0] _decode_info_T_122 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,
    decode_info_andMatrixInput_2,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,
    decode_info_andMatrixInput_5_9,decode_info_andMatrixInput_6_15,decode_info_andMatrixInput_7_18,decode_info_hi_lo_20,
    decode_info_lo_61}; // @[Cat.scala 33:92]
  wire  _decode_info_T_123 = &_decode_info_T_122; // @[pla.scala 98:74]
  wire  decode_info_andMatrixInput_15_19 = from_IFU_bits_inst[30]; // @[pla.scala 90:45]
  wire [7:0] decode_info_lo_62 = {decode_info_andMatrixInput_7_2,decode_info_andMatrixInput_10,
    decode_info_andMatrixInput_11,decode_info_andMatrixInput_12,decode_info_andMatrixInput_13,
    decode_info_andMatrixInput_14,decode_info_andMatrixInput_15_19,decode_info_andMatrixInput_15}; // @[Cat.scala 33:92]
  wire [16:0] _decode_info_T_124 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,
    decode_info_andMatrixInput_2,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,
    decode_info_andMatrixInput_5_9,decode_info_andMatrixInput_6,decode_info_andMatrixInput_6_1,
    decode_info_andMatrixInput_7,decode_info_lo_62}; // @[Cat.scala 33:92]
  wire  _decode_info_T_125 = &_decode_info_T_124; // @[pla.scala 98:74]
  wire [7:0] decode_info_lo_63 = {decode_info_andMatrixInput_7,decode_info_andMatrixInput_8_27,
    decode_info_andMatrixInput_11,decode_info_andMatrixInput_12,decode_info_andMatrixInput_13,
    decode_info_andMatrixInput_14,decode_info_andMatrixInput_15_19,decode_info_andMatrixInput_15}; // @[Cat.scala 33:92]
  wire [15:0] _decode_info_T_126 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,
    decode_info_andMatrixInput_2,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,
    decode_info_andMatrixInput_5,decode_info_andMatrixInput_6,decode_info_andMatrixInput_6_22,decode_info_lo_63}; // @[Cat.scala 33:92]
  wire  _decode_info_T_127 = &_decode_info_T_126; // @[pla.scala 98:74]
  wire [7:0] decode_info_lo_64 = {decode_info_andMatrixInput_8_27,decode_info_andMatrixInput_10,
    decode_info_andMatrixInput_11,decode_info_andMatrixInput_12,decode_info_andMatrixInput_13,
    decode_info_andMatrixInput_14,decode_info_andMatrixInput_15_19,decode_info_andMatrixInput_15}; // @[Cat.scala 33:92]
  wire [16:0] _decode_info_T_128 = {decode_info_andMatrixInput_0,decode_info_andMatrixInput_1,
    decode_info_andMatrixInput_2,decode_info_andMatrixInput_3,decode_info_andMatrixInput_4_6,
    decode_info_andMatrixInput_5_9,decode_info_andMatrixInput_6,decode_info_andMatrixInput_6_22,
    decode_info_andMatrixInput_7,decode_info_lo_64}; // @[Cat.scala 33:92]
  wire  _decode_info_T_129 = &_decode_info_T_128; // @[pla.scala 98:74]
  wire  _decode_info_orMatrixOutputs_T = |_decode_info_T_109; // @[pla.scala 114:39]
  wire [1:0] _decode_info_orMatrixOutputs_T_1 = {_decode_info_T_111,_decode_info_T_113}; // @[Cat.scala 33:92]
  wire  _decode_info_orMatrixOutputs_T_2 = |_decode_info_orMatrixOutputs_T_1; // @[pla.scala 114:39]
  wire [2:0] _decode_info_orMatrixOutputs_T_3 = {_decode_info_T_115,_decode_info_T_117,_decode_info_T_119}; // @[Cat.scala 33:92]
  wire  _decode_info_orMatrixOutputs_T_4 = |_decode_info_orMatrixOutputs_T_3; // @[pla.scala 114:39]
  wire  _decode_info_orMatrixOutputs_T_5 = |_decode_info_T_121; // @[pla.scala 114:39]
  wire [1:0] _decode_info_orMatrixOutputs_T_6 = {_decode_info_T_45,_decode_info_T_61}; // @[Cat.scala 33:92]
  wire  _decode_info_orMatrixOutputs_T_7 = |_decode_info_orMatrixOutputs_T_6; // @[pla.scala 114:39]
  wire [1:0] _decode_info_orMatrixOutputs_T_8 = {_decode_info_T_61,_decode_info_T_123}; // @[Cat.scala 33:92]
  wire  _decode_info_orMatrixOutputs_T_9 = |_decode_info_orMatrixOutputs_T_8; // @[pla.scala 114:39]
  wire  _decode_info_orMatrixOutputs_T_10 = |_decode_info_T_73; // @[pla.scala 114:39]
  wire [8:0] decode_info_orMatrixOutputs_lo = {_decode_info_T_43,_decode_info_T_49,_decode_info_T_59,_decode_info_T_65,
    _decode_info_T_73,_decode_info_T_87,_decode_info_T_93,_decode_info_T_97,_decode_info_T_123}; // @[Cat.scala 33:92]
  wire [17:0] _decode_info_orMatrixOutputs_T_11 = {_decode_info_T_1,_decode_info_T_3,_decode_info_T_5,_decode_info_T_11,
    _decode_info_T_15,_decode_info_T_25,_decode_info_T_27,_decode_info_T_37,_decode_info_T_41,
    decode_info_orMatrixOutputs_lo}; // @[Cat.scala 33:92]
  wire  _decode_info_orMatrixOutputs_T_12 = |_decode_info_orMatrixOutputs_T_11; // @[pla.scala 114:39]
  wire  _decode_info_orMatrixOutputs_T_13 = |_decode_info_T_105; // @[pla.scala 114:39]
  wire [1:0] _decode_info_orMatrixOutputs_T_14 = {_decode_info_T_19,_decode_info_T_23}; // @[Cat.scala 33:92]
  wire  _decode_info_orMatrixOutputs_T_15 = |_decode_info_orMatrixOutputs_T_14; // @[pla.scala 114:39]
  wire [6:0] decode_info_orMatrixOutputs_lo_1 = {_decode_info_T_41,_decode_info_T_49,_decode_info_T_61,_decode_info_T_65
    ,_decode_info_T_73,_decode_info_T_93,_decode_info_T_97}; // @[Cat.scala 33:92]
  wire [13:0] _decode_info_orMatrixOutputs_T_16 = {_decode_info_T_1,_decode_info_T_3,_decode_info_T_7,_decode_info_T_15,
    _decode_info_T_25,_decode_info_T_27,_decode_info_T_39,decode_info_orMatrixOutputs_lo_1}; // @[Cat.scala 33:92]
  wire  _decode_info_orMatrixOutputs_T_17 = |_decode_info_orMatrixOutputs_T_16; // @[pla.scala 114:39]
  wire [4:0] decode_info_orMatrixOutputs_lo_2 = {_decode_info_T_41,_decode_info_T_51,_decode_info_T_65,_decode_info_T_87
    ,_decode_info_T_93}; // @[Cat.scala 33:92]
  wire [10:0] _decode_info_orMatrixOutputs_T_18 = {_decode_info_T_1,_decode_info_T_3,_decode_info_T_5,_decode_info_T_15,
    _decode_info_T_21,_decode_info_T_37,decode_info_orMatrixOutputs_lo_2}; // @[Cat.scala 33:92]
  wire  _decode_info_orMatrixOutputs_T_19 = |_decode_info_orMatrixOutputs_T_18; // @[pla.scala 114:39]
  wire [6:0] decode_info_orMatrixOutputs_lo_3 = {_decode_info_T_37,_decode_info_T_41,_decode_info_T_49,_decode_info_T_65
    ,_decode_info_T_87,_decode_info_T_93,_decode_info_T_97}; // @[Cat.scala 33:92]
  wire [13:0] _decode_info_orMatrixOutputs_T_20 = {_decode_info_T_1,_decode_info_T_3,_decode_info_T_5,_decode_info_T_15,
    _decode_info_T_21,_decode_info_T_25,_decode_info_T_27,decode_info_orMatrixOutputs_lo_3}; // @[Cat.scala 33:92]
  wire  _decode_info_orMatrixOutputs_T_21 = |_decode_info_orMatrixOutputs_T_20; // @[pla.scala 114:39]
  wire [3:0] _decode_info_orMatrixOutputs_T_22 = {_decode_info_T_17,_decode_info_T_33,_decode_info_T_41,
    _decode_info_T_87}; // @[Cat.scala 33:92]
  wire  _decode_info_orMatrixOutputs_T_23 = |_decode_info_orMatrixOutputs_T_22; // @[pla.scala 114:39]
  wire [4:0] decode_info_orMatrixOutputs_lo_5 = {_decode_info_T_39,_decode_info_T_49,_decode_info_T_65,_decode_info_T_93
    ,_decode_info_T_97}; // @[Cat.scala 33:92]
  wire [10:0] _decode_info_orMatrixOutputs_T_24 = {_decode_info_T_1,_decode_info_T_3,_decode_info_T_5,_decode_info_T_11,
    _decode_info_T_25,_decode_info_T_27,decode_info_orMatrixOutputs_lo_5}; // @[Cat.scala 33:92]
  wire  _decode_info_orMatrixOutputs_T_25 = |_decode_info_orMatrixOutputs_T_24; // @[pla.scala 114:39]
  wire [5:0] decode_info_orMatrixOutputs_lo_6 = {_decode_info_T_41,_decode_info_T_75,_decode_info_T_77,_decode_info_T_85
    ,_decode_info_T_87,_decode_info_T_95}; // @[Cat.scala 33:92]
  wire [12:0] _decode_info_orMatrixOutputs_T_26 = {_decode_info_T_1,_decode_info_T_3,_decode_info_T_5,_decode_info_T_15,
    _decode_info_T_21,_decode_info_T_31,_decode_info_T_37,decode_info_orMatrixOutputs_lo_6}; // @[Cat.scala 33:92]
  wire  _decode_info_orMatrixOutputs_T_27 = |_decode_info_orMatrixOutputs_T_26; // @[pla.scala 114:39]
  wire [6:0] _decode_info_orMatrixOutputs_T_28 = {_decode_info_T_67,_decode_info_T_71,_decode_info_T_75,
    _decode_info_T_77,_decode_info_T_125,_decode_info_T_127,_decode_info_T_129}; // @[Cat.scala 33:92]
  wire  _decode_info_orMatrixOutputs_T_29 = |_decode_info_orMatrixOutputs_T_28; // @[pla.scala 114:39]
  wire [3:0] _decode_info_orMatrixOutputs_T_30 = {_decode_info_T_67,_decode_info_T_71,_decode_info_T_81,
    _decode_info_T_83}; // @[Cat.scala 33:92]
  wire  _decode_info_orMatrixOutputs_T_31 = |_decode_info_orMatrixOutputs_T_30; // @[pla.scala 114:39]
  wire [3:0] _decode_info_orMatrixOutputs_T_32 = {_decode_info_T_51,_decode_info_T_55,_decode_info_T_93,
    _decode_info_T_97}; // @[Cat.scala 33:92]
  wire  _decode_info_orMatrixOutputs_T_33 = |_decode_info_orMatrixOutputs_T_32; // @[pla.scala 114:39]
  wire [5:0] decode_info_orMatrixOutputs_lo_10 = {_decode_info_T_59,_decode_info_T_65,_decode_info_T_73,
    _decode_info_T_87,_decode_info_T_93,_decode_info_T_123}; // @[Cat.scala 33:92]
  wire [11:0] _decode_info_orMatrixOutputs_T_34 = {_decode_info_T_1,_decode_info_T_3,_decode_info_T_7,_decode_info_T_37,
    _decode_info_T_41,_decode_info_T_51,decode_info_orMatrixOutputs_lo_10}; // @[Cat.scala 33:92]
  wire  _decode_info_orMatrixOutputs_T_35 = |_decode_info_orMatrixOutputs_T_34; // @[pla.scala 114:39]
  wire [6:0] decode_info_orMatrixOutputs_lo_11 = {_decode_info_T_49,_decode_info_T_61,_decode_info_T_65,
    _decode_info_T_73,_decode_info_T_93,_decode_info_T_97,_decode_info_T_123}; // @[Cat.scala 33:92]
  wire [14:0] _decode_info_orMatrixOutputs_T_36 = {_decode_info_T_1,_decode_info_T_3,_decode_info_T_7,_decode_info_T_15,
    _decode_info_T_25,_decode_info_T_27,_decode_info_T_39,_decode_info_T_41,decode_info_orMatrixOutputs_lo_11}; // @[Cat.scala 33:92]
  wire  _decode_info_orMatrixOutputs_T_37 = |_decode_info_orMatrixOutputs_T_36; // @[pla.scala 114:39]
  wire [6:0] decode_info_orMatrixOutputs_lo_12 = {_decode_info_T_59,_decode_info_T_65,_decode_info_T_73,
    _decode_info_T_87,_decode_info_T_93,_decode_info_T_97,_decode_info_T_123}; // @[Cat.scala 33:92]
  wire [14:0] _decode_info_orMatrixOutputs_T_38 = {_decode_info_T_1,_decode_info_T_3,_decode_info_T_5,_decode_info_T_11,
    _decode_info_T_25,_decode_info_T_27,_decode_info_T_37,_decode_info_T_49,decode_info_orMatrixOutputs_lo_12}; // @[Cat.scala 33:92]
  wire  _decode_info_orMatrixOutputs_T_39 = |_decode_info_orMatrixOutputs_T_38; // @[pla.scala 114:39]
  wire [2:0] _decode_info_orMatrixOutputs_T_40 = {_decode_info_T_35,_decode_info_T_41,_decode_info_T_89}; // @[Cat.scala 33:92]
  wire  _decode_info_orMatrixOutputs_T_41 = |_decode_info_orMatrixOutputs_T_40; // @[pla.scala 114:39]
  wire [2:0] _decode_info_orMatrixOutputs_T_42 = {_decode_info_T_37,_decode_info_T_99,_decode_info_T_101}; // @[Cat.scala 33:92]
  wire  _decode_info_orMatrixOutputs_T_43 = |_decode_info_orMatrixOutputs_T_42; // @[pla.scala 114:39]
  wire [1:0] _decode_info_orMatrixOutputs_T_44 = {_decode_info_T_57,_decode_info_T_89}; // @[Cat.scala 33:92]
  wire  _decode_info_orMatrixOutputs_T_45 = |_decode_info_orMatrixOutputs_T_44; // @[pla.scala 114:39]
  wire  _decode_info_orMatrixOutputs_T_46 = |_decode_info_T_103; // @[pla.scala 114:39]
  wire [2:0] _decode_info_orMatrixOutputs_T_47 = {_decode_info_T_9,_decode_info_T_53,_decode_info_T_91}; // @[Cat.scala 33:92]
  wire  _decode_info_orMatrixOutputs_T_48 = |_decode_info_orMatrixOutputs_T_47; // @[pla.scala 114:39]
  wire [2:0] _decode_info_orMatrixOutputs_T_49 = {_decode_info_T_23,_decode_info_T_47,_decode_info_T_63}; // @[Cat.scala 33:92]
  wire  _decode_info_orMatrixOutputs_T_50 = |_decode_info_orMatrixOutputs_T_49; // @[pla.scala 114:39]
  wire [1:0] _decode_info_orMatrixOutputs_T_51 = {_decode_info_T_23,_decode_info_T_79}; // @[Cat.scala 33:92]
  wire  _decode_info_orMatrixOutputs_T_52 = |_decode_info_orMatrixOutputs_T_51; // @[pla.scala 114:39]
  wire  _decode_info_orMatrixOutputs_T_53 = |_decode_info_T_69; // @[pla.scala 114:39]
  wire [14:0] _decode_info_orMatrixOutputs_T_54 = {_decode_info_T_13,_decode_info_T_15,_decode_info_T_25,
    _decode_info_T_29,_decode_info_T_37,_decode_info_T_41,_decode_info_T_43,_decode_info_T_51,
    decode_info_orMatrixOutputs_lo_12}; // @[Cat.scala 33:92]
  wire  _decode_info_orMatrixOutputs_T_55 = |_decode_info_orMatrixOutputs_T_54; // @[pla.scala 114:39]
  wire [4:0] _decode_info_orMatrixOutputs_T_56 = {_decode_info_T_33,_decode_info_T_37,_decode_info_T_41,
    _decode_info_T_87,_decode_info_T_107}; // @[Cat.scala 33:92]
  wire  _decode_info_orMatrixOutputs_T_57 = |_decode_info_orMatrixOutputs_T_56; // @[pla.scala 114:39]
  wire [6:0] _decode_info_orMatrixOutputs_T_58 = {_decode_info_T_1,_decode_info_T_5,_decode_info_T_11,_decode_info_T_43,
    _decode_info_T_61,_decode_info_T_73,_decode_info_T_123}; // @[Cat.scala 33:92]
  wire  _decode_info_orMatrixOutputs_T_59 = |_decode_info_orMatrixOutputs_T_58; // @[pla.scala 114:39]
  wire [7:0] decode_info_orMatrixOutputs_lo_lo_10 = {_decode_info_orMatrixOutputs_T_12,_decode_info_orMatrixOutputs_T_10
    ,_decode_info_orMatrixOutputs_T_9,_decode_info_orMatrixOutputs_T_7,_decode_info_orMatrixOutputs_T_5,
    _decode_info_orMatrixOutputs_T_4,_decode_info_orMatrixOutputs_T_2,_decode_info_orMatrixOutputs_T}; // @[Cat.scala 33:92]
  wire [7:0] decode_info_orMatrixOutputs_hi_lo_12 = {_decode_info_orMatrixOutputs_T_43,_decode_info_orMatrixOutputs_T_41
    ,_decode_info_orMatrixOutputs_T_39,_decode_info_orMatrixOutputs_T_37,_decode_info_orMatrixOutputs_T_35,
    _decode_info_orMatrixOutputs_T_33,_decode_info_orMatrixOutputs_T_31,_decode_info_orMatrixOutputs_T_29}; // @[Cat.scala 33:92]
  wire [16:0] decode_info_orMatrixOutputs_hi_21 = {_decode_info_orMatrixOutputs_T_59,_decode_info_orMatrixOutputs_T_57,
    _decode_info_orMatrixOutputs_T_55,_decode_info_orMatrixOutputs_T_53,_decode_info_orMatrixOutputs_T_52,
    _decode_info_orMatrixOutputs_T_50,_decode_info_orMatrixOutputs_T_48,_decode_info_orMatrixOutputs_T_46,
    _decode_info_orMatrixOutputs_T_45,decode_info_orMatrixOutputs_hi_lo_12}; // @[Cat.scala 33:92]
  wire [32:0] decode_info_orMatrixOutputs = {decode_info_orMatrixOutputs_hi_21,_decode_info_orMatrixOutputs_T_27,
    _decode_info_orMatrixOutputs_T_25,_decode_info_orMatrixOutputs_T_23,_decode_info_orMatrixOutputs_T_21,
    _decode_info_orMatrixOutputs_T_19,_decode_info_orMatrixOutputs_T_17,_decode_info_orMatrixOutputs_T_15,
    _decode_info_orMatrixOutputs_T_13,decode_info_orMatrixOutputs_lo_lo_10}; // @[Cat.scala 33:92]
  wire  _decode_info_invMatrixOutputs_T_8 = ~decode_info_orMatrixOutputs[7]; // @[pla.scala 123:40]
  wire  _decode_info_invMatrixOutputs_T_22 = ~decode_info_orMatrixOutputs[20]; // @[pla.scala 123:40]
  wire  _decode_info_invMatrixOutputs_T_24 = ~decode_info_orMatrixOutputs[21]; // @[pla.scala 123:40]
  wire [7:0] decode_info_invMatrixOutputs_lo_lo = {_decode_info_invMatrixOutputs_T_8,decode_info_orMatrixOutputs[6],
    decode_info_orMatrixOutputs[5],decode_info_orMatrixOutputs[4],decode_info_orMatrixOutputs[3],
    decode_info_orMatrixOutputs[2],decode_info_orMatrixOutputs[1],decode_info_orMatrixOutputs[0]}; // @[Cat.scala 33:92]
  wire [7:0] decode_info_invMatrixOutputs_hi_lo = {decode_info_orMatrixOutputs[23],decode_info_orMatrixOutputs[22],
    _decode_info_invMatrixOutputs_T_24,_decode_info_invMatrixOutputs_T_22,decode_info_orMatrixOutputs[19],
    decode_info_orMatrixOutputs[18],decode_info_orMatrixOutputs[17],decode_info_orMatrixOutputs[16]}; // @[Cat.scala 33:92]
  wire [16:0] decode_info_invMatrixOutputs_hi = {decode_info_orMatrixOutputs[32],decode_info_orMatrixOutputs[31],
    decode_info_orMatrixOutputs[30],decode_info_orMatrixOutputs[29],decode_info_orMatrixOutputs[28],
    decode_info_orMatrixOutputs[27],decode_info_orMatrixOutputs[26],decode_info_orMatrixOutputs[25],
    decode_info_orMatrixOutputs[24],decode_info_invMatrixOutputs_hi_lo}; // @[Cat.scala 33:92]
  wire [32:0] decode_info_invMatrixOutputs = {decode_info_invMatrixOutputs_hi,decode_info_orMatrixOutputs[15],
    decode_info_orMatrixOutputs[14],decode_info_orMatrixOutputs[13],decode_info_orMatrixOutputs[12],
    decode_info_orMatrixOutputs[11],decode_info_orMatrixOutputs[10],decode_info_orMatrixOutputs[9],
    decode_info_orMatrixOutputs[8],decode_info_invMatrixOutputs_lo_lo}; // @[Cat.scala 33:92]
  wire [2:0] inst_type = decode_info_invMatrixOutputs[21:19]; // @[IDU.scala 141:36]
  wire [31:0] _io_out_imm_T_1 = 3'h1 == inst_type ? imm_i : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _io_out_imm_T_3 = 3'h2 == inst_type ? imm_s : _io_out_imm_T_1; // @[Mux.scala 81:58]
  wire [31:0] _io_out_imm_T_5 = 3'h3 == inst_type ? imm_b : _io_out_imm_T_3; // @[Mux.scala 81:58]
  wire [31:0] _io_out_imm_T_7 = 3'h4 == inst_type ? imm_u : _io_out_imm_T_5; // @[Mux.scala 81:58]
  wire [32:0] _io_out_imm_T_9 = 3'h5 == inst_type ? imm_j : {{1'd0}, _io_out_imm_T_7}; // @[Mux.scala 81:58]
  assign io_out_imm = _io_out_imm_T_9[31:0]; // @[IDU.scala 142:16]
  assign io_out_rs1 = from_IFU_bits_inst[19:15]; // @[IDU.scala 165:37]
  assign io_out_rs2 = from_IFU_bits_inst[24:20]; // @[IDU.scala 166:37]
  assign io_out_rd = from_IFU_bits_inst[11:7]; // @[IDU.scala 167:37]
  assign io_out_ctrl_sig_mem_wen = decode_info_invMatrixOutputs[9]; // @[IDU.scala 155:45]
  assign io_out_ctrl_sig_reg_wen = decode_info_invMatrixOutputs[10]; // @[IDU.scala 156:45]
  assign io_out_ctrl_sig_is_ebreak = decode_info_invMatrixOutputs[8]; // @[IDU.scala 154:45]
  assign io_out_ctrl_sig_not_impl = decode_info_invMatrixOutputs[7]; // @[IDU.scala 153:45]
  assign io_out_ctrl_sig_src1_op = decode_info_invMatrixOutputs[14:13]; // @[IDU.scala 158:45]
  assign io_out_ctrl_sig_src2_op = decode_info_invMatrixOutputs[12:11]; // @[IDU.scala 157:45]
  assign io_out_ctrl_sig_alu_op = decode_info_invMatrixOutputs[18:15]; // @[IDU.scala 159:45]
  assign io_out_ctrl_sig_fu_op = decode_info_invMatrixOutputs[32:30]; // @[IDU.scala 162:45]
  assign io_out_ctrl_sig_lsu_op = decode_info_invMatrixOutputs[29:26]; // @[IDU.scala 161:45]
  assign io_out_ctrl_sig_bru_op = decode_info_invMatrixOutputs[25:22]; // @[IDU.scala 160:45]
  assign io_out_ctrl_sig_csr_op = decode_info_invMatrixOutputs[6:4]; // @[IDU.scala 152:45]
  assign io_out_ctrl_sig_mdu_op = decode_info_invMatrixOutputs[3:0]; // @[IDU.scala 151:45]
endmodule
module RegFile(
  input         clock,
  input         reset,
  input  [4:0]  io_in_rs1,
  input  [4:0]  io_in_rs2,
  input  [4:0]  io_in_rd,
  input  [31:0] io_in_wdata,
  input         io_in_reg_wen,
  output [31:0] io_out_rdata1,
  output [31:0] io_out_rdata2
);
  wire  regfile_clock; // @[regfile.scala 48:25]
  wire  regfile_reset; // @[regfile.scala 48:25]
  wire [4:0] regfile_rs1; // @[regfile.scala 48:25]
  wire [4:0] regfile_rs2; // @[regfile.scala 48:25]
  wire [4:0] regfile_rd; // @[regfile.scala 48:25]
  wire [31:0] regfile_wdata; // @[regfile.scala 48:25]
  wire  regfile_reg_wen; // @[regfile.scala 48:25]
  wire [31:0] regfile_rdata1; // @[regfile.scala 48:25]
  wire [31:0] regfile_rdata2; // @[regfile.scala 48:25]
  RegisterFileBB regfile ( // @[regfile.scala 48:25]
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
  wire [4:0] shamt = io_alu_in_src2[4:0]; // @[alu.scala 31:25]
  wire [31:0] _io_alu_out_alu_result_T_1 = io_alu_in_src1 + io_alu_in_src2; // @[alu.scala 36:42]
  wire [31:0] _io_alu_out_alu_result_T_3 = io_alu_in_src1 - io_alu_in_src2; // @[alu.scala 37:42]
  wire [31:0] _io_alu_out_alu_result_T_4 = io_alu_in_src1 & io_alu_in_src2; // @[alu.scala 38:42]
  wire [31:0] _io_alu_out_alu_result_T_5 = io_alu_in_src1 | io_alu_in_src2; // @[alu.scala 39:42]
  wire [31:0] _io_alu_out_alu_result_T_6 = io_alu_in_src1 ^ io_alu_in_src2; // @[alu.scala 40:42]
  wire  _io_alu_out_alu_result_T_9 = $signed(io_alu_in_src1) < $signed(io_alu_in_src2); // @[alu.scala 41:49]
  wire  _io_alu_out_alu_result_T_10 = io_alu_in_src1 < io_alu_in_src2; // @[alu.scala 42:42]
  wire [62:0] _GEN_0 = {{31'd0}, io_alu_in_src1}; // @[alu.scala 43:42]
  wire [62:0] _io_alu_out_alu_result_T_11 = _GEN_0 << shamt; // @[alu.scala 43:42]
  wire [31:0] _io_alu_out_alu_result_T_12 = io_alu_in_src1 >> shamt; // @[alu.scala 44:42]
  wire [31:0] _io_alu_out_alu_result_T_15 = $signed(io_alu_in_src1) >>> shamt; // @[alu.scala 45:59]
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
  assign io_alu_out_alu_result = _io_alu_out_alu_result_T_37[31:0]; // @[alu.scala 33:29]
endmodule
module Bru(
  input  [31:0] io_bru_in_src1,
  input  [31:0] io_bru_in_src2,
  input  [3:0]  io_bru_in_bru_op,
  output        io_bru_out_ctrl_br
);
  wire  _io_bru_out_ctrl_br_T = io_bru_in_src1 == io_bru_in_src2; // @[bru.scala 35:44]
  wire  _io_bru_out_ctrl_br_T_1 = io_bru_in_src1 != io_bru_in_src2; // @[bru.scala 36:44]
  wire  _io_bru_out_ctrl_br_T_4 = $signed(io_bru_in_src1) < $signed(io_bru_in_src2); // @[bru.scala 37:51]
  wire  _io_bru_out_ctrl_br_T_7 = $signed(io_bru_in_src1) >= $signed(io_bru_in_src2); // @[bru.scala 38:51]
  wire  _io_bru_out_ctrl_br_T_8 = io_bru_in_src1 < io_bru_in_src2; // @[bru.scala 39:51]
  wire  _io_bru_out_ctrl_br_T_9 = io_bru_in_src1 >= io_bru_in_src2; // @[bru.scala 40:51]
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
  input         io_in_valid,
  input         io_in_mem_wen,
  input  [31:0] io_in_addr,
  input  [31:0] io_in_wdata,
  input  [3:0]  io_in_lsu_op,
  output [31:0] io_out_rdata
);
  wire  RamBB_i1_clock; // @[datamem.scala 50:26]
  wire [31:0] RamBB_i1_addr; // @[datamem.scala 50:26]
  wire [31:0] RamBB_i1_wdata; // @[datamem.scala 50:26]
  wire  RamBB_i1_mem_wen; // @[datamem.scala 50:26]
  wire  RamBB_i1_valid; // @[datamem.scala 50:26]
  wire [31:0] RamBB_i1_rdata; // @[datamem.scala 50:26]
  wire [31:0] RamBB_i1_rdata_4_w; // @[datamem.scala 50:26]
  wire [1:0] addr_low_2 = io_in_addr[1:0]; // @[datamem.scala 46:31]
  wire [23:0] _lb_rdata_T_2 = RamBB_i1_rdata[7] ? 24'hffffff : 24'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _lb_rdata_T_4 = {_lb_rdata_T_2,RamBB_i1_rdata[7:0]}; // @[Cat.scala 33:92]
  wire [23:0] _lb_rdata_T_7 = RamBB_i1_rdata[15] ? 24'hffffff : 24'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _lb_rdata_T_9 = {_lb_rdata_T_7,RamBB_i1_rdata[15:8]}; // @[Cat.scala 33:92]
  wire [23:0] _lb_rdata_T_12 = RamBB_i1_rdata[23] ? 24'hffffff : 24'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _lb_rdata_T_14 = {_lb_rdata_T_12,RamBB_i1_rdata[23:16]}; // @[Cat.scala 33:92]
  wire [23:0] _lb_rdata_T_17 = RamBB_i1_rdata[31] ? 24'hffffff : 24'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _lb_rdata_T_19 = {_lb_rdata_T_17,RamBB_i1_rdata[31:24]}; // @[Cat.scala 33:92]
  wire [31:0] _lb_rdata_T_21 = 2'h1 == addr_low_2 ? _lb_rdata_T_9 : _lb_rdata_T_4; // @[Mux.scala 81:58]
  wire [31:0] _lb_rdata_T_23 = 2'h2 == addr_low_2 ? _lb_rdata_T_14 : _lb_rdata_T_21; // @[Mux.scala 81:58]
  wire [31:0] lb_rdata = 2'h3 == addr_low_2 ? _lb_rdata_T_19 : _lb_rdata_T_23; // @[Mux.scala 81:58]
  wire [31:0] _lbu_rdata_T_2 = {24'h0,RamBB_i1_rdata[7:0]}; // @[Cat.scala 33:92]
  wire [31:0] _lbu_rdata_T_5 = {24'h0,RamBB_i1_rdata[15:8]}; // @[Cat.scala 33:92]
  wire [31:0] _lbu_rdata_T_8 = {24'h0,RamBB_i1_rdata[23:16]}; // @[Cat.scala 33:92]
  wire [31:0] _lbu_rdata_T_11 = {24'h0,RamBB_i1_rdata[31:24]}; // @[Cat.scala 33:92]
  wire [31:0] _lbu_rdata_T_13 = 2'h1 == addr_low_2 ? _lbu_rdata_T_5 : _lbu_rdata_T_2; // @[Mux.scala 81:58]
  wire [31:0] _lbu_rdata_T_15 = 2'h2 == addr_low_2 ? _lbu_rdata_T_8 : _lbu_rdata_T_13; // @[Mux.scala 81:58]
  wire [31:0] lbu_rdata = 2'h3 == addr_low_2 ? _lbu_rdata_T_11 : _lbu_rdata_T_15; // @[Mux.scala 81:58]
  wire [15:0] _lh_rdata_T_2 = RamBB_i1_rdata[15] ? 16'hffff : 16'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _lh_rdata_T_4 = {_lh_rdata_T_2,RamBB_i1_rdata[15:0]}; // @[Cat.scala 33:92]
  wire [15:0] _lh_rdata_T_7 = RamBB_i1_rdata[31] ? 16'hffff : 16'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _lh_rdata_T_9 = {_lh_rdata_T_7,RamBB_i1_rdata[31:16]}; // @[Cat.scala 33:92]
  wire [31:0] _lh_rdata_T_11 = 2'h0 == addr_low_2 ? _lh_rdata_T_4 : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] lh_rdata = 2'h2 == addr_low_2 ? _lh_rdata_T_9 : _lh_rdata_T_11; // @[Mux.scala 81:58]
  wire [31:0] _lhu_rdata_T_2 = {16'h0,RamBB_i1_rdata[15:0]}; // @[Cat.scala 33:92]
  wire [31:0] _lhu_rdata_T_5 = {16'h0,RamBB_i1_rdata[31:16]}; // @[Cat.scala 33:92]
  wire [31:0] _lhu_rdata_T_7 = 2'h0 == addr_low_2 ? _lhu_rdata_T_2 : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] lhu_rdata = 2'h2 == addr_low_2 ? _lhu_rdata_T_5 : _lhu_rdata_T_7; // @[Mux.scala 81:58]
  wire [31:0] _io_out_rdata_T_3 = 4'h1 == io_in_lsu_op ? lb_rdata : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _io_out_rdata_T_5 = 4'h4 == io_in_lsu_op ? lbu_rdata : _io_out_rdata_T_3; // @[Mux.scala 81:58]
  wire [31:0] _io_out_rdata_T_7 = 4'h2 == io_in_lsu_op ? lh_rdata : _io_out_rdata_T_5; // @[Mux.scala 81:58]
  wire [31:0] _io_out_rdata_T_9 = 4'h5 == io_in_lsu_op ? lhu_rdata : _io_out_rdata_T_7; // @[Mux.scala 81:58]
  wire [31:0] lw_rdata = RamBB_i1_rdata; // @[datamem.scala 67:25 93:14]
  wire [15:0] _sb_wmask_T_1 = 2'h1 == addr_low_2 ? 16'hff00 : 16'hff; // @[Mux.scala 81:58]
  wire [23:0] _sb_wmask_T_3 = 2'h2 == addr_low_2 ? 24'hff0000 : {{8'd0}, _sb_wmask_T_1}; // @[Mux.scala 81:58]
  wire [31:0] sb_wmask = 2'h3 == addr_low_2 ? 32'hff000000 : {{8'd0}, _sb_wmask_T_3}; // @[Mux.scala 81:58]
  wire [15:0] _sh_wmask_T_1 = 2'h0 == addr_low_2 ? 16'hffff : 16'h0; // @[Mux.scala 81:58]
  wire [31:0] sh_wmask = 2'h2 == addr_low_2 ? 32'hffff0000 : {{16'd0}, _sh_wmask_T_1}; // @[Mux.scala 81:58]
  wire [31:0] _wmask_T_1 = 4'h6 == io_in_lsu_op ? sb_wmask : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _wmask_T_3 = 4'h7 == io_in_lsu_op ? sh_wmask : _wmask_T_1; // @[Mux.scala 81:58]
  wire [31:0] wmask = 4'h8 == io_in_lsu_op ? 32'hffffffff : _wmask_T_3; // @[Mux.scala 81:58]
  wire [5:0] _wdata_align_4_T = 4'h8 * addr_low_2; // @[datamem.scala 131:32]
  wire [94:0] _GEN_2 = {{63'd0}, io_in_wdata}; // @[datamem.scala 131:24]
  wire [94:0] _wdata_align_4_T_1 = _GEN_2 << _wdata_align_4_T; // @[datamem.scala 131:24]
  wire [94:0] _GEN_0 = {{63'd0}, wmask}; // @[datamem.scala 131:47]
  wire [94:0] _wdata_align_4_T_2 = _wdata_align_4_T_1 & _GEN_0; // @[datamem.scala 131:47]
  wire [31:0] _wdata_align_4_T_3 = ~wmask; // @[datamem.scala 131:71]
  wire [31:0] _wdata_align_4_T_4 = RamBB_i1_rdata_4_w & _wdata_align_4_T_3; // @[datamem.scala 131:69]
  wire [94:0] _GEN_1 = {{63'd0}, _wdata_align_4_T_4}; // @[datamem.scala 131:56]
  wire [94:0] wdata_align_4 = _wdata_align_4_T_2 | _GEN_1; // @[datamem.scala 131:56]
  RamBB RamBB_i1 ( // @[datamem.scala 50:26]
    .clock(RamBB_i1_clock),
    .addr(RamBB_i1_addr),
    .wdata(RamBB_i1_wdata),
    .mem_wen(RamBB_i1_mem_wen),
    .valid(RamBB_i1_valid),
    .rdata(RamBB_i1_rdata),
    .rdata_4_w(RamBB_i1_rdata_4_w)
  );
  assign io_out_rdata = 4'h3 == io_in_lsu_op ? lw_rdata : _io_out_rdata_T_9; // @[Mux.scala 81:58]
  assign RamBB_i1_clock = clock; // @[datamem.scala 52:25]
  assign RamBB_i1_addr = {io_in_addr[31:2], 2'h0}; // @[datamem.scala 53:46]
  assign RamBB_i1_wdata = wdata_align_4[31:0]; // @[datamem.scala 133:25]
  assign RamBB_i1_mem_wen = io_in_mem_wen; // @[datamem.scala 54:25]
  assign RamBB_i1_valid = io_in_valid; // @[datamem.scala 55:25]
endmodule
module ebreak_moudle(
  input   is_ebreak
);
  wire  EbreakBB_i1_is_ebreak; // @[ebreak.scala 21:29]
  EbreakBB EbreakBB_i1 ( // @[ebreak.scala 21:29]
    .is_ebreak(EbreakBB_i1_is_ebreak)
  );
  assign EbreakBB_i1_is_ebreak = is_ebreak; // @[ebreak.scala 23:30]
endmodule
module not_impl_moudle(
  input   not_impl
);
  wire  NotImplBB_i1_not_impl; // @[not_impl.scala 21:30]
  NotImplBB NotImplBB_i1 ( // @[not_impl.scala 21:30]
    .not_impl(NotImplBB_i1_not_impl)
  );
  assign NotImplBB_i1_not_impl = not_impl; // @[not_impl.scala 23:30]
endmodule
module CSR(
  input         clock,
  input         reset,
  input  [2:0]  io_in_csr_op,
  input  [31:0] io_in_cur_pc,
  input  [31:0] io_in_csr_id,
  input  [31:0] io_in_wdata,
  output        io_out_ctrl_csr,
  output [31:0] io_out_csr_pc,
  output [31:0] io_out_r_csr,
  output [31:0] io_out_difftest_mcause,
  output [31:0] io_out_difftest_mepc,
  output [31:0] io_out_difftest_mstatus,
  output [31:0] io_out_difftest_mtvec
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] reg_mepc; // @[csr.scala 40:28]
  reg [31:0] reg_mcause; // @[csr.scala 41:28]
  reg [31:0] reg_mstatus; // @[csr.scala 42:28]
  reg [31:0] reg_mtvec; // @[csr.scala 43:28]
  wire [31:0] _reg_mcause_csrrs_T = io_in_wdata | reg_mcause; // @[csr.scala 59:32]
  wire [31:0] _reg_mepc_csrrs_T = io_in_wdata | reg_mepc; // @[csr.scala 71:30]
  wire [31:0] _reg_mstatus_csrrs_T = io_in_wdata | reg_mstatus; // @[csr.scala 83:33]
  wire [31:0] _reg_mstatus_T_5 = {reg_mstatus[31:13],2'h3,reg_mstatus[10:8],reg_mstatus[3],reg_mstatus[6:4],1'h0,
    reg_mstatus[2:0]}; // @[Cat.scala 33:92]
  wire [30:0] _reg_mstatus_T_11 = {reg_mstatus[31:13],1'h0,reg_mstatus[10:8],1'h1,reg_mstatus[6:4],reg_mstatus[7],
    reg_mstatus[2:0]}; // @[Cat.scala 33:92]
  wire [31:0] _reg_mstatus_T_13 = 3'h1 == io_in_csr_op ? _reg_mstatus_T_5 : reg_mstatus; // @[Mux.scala 81:58]
  wire [31:0] _reg_mtvec_csrrs_T = io_in_wdata | reg_mtvec; // @[csr.scala 108:31]
  wire [31:0] _io_out_csr_pc_T_1 = 3'h1 == io_in_csr_op ? reg_mtvec : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _io_out_r_csr_T_1 = 32'h305 == io_in_csr_id ? reg_mtvec : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _io_out_r_csr_T_3 = 32'h341 == io_in_csr_id ? reg_mepc : _io_out_r_csr_T_1; // @[Mux.scala 81:58]
  wire [31:0] _io_out_r_csr_T_5 = 32'h342 == io_in_csr_id ? reg_mcause : _io_out_r_csr_T_3; // @[Mux.scala 81:58]
  assign io_out_ctrl_csr = 3'h2 == io_in_csr_op | 3'h1 == io_in_csr_op; // @[Mux.scala 81:58]
  assign io_out_csr_pc = 3'h2 == io_in_csr_op ? reg_mepc : _io_out_csr_pc_T_1; // @[Mux.scala 81:58]
  assign io_out_r_csr = 32'h300 == io_in_csr_id ? reg_mstatus : _io_out_r_csr_T_5; // @[Mux.scala 81:58]
  assign io_out_difftest_mcause = reg_mcause; // @[csr.scala 133:27]
  assign io_out_difftest_mepc = reg_mepc; // @[csr.scala 134:27]
  assign io_out_difftest_mstatus = reg_mstatus; // @[csr.scala 135:27]
  assign io_out_difftest_mtvec = reg_mtvec; // @[csr.scala 136:27]
  always @(posedge clock) begin
    if (reset) begin // @[csr.scala 40:28]
      reg_mepc <= 32'h0; // @[csr.scala 40:28]
    end else if (3'h4 == io_in_csr_op) begin // @[Mux.scala 81:58]
      if (32'h341 == io_in_csr_id) begin // @[Mux.scala 81:58]
        reg_mepc <= _reg_mepc_csrrs_T;
      end
    end else if (3'h3 == io_in_csr_op) begin // @[Mux.scala 81:58]
      if (32'h341 == io_in_csr_id) begin // @[Mux.scala 81:58]
        reg_mepc <= io_in_wdata;
      end
    end else if (3'h1 == io_in_csr_op) begin // @[Mux.scala 81:58]
      reg_mepc <= io_in_cur_pc;
    end
    if (reset) begin // @[csr.scala 41:28]
      reg_mcause <= 32'h0; // @[csr.scala 41:28]
    end else if (3'h4 == io_in_csr_op) begin // @[Mux.scala 81:58]
      if (32'h342 == io_in_csr_id) begin // @[Mux.scala 81:58]
        reg_mcause <= _reg_mcause_csrrs_T;
      end
    end else if (3'h3 == io_in_csr_op) begin // @[Mux.scala 81:58]
      if (32'h342 == io_in_csr_id) begin // @[Mux.scala 81:58]
        reg_mcause <= io_in_wdata;
      end
    end else if (3'h1 == io_in_csr_op) begin // @[Mux.scala 81:58]
      reg_mcause <= 32'hb;
    end
    if (reset) begin // @[csr.scala 42:28]
      reg_mstatus <= 32'h0; // @[csr.scala 42:28]
    end else if (3'h4 == io_in_csr_op) begin // @[Mux.scala 81:58]
      if (32'h300 == io_in_csr_id) begin // @[Mux.scala 81:58]
        reg_mstatus <= _reg_mstatus_csrrs_T;
      end
    end else if (3'h3 == io_in_csr_op) begin // @[Mux.scala 81:58]
      if (32'h300 == io_in_csr_id) begin // @[Mux.scala 81:58]
        reg_mstatus <= io_in_wdata;
      end
    end else if (3'h2 == io_in_csr_op) begin // @[Mux.scala 81:58]
      reg_mstatus <= {{1'd0}, _reg_mstatus_T_11};
    end else begin
      reg_mstatus <= _reg_mstatus_T_13;
    end
    if (reset) begin // @[csr.scala 43:28]
      reg_mtvec <= 32'h0; // @[csr.scala 43:28]
    end else if (3'h4 == io_in_csr_op) begin // @[Mux.scala 81:58]
      if (32'h305 == io_in_csr_id) begin // @[Mux.scala 81:58]
        reg_mtvec <= _reg_mtvec_csrrs_T;
      end
    end else if (3'h3 == io_in_csr_op) begin // @[Mux.scala 81:58]
      if (32'h305 == io_in_csr_id) begin // @[Mux.scala 81:58]
        reg_mtvec <= io_in_wdata;
      end
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
  reg_mepc = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  reg_mcause = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  reg_mstatus = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  reg_mtvec = _RAND_3[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Mdu(
  input  [31:0] io_in_src1,
  input  [31:0] io_in_src2,
  input  [3:0]  io_in_mdu_op,
  output [31:0] io_out_mdu_result
);
  wire [63:0] _io_out_mdu_result_T = io_in_src1 * io_in_src2; // @[mdu.scala 36:44]
  wire [63:0] _io_out_mdu_result_T_3 = $signed(io_in_src1) * $signed(io_in_src2); // @[mdu.scala 37:52]
  wire [31:0] _io_out_mdu_result_T_5 = _io_out_mdu_result_T_3[63:32]; // @[mdu.scala 37:86]
  wire [32:0] _io_out_mdu_result_T_7 = {1'b0,$signed(io_in_src2)}; // @[mdu.scala 38:52]
  wire [64:0] _io_out_mdu_result_T_8 = $signed(io_in_src1) * $signed(_io_out_mdu_result_T_7); // @[mdu.scala 38:52]
  wire [63:0] _io_out_mdu_result_T_10 = _io_out_mdu_result_T_8[63:0]; // @[mdu.scala 38:52]
  wire [31:0] _io_out_mdu_result_T_12 = _io_out_mdu_result_T_10[63:32]; // @[mdu.scala 38:79]
  wire [32:0] _io_out_mdu_result_T_18 = $signed(io_in_src1) / $signed(io_in_src2); // @[mdu.scala 40:70]
  wire [31:0] _io_out_mdu_result_T_19 = io_in_src1 / io_in_src2; // @[mdu.scala 41:44]
  wire [31:0] _io_out_mdu_result_T_23 = $signed(io_in_src1) % $signed(io_in_src2); // @[mdu.scala 42:70]
  wire [31:0] _io_out_mdu_result_T_24 = io_in_src1 % io_in_src2; // @[mdu.scala 43:44]
  wire [63:0] _io_out_mdu_result_T_28 = 4'h1 == io_in_mdu_op ? _io_out_mdu_result_T : 64'h0; // @[Mux.scala 81:58]
  wire [63:0] _io_out_mdu_result_T_30 = 4'h2 == io_in_mdu_op ? {{32'd0}, _io_out_mdu_result_T_5} :
    _io_out_mdu_result_T_28; // @[Mux.scala 81:58]
  wire [63:0] _io_out_mdu_result_T_32 = 4'h3 == io_in_mdu_op ? {{32'd0}, _io_out_mdu_result_T_12} :
    _io_out_mdu_result_T_30; // @[Mux.scala 81:58]
  wire [63:0] _io_out_mdu_result_T_34 = 4'h4 == io_in_mdu_op ? {{32'd0}, _io_out_mdu_result_T[63:32]} :
    _io_out_mdu_result_T_32; // @[Mux.scala 81:58]
  wire [63:0] _io_out_mdu_result_T_36 = 4'h5 == io_in_mdu_op ? {{31'd0}, _io_out_mdu_result_T_18} :
    _io_out_mdu_result_T_34; // @[Mux.scala 81:58]
  wire [63:0] _io_out_mdu_result_T_38 = 4'h6 == io_in_mdu_op ? {{32'd0}, _io_out_mdu_result_T_19} :
    _io_out_mdu_result_T_36; // @[Mux.scala 81:58]
  wire [63:0] _io_out_mdu_result_T_40 = 4'h7 == io_in_mdu_op ? {{32'd0}, _io_out_mdu_result_T_23} :
    _io_out_mdu_result_T_38; // @[Mux.scala 81:58]
  wire [63:0] _io_out_mdu_result_T_42 = 4'h8 == io_in_mdu_op ? {{32'd0}, _io_out_mdu_result_T_24} :
    _io_out_mdu_result_T_40; // @[Mux.scala 81:58]
  assign io_out_mdu_result = _io_out_mdu_result_T_42[31:0]; // @[mdu.scala 33:25]
endmodule
module top(
  input         clock,
  input         reset,
  output [31:0] io_out_inst,
  output [31:0] io_out_pc,
  output [31:0] io_out_difftest_mcause,
  output [31:0] io_out_difftest_mepc,
  output [31:0] io_out_difftest_mstatus,
  output [31:0] io_out_difftest_mtvec
);
  wire  IFU_i_clock; // @[top.scala 36:37]
  wire  IFU_i_reset; // @[top.scala 36:37]
  wire  IFU_i_io_in_ctrl_br; // @[top.scala 36:37]
  wire [31:0] IFU_i_io_in_addr_target; // @[top.scala 36:37]
  wire  IFU_i_io_in_ctrl_csr; // @[top.scala 36:37]
  wire [31:0] IFU_i_io_in_excpt_addr; // @[top.scala 36:37]
  wire [31:0] IFU_i_io_out_cur_pc; // @[top.scala 36:37]
  wire [31:0] IFU_i_to_IDU_bits_inst; // @[top.scala 36:37]
  wire [31:0] IDU_i_io_out_imm; // @[top.scala 37:33]
  wire [4:0] IDU_i_io_out_rs1; // @[top.scala 37:33]
  wire [4:0] IDU_i_io_out_rs2; // @[top.scala 37:33]
  wire [4:0] IDU_i_io_out_rd; // @[top.scala 37:33]
  wire  IDU_i_io_out_ctrl_sig_mem_wen; // @[top.scala 37:33]
  wire  IDU_i_io_out_ctrl_sig_reg_wen; // @[top.scala 37:33]
  wire  IDU_i_io_out_ctrl_sig_is_ebreak; // @[top.scala 37:33]
  wire  IDU_i_io_out_ctrl_sig_not_impl; // @[top.scala 37:33]
  wire [1:0] IDU_i_io_out_ctrl_sig_src1_op; // @[top.scala 37:33]
  wire [1:0] IDU_i_io_out_ctrl_sig_src2_op; // @[top.scala 37:33]
  wire [3:0] IDU_i_io_out_ctrl_sig_alu_op; // @[top.scala 37:33]
  wire [2:0] IDU_i_io_out_ctrl_sig_fu_op; // @[top.scala 37:33]
  wire [3:0] IDU_i_io_out_ctrl_sig_lsu_op; // @[top.scala 37:33]
  wire [3:0] IDU_i_io_out_ctrl_sig_bru_op; // @[top.scala 37:33]
  wire [2:0] IDU_i_io_out_ctrl_sig_csr_op; // @[top.scala 37:33]
  wire [3:0] IDU_i_io_out_ctrl_sig_mdu_op; // @[top.scala 37:33]
  wire [31:0] IDU_i_from_IFU_bits_inst; // @[top.scala 37:33]
  wire  RegFile_i_clock; // @[top.scala 38:37]
  wire  RegFile_i_reset; // @[top.scala 38:37]
  wire [4:0] RegFile_i_io_in_rs1; // @[top.scala 38:37]
  wire [4:0] RegFile_i_io_in_rs2; // @[top.scala 38:37]
  wire [4:0] RegFile_i_io_in_rd; // @[top.scala 38:37]
  wire [31:0] RegFile_i_io_in_wdata; // @[top.scala 38:37]
  wire  RegFile_i_io_in_reg_wen; // @[top.scala 38:37]
  wire [31:0] RegFile_i_io_out_rdata1; // @[top.scala 38:37]
  wire [31:0] RegFile_i_io_out_rdata2; // @[top.scala 38:37]
  wire [31:0] Alu_i_io_alu_in_src1; // @[top.scala 39:37]
  wire [31:0] Alu_i_io_alu_in_src2; // @[top.scala 39:37]
  wire [3:0] Alu_i_io_alu_in_alu_op; // @[top.scala 39:37]
  wire [31:0] Alu_i_io_alu_out_alu_result; // @[top.scala 39:37]
  wire [31:0] Bru_i_io_bru_in_src1; // @[top.scala 40:37]
  wire [31:0] Bru_i_io_bru_in_src2; // @[top.scala 40:37]
  wire [3:0] Bru_i_io_bru_in_bru_op; // @[top.scala 40:37]
  wire  Bru_i_io_bru_out_ctrl_br; // @[top.scala 40:37]
  wire  Ram_i_clock; // @[top.scala 41:37]
  wire  Ram_i_io_in_valid; // @[top.scala 41:37]
  wire  Ram_i_io_in_mem_wen; // @[top.scala 41:37]
  wire [31:0] Ram_i_io_in_addr; // @[top.scala 41:37]
  wire [31:0] Ram_i_io_in_wdata; // @[top.scala 41:37]
  wire [3:0] Ram_i_io_in_lsu_op; // @[top.scala 41:37]
  wire [31:0] Ram_i_io_out_rdata; // @[top.scala 41:37]
  wire  ebreak_moudle_i_is_ebreak; // @[top.scala 42:37]
  wire  not_impl_moudle_i_not_impl; // @[top.scala 43:37]
  wire  csr_i_clock; // @[top.scala 44:37]
  wire  csr_i_reset; // @[top.scala 44:37]
  wire [2:0] csr_i_io_in_csr_op; // @[top.scala 44:37]
  wire [31:0] csr_i_io_in_cur_pc; // @[top.scala 44:37]
  wire [31:0] csr_i_io_in_csr_id; // @[top.scala 44:37]
  wire [31:0] csr_i_io_in_wdata; // @[top.scala 44:37]
  wire  csr_i_io_out_ctrl_csr; // @[top.scala 44:37]
  wire [31:0] csr_i_io_out_csr_pc; // @[top.scala 44:37]
  wire [31:0] csr_i_io_out_r_csr; // @[top.scala 44:37]
  wire [31:0] csr_i_io_out_difftest_mcause; // @[top.scala 44:37]
  wire [31:0] csr_i_io_out_difftest_mepc; // @[top.scala 44:37]
  wire [31:0] csr_i_io_out_difftest_mstatus; // @[top.scala 44:37]
  wire [31:0] csr_i_io_out_difftest_mtvec; // @[top.scala 44:37]
  wire [31:0] Mdu_i_io_in_src1; // @[top.scala 45:37]
  wire [31:0] Mdu_i_io_in_src2; // @[top.scala 45:37]
  wire [3:0] Mdu_i_io_in_mdu_op; // @[top.scala 45:37]
  wire [31:0] Mdu_i_io_out_mdu_result; // @[top.scala 45:37]
  wire [31:0] _RegFile_i_io_in_wdata_T_1 = IFU_i_io_out_cur_pc + 32'h4; // @[top.scala 70:50]
  wire [31:0] _RegFile_i_io_in_wdata_T_3 = 3'h1 == IDU_i_io_out_ctrl_sig_fu_op ? Alu_i_io_alu_out_alu_result : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _RegFile_i_io_in_wdata_T_5 = 3'h4 == IDU_i_io_out_ctrl_sig_fu_op ? Ram_i_io_out_rdata :
    _RegFile_i_io_in_wdata_T_3; // @[Mux.scala 81:58]
  wire [31:0] _RegFile_i_io_in_wdata_T_7 = 3'h3 == IDU_i_io_out_ctrl_sig_fu_op ? _RegFile_i_io_in_wdata_T_1 :
    _RegFile_i_io_in_wdata_T_5; // @[Mux.scala 81:58]
  wire [31:0] _RegFile_i_io_in_wdata_T_9 = 3'h5 == IDU_i_io_out_ctrl_sig_fu_op ? csr_i_io_out_r_csr :
    _RegFile_i_io_in_wdata_T_7; // @[Mux.scala 81:58]
  wire [31:0] _Alu_i_io_alu_in_src1_T_1 = 2'h2 == IDU_i_io_out_ctrl_sig_src1_op ? RegFile_i_io_out_rdata1 : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _Alu_i_io_alu_in_src2_T_1 = 2'h2 == IDU_i_io_out_ctrl_sig_src2_op ? RegFile_i_io_out_rdata2 : 32'h0; // @[Mux.scala 81:58]
  IFU IFU_i ( // @[top.scala 36:37]
    .clock(IFU_i_clock),
    .reset(IFU_i_reset),
    .io_in_ctrl_br(IFU_i_io_in_ctrl_br),
    .io_in_addr_target(IFU_i_io_in_addr_target),
    .io_in_ctrl_csr(IFU_i_io_in_ctrl_csr),
    .io_in_excpt_addr(IFU_i_io_in_excpt_addr),
    .io_out_cur_pc(IFU_i_io_out_cur_pc),
    .to_IDU_bits_inst(IFU_i_to_IDU_bits_inst)
  );
  IDU IDU_i ( // @[top.scala 37:33]
    .io_out_imm(IDU_i_io_out_imm),
    .io_out_rs1(IDU_i_io_out_rs1),
    .io_out_rs2(IDU_i_io_out_rs2),
    .io_out_rd(IDU_i_io_out_rd),
    .io_out_ctrl_sig_mem_wen(IDU_i_io_out_ctrl_sig_mem_wen),
    .io_out_ctrl_sig_reg_wen(IDU_i_io_out_ctrl_sig_reg_wen),
    .io_out_ctrl_sig_is_ebreak(IDU_i_io_out_ctrl_sig_is_ebreak),
    .io_out_ctrl_sig_not_impl(IDU_i_io_out_ctrl_sig_not_impl),
    .io_out_ctrl_sig_src1_op(IDU_i_io_out_ctrl_sig_src1_op),
    .io_out_ctrl_sig_src2_op(IDU_i_io_out_ctrl_sig_src2_op),
    .io_out_ctrl_sig_alu_op(IDU_i_io_out_ctrl_sig_alu_op),
    .io_out_ctrl_sig_fu_op(IDU_i_io_out_ctrl_sig_fu_op),
    .io_out_ctrl_sig_lsu_op(IDU_i_io_out_ctrl_sig_lsu_op),
    .io_out_ctrl_sig_bru_op(IDU_i_io_out_ctrl_sig_bru_op),
    .io_out_ctrl_sig_csr_op(IDU_i_io_out_ctrl_sig_csr_op),
    .io_out_ctrl_sig_mdu_op(IDU_i_io_out_ctrl_sig_mdu_op),
    .from_IFU_bits_inst(IDU_i_from_IFU_bits_inst)
  );
  RegFile RegFile_i ( // @[top.scala 38:37]
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
  Alu Alu_i ( // @[top.scala 39:37]
    .io_alu_in_src1(Alu_i_io_alu_in_src1),
    .io_alu_in_src2(Alu_i_io_alu_in_src2),
    .io_alu_in_alu_op(Alu_i_io_alu_in_alu_op),
    .io_alu_out_alu_result(Alu_i_io_alu_out_alu_result)
  );
  Bru Bru_i ( // @[top.scala 40:37]
    .io_bru_in_src1(Bru_i_io_bru_in_src1),
    .io_bru_in_src2(Bru_i_io_bru_in_src2),
    .io_bru_in_bru_op(Bru_i_io_bru_in_bru_op),
    .io_bru_out_ctrl_br(Bru_i_io_bru_out_ctrl_br)
  );
  Ram Ram_i ( // @[top.scala 41:37]
    .clock(Ram_i_clock),
    .io_in_valid(Ram_i_io_in_valid),
    .io_in_mem_wen(Ram_i_io_in_mem_wen),
    .io_in_addr(Ram_i_io_in_addr),
    .io_in_wdata(Ram_i_io_in_wdata),
    .io_in_lsu_op(Ram_i_io_in_lsu_op),
    .io_out_rdata(Ram_i_io_out_rdata)
  );
  ebreak_moudle ebreak_moudle_i ( // @[top.scala 42:37]
    .is_ebreak(ebreak_moudle_i_is_ebreak)
  );
  not_impl_moudle not_impl_moudle_i ( // @[top.scala 43:37]
    .not_impl(not_impl_moudle_i_not_impl)
  );
  CSR csr_i ( // @[top.scala 44:37]
    .clock(csr_i_clock),
    .reset(csr_i_reset),
    .io_in_csr_op(csr_i_io_in_csr_op),
    .io_in_cur_pc(csr_i_io_in_cur_pc),
    .io_in_csr_id(csr_i_io_in_csr_id),
    .io_in_wdata(csr_i_io_in_wdata),
    .io_out_ctrl_csr(csr_i_io_out_ctrl_csr),
    .io_out_csr_pc(csr_i_io_out_csr_pc),
    .io_out_r_csr(csr_i_io_out_r_csr),
    .io_out_difftest_mcause(csr_i_io_out_difftest_mcause),
    .io_out_difftest_mepc(csr_i_io_out_difftest_mepc),
    .io_out_difftest_mstatus(csr_i_io_out_difftest_mstatus),
    .io_out_difftest_mtvec(csr_i_io_out_difftest_mtvec)
  );
  Mdu Mdu_i ( // @[top.scala 45:37]
    .io_in_src1(Mdu_i_io_in_src1),
    .io_in_src2(Mdu_i_io_in_src2),
    .io_in_mdu_op(Mdu_i_io_in_mdu_op),
    .io_out_mdu_result(Mdu_i_io_out_mdu_result)
  );
  assign io_out_inst = IFU_i_to_IDU_bits_inst; // @[top.scala 115:20]
  assign io_out_pc = IFU_i_io_out_cur_pc; // @[top.scala 116:20]
  assign io_out_difftest_mcause = csr_i_io_out_difftest_mcause; // @[top.scala 118:29]
  assign io_out_difftest_mepc = csr_i_io_out_difftest_mepc; // @[top.scala 119:29]
  assign io_out_difftest_mstatus = csr_i_io_out_difftest_mstatus; // @[top.scala 120:29]
  assign io_out_difftest_mtvec = csr_i_io_out_difftest_mtvec; // @[top.scala 121:29]
  assign IFU_i_clock = clock;
  assign IFU_i_reset = reset;
  assign IFU_i_io_in_ctrl_br = Bru_i_io_bru_out_ctrl_br; // @[top.scala 48:30]
  assign IFU_i_io_in_addr_target = Alu_i_io_alu_out_alu_result; // @[top.scala 49:30]
  assign IFU_i_io_in_ctrl_csr = csr_i_io_out_ctrl_csr; // @[top.scala 50:30]
  assign IFU_i_io_in_excpt_addr = csr_i_io_out_csr_pc; // @[top.scala 51:30]
  assign IDU_i_from_IFU_bits_inst = IFU_i_to_IDU_bits_inst; // @[top.scala 58:26]
  assign RegFile_i_clock = clock;
  assign RegFile_i_reset = reset;
  assign RegFile_i_io_in_rs1 = IDU_i_io_out_rs1; // @[top.scala 64:29]
  assign RegFile_i_io_in_rs2 = IDU_i_io_out_rs2; // @[top.scala 65:29]
  assign RegFile_i_io_in_rd = IDU_i_io_out_rd; // @[top.scala 63:29]
  assign RegFile_i_io_in_wdata = 3'h2 == IDU_i_io_out_ctrl_sig_fu_op ? Mdu_i_io_out_mdu_result :
    _RegFile_i_io_in_wdata_T_9; // @[Mux.scala 81:58]
  assign RegFile_i_io_in_reg_wen = IDU_i_io_out_ctrl_sig_reg_wen; // @[top.scala 66:29]
  assign Alu_i_io_alu_in_src1 = 2'h1 == IDU_i_io_out_ctrl_sig_src1_op ? IFU_i_io_out_cur_pc : _Alu_i_io_alu_in_src1_T_1; // @[Mux.scala 81:58]
  assign Alu_i_io_alu_in_src2 = 2'h3 == IDU_i_io_out_ctrl_sig_src2_op ? IDU_i_io_out_imm : _Alu_i_io_alu_in_src2_T_1; // @[Mux.scala 81:58]
  assign Alu_i_io_alu_in_alu_op = IDU_i_io_out_ctrl_sig_alu_op; // @[top.scala 76:28]
  assign Bru_i_io_bru_in_src1 = RegFile_i_io_out_rdata1; // @[top.scala 93:28]
  assign Bru_i_io_bru_in_src2 = RegFile_i_io_out_rdata2; // @[top.scala 94:28]
  assign Bru_i_io_bru_in_bru_op = IDU_i_io_out_ctrl_sig_bru_op; // @[top.scala 92:28]
  assign Ram_i_clock = clock;
  assign Ram_i_io_in_valid = IDU_i_io_out_ctrl_sig_fu_op == 3'h4; // @[top.scala 101:56]
  assign Ram_i_io_in_mem_wen = IDU_i_io_out_ctrl_sig_mem_wen; // @[top.scala 99:25]
  assign Ram_i_io_in_addr = Alu_i_io_alu_out_alu_result; // @[top.scala 97:25]
  assign Ram_i_io_in_wdata = RegFile_i_io_out_rdata2; // @[top.scala 98:25]
  assign Ram_i_io_in_lsu_op = IDU_i_io_out_ctrl_sig_lsu_op; // @[top.scala 100:25]
  assign ebreak_moudle_i_is_ebreak = IDU_i_io_out_ctrl_sig_is_ebreak; // @[top.scala 110:32]
  assign not_impl_moudle_i_not_impl = IDU_i_io_out_ctrl_sig_not_impl; // @[top.scala 113:32]
  assign csr_i_clock = clock;
  assign csr_i_reset = reset;
  assign csr_i_io_in_csr_op = IDU_i_io_out_ctrl_sig_csr_op; // @[top.scala 104:25]
  assign csr_i_io_in_cur_pc = IFU_i_io_out_cur_pc; // @[top.scala 105:25]
  assign csr_i_io_in_csr_id = IDU_i_io_out_imm; // @[top.scala 106:25]
  assign csr_i_io_in_wdata = RegFile_i_io_out_rdata1; // @[top.scala 107:25]
  assign Mdu_i_io_in_src1 = RegFile_i_io_out_rdata1; // @[top.scala 88:24]
  assign Mdu_i_io_in_src2 = RegFile_i_io_out_rdata2; // @[top.scala 89:24]
  assign Mdu_i_io_in_mdu_op = IDU_i_io_out_ctrl_sig_mdu_op; // @[top.scala 87:24]
endmodule
