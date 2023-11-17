/* verilator lint_off DECLFILENAME */
/* verilator lint_off UNUSEDSIGNAL */
/* verilator lint_off UNDRIVEN */
/* verilator lint_off UNOPTFLAT */
/* verilator lint_off WIDTHEXPAND */
module IDU(
  input         from_IFU_valid,
  input  [31:0] from_IFU_bits_inst,
  input  [31:0] from_IFU_bits_pc,
  output        to_ISU_valid,
  output [31:0] to_ISU_bits_imm,
  output [31:0] to_ISU_bits_pc,
  output [4:0]  to_ISU_bits_rs1,
  output [4:0]  to_ISU_bits_rs2,
  output [4:0]  to_ISU_bits_rd,
  output        to_ISU_bits_ctrl_sig_reg_wen,
  output [2:0]  to_ISU_bits_ctrl_sig_fu_op,
  output        to_ISU_bits_ctrl_sig_mem_wen,
  output        to_ISU_bits_ctrl_sig_is_ebreak,
  output        to_ISU_bits_ctrl_sig_not_impl,
  output [1:0]  to_ISU_bits_ctrl_sig_src1_op,
  output [1:0]  to_ISU_bits_ctrl_sig_src2_op,
  output [3:0]  to_ISU_bits_ctrl_sig_alu_op,
  output [3:0]  to_ISU_bits_ctrl_sig_lsu_op,
  output [3:0]  to_ISU_bits_ctrl_sig_bru_op,
  output [2:0]  to_ISU_bits_ctrl_sig_csr_op,
  output [3:0]  to_ISU_bits_ctrl_sig_mdu_op
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
  wire [2:0] inst_type = decode_info_invMatrixOutputs[21:19]; // @[IDU.scala 111:36]
  wire [31:0] _to_ISU_bits_imm_T_1 = 3'h1 == inst_type ? imm_i : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _to_ISU_bits_imm_T_3 = 3'h2 == inst_type ? imm_s : _to_ISU_bits_imm_T_1; // @[Mux.scala 81:58]
  wire [31:0] _to_ISU_bits_imm_T_5 = 3'h3 == inst_type ? imm_b : _to_ISU_bits_imm_T_3; // @[Mux.scala 81:58]
  wire [31:0] _to_ISU_bits_imm_T_7 = 3'h4 == inst_type ? imm_u : _to_ISU_bits_imm_T_5; // @[Mux.scala 81:58]
  wire [32:0] _to_ISU_bits_imm_T_9 = 3'h5 == inst_type ? imm_j : {{1'd0}, _to_ISU_bits_imm_T_7}; // @[Mux.scala 81:58]
  assign to_ISU_valid = from_IFU_valid; // @[IDU.scala 17:20]
  assign to_ISU_bits_imm = _to_ISU_bits_imm_T_9[31:0]; // @[IDU.scala 112:21]
  assign to_ISU_bits_pc = from_IFU_bits_pc; // @[IDU.scala 122:21]
  assign to_ISU_bits_rs1 = from_IFU_bits_inst[19:15]; // @[IDU.scala 119:42]
  assign to_ISU_bits_rs2 = from_IFU_bits_inst[24:20]; // @[IDU.scala 120:42]
  assign to_ISU_bits_rd = from_IFU_bits_inst[11:7]; // @[IDU.scala 121:42]
  assign to_ISU_bits_ctrl_sig_reg_wen = decode_info_invMatrixOutputs[10]; // @[IDU.scala 130:50]
  assign to_ISU_bits_ctrl_sig_fu_op = decode_info_invMatrixOutputs[32:30]; // @[IDU.scala 136:50]
  assign to_ISU_bits_ctrl_sig_mem_wen = decode_info_invMatrixOutputs[9]; // @[IDU.scala 129:50]
  assign to_ISU_bits_ctrl_sig_is_ebreak = decode_info_invMatrixOutputs[8]; // @[IDU.scala 128:50]
  assign to_ISU_bits_ctrl_sig_not_impl = decode_info_invMatrixOutputs[7]; // @[IDU.scala 127:50]
  assign to_ISU_bits_ctrl_sig_src1_op = decode_info_invMatrixOutputs[14:13]; // @[IDU.scala 132:50]
  assign to_ISU_bits_ctrl_sig_src2_op = decode_info_invMatrixOutputs[12:11]; // @[IDU.scala 131:50]
  assign to_ISU_bits_ctrl_sig_alu_op = decode_info_invMatrixOutputs[18:15]; // @[IDU.scala 133:50]
  assign to_ISU_bits_ctrl_sig_lsu_op = decode_info_invMatrixOutputs[29:26]; // @[IDU.scala 135:50]
  assign to_ISU_bits_ctrl_sig_bru_op = decode_info_invMatrixOutputs[25:22]; // @[IDU.scala 134:50]
  assign to_ISU_bits_ctrl_sig_csr_op = decode_info_invMatrixOutputs[6:4]; // @[IDU.scala 126:50]
  assign to_ISU_bits_ctrl_sig_mdu_op = decode_info_invMatrixOutputs[3:0]; // @[IDU.scala 125:50]
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
module ISU(
  input         clock,
  input         reset,
  input         from_IDU_valid,
  input  [31:0] from_IDU_bits_imm,
  input  [31:0] from_IDU_bits_pc,
  input  [4:0]  from_IDU_bits_rs1,
  input  [4:0]  from_IDU_bits_rs2,
  input  [4:0]  from_IDU_bits_rd,
  input         from_IDU_bits_ctrl_sig_reg_wen,
  input  [2:0]  from_IDU_bits_ctrl_sig_fu_op,
  input         from_IDU_bits_ctrl_sig_mem_wen,
  input         from_IDU_bits_ctrl_sig_is_ebreak,
  input         from_IDU_bits_ctrl_sig_not_impl,
  input  [1:0]  from_IDU_bits_ctrl_sig_src1_op,
  input  [1:0]  from_IDU_bits_ctrl_sig_src2_op,
  input  [3:0]  from_IDU_bits_ctrl_sig_alu_op,
  input  [3:0]  from_IDU_bits_ctrl_sig_lsu_op,
  input  [3:0]  from_IDU_bits_ctrl_sig_bru_op,
  input  [2:0]  from_IDU_bits_ctrl_sig_csr_op,
  input  [3:0]  from_IDU_bits_ctrl_sig_mdu_op,
  input         from_WBU_bits_reg_wen,
  input  [31:0] from_WBU_bits_wdata,
  input  [4:0]  from_WBU_bits_rd,
  output        to_EXU_valid,
  output [31:0] to_EXU_bits_imm,
  output [31:0] to_EXU_bits_pc,
  output [31:0] to_EXU_bits_rdata1,
  output [31:0] to_EXU_bits_rdata2,
  output [4:0]  to_EXU_bits_rd,
  output        to_EXU_bits_ctrl_sig_reg_wen,
  output [2:0]  to_EXU_bits_ctrl_sig_fu_op,
  output        to_EXU_bits_ctrl_sig_mem_wen,
  output        to_EXU_bits_ctrl_sig_is_ebreak,
  output        to_EXU_bits_ctrl_sig_not_impl,
  output [1:0]  to_EXU_bits_ctrl_sig_src1_op,
  output [1:0]  to_EXU_bits_ctrl_sig_src2_op,
  output [3:0]  to_EXU_bits_ctrl_sig_alu_op,
  output [3:0]  to_EXU_bits_ctrl_sig_lsu_op,
  output [3:0]  to_EXU_bits_ctrl_sig_bru_op,
  output [2:0]  to_EXU_bits_ctrl_sig_csr_op,
  output [3:0]  to_EXU_bits_ctrl_sig_mdu_op
);
  wire  RegFile_i_clock; // @[ISU.scala 20:37]
  wire  RegFile_i_reset; // @[ISU.scala 20:37]
  wire [4:0] RegFile_i_io_in_rs1; // @[ISU.scala 20:37]
  wire [4:0] RegFile_i_io_in_rs2; // @[ISU.scala 20:37]
  wire [4:0] RegFile_i_io_in_rd; // @[ISU.scala 20:37]
  wire [31:0] RegFile_i_io_in_wdata; // @[ISU.scala 20:37]
  wire  RegFile_i_io_in_reg_wen; // @[ISU.scala 20:37]
  wire [31:0] RegFile_i_io_out_rdata1; // @[ISU.scala 20:37]
  wire [31:0] RegFile_i_io_out_rdata2; // @[ISU.scala 20:37]
  RegFile RegFile_i ( // @[ISU.scala 20:37]
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
  assign to_EXU_valid = from_IDU_valid; // @[ISU.scala 18:20]
  assign to_EXU_bits_imm = from_IDU_bits_imm; // @[ISU.scala 33:26]
  assign to_EXU_bits_pc = from_IDU_bits_pc; // @[ISU.scala 34:26]
  assign to_EXU_bits_rdata1 = RegFile_i_io_out_rdata1; // @[ISU.scala 36:26]
  assign to_EXU_bits_rdata2 = RegFile_i_io_out_rdata2; // @[ISU.scala 37:26]
  assign to_EXU_bits_rd = from_IDU_bits_rd; // @[ISU.scala 35:26]
  assign to_EXU_bits_ctrl_sig_reg_wen = from_IDU_bits_ctrl_sig_reg_wen; // @[ISU.scala 32:26]
  assign to_EXU_bits_ctrl_sig_fu_op = from_IDU_bits_ctrl_sig_fu_op; // @[ISU.scala 32:26]
  assign to_EXU_bits_ctrl_sig_mem_wen = from_IDU_bits_ctrl_sig_mem_wen; // @[ISU.scala 32:26]
  assign to_EXU_bits_ctrl_sig_is_ebreak = from_IDU_bits_ctrl_sig_is_ebreak; // @[ISU.scala 32:26]
  assign to_EXU_bits_ctrl_sig_not_impl = from_IDU_bits_ctrl_sig_not_impl; // @[ISU.scala 32:26]
  assign to_EXU_bits_ctrl_sig_src1_op = from_IDU_bits_ctrl_sig_src1_op; // @[ISU.scala 32:26]
  assign to_EXU_bits_ctrl_sig_src2_op = from_IDU_bits_ctrl_sig_src2_op; // @[ISU.scala 32:26]
  assign to_EXU_bits_ctrl_sig_alu_op = from_IDU_bits_ctrl_sig_alu_op; // @[ISU.scala 32:26]
  assign to_EXU_bits_ctrl_sig_lsu_op = from_IDU_bits_ctrl_sig_lsu_op; // @[ISU.scala 32:26]
  assign to_EXU_bits_ctrl_sig_bru_op = from_IDU_bits_ctrl_sig_bru_op; // @[ISU.scala 32:26]
  assign to_EXU_bits_ctrl_sig_csr_op = from_IDU_bits_ctrl_sig_csr_op; // @[ISU.scala 32:26]
  assign to_EXU_bits_ctrl_sig_mdu_op = from_IDU_bits_ctrl_sig_mdu_op; // @[ISU.scala 32:26]
  assign RegFile_i_clock = clock;
  assign RegFile_i_reset = reset;
  assign RegFile_i_io_in_rs1 = from_IDU_bits_rs1; // @[ISU.scala 24:29]
  assign RegFile_i_io_in_rs2 = from_IDU_bits_rs2; // @[ISU.scala 25:29]
  assign RegFile_i_io_in_rd = from_WBU_bits_rd; // @[ISU.scala 23:29]
  assign RegFile_i_io_in_wdata = from_WBU_bits_wdata; // @[ISU.scala 29:29]
  assign RegFile_i_io_in_reg_wen = from_WBU_bits_reg_wen; // @[ISU.scala 28:29]
endmodule
module Alu(
  input  [31:0] io_in_src1,
  input  [31:0] io_in_src2,
  input  [3:0]  io_in_op,
  output [31:0] io_out_result
);
  wire [4:0] shamt = io_in_src2[4:0]; // @[alu.scala 31:25]
  wire [31:0] _io_out_result_T_1 = io_in_src1 + io_in_src2; // @[alu.scala 36:42]
  wire [31:0] _io_out_result_T_3 = io_in_src1 - io_in_src2; // @[alu.scala 37:42]
  wire [31:0] _io_out_result_T_4 = io_in_src1 & io_in_src2; // @[alu.scala 38:42]
  wire [31:0] _io_out_result_T_5 = io_in_src1 | io_in_src2; // @[alu.scala 39:42]
  wire [31:0] _io_out_result_T_6 = io_in_src1 ^ io_in_src2; // @[alu.scala 40:42]
  wire  _io_out_result_T_9 = $signed(io_in_src1) < $signed(io_in_src2); // @[alu.scala 41:49]
  wire  _io_out_result_T_10 = io_in_src1 < io_in_src2; // @[alu.scala 42:42]
  wire [62:0] _GEN_0 = {{31'd0}, io_in_src1}; // @[alu.scala 43:42]
  wire [62:0] _io_out_result_T_11 = _GEN_0 << shamt; // @[alu.scala 43:42]
  wire [31:0] _io_out_result_T_12 = io_in_src1 >> shamt; // @[alu.scala 44:42]
  wire [31:0] _io_out_result_T_15 = $signed(io_in_src1) >>> shamt; // @[alu.scala 45:59]
  wire [31:0] _io_out_result_T_19 = 4'h1 == io_in_op ? _io_out_result_T_1 : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _io_out_result_T_21 = 4'h2 == io_in_op ? _io_out_result_T_3 : _io_out_result_T_19; // @[Mux.scala 81:58]
  wire [31:0] _io_out_result_T_23 = 4'h3 == io_in_op ? _io_out_result_T_4 : _io_out_result_T_21; // @[Mux.scala 81:58]
  wire [31:0] _io_out_result_T_25 = 4'h4 == io_in_op ? _io_out_result_T_5 : _io_out_result_T_23; // @[Mux.scala 81:58]
  wire [31:0] _io_out_result_T_27 = 4'h5 == io_in_op ? _io_out_result_T_6 : _io_out_result_T_25; // @[Mux.scala 81:58]
  wire [31:0] _io_out_result_T_29 = 4'h6 == io_in_op ? {{31'd0}, _io_out_result_T_9} : _io_out_result_T_27; // @[Mux.scala 81:58]
  wire [31:0] _io_out_result_T_31 = 4'h7 == io_in_op ? {{31'd0}, _io_out_result_T_10} : _io_out_result_T_29; // @[Mux.scala 81:58]
  wire [62:0] _io_out_result_T_33 = 4'h8 == io_in_op ? _io_out_result_T_11 : {{31'd0}, _io_out_result_T_31}; // @[Mux.scala 81:58]
  wire [62:0] _io_out_result_T_35 = 4'h9 == io_in_op ? {{31'd0}, _io_out_result_T_12} : _io_out_result_T_33; // @[Mux.scala 81:58]
  wire [62:0] _io_out_result_T_37 = 4'ha == io_in_op ? {{31'd0}, _io_out_result_T_15} : _io_out_result_T_35; // @[Mux.scala 81:58]
  assign io_out_result = _io_out_result_T_37[31:0]; // @[alu.scala 33:21]
endmodule
module Mdu(
  input  [31:0] io_in_src1,
  input  [31:0] io_in_src2,
  input  [3:0]  io_in_op,
  output [31:0] io_out_result
);
  wire [63:0] _io_out_result_T = io_in_src1 * io_in_src2; // @[mdu.scala 36:44]
  wire [63:0] _io_out_result_T_3 = $signed(io_in_src1) * $signed(io_in_src2); // @[mdu.scala 37:52]
  wire [31:0] _io_out_result_T_5 = _io_out_result_T_3[63:32]; // @[mdu.scala 37:86]
  wire [32:0] _io_out_result_T_7 = {1'b0,$signed(io_in_src2)}; // @[mdu.scala 38:52]
  wire [64:0] _io_out_result_T_8 = $signed(io_in_src1) * $signed(_io_out_result_T_7); // @[mdu.scala 38:52]
  wire [63:0] _io_out_result_T_10 = _io_out_result_T_8[63:0]; // @[mdu.scala 38:52]
  wire [31:0] _io_out_result_T_12 = _io_out_result_T_10[63:32]; // @[mdu.scala 38:79]
  wire [32:0] _io_out_result_T_18 = $signed(io_in_src1) / $signed(io_in_src2); // @[mdu.scala 40:70]
  wire [31:0] _io_out_result_T_19 = io_in_src1 / io_in_src2; // @[mdu.scala 41:44]
  wire [31:0] _io_out_result_T_23 = $signed(io_in_src1) % $signed(io_in_src2); // @[mdu.scala 42:70]
  wire [31:0] _io_out_result_T_24 = io_in_src1 % io_in_src2; // @[mdu.scala 43:44]
  wire [63:0] _io_out_result_T_28 = 4'h1 == io_in_op ? _io_out_result_T : 64'h0; // @[Mux.scala 81:58]
  wire [63:0] _io_out_result_T_30 = 4'h2 == io_in_op ? {{32'd0}, _io_out_result_T_5} : _io_out_result_T_28; // @[Mux.scala 81:58]
  wire [63:0] _io_out_result_T_32 = 4'h3 == io_in_op ? {{32'd0}, _io_out_result_T_12} : _io_out_result_T_30; // @[Mux.scala 81:58]
  wire [63:0] _io_out_result_T_34 = 4'h4 == io_in_op ? {{32'd0}, _io_out_result_T[63:32]} : _io_out_result_T_32; // @[Mux.scala 81:58]
  wire [63:0] _io_out_result_T_36 = 4'h5 == io_in_op ? {{31'd0}, _io_out_result_T_18} : _io_out_result_T_34; // @[Mux.scala 81:58]
  wire [63:0] _io_out_result_T_38 = 4'h6 == io_in_op ? {{32'd0}, _io_out_result_T_19} : _io_out_result_T_36; // @[Mux.scala 81:58]
  wire [63:0] _io_out_result_T_40 = 4'h7 == io_in_op ? {{32'd0}, _io_out_result_T_23} : _io_out_result_T_38; // @[Mux.scala 81:58]
  wire [63:0] _io_out_result_T_42 = 4'h8 == io_in_op ? {{32'd0}, _io_out_result_T_24} : _io_out_result_T_40; // @[Mux.scala 81:58]
  assign io_out_result = _io_out_result_T_42[31:0]; // @[mdu.scala 33:21]
endmodule
module Bru(
  input  [31:0] io_in_src1,
  input  [31:0] io_in_src2,
  input  [3:0]  io_in_op,
  output        io_out_ctrl_br
);
  wire  _io_out_ctrl_br_T = io_in_src1 == io_in_src2; // @[bru.scala 35:44]
  wire  _io_out_ctrl_br_T_1 = io_in_src1 != io_in_src2; // @[bru.scala 36:44]
  wire  _io_out_ctrl_br_T_4 = $signed(io_in_src1) < $signed(io_in_src2); // @[bru.scala 37:51]
  wire  _io_out_ctrl_br_T_7 = $signed(io_in_src1) >= $signed(io_in_src2); // @[bru.scala 38:51]
  wire  _io_out_ctrl_br_T_8 = io_in_src1 < io_in_src2; // @[bru.scala 39:51]
  wire  _io_out_ctrl_br_T_9 = io_in_src1 >= io_in_src2; // @[bru.scala 40:51]
  wire  _io_out_ctrl_br_T_15 = 4'h3 == io_in_op ? _io_out_ctrl_br_T : 4'h2 == io_in_op | 4'h1 == io_in_op; // @[Mux.scala 81:58]
  wire  _io_out_ctrl_br_T_17 = 4'h4 == io_in_op ? _io_out_ctrl_br_T_1 : _io_out_ctrl_br_T_15; // @[Mux.scala 81:58]
  wire  _io_out_ctrl_br_T_19 = 4'h5 == io_in_op ? _io_out_ctrl_br_T_4 : _io_out_ctrl_br_T_17; // @[Mux.scala 81:58]
  wire  _io_out_ctrl_br_T_21 = 4'h6 == io_in_op ? _io_out_ctrl_br_T_7 : _io_out_ctrl_br_T_19; // @[Mux.scala 81:58]
  wire  _io_out_ctrl_br_T_23 = 4'h7 == io_in_op ? _io_out_ctrl_br_T_8 : _io_out_ctrl_br_T_21; // @[Mux.scala 81:58]
  assign io_out_ctrl_br = 4'h8 == io_in_op ? _io_out_ctrl_br_T_9 : _io_out_ctrl_br_T_23; // @[Mux.scala 81:58]
endmodule
module Lsu_axi(
  input         clock,
  input         reset,
  input         io_in_valid,
  input         io_in_mem_wen,
  input  [31:0] io_in_addr,
  input  [31:0] io_in_wdata,
  input  [3:0]  io_in_op,
  output [31:0] io_out_rdata,
  output        io_out_end,
  output        io_out_idle,
  input         axi_ar_ready,
  output        axi_ar_valid,
  output [31:0] axi_ar_bits_addr,
  output        axi_r_ready,
  input         axi_r_valid,
  input  [31:0] axi_r_bits_data,
  input         axi_aw_ready,
  output        axi_aw_valid,
  output [31:0] axi_aw_bits_addr,
  output        axi_w_valid,
  output [31:0] axi_w_bits_data,
  output [3:0]  axi_w_bits_strb,
  output        axi_b_ready,
  input         axi_b_valid
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [2:0] state_lsu; // @[lsu.scala 166:28]
  wire  _state_lsu_T = axi_ar_ready & axi_ar_valid; // @[Decoupled.scala 51:35]
  wire  _state_lsu_T_2 = axi_r_ready & axi_r_valid; // @[Decoupled.scala 51:35]
  wire [2:0] _state_lsu_T_3 = _state_lsu_T_2 ? 3'h5 : 3'h2; // @[lsu.scala 183:29]
  wire  _state_lsu_T_4 = axi_aw_ready & axi_aw_valid; // @[Decoupled.scala 51:35]
  wire [2:0] _state_lsu_T_5 = _state_lsu_T_4 ? 3'h4 : 3'h3; // @[lsu.scala 188:29]
  wire  _state_lsu_T_6 = axi_b_ready & axi_b_valid; // @[Decoupled.scala 51:35]
  wire [2:0] _state_lsu_T_7 = _state_lsu_T_6 ? 3'h5 : 3'h4; // @[lsu.scala 191:29]
  wire [2:0] _GEN_2 = 3'h5 == state_lsu ? 3'h0 : state_lsu; // @[lsu.scala 167:24 194:23 166:28]
  wire [2:0] _GEN_3 = 3'h4 == state_lsu ? _state_lsu_T_7 : _GEN_2; // @[lsu.scala 167:24 191:23]
  wire [2:0] _GEN_4 = 3'h3 == state_lsu ? _state_lsu_T_5 : _GEN_3; // @[lsu.scala 167:24 188:23]
  wire [1:0] addr_low_2 = io_in_addr[1:0]; // @[lsu.scala 201:31]
  wire [23:0] _lb_rdata_T_2 = axi_r_bits_data[7] ? 24'hffffff : 24'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _lb_rdata_T_4 = {_lb_rdata_T_2,axi_r_bits_data[7:0]}; // @[Cat.scala 33:92]
  wire [23:0] _lb_rdata_T_7 = axi_r_bits_data[15] ? 24'hffffff : 24'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _lb_rdata_T_9 = {_lb_rdata_T_7,axi_r_bits_data[15:8]}; // @[Cat.scala 33:92]
  wire [23:0] _lb_rdata_T_12 = axi_r_bits_data[23] ? 24'hffffff : 24'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _lb_rdata_T_14 = {_lb_rdata_T_12,axi_r_bits_data[23:16]}; // @[Cat.scala 33:92]
  wire [23:0] _lb_rdata_T_17 = axi_r_bits_data[31] ? 24'hffffff : 24'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _lb_rdata_T_19 = {_lb_rdata_T_17,axi_r_bits_data[31:24]}; // @[Cat.scala 33:92]
  wire [31:0] _lb_rdata_T_21 = 2'h1 == addr_low_2 ? _lb_rdata_T_9 : _lb_rdata_T_4; // @[Mux.scala 81:58]
  wire [31:0] _lb_rdata_T_23 = 2'h2 == addr_low_2 ? _lb_rdata_T_14 : _lb_rdata_T_21; // @[Mux.scala 81:58]
  wire [31:0] lb_rdata = 2'h3 == addr_low_2 ? _lb_rdata_T_19 : _lb_rdata_T_23; // @[Mux.scala 81:58]
  wire [31:0] _lbu_rdata_T_2 = {24'h0,axi_r_bits_data[7:0]}; // @[Cat.scala 33:92]
  wire [31:0] _lbu_rdata_T_5 = {24'h0,axi_r_bits_data[15:8]}; // @[Cat.scala 33:92]
  wire [31:0] _lbu_rdata_T_8 = {24'h0,axi_r_bits_data[23:16]}; // @[Cat.scala 33:92]
  wire [31:0] _lbu_rdata_T_11 = {24'h0,axi_r_bits_data[31:24]}; // @[Cat.scala 33:92]
  wire [31:0] _lbu_rdata_T_13 = 2'h1 == addr_low_2 ? _lbu_rdata_T_5 : _lbu_rdata_T_2; // @[Mux.scala 81:58]
  wire [31:0] _lbu_rdata_T_15 = 2'h2 == addr_low_2 ? _lbu_rdata_T_8 : _lbu_rdata_T_13; // @[Mux.scala 81:58]
  wire [31:0] lbu_rdata = 2'h3 == addr_low_2 ? _lbu_rdata_T_11 : _lbu_rdata_T_15; // @[Mux.scala 81:58]
  wire [15:0] _lh_rdata_T_2 = axi_r_bits_data[15] ? 16'hffff : 16'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _lh_rdata_T_4 = {_lh_rdata_T_2,axi_r_bits_data[15:0]}; // @[Cat.scala 33:92]
  wire [15:0] _lh_rdata_T_7 = axi_r_bits_data[31] ? 16'hffff : 16'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _lh_rdata_T_9 = {_lh_rdata_T_7,axi_r_bits_data[31:16]}; // @[Cat.scala 33:92]
  wire [31:0] _lh_rdata_T_11 = 2'h0 == addr_low_2 ? _lh_rdata_T_4 : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] lh_rdata = 2'h2 == addr_low_2 ? _lh_rdata_T_9 : _lh_rdata_T_11; // @[Mux.scala 81:58]
  wire [31:0] _lhu_rdata_T_2 = {16'h0,axi_r_bits_data[15:0]}; // @[Cat.scala 33:92]
  wire [31:0] _lhu_rdata_T_5 = {16'h0,axi_r_bits_data[31:16]}; // @[Cat.scala 33:92]
  wire [31:0] _lhu_rdata_T_7 = 2'h0 == addr_low_2 ? _lhu_rdata_T_2 : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] lhu_rdata = 2'h2 == addr_low_2 ? _lhu_rdata_T_5 : _lhu_rdata_T_7; // @[Mux.scala 81:58]
  wire [1:0] _sb_wmask_T_1 = 2'h1 == addr_low_2 ? 2'h2 : 2'h1; // @[Mux.scala 81:58]
  wire [2:0] _sb_wmask_T_3 = 2'h2 == addr_low_2 ? 3'h4 : {{1'd0}, _sb_wmask_T_1}; // @[Mux.scala 81:58]
  wire [3:0] sb_wmask = 2'h3 == addr_low_2 ? 4'h8 : {{1'd0}, _sb_wmask_T_3}; // @[Mux.scala 81:58]
  wire [1:0] _sh_wmask_T_1 = 2'h0 == addr_low_2 ? 2'h3 : 2'h0; // @[Mux.scala 81:58]
  wire [3:0] sh_wmask = 2'h2 == addr_low_2 ? 4'hc : {{2'd0}, _sh_wmask_T_1}; // @[Mux.scala 81:58]
  wire [3:0] _wmask_T_1 = 4'h6 == io_in_op ? sb_wmask : 4'h0; // @[Mux.scala 81:58]
  wire [3:0] _wmask_T_3 = 4'h7 == io_in_op ? sh_wmask : _wmask_T_1; // @[Mux.scala 81:58]
  wire [31:0] _io_out_rdata_T_3 = 4'h1 == io_in_op ? lb_rdata : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _io_out_rdata_T_5 = 4'h4 == io_in_op ? lbu_rdata : _io_out_rdata_T_3; // @[Mux.scala 81:58]
  wire [31:0] _io_out_rdata_T_7 = 4'h2 == io_in_op ? lh_rdata : _io_out_rdata_T_5; // @[Mux.scala 81:58]
  wire [31:0] _io_out_rdata_T_9 = 4'h5 == io_in_op ? lhu_rdata : _io_out_rdata_T_7; // @[Mux.scala 81:58]
  assign io_out_rdata = 4'h3 == io_in_op ? axi_r_bits_data : _io_out_rdata_T_9; // @[Mux.scala 81:58]
  assign io_out_end = 3'h5 == state_lsu; // @[Mux.scala 81:61]
  assign io_out_idle = 3'h0 == state_lsu; // @[Mux.scala 81:61]
  assign axi_ar_valid = 3'h1 == state_lsu; // @[Mux.scala 81:61]
  assign axi_ar_bits_addr = io_in_addr; // @[lsu.scala 278:23]
  assign axi_r_ready = 3'h2 == state_lsu; // @[Mux.scala 81:61]
  assign axi_aw_valid = 3'h3 == state_lsu; // @[Mux.scala 81:61]
  assign axi_aw_bits_addr = io_in_addr; // @[lsu.scala 284:23]
  assign axi_w_valid = 3'h4 == state_lsu; // @[Mux.scala 81:61]
  assign axi_w_bits_data = io_in_wdata; // @[lsu.scala 289:23]
  assign axi_w_bits_strb = 4'h8 == io_in_op ? 4'hf : _wmask_T_3; // @[Mux.scala 81:58]
  assign axi_b_ready = 3'h4 == state_lsu; // @[Mux.scala 81:61]
  always @(posedge clock) begin
    if (reset) begin // @[lsu.scala 166:28]
      state_lsu <= 3'h0; // @[lsu.scala 166:28]
    end else if (3'h0 == state_lsu) begin // @[lsu.scala 167:24]
      if (io_in_valid) begin // @[lsu.scala 169:32]
        if (io_in_mem_wen) begin // @[lsu.scala 170:38]
          state_lsu <= 3'h3; // @[lsu.scala 171:31]
        end else begin
          state_lsu <= 3'h1; // @[lsu.scala 173:31]
        end
      end else begin
        state_lsu <= 3'h0; // @[lsu.scala 176:27]
      end
    end else if (3'h1 == state_lsu) begin // @[lsu.scala 167:24]
      if (_state_lsu_T) begin // @[lsu.scala 180:29]
        state_lsu <= 3'h2;
      end else begin
        state_lsu <= 3'h1;
      end
    end else if (3'h2 == state_lsu) begin // @[lsu.scala 167:24]
      state_lsu <= _state_lsu_T_3; // @[lsu.scala 183:23]
    end else begin
      state_lsu <= _GEN_4;
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
  state_lsu = _RAND_0[2:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Csr(
  input         clock,
  input         reset,
  input  [2:0]  io_in_op,
  input  [31:0] io_in_cur_pc,
  input  [31:0] io_in_csr_id,
  input  [31:0] io_in_wdata,
  output        io_out_csr_br,
  output [31:0] io_out_csr_addr,
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
  reg [31:0] reg_mepc; // @[csr.scala 32:28]
  reg [31:0] reg_mcause; // @[csr.scala 33:28]
  reg [31:0] reg_mstatus; // @[csr.scala 34:28]
  reg [31:0] reg_mtvec; // @[csr.scala 35:28]
  wire [31:0] _reg_mcause_csrrs_T = io_in_wdata | reg_mcause; // @[csr.scala 51:32]
  wire [31:0] _reg_mepc_csrrs_T = io_in_wdata | reg_mepc; // @[csr.scala 63:30]
  wire [31:0] _reg_mstatus_csrrs_T = io_in_wdata | reg_mstatus; // @[csr.scala 75:33]
  wire [31:0] _reg_mstatus_T_5 = {reg_mstatus[31:13],2'h3,reg_mstatus[10:8],reg_mstatus[3],reg_mstatus[6:4],1'h0,
    reg_mstatus[2:0]}; // @[Cat.scala 33:92]
  wire [30:0] _reg_mstatus_T_11 = {reg_mstatus[31:13],1'h0,reg_mstatus[10:8],1'h1,reg_mstatus[6:4],reg_mstatus[7],
    reg_mstatus[2:0]}; // @[Cat.scala 33:92]
  wire [31:0] _reg_mstatus_T_13 = 3'h1 == io_in_op ? _reg_mstatus_T_5 : reg_mstatus; // @[Mux.scala 81:58]
  wire [31:0] _reg_mtvec_csrrs_T = io_in_wdata | reg_mtvec; // @[csr.scala 100:31]
  wire [31:0] _io_out_csr_addr_T_1 = 3'h1 == io_in_op ? reg_mtvec : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _io_out_r_csr_T_1 = 32'h305 == io_in_csr_id ? reg_mtvec : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _io_out_r_csr_T_3 = 32'h341 == io_in_csr_id ? reg_mepc : _io_out_r_csr_T_1; // @[Mux.scala 81:58]
  wire [31:0] _io_out_r_csr_T_5 = 32'h342 == io_in_csr_id ? reg_mcause : _io_out_r_csr_T_3; // @[Mux.scala 81:58]
  assign io_out_csr_br = 3'h2 == io_in_op | 3'h1 == io_in_op; // @[Mux.scala 81:58]
  assign io_out_csr_addr = 3'h2 == io_in_op ? reg_mepc : _io_out_csr_addr_T_1; // @[Mux.scala 81:58]
  assign io_out_r_csr = 32'h300 == io_in_csr_id ? reg_mstatus : _io_out_r_csr_T_5; // @[Mux.scala 81:58]
  assign io_out_difftest_mcause = reg_mcause; // @[csr.scala 125:27]
  assign io_out_difftest_mepc = reg_mepc; // @[csr.scala 126:27]
  assign io_out_difftest_mstatus = reg_mstatus; // @[csr.scala 127:27]
  assign io_out_difftest_mtvec = reg_mtvec; // @[csr.scala 128:27]
  always @(posedge clock) begin
    if (reset) begin // @[csr.scala 32:28]
      reg_mepc <= 32'h0; // @[csr.scala 32:28]
    end else if (3'h4 == io_in_op) begin // @[Mux.scala 81:58]
      if (32'h341 == io_in_csr_id) begin // @[Mux.scala 81:58]
        reg_mepc <= _reg_mepc_csrrs_T;
      end
    end else if (3'h3 == io_in_op) begin // @[Mux.scala 81:58]
      if (32'h341 == io_in_csr_id) begin // @[Mux.scala 81:58]
        reg_mepc <= io_in_wdata;
      end
    end else if (3'h1 == io_in_op) begin // @[Mux.scala 81:58]
      reg_mepc <= io_in_cur_pc;
    end
    if (reset) begin // @[csr.scala 33:28]
      reg_mcause <= 32'h0; // @[csr.scala 33:28]
    end else if (3'h4 == io_in_op) begin // @[Mux.scala 81:58]
      if (32'h342 == io_in_csr_id) begin // @[Mux.scala 81:58]
        reg_mcause <= _reg_mcause_csrrs_T;
      end
    end else if (3'h3 == io_in_op) begin // @[Mux.scala 81:58]
      if (32'h342 == io_in_csr_id) begin // @[Mux.scala 81:58]
        reg_mcause <= io_in_wdata;
      end
    end else if (3'h1 == io_in_op) begin // @[Mux.scala 81:58]
      reg_mcause <= 32'hb;
    end
    if (reset) begin // @[csr.scala 34:28]
      reg_mstatus <= 32'h0; // @[csr.scala 34:28]
    end else if (3'h4 == io_in_op) begin // @[Mux.scala 81:58]
      if (32'h300 == io_in_csr_id) begin // @[Mux.scala 81:58]
        reg_mstatus <= _reg_mstatus_csrrs_T;
      end
    end else if (3'h3 == io_in_op) begin // @[Mux.scala 81:58]
      if (32'h300 == io_in_csr_id) begin // @[Mux.scala 81:58]
        reg_mstatus <= io_in_wdata;
      end
    end else if (3'h2 == io_in_op) begin // @[Mux.scala 81:58]
      reg_mstatus <= {{1'd0}, _reg_mstatus_T_11};
    end else begin
      reg_mstatus <= _reg_mstatus_T_13;
    end
    if (reset) begin // @[csr.scala 35:28]
      reg_mtvec <= 32'h0; // @[csr.scala 35:28]
    end else if (3'h4 == io_in_op) begin // @[Mux.scala 81:58]
      if (32'h305 == io_in_csr_id) begin // @[Mux.scala 81:58]
        reg_mtvec <= _reg_mtvec_csrrs_T;
      end
    end else if (3'h3 == io_in_op) begin // @[Mux.scala 81:58]
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
module EXU(
  input         clock,
  input         reset,
  output        from_ISU_ready,
  input         from_ISU_valid,
  input  [31:0] from_ISU_bits_imm,
  input  [31:0] from_ISU_bits_pc,
  input  [31:0] from_ISU_bits_rdata1,
  input  [31:0] from_ISU_bits_rdata2,
  input  [4:0]  from_ISU_bits_rd,
  input         from_ISU_bits_ctrl_sig_reg_wen,
  input  [2:0]  from_ISU_bits_ctrl_sig_fu_op,
  input         from_ISU_bits_ctrl_sig_mem_wen,
  input         from_ISU_bits_ctrl_sig_is_ebreak,
  input         from_ISU_bits_ctrl_sig_not_impl,
  input  [1:0]  from_ISU_bits_ctrl_sig_src1_op,
  input  [1:0]  from_ISU_bits_ctrl_sig_src2_op,
  input  [3:0]  from_ISU_bits_ctrl_sig_alu_op,
  input  [3:0]  from_ISU_bits_ctrl_sig_lsu_op,
  input  [3:0]  from_ISU_bits_ctrl_sig_bru_op,
  input  [2:0]  from_ISU_bits_ctrl_sig_csr_op,
  input  [3:0]  from_ISU_bits_ctrl_sig_mdu_op,
  output        to_WBU_valid,
  output [31:0] to_WBU_bits_alu_result,
  output [31:0] to_WBU_bits_mdu_result,
  output [31:0] to_WBU_bits_lsu_rdata,
  output [31:0] to_WBU_bits_csr_rdata,
  output [31:0] to_WBU_bits_pc,
  output        to_WBU_bits_reg_wen,
  output [4:0]  to_WBU_bits_rd,
  output [2:0]  to_WBU_bits_fu_op,
  output        to_IFU_bits_bru_ctrl_br,
  output [31:0] to_IFU_bits_bru_addr,
  output        to_IFU_bits_csr_ctrl_br,
  output [31:0] to_IFU_bits_csr_addr,
  output [31:0] difftest_mcause,
  output [31:0] difftest_mepc,
  output [31:0] difftest_mstatus,
  output [31:0] difftest_mtvec,
  input         lsu_axi_master_ar_ready,
  output        lsu_axi_master_ar_valid,
  output [31:0] lsu_axi_master_ar_bits_addr,
  output        lsu_axi_master_r_ready,
  input         lsu_axi_master_r_valid,
  input  [31:0] lsu_axi_master_r_bits_data,
  input         lsu_axi_master_aw_ready,
  output        lsu_axi_master_aw_valid,
  output [31:0] lsu_axi_master_aw_bits_addr,
  output        lsu_axi_master_w_valid,
  output [31:0] lsu_axi_master_w_bits_data,
  output [3:0]  lsu_axi_master_w_bits_strb,
  input         lsu_axi_master_b_valid
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire [31:0] Alu_i_io_in_src1; // @[EXU.scala 24:35]
  wire [31:0] Alu_i_io_in_src2; // @[EXU.scala 24:35]
  wire [3:0] Alu_i_io_in_op; // @[EXU.scala 24:35]
  wire [31:0] Alu_i_io_out_result; // @[EXU.scala 24:35]
  wire [31:0] Mdu_i_io_in_src1; // @[EXU.scala 25:35]
  wire [31:0] Mdu_i_io_in_src2; // @[EXU.scala 25:35]
  wire [3:0] Mdu_i_io_in_op; // @[EXU.scala 25:35]
  wire [31:0] Mdu_i_io_out_result; // @[EXU.scala 25:35]
  wire [31:0] Bru_i_io_in_src1; // @[EXU.scala 26:35]
  wire [31:0] Bru_i_io_in_src2; // @[EXU.scala 26:35]
  wire [3:0] Bru_i_io_in_op; // @[EXU.scala 26:35]
  wire  Bru_i_io_out_ctrl_br; // @[EXU.scala 26:35]
  wire  Lsu_i_clock; // @[EXU.scala 27:35]
  wire  Lsu_i_reset; // @[EXU.scala 27:35]
  wire  Lsu_i_io_in_valid; // @[EXU.scala 27:35]
  wire  Lsu_i_io_in_mem_wen; // @[EXU.scala 27:35]
  wire [31:0] Lsu_i_io_in_addr; // @[EXU.scala 27:35]
  wire [31:0] Lsu_i_io_in_wdata; // @[EXU.scala 27:35]
  wire [3:0] Lsu_i_io_in_op; // @[EXU.scala 27:35]
  wire [31:0] Lsu_i_io_out_rdata; // @[EXU.scala 27:35]
  wire  Lsu_i_io_out_end; // @[EXU.scala 27:35]
  wire  Lsu_i_io_out_idle; // @[EXU.scala 27:35]
  wire  Lsu_i_axi_ar_ready; // @[EXU.scala 27:35]
  wire  Lsu_i_axi_ar_valid; // @[EXU.scala 27:35]
  wire [31:0] Lsu_i_axi_ar_bits_addr; // @[EXU.scala 27:35]
  wire  Lsu_i_axi_r_ready; // @[EXU.scala 27:35]
  wire  Lsu_i_axi_r_valid; // @[EXU.scala 27:35]
  wire [31:0] Lsu_i_axi_r_bits_data; // @[EXU.scala 27:35]
  wire  Lsu_i_axi_aw_ready; // @[EXU.scala 27:35]
  wire  Lsu_i_axi_aw_valid; // @[EXU.scala 27:35]
  wire [31:0] Lsu_i_axi_aw_bits_addr; // @[EXU.scala 27:35]
  wire  Lsu_i_axi_w_valid; // @[EXU.scala 27:35]
  wire [31:0] Lsu_i_axi_w_bits_data; // @[EXU.scala 27:35]
  wire [3:0] Lsu_i_axi_w_bits_strb; // @[EXU.scala 27:35]
  wire  Lsu_i_axi_b_ready; // @[EXU.scala 27:35]
  wire  Lsu_i_axi_b_valid; // @[EXU.scala 27:35]
  wire  Csr_i_clock; // @[EXU.scala 29:35]
  wire  Csr_i_reset; // @[EXU.scala 29:35]
  wire [2:0] Csr_i_io_in_op; // @[EXU.scala 29:35]
  wire [31:0] Csr_i_io_in_cur_pc; // @[EXU.scala 29:35]
  wire [31:0] Csr_i_io_in_csr_id; // @[EXU.scala 29:35]
  wire [31:0] Csr_i_io_in_wdata; // @[EXU.scala 29:35]
  wire  Csr_i_io_out_csr_br; // @[EXU.scala 29:35]
  wire [31:0] Csr_i_io_out_csr_addr; // @[EXU.scala 29:35]
  wire [31:0] Csr_i_io_out_r_csr; // @[EXU.scala 29:35]
  wire [31:0] Csr_i_io_out_difftest_mcause; // @[EXU.scala 29:35]
  wire [31:0] Csr_i_io_out_difftest_mepc; // @[EXU.scala 29:35]
  wire [31:0] Csr_i_io_out_difftest_mstatus; // @[EXU.scala 29:35]
  wire [31:0] Csr_i_io_out_difftest_mtvec; // @[EXU.scala 29:35]
  wire  ebreak_moudle_i_is_ebreak; // @[EXU.scala 30:35]
  wire  not_impl_moudle_i_not_impl; // @[EXU.scala 31:35]
  reg [1:0] state; // @[EXU.scala 40:24]
  wire  _state_T = from_ISU_ready & from_ISU_valid; // @[Decoupled.scala 51:35]
  wire [1:0] _state_T_2 = Lsu_i_io_out_idle ? 2'h2 : 2'h1; // @[EXU.scala 48:29]
  wire [1:0] _state_T_3 = Lsu_i_io_out_end ? 2'h3 : 2'h2; // @[EXU.scala 54:25]
  wire [1:0] _GEN_1 = 2'h3 == state ? 2'h0 : state; // @[EXU.scala 41:20 57:19 40:24]
  wire [31:0] _Alu_i_io_in_src1_T_1 = 2'h2 == from_ISU_bits_ctrl_sig_src1_op ? from_ISU_bits_rdata1 : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _Alu_i_io_in_src2_T_1 = 2'h2 == from_ISU_bits_ctrl_sig_src2_op ? from_ISU_bits_rdata2 : 32'h0; // @[Mux.scala 81:58]
  Alu Alu_i ( // @[EXU.scala 24:35]
    .io_in_src1(Alu_i_io_in_src1),
    .io_in_src2(Alu_i_io_in_src2),
    .io_in_op(Alu_i_io_in_op),
    .io_out_result(Alu_i_io_out_result)
  );
  Mdu Mdu_i ( // @[EXU.scala 25:35]
    .io_in_src1(Mdu_i_io_in_src1),
    .io_in_src2(Mdu_i_io_in_src2),
    .io_in_op(Mdu_i_io_in_op),
    .io_out_result(Mdu_i_io_out_result)
  );
  Bru Bru_i ( // @[EXU.scala 26:35]
    .io_in_src1(Bru_i_io_in_src1),
    .io_in_src2(Bru_i_io_in_src2),
    .io_in_op(Bru_i_io_in_op),
    .io_out_ctrl_br(Bru_i_io_out_ctrl_br)
  );
  Lsu_axi Lsu_i ( // @[EXU.scala 27:35]
    .clock(Lsu_i_clock),
    .reset(Lsu_i_reset),
    .io_in_valid(Lsu_i_io_in_valid),
    .io_in_mem_wen(Lsu_i_io_in_mem_wen),
    .io_in_addr(Lsu_i_io_in_addr),
    .io_in_wdata(Lsu_i_io_in_wdata),
    .io_in_op(Lsu_i_io_in_op),
    .io_out_rdata(Lsu_i_io_out_rdata),
    .io_out_end(Lsu_i_io_out_end),
    .io_out_idle(Lsu_i_io_out_idle),
    .axi_ar_ready(Lsu_i_axi_ar_ready),
    .axi_ar_valid(Lsu_i_axi_ar_valid),
    .axi_ar_bits_addr(Lsu_i_axi_ar_bits_addr),
    .axi_r_ready(Lsu_i_axi_r_ready),
    .axi_r_valid(Lsu_i_axi_r_valid),
    .axi_r_bits_data(Lsu_i_axi_r_bits_data),
    .axi_aw_ready(Lsu_i_axi_aw_ready),
    .axi_aw_valid(Lsu_i_axi_aw_valid),
    .axi_aw_bits_addr(Lsu_i_axi_aw_bits_addr),
    .axi_w_valid(Lsu_i_axi_w_valid),
    .axi_w_bits_data(Lsu_i_axi_w_bits_data),
    .axi_w_bits_strb(Lsu_i_axi_w_bits_strb),
    .axi_b_ready(Lsu_i_axi_b_ready),
    .axi_b_valid(Lsu_i_axi_b_valid)
  );
  Csr Csr_i ( // @[EXU.scala 29:35]
    .clock(Csr_i_clock),
    .reset(Csr_i_reset),
    .io_in_op(Csr_i_io_in_op),
    .io_in_cur_pc(Csr_i_io_in_cur_pc),
    .io_in_csr_id(Csr_i_io_in_csr_id),
    .io_in_wdata(Csr_i_io_in_wdata),
    .io_out_csr_br(Csr_i_io_out_csr_br),
    .io_out_csr_addr(Csr_i_io_out_csr_addr),
    .io_out_r_csr(Csr_i_io_out_r_csr),
    .io_out_difftest_mcause(Csr_i_io_out_difftest_mcause),
    .io_out_difftest_mepc(Csr_i_io_out_difftest_mepc),
    .io_out_difftest_mstatus(Csr_i_io_out_difftest_mstatus),
    .io_out_difftest_mtvec(Csr_i_io_out_difftest_mtvec)
  );
  ebreak_moudle ebreak_moudle_i ( // @[EXU.scala 30:35]
    .is_ebreak(ebreak_moudle_i_is_ebreak)
  );
  not_impl_moudle not_impl_moudle_i ( // @[EXU.scala 31:35]
    .not_impl(not_impl_moudle_i_not_impl)
  );
  assign from_ISU_ready = 2'h0 == state; // @[Mux.scala 81:61]
  assign to_WBU_valid = 2'h3 == state; // @[Mux.scala 81:61]
  assign to_WBU_bits_alu_result = Alu_i_io_out_result; // @[EXU.scala 105:28]
  assign to_WBU_bits_mdu_result = Mdu_i_io_out_result; // @[EXU.scala 106:28]
  assign to_WBU_bits_lsu_rdata = Lsu_i_io_out_rdata; // @[EXU.scala 107:28]
  assign to_WBU_bits_csr_rdata = Csr_i_io_out_r_csr; // @[EXU.scala 108:28]
  assign to_WBU_bits_pc = from_ISU_bits_pc; // @[EXU.scala 110:25]
  assign to_WBU_bits_reg_wen = from_ISU_bits_ctrl_sig_reg_wen; // @[EXU.scala 111:25]
  assign to_WBU_bits_rd = from_ISU_bits_rd; // @[EXU.scala 113:25]
  assign to_WBU_bits_fu_op = from_ISU_bits_ctrl_sig_fu_op; // @[EXU.scala 112:25]
  assign to_IFU_bits_bru_ctrl_br = Bru_i_io_out_ctrl_br; // @[EXU.scala 115:29]
  assign to_IFU_bits_bru_addr = Alu_i_io_out_result; // @[EXU.scala 116:29]
  assign to_IFU_bits_csr_ctrl_br = Csr_i_io_out_csr_br; // @[EXU.scala 117:29]
  assign to_IFU_bits_csr_addr = Csr_i_io_out_csr_addr; // @[EXU.scala 118:29]
  assign difftest_mcause = Csr_i_io_out_difftest_mcause; // @[EXU.scala 120:14]
  assign difftest_mepc = Csr_i_io_out_difftest_mepc; // @[EXU.scala 120:14]
  assign difftest_mstatus = Csr_i_io_out_difftest_mstatus; // @[EXU.scala 120:14]
  assign difftest_mtvec = Csr_i_io_out_difftest_mtvec; // @[EXU.scala 120:14]
  assign lsu_axi_master_ar_valid = Lsu_i_axi_ar_valid; // @[EXU.scala 121:20]
  assign lsu_axi_master_ar_bits_addr = Lsu_i_axi_ar_bits_addr; // @[EXU.scala 121:20]
  assign lsu_axi_master_r_ready = Lsu_i_axi_r_ready; // @[EXU.scala 121:20]
  assign lsu_axi_master_aw_valid = Lsu_i_axi_aw_valid; // @[EXU.scala 121:20]
  assign lsu_axi_master_aw_bits_addr = Lsu_i_axi_aw_bits_addr; // @[EXU.scala 121:20]
  assign lsu_axi_master_w_valid = Lsu_i_axi_w_valid; // @[EXU.scala 121:20]
  assign lsu_axi_master_w_bits_data = Lsu_i_axi_w_bits_data; // @[EXU.scala 121:20]
  assign lsu_axi_master_w_bits_strb = Lsu_i_axi_w_bits_strb; // @[EXU.scala 121:20]
  assign Alu_i_io_in_src1 = 2'h1 == from_ISU_bits_ctrl_sig_src1_op ? from_ISU_bits_pc : _Alu_i_io_in_src1_T_1; // @[Mux.scala 81:58]
  assign Alu_i_io_in_src2 = 2'h3 == from_ISU_bits_ctrl_sig_src2_op ? from_ISU_bits_imm : _Alu_i_io_in_src2_T_1; // @[Mux.scala 81:58]
  assign Alu_i_io_in_op = from_ISU_bits_ctrl_sig_alu_op; // @[EXU.scala 65:20]
  assign Mdu_i_io_in_src1 = from_ISU_bits_rdata1; // @[EXU.scala 77:22]
  assign Mdu_i_io_in_src2 = from_ISU_bits_rdata2; // @[EXU.scala 78:22]
  assign Mdu_i_io_in_op = from_ISU_bits_ctrl_sig_mdu_op; // @[EXU.scala 76:22]
  assign Bru_i_io_in_src1 = from_ISU_bits_rdata1; // @[EXU.scala 90:24]
  assign Bru_i_io_in_src2 = from_ISU_bits_rdata2; // @[EXU.scala 91:24]
  assign Bru_i_io_in_op = from_ISU_bits_ctrl_sig_bru_op; // @[EXU.scala 89:24]
  assign Lsu_i_clock = clock;
  assign Lsu_i_reset = reset;
  assign Lsu_i_io_in_valid = 2'h2 == state; // @[Mux.scala 81:61]
  assign Lsu_i_io_in_mem_wen = from_ISU_bits_ctrl_sig_mem_wen; // @[EXU.scala 83:25]
  assign Lsu_i_io_in_addr = Alu_i_io_out_result; // @[EXU.scala 81:25]
  assign Lsu_i_io_in_wdata = from_ISU_bits_rdata2; // @[EXU.scala 82:25]
  assign Lsu_i_io_in_op = from_ISU_bits_ctrl_sig_lsu_op; // @[EXU.scala 84:25]
  assign Lsu_i_axi_ar_ready = lsu_axi_master_ar_ready; // @[EXU.scala 121:20]
  assign Lsu_i_axi_r_valid = lsu_axi_master_r_valid; // @[EXU.scala 121:20]
  assign Lsu_i_axi_r_bits_data = lsu_axi_master_r_bits_data; // @[EXU.scala 121:20]
  assign Lsu_i_axi_aw_ready = lsu_axi_master_aw_ready; // @[EXU.scala 121:20]
  assign Lsu_i_axi_b_valid = lsu_axi_master_b_valid; // @[EXU.scala 121:20]
  assign Csr_i_clock = clock;
  assign Csr_i_reset = reset;
  assign Csr_i_io_in_op = from_ISU_bits_ctrl_sig_csr_op; // @[EXU.scala 94:25]
  assign Csr_i_io_in_cur_pc = from_ISU_bits_pc; // @[EXU.scala 95:25]
  assign Csr_i_io_in_csr_id = from_ISU_bits_imm; // @[EXU.scala 96:25]
  assign Csr_i_io_in_wdata = from_ISU_bits_rdata1; // @[EXU.scala 98:25]
  assign ebreak_moudle_i_is_ebreak = from_ISU_bits_ctrl_sig_is_ebreak; // @[EXU.scala 101:32]
  assign not_impl_moudle_i_not_impl = from_ISU_bits_ctrl_sig_not_impl; // @[EXU.scala 103:32]
  always @(posedge clock) begin
    if (reset) begin // @[EXU.scala 40:24]
      state <= 2'h0; // @[EXU.scala 40:24]
    end else if (2'h0 == state) begin // @[EXU.scala 41:20]
      if (_state_T) begin // @[EXU.scala 43:25]
        state <= 2'h1;
      end else begin
        state <= 2'h0;
      end
    end else if (2'h1 == state) begin // @[EXU.scala 41:20]
      if (from_ISU_bits_ctrl_sig_fu_op == 3'h4) begin // @[EXU.scala 47:69]
        state <= _state_T_2; // @[EXU.scala 48:23]
      end else begin
        state <= 2'h3; // @[EXU.scala 50:23]
      end
    end else if (2'h2 == state) begin // @[EXU.scala 41:20]
      state <= _state_T_3; // @[EXU.scala 54:19]
    end else begin
      state <= _GEN_1;
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
  state = _RAND_0[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module WBU(
  output        from_EXU_ready,
  input         from_EXU_valid,
  input  [31:0] from_EXU_bits_alu_result,
  input  [31:0] from_EXU_bits_mdu_result,
  input  [31:0] from_EXU_bits_lsu_rdata,
  input  [31:0] from_EXU_bits_csr_rdata,
  input  [31:0] from_EXU_bits_pc,
  input         from_EXU_bits_reg_wen,
  input  [4:0]  from_EXU_bits_rd,
  input  [2:0]  from_EXU_bits_fu_op,
  output        to_ISU_bits_reg_wen,
  output [31:0] to_ISU_bits_wdata,
  output [4:0]  to_ISU_bits_rd,
  output        to_IFU_valid
);
  wire  _to_ISU_bits_reg_wen_T = from_EXU_ready & from_EXU_valid; // @[Decoupled.scala 51:35]
  wire [31:0] _to_ISU_bits_wdata_T_1 = from_EXU_bits_pc + 32'h4; // @[WBU.scala 25:47]
  wire [31:0] _to_ISU_bits_wdata_T_3 = 3'h1 == from_EXU_bits_fu_op ? from_EXU_bits_alu_result : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _to_ISU_bits_wdata_T_5 = 3'h4 == from_EXU_bits_fu_op ? from_EXU_bits_lsu_rdata : _to_ISU_bits_wdata_T_3; // @[Mux.scala 81:58]
  wire [31:0] _to_ISU_bits_wdata_T_7 = 3'h3 == from_EXU_bits_fu_op ? _to_ISU_bits_wdata_T_1 : _to_ISU_bits_wdata_T_5; // @[Mux.scala 81:58]
  wire [31:0] _to_ISU_bits_wdata_T_9 = 3'h5 == from_EXU_bits_fu_op ? from_EXU_bits_csr_rdata : _to_ISU_bits_wdata_T_7; // @[Mux.scala 81:58]
  assign from_EXU_ready = 1'h1; // @[WBU.scala 14:20]
  assign to_ISU_bits_reg_wen = _to_ISU_bits_reg_wen_T & from_EXU_bits_reg_wen; // @[WBU.scala 19:31]
  assign to_ISU_bits_wdata = 3'h2 == from_EXU_bits_fu_op ? from_EXU_bits_mdu_result : _to_ISU_bits_wdata_T_9; // @[Mux.scala 81:58]
  assign to_ISU_bits_rd = from_EXU_bits_rd; // @[WBU.scala 20:25]
  assign to_IFU_valid = from_EXU_valid; // @[WBU.scala 16:20]
endmodule
module IFU_cache(
  input         clock,
  input         reset,
  output        to_IDU_valid,
  output [31:0] to_IDU_bits_inst,
  output [31:0] to_IDU_bits_pc,
  input         from_EXU_bits_bru_ctrl_br,
  input  [31:0] from_EXU_bits_bru_addr,
  input         from_EXU_bits_csr_ctrl_br,
  input  [31:0] from_EXU_bits_csr_addr,
  output        from_WBU_ready,
  input         from_WBU_valid,
  input         to_cache_ready,
  output        to_cache_valid,
  output [31:0] to_cache_bits_addr,
  output        from_cache_ready,
  input         from_cache_valid,
  input  [31:0] from_cache_bits_data
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] reg_PC; // @[IFU.scala 148:26]
  wire [31:0] _next_PC_T_1 = reg_PC + 32'h4; // @[IFU.scala 156:27]
  wire  _reg_PC_T = from_WBU_ready & from_WBU_valid; // @[Decoupled.scala 51:35]
  reg [1:0] state_ifu; // @[IFU.scala 164:28]
  wire  _state_ifu_T = to_cache_ready & to_cache_valid; // @[Decoupled.scala 51:35]
  wire [1:0] _state_ifu_T_1 = _state_ifu_T ? 2'h1 : 2'h0; // @[IFU.scala 166:26]
  wire  _state_ifu_T_2 = from_cache_ready & from_cache_valid; // @[Decoupled.scala 51:35]
  assign to_IDU_valid = 2'h2 == state_ifu; // @[Mux.scala 81:61]
  assign to_IDU_bits_inst = to_IDU_valid ? from_cache_bits_data : 32'h13; // @[IFU.scala 178:28]
  assign to_IDU_bits_pc = reg_PC; // @[IFU.scala 179:22]
  assign from_WBU_ready = 2'h2 == state_ifu; // @[Mux.scala 81:61]
  assign to_cache_valid = 2'h0 == state_ifu; // @[Mux.scala 81:61]
  assign to_cache_bits_addr = reg_PC; // @[IFU.scala 173:24]
  assign from_cache_ready = 2'h1 == state_ifu; // @[Mux.scala 81:61]
  always @(posedge clock) begin
    if (reset) begin // @[IFU.scala 148:26]
      reg_PC <= 32'h80000000; // @[IFU.scala 148:26]
    end else if (_reg_PC_T) begin // @[IFU.scala 160:18]
      if (from_EXU_bits_bru_ctrl_br) begin // @[IFU.scala 151:38]
        reg_PC <= from_EXU_bits_bru_addr; // @[IFU.scala 152:17]
      end else if (from_EXU_bits_csr_ctrl_br) begin // @[IFU.scala 153:45]
        reg_PC <= from_EXU_bits_csr_addr; // @[IFU.scala 154:17]
      end else begin
        reg_PC <= _next_PC_T_1; // @[IFU.scala 156:17]
      end
    end
    if (reset) begin // @[IFU.scala 164:28]
      state_ifu <= 2'h0; // @[IFU.scala 164:28]
    end else if (2'h2 == state_ifu) begin // @[Mux.scala 81:58]
      if (_reg_PC_T) begin // @[IFU.scala 168:28]
        state_ifu <= 2'h0;
      end else begin
        state_ifu <= 2'h2;
      end
    end else if (2'h1 == state_ifu) begin // @[Mux.scala 81:58]
      if (_state_ifu_T_2) begin // @[IFU.scala 167:28]
        state_ifu <= 2'h2;
      end else begin
        state_ifu <= 2'h1;
      end
    end else if (2'h0 == state_ifu) begin // @[Mux.scala 81:58]
      state_ifu <= _state_ifu_T_1;
    end else begin
      state_ifu <= 2'h0;
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
  _RAND_1 = {1{`RANDOM}};
  state_ifu = _RAND_1[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module I_Cache(
  input         clock,
  input         reset,
  output        from_IFU_ready,
  input         from_IFU_valid,
  input  [31:0] from_IFU_bits_addr,
  output        to_IFU_valid,
  output [31:0] to_IFU_bits_data,
  input         to_sram_ar_ready,
  output        to_sram_ar_valid,
  output [31:0] to_sram_ar_bits_addr,
  output [7:0]  to_sram_ar_bits_len,
  output        to_sram_r_ready,
  input         to_sram_r_valid,
  input  [31:0] to_sram_r_bits_data,
  input         to_sram_r_bits_last
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_33;
  reg [31:0] _RAND_36;
  reg [31:0] _RAND_39;
  reg [31:0] _RAND_42;
  reg [31:0] _RAND_45;
  reg [31:0] _RAND_48;
  reg [31:0] _RAND_51;
  reg [31:0] _RAND_54;
  reg [31:0] _RAND_57;
  reg [31:0] _RAND_60;
  reg [31:0] _RAND_63;
  reg [31:0] _RAND_66;
  reg [31:0] _RAND_69;
  reg [31:0] _RAND_72;
  reg [31:0] _RAND_75;
  reg [31:0] _RAND_78;
  reg [31:0] _RAND_81;
  reg [31:0] _RAND_84;
  reg [31:0] _RAND_87;
  reg [31:0] _RAND_90;
  reg [31:0] _RAND_93;
  reg [31:0] _RAND_96;
  reg [31:0] _RAND_99;
  reg [31:0] _RAND_102;
  reg [31:0] _RAND_105;
  reg [31:0] _RAND_108;
  reg [31:0] _RAND_111;
  reg [31:0] _RAND_114;
  reg [31:0] _RAND_117;
  reg [31:0] _RAND_120;
  reg [31:0] _RAND_123;
  reg [31:0] _RAND_126;
  reg [31:0] _RAND_129;
  reg [31:0] _RAND_132;
  reg [31:0] _RAND_135;
  reg [31:0] _RAND_138;
  reg [31:0] _RAND_141;
  reg [31:0] _RAND_144;
  reg [31:0] _RAND_147;
  reg [31:0] _RAND_150;
  reg [31:0] _RAND_153;
  reg [31:0] _RAND_156;
  reg [31:0] _RAND_159;
  reg [31:0] _RAND_162;
  reg [31:0] _RAND_165;
  reg [31:0] _RAND_168;
  reg [31:0] _RAND_171;
  reg [31:0] _RAND_174;
  reg [31:0] _RAND_177;
  reg [31:0] _RAND_180;
  reg [31:0] _RAND_183;
  reg [31:0] _RAND_186;
  reg [31:0] _RAND_189;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [31:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [31:0] _RAND_40;
  reg [31:0] _RAND_41;
  reg [31:0] _RAND_43;
  reg [31:0] _RAND_44;
  reg [31:0] _RAND_46;
  reg [31:0] _RAND_47;
  reg [31:0] _RAND_49;
  reg [31:0] _RAND_50;
  reg [31:0] _RAND_52;
  reg [31:0] _RAND_53;
  reg [31:0] _RAND_55;
  reg [31:0] _RAND_56;
  reg [31:0] _RAND_58;
  reg [31:0] _RAND_59;
  reg [31:0] _RAND_61;
  reg [31:0] _RAND_62;
  reg [31:0] _RAND_64;
  reg [31:0] _RAND_65;
  reg [31:0] _RAND_67;
  reg [31:0] _RAND_68;
  reg [31:0] _RAND_70;
  reg [31:0] _RAND_71;
  reg [31:0] _RAND_73;
  reg [31:0] _RAND_74;
  reg [31:0] _RAND_76;
  reg [31:0] _RAND_77;
  reg [31:0] _RAND_79;
  reg [31:0] _RAND_80;
  reg [31:0] _RAND_82;
  reg [31:0] _RAND_83;
  reg [31:0] _RAND_85;
  reg [31:0] _RAND_86;
  reg [31:0] _RAND_88;
  reg [31:0] _RAND_89;
  reg [31:0] _RAND_91;
  reg [31:0] _RAND_92;
  reg [31:0] _RAND_94;
  reg [31:0] _RAND_95;
  reg [31:0] _RAND_97;
  reg [31:0] _RAND_98;
  reg [31:0] _RAND_100;
  reg [31:0] _RAND_101;
  reg [31:0] _RAND_103;
  reg [31:0] _RAND_104;
  reg [31:0] _RAND_106;
  reg [31:0] _RAND_107;
  reg [31:0] _RAND_109;
  reg [31:0] _RAND_110;
  reg [31:0] _RAND_112;
  reg [31:0] _RAND_113;
  reg [31:0] _RAND_115;
  reg [31:0] _RAND_116;
  reg [31:0] _RAND_118;
  reg [31:0] _RAND_119;
  reg [31:0] _RAND_121;
  reg [31:0] _RAND_122;
  reg [31:0] _RAND_124;
  reg [31:0] _RAND_125;
  reg [31:0] _RAND_127;
  reg [31:0] _RAND_128;
  reg [31:0] _RAND_130;
  reg [31:0] _RAND_131;
  reg [31:0] _RAND_133;
  reg [31:0] _RAND_134;
  reg [31:0] _RAND_136;
  reg [31:0] _RAND_137;
  reg [31:0] _RAND_139;
  reg [31:0] _RAND_140;
  reg [31:0] _RAND_142;
  reg [31:0] _RAND_143;
  reg [31:0] _RAND_145;
  reg [31:0] _RAND_146;
  reg [31:0] _RAND_148;
  reg [31:0] _RAND_149;
  reg [31:0] _RAND_151;
  reg [31:0] _RAND_152;
  reg [31:0] _RAND_154;
  reg [31:0] _RAND_155;
  reg [31:0] _RAND_157;
  reg [31:0] _RAND_158;
  reg [31:0] _RAND_160;
  reg [31:0] _RAND_161;
  reg [31:0] _RAND_163;
  reg [31:0] _RAND_164;
  reg [31:0] _RAND_166;
  reg [31:0] _RAND_167;
  reg [31:0] _RAND_169;
  reg [31:0] _RAND_170;
  reg [31:0] _RAND_172;
  reg [31:0] _RAND_173;
  reg [31:0] _RAND_175;
  reg [31:0] _RAND_176;
  reg [31:0] _RAND_178;
  reg [31:0] _RAND_179;
  reg [31:0] _RAND_181;
  reg [31:0] _RAND_182;
  reg [31:0] _RAND_184;
  reg [31:0] _RAND_185;
  reg [31:0] _RAND_187;
  reg [31:0] _RAND_188;
  reg [31:0] _RAND_190;
  reg [31:0] _RAND_191;
  reg [31:0] _RAND_192;
  reg [31:0] _RAND_193;
  reg [31:0] _RAND_194;
  reg [31:0] _RAND_195;
  reg [31:0] _RAND_196;
  reg [31:0] _RAND_197;
  reg [31:0] _RAND_198;
  reg [31:0] _RAND_199;
  reg [31:0] _RAND_200;
  reg [31:0] _RAND_201;
  reg [31:0] _RAND_202;
  reg [31:0] _RAND_203;
  reg [31:0] _RAND_204;
  reg [31:0] _RAND_205;
  reg [31:0] _RAND_206;
  reg [31:0] _RAND_207;
  reg [31:0] _RAND_208;
  reg [31:0] _RAND_209;
  reg [31:0] _RAND_210;
  reg [31:0] _RAND_211;
  reg [31:0] _RAND_212;
  reg [31:0] _RAND_213;
  reg [31:0] _RAND_214;
  reg [31:0] _RAND_215;
  reg [31:0] _RAND_216;
  reg [31:0] _RAND_217;
  reg [31:0] _RAND_218;
  reg [31:0] _RAND_219;
  reg [31:0] _RAND_220;
  reg [31:0] _RAND_221;
  reg [31:0] _RAND_222;
  reg [31:0] _RAND_223;
  reg [31:0] _RAND_224;
  reg [31:0] _RAND_225;
  reg [31:0] _RAND_226;
  reg [31:0] _RAND_227;
  reg [31:0] _RAND_228;
  reg [31:0] _RAND_229;
  reg [31:0] _RAND_230;
  reg [31:0] _RAND_231;
  reg [31:0] _RAND_232;
  reg [31:0] _RAND_233;
  reg [31:0] _RAND_234;
  reg [31:0] _RAND_235;
  reg [31:0] _RAND_236;
  reg [31:0] _RAND_237;
  reg [31:0] _RAND_238;
  reg [31:0] _RAND_239;
  reg [31:0] _RAND_240;
  reg [31:0] _RAND_241;
  reg [31:0] _RAND_242;
  reg [31:0] _RAND_243;
  reg [31:0] _RAND_244;
  reg [31:0] _RAND_245;
  reg [31:0] _RAND_246;
  reg [31:0] _RAND_247;
  reg [31:0] _RAND_248;
  reg [31:0] _RAND_249;
  reg [31:0] _RAND_250;
  reg [31:0] _RAND_251;
  reg [31:0] _RAND_252;
  reg [31:0] _RAND_253;
  reg [31:0] _RAND_254;
  reg [31:0] _RAND_255;
  reg [31:0] _RAND_256;
  reg [31:0] _RAND_257;
  reg [31:0] _RAND_258;
  reg [31:0] _RAND_259;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] dataArray_0_0 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_0_0_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_0_0_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_0_0_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_0_0_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_0_0_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_0_0_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_0_0_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_0_0_cachedata_MPORT_en_pipe_0;
  reg  dataArray_0_0_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_0_1 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_0_1_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_0_1_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_0_1_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_0_1_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_0_1_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_0_1_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_0_1_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_0_1_cachedata_MPORT_en_pipe_0;
  reg  dataArray_0_1_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_0_2 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_0_2_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_0_2_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_0_2_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_0_2_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_0_2_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_0_2_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_0_2_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_0_2_cachedata_MPORT_en_pipe_0;
  reg  dataArray_0_2_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_0_3 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_0_3_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_0_3_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_0_3_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_0_3_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_0_3_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_0_3_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_0_3_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_0_3_cachedata_MPORT_en_pipe_0;
  reg  dataArray_0_3_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_1_0 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_1_0_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_1_0_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_1_0_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_1_0_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_1_0_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_1_0_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_1_0_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_1_0_cachedata_MPORT_en_pipe_0;
  reg  dataArray_1_0_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_1_1 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_1_1_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_1_1_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_1_1_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_1_1_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_1_1_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_1_1_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_1_1_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_1_1_cachedata_MPORT_en_pipe_0;
  reg  dataArray_1_1_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_1_2 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_1_2_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_1_2_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_1_2_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_1_2_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_1_2_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_1_2_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_1_2_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_1_2_cachedata_MPORT_en_pipe_0;
  reg  dataArray_1_2_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_1_3 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_1_3_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_1_3_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_1_3_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_1_3_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_1_3_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_1_3_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_1_3_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_1_3_cachedata_MPORT_en_pipe_0;
  reg  dataArray_1_3_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_2_0 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_2_0_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_2_0_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_2_0_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_2_0_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_2_0_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_2_0_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_2_0_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_2_0_cachedata_MPORT_en_pipe_0;
  reg  dataArray_2_0_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_2_1 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_2_1_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_2_1_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_2_1_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_2_1_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_2_1_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_2_1_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_2_1_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_2_1_cachedata_MPORT_en_pipe_0;
  reg  dataArray_2_1_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_2_2 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_2_2_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_2_2_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_2_2_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_2_2_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_2_2_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_2_2_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_2_2_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_2_2_cachedata_MPORT_en_pipe_0;
  reg  dataArray_2_2_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_2_3 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_2_3_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_2_3_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_2_3_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_2_3_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_2_3_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_2_3_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_2_3_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_2_3_cachedata_MPORT_en_pipe_0;
  reg  dataArray_2_3_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_3_0 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_3_0_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_3_0_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_3_0_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_3_0_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_3_0_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_3_0_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_3_0_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_3_0_cachedata_MPORT_en_pipe_0;
  reg  dataArray_3_0_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_3_1 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_3_1_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_3_1_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_3_1_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_3_1_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_3_1_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_3_1_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_3_1_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_3_1_cachedata_MPORT_en_pipe_0;
  reg  dataArray_3_1_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_3_2 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_3_2_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_3_2_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_3_2_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_3_2_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_3_2_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_3_2_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_3_2_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_3_2_cachedata_MPORT_en_pipe_0;
  reg  dataArray_3_2_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_3_3 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_3_3_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_3_3_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_3_3_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_3_3_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_3_3_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_3_3_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_3_3_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_3_3_cachedata_MPORT_en_pipe_0;
  reg  dataArray_3_3_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_4_0 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_4_0_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_4_0_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_4_0_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_4_0_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_4_0_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_4_0_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_4_0_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_4_0_cachedata_MPORT_en_pipe_0;
  reg  dataArray_4_0_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_4_1 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_4_1_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_4_1_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_4_1_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_4_1_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_4_1_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_4_1_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_4_1_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_4_1_cachedata_MPORT_en_pipe_0;
  reg  dataArray_4_1_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_4_2 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_4_2_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_4_2_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_4_2_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_4_2_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_4_2_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_4_2_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_4_2_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_4_2_cachedata_MPORT_en_pipe_0;
  reg  dataArray_4_2_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_4_3 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_4_3_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_4_3_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_4_3_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_4_3_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_4_3_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_4_3_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_4_3_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_4_3_cachedata_MPORT_en_pipe_0;
  reg  dataArray_4_3_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_5_0 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_5_0_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_5_0_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_5_0_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_5_0_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_5_0_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_5_0_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_5_0_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_5_0_cachedata_MPORT_en_pipe_0;
  reg  dataArray_5_0_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_5_1 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_5_1_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_5_1_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_5_1_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_5_1_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_5_1_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_5_1_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_5_1_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_5_1_cachedata_MPORT_en_pipe_0;
  reg  dataArray_5_1_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_5_2 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_5_2_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_5_2_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_5_2_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_5_2_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_5_2_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_5_2_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_5_2_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_5_2_cachedata_MPORT_en_pipe_0;
  reg  dataArray_5_2_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_5_3 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_5_3_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_5_3_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_5_3_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_5_3_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_5_3_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_5_3_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_5_3_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_5_3_cachedata_MPORT_en_pipe_0;
  reg  dataArray_5_3_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_6_0 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_6_0_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_6_0_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_6_0_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_6_0_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_6_0_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_6_0_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_6_0_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_6_0_cachedata_MPORT_en_pipe_0;
  reg  dataArray_6_0_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_6_1 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_6_1_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_6_1_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_6_1_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_6_1_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_6_1_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_6_1_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_6_1_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_6_1_cachedata_MPORT_en_pipe_0;
  reg  dataArray_6_1_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_6_2 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_6_2_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_6_2_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_6_2_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_6_2_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_6_2_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_6_2_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_6_2_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_6_2_cachedata_MPORT_en_pipe_0;
  reg  dataArray_6_2_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_6_3 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_6_3_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_6_3_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_6_3_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_6_3_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_6_3_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_6_3_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_6_3_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_6_3_cachedata_MPORT_en_pipe_0;
  reg  dataArray_6_3_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_7_0 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_7_0_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_7_0_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_7_0_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_7_0_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_7_0_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_7_0_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_7_0_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_7_0_cachedata_MPORT_en_pipe_0;
  reg  dataArray_7_0_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_7_1 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_7_1_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_7_1_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_7_1_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_7_1_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_7_1_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_7_1_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_7_1_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_7_1_cachedata_MPORT_en_pipe_0;
  reg  dataArray_7_1_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_7_2 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_7_2_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_7_2_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_7_2_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_7_2_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_7_2_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_7_2_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_7_2_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_7_2_cachedata_MPORT_en_pipe_0;
  reg  dataArray_7_2_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_7_3 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_7_3_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_7_3_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_7_3_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_7_3_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_7_3_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_7_3_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_7_3_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_7_3_cachedata_MPORT_en_pipe_0;
  reg  dataArray_7_3_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_8_0 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_8_0_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_8_0_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_8_0_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_8_0_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_8_0_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_8_0_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_8_0_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_8_0_cachedata_MPORT_en_pipe_0;
  reg  dataArray_8_0_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_8_1 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_8_1_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_8_1_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_8_1_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_8_1_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_8_1_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_8_1_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_8_1_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_8_1_cachedata_MPORT_en_pipe_0;
  reg  dataArray_8_1_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_8_2 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_8_2_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_8_2_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_8_2_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_8_2_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_8_2_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_8_2_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_8_2_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_8_2_cachedata_MPORT_en_pipe_0;
  reg  dataArray_8_2_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_8_3 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_8_3_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_8_3_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_8_3_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_8_3_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_8_3_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_8_3_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_8_3_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_8_3_cachedata_MPORT_en_pipe_0;
  reg  dataArray_8_3_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_9_0 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_9_0_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_9_0_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_9_0_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_9_0_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_9_0_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_9_0_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_9_0_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_9_0_cachedata_MPORT_en_pipe_0;
  reg  dataArray_9_0_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_9_1 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_9_1_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_9_1_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_9_1_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_9_1_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_9_1_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_9_1_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_9_1_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_9_1_cachedata_MPORT_en_pipe_0;
  reg  dataArray_9_1_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_9_2 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_9_2_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_9_2_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_9_2_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_9_2_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_9_2_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_9_2_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_9_2_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_9_2_cachedata_MPORT_en_pipe_0;
  reg  dataArray_9_2_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_9_3 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_9_3_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_9_3_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_9_3_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_9_3_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_9_3_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_9_3_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_9_3_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_9_3_cachedata_MPORT_en_pipe_0;
  reg  dataArray_9_3_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_10_0 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_10_0_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_10_0_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_10_0_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_10_0_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_10_0_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_10_0_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_10_0_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_10_0_cachedata_MPORT_en_pipe_0;
  reg  dataArray_10_0_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_10_1 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_10_1_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_10_1_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_10_1_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_10_1_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_10_1_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_10_1_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_10_1_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_10_1_cachedata_MPORT_en_pipe_0;
  reg  dataArray_10_1_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_10_2 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_10_2_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_10_2_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_10_2_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_10_2_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_10_2_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_10_2_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_10_2_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_10_2_cachedata_MPORT_en_pipe_0;
  reg  dataArray_10_2_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_10_3 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_10_3_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_10_3_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_10_3_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_10_3_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_10_3_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_10_3_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_10_3_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_10_3_cachedata_MPORT_en_pipe_0;
  reg  dataArray_10_3_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_11_0 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_11_0_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_11_0_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_11_0_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_11_0_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_11_0_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_11_0_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_11_0_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_11_0_cachedata_MPORT_en_pipe_0;
  reg  dataArray_11_0_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_11_1 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_11_1_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_11_1_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_11_1_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_11_1_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_11_1_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_11_1_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_11_1_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_11_1_cachedata_MPORT_en_pipe_0;
  reg  dataArray_11_1_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_11_2 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_11_2_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_11_2_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_11_2_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_11_2_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_11_2_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_11_2_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_11_2_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_11_2_cachedata_MPORT_en_pipe_0;
  reg  dataArray_11_2_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_11_3 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_11_3_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_11_3_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_11_3_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_11_3_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_11_3_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_11_3_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_11_3_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_11_3_cachedata_MPORT_en_pipe_0;
  reg  dataArray_11_3_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_12_0 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_12_0_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_12_0_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_12_0_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_12_0_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_12_0_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_12_0_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_12_0_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_12_0_cachedata_MPORT_en_pipe_0;
  reg  dataArray_12_0_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_12_1 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_12_1_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_12_1_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_12_1_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_12_1_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_12_1_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_12_1_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_12_1_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_12_1_cachedata_MPORT_en_pipe_0;
  reg  dataArray_12_1_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_12_2 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_12_2_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_12_2_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_12_2_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_12_2_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_12_2_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_12_2_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_12_2_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_12_2_cachedata_MPORT_en_pipe_0;
  reg  dataArray_12_2_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_12_3 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_12_3_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_12_3_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_12_3_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_12_3_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_12_3_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_12_3_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_12_3_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_12_3_cachedata_MPORT_en_pipe_0;
  reg  dataArray_12_3_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_13_0 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_13_0_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_13_0_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_13_0_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_13_0_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_13_0_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_13_0_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_13_0_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_13_0_cachedata_MPORT_en_pipe_0;
  reg  dataArray_13_0_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_13_1 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_13_1_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_13_1_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_13_1_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_13_1_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_13_1_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_13_1_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_13_1_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_13_1_cachedata_MPORT_en_pipe_0;
  reg  dataArray_13_1_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_13_2 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_13_2_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_13_2_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_13_2_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_13_2_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_13_2_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_13_2_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_13_2_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_13_2_cachedata_MPORT_en_pipe_0;
  reg  dataArray_13_2_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_13_3 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_13_3_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_13_3_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_13_3_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_13_3_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_13_3_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_13_3_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_13_3_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_13_3_cachedata_MPORT_en_pipe_0;
  reg  dataArray_13_3_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_14_0 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_14_0_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_14_0_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_14_0_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_14_0_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_14_0_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_14_0_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_14_0_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_14_0_cachedata_MPORT_en_pipe_0;
  reg  dataArray_14_0_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_14_1 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_14_1_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_14_1_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_14_1_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_14_1_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_14_1_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_14_1_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_14_1_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_14_1_cachedata_MPORT_en_pipe_0;
  reg  dataArray_14_1_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_14_2 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_14_2_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_14_2_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_14_2_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_14_2_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_14_2_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_14_2_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_14_2_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_14_2_cachedata_MPORT_en_pipe_0;
  reg  dataArray_14_2_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_14_3 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_14_3_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_14_3_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_14_3_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_14_3_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_14_3_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_14_3_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_14_3_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_14_3_cachedata_MPORT_en_pipe_0;
  reg  dataArray_14_3_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_15_0 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_15_0_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_15_0_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_15_0_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_15_0_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_15_0_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_15_0_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_15_0_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_15_0_cachedata_MPORT_en_pipe_0;
  reg  dataArray_15_0_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_15_1 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_15_1_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_15_1_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_15_1_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_15_1_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_15_1_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_15_1_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_15_1_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_15_1_cachedata_MPORT_en_pipe_0;
  reg  dataArray_15_1_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_15_2 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_15_2_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_15_2_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_15_2_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_15_2_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_15_2_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_15_2_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_15_2_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_15_2_cachedata_MPORT_en_pipe_0;
  reg  dataArray_15_2_cachedata_MPORT_addr_pipe_0;
  reg [31:0] dataArray_15_3 [0:1]; // @[icache.scala 30:33]
  wire  dataArray_15_3_cachedata_MPORT_en; // @[icache.scala 30:33]
  wire  dataArray_15_3_cachedata_MPORT_addr; // @[icache.scala 30:33]
  wire [31:0] dataArray_15_3_cachedata_MPORT_data; // @[icache.scala 30:33]
  wire [31:0] dataArray_15_3_MPORT_data; // @[icache.scala 30:33]
  wire  dataArray_15_3_MPORT_addr; // @[icache.scala 30:33]
  wire  dataArray_15_3_MPORT_mask; // @[icache.scala 30:33]
  wire  dataArray_15_3_MPORT_en; // @[icache.scala 30:33]
  reg  dataArray_15_3_cachedata_MPORT_en_pipe_0;
  reg  dataArray_15_3_cachedata_MPORT_addr_pipe_0;
  reg  replace_set; // @[icache.scala 21:30]
  wire [1:0] EntId = from_IFU_bits_addr[3:2]; // @[icache.scala 22:41]
  wire [3:0] CacheLineId = from_IFU_bits_addr[7:4]; // @[icache.scala 23:41]
  wire [23:0] tag = from_IFU_bits_addr[31:8]; // @[icache.scala 24:41]
  reg  random_num; // @[icache.scala 27:29]
  reg [23:0] tagArray_0_0; // @[icache.scala 31:29]
  reg [23:0] tagArray_0_1; // @[icache.scala 31:29]
  reg [23:0] tagArray_0_2; // @[icache.scala 31:29]
  reg [23:0] tagArray_0_3; // @[icache.scala 31:29]
  reg [23:0] tagArray_0_4; // @[icache.scala 31:29]
  reg [23:0] tagArray_0_5; // @[icache.scala 31:29]
  reg [23:0] tagArray_0_6; // @[icache.scala 31:29]
  reg [23:0] tagArray_0_7; // @[icache.scala 31:29]
  reg [23:0] tagArray_0_8; // @[icache.scala 31:29]
  reg [23:0] tagArray_0_9; // @[icache.scala 31:29]
  reg [23:0] tagArray_0_10; // @[icache.scala 31:29]
  reg [23:0] tagArray_0_11; // @[icache.scala 31:29]
  reg [23:0] tagArray_0_12; // @[icache.scala 31:29]
  reg [23:0] tagArray_0_13; // @[icache.scala 31:29]
  reg [23:0] tagArray_0_14; // @[icache.scala 31:29]
  reg [23:0] tagArray_0_15; // @[icache.scala 31:29]
  reg [23:0] tagArray_1_0; // @[icache.scala 31:29]
  reg [23:0] tagArray_1_1; // @[icache.scala 31:29]
  reg [23:0] tagArray_1_2; // @[icache.scala 31:29]
  reg [23:0] tagArray_1_3; // @[icache.scala 31:29]
  reg [23:0] tagArray_1_4; // @[icache.scala 31:29]
  reg [23:0] tagArray_1_5; // @[icache.scala 31:29]
  reg [23:0] tagArray_1_6; // @[icache.scala 31:29]
  reg [23:0] tagArray_1_7; // @[icache.scala 31:29]
  reg [23:0] tagArray_1_8; // @[icache.scala 31:29]
  reg [23:0] tagArray_1_9; // @[icache.scala 31:29]
  reg [23:0] tagArray_1_10; // @[icache.scala 31:29]
  reg [23:0] tagArray_1_11; // @[icache.scala 31:29]
  reg [23:0] tagArray_1_12; // @[icache.scala 31:29]
  reg [23:0] tagArray_1_13; // @[icache.scala 31:29]
  reg [23:0] tagArray_1_14; // @[icache.scala 31:29]
  reg [23:0] tagArray_1_15; // @[icache.scala 31:29]
  reg  validArray_0_0; // @[icache.scala 32:29]
  reg  validArray_0_1; // @[icache.scala 32:29]
  reg  validArray_0_2; // @[icache.scala 32:29]
  reg  validArray_0_3; // @[icache.scala 32:29]
  reg  validArray_0_4; // @[icache.scala 32:29]
  reg  validArray_0_5; // @[icache.scala 32:29]
  reg  validArray_0_6; // @[icache.scala 32:29]
  reg  validArray_0_7; // @[icache.scala 32:29]
  reg  validArray_0_8; // @[icache.scala 32:29]
  reg  validArray_0_9; // @[icache.scala 32:29]
  reg  validArray_0_10; // @[icache.scala 32:29]
  reg  validArray_0_11; // @[icache.scala 32:29]
  reg  validArray_0_12; // @[icache.scala 32:29]
  reg  validArray_0_13; // @[icache.scala 32:29]
  reg  validArray_0_14; // @[icache.scala 32:29]
  reg  validArray_0_15; // @[icache.scala 32:29]
  reg  validArray_1_0; // @[icache.scala 32:29]
  reg  validArray_1_1; // @[icache.scala 32:29]
  reg  validArray_1_2; // @[icache.scala 32:29]
  reg  validArray_1_3; // @[icache.scala 32:29]
  reg  validArray_1_4; // @[icache.scala 32:29]
  reg  validArray_1_5; // @[icache.scala 32:29]
  reg  validArray_1_6; // @[icache.scala 32:29]
  reg  validArray_1_7; // @[icache.scala 32:29]
  reg  validArray_1_8; // @[icache.scala 32:29]
  reg  validArray_1_9; // @[icache.scala 32:29]
  reg  validArray_1_10; // @[icache.scala 32:29]
  reg  validArray_1_11; // @[icache.scala 32:29]
  reg  validArray_1_12; // @[icache.scala 32:29]
  reg  validArray_1_13; // @[icache.scala 32:29]
  reg  validArray_1_14; // @[icache.scala 32:29]
  reg  validArray_1_15; // @[icache.scala 32:29]
  wire [23:0] _GEN_1 = 4'h1 == CacheLineId ? tagArray_0_1 : tagArray_0_0; // @[icache.scala 36:{14,14}]
  wire [23:0] _GEN_2 = 4'h2 == CacheLineId ? tagArray_0_2 : _GEN_1; // @[icache.scala 36:{14,14}]
  wire [23:0] _GEN_3 = 4'h3 == CacheLineId ? tagArray_0_3 : _GEN_2; // @[icache.scala 36:{14,14}]
  wire [23:0] _GEN_4 = 4'h4 == CacheLineId ? tagArray_0_4 : _GEN_3; // @[icache.scala 36:{14,14}]
  wire [23:0] _GEN_5 = 4'h5 == CacheLineId ? tagArray_0_5 : _GEN_4; // @[icache.scala 36:{14,14}]
  wire [23:0] _GEN_6 = 4'h6 == CacheLineId ? tagArray_0_6 : _GEN_5; // @[icache.scala 36:{14,14}]
  wire [23:0] _GEN_7 = 4'h7 == CacheLineId ? tagArray_0_7 : _GEN_6; // @[icache.scala 36:{14,14}]
  wire [23:0] _GEN_8 = 4'h8 == CacheLineId ? tagArray_0_8 : _GEN_7; // @[icache.scala 36:{14,14}]
  wire [23:0] _GEN_9 = 4'h9 == CacheLineId ? tagArray_0_9 : _GEN_8; // @[icache.scala 36:{14,14}]
  wire [23:0] _GEN_10 = 4'ha == CacheLineId ? tagArray_0_10 : _GEN_9; // @[icache.scala 36:{14,14}]
  wire [23:0] _GEN_11 = 4'hb == CacheLineId ? tagArray_0_11 : _GEN_10; // @[icache.scala 36:{14,14}]
  wire [23:0] _GEN_12 = 4'hc == CacheLineId ? tagArray_0_12 : _GEN_11; // @[icache.scala 36:{14,14}]
  wire [23:0] _GEN_13 = 4'hd == CacheLineId ? tagArray_0_13 : _GEN_12; // @[icache.scala 36:{14,14}]
  wire [23:0] _GEN_14 = 4'he == CacheLineId ? tagArray_0_14 : _GEN_13; // @[icache.scala 36:{14,14}]
  wire [23:0] _GEN_15 = 4'hf == CacheLineId ? tagArray_0_15 : _GEN_14; // @[icache.scala 36:{14,14}]
  wire  _GEN_17 = 4'h1 == CacheLineId ? validArray_0_1 : validArray_0_0; // @[icache.scala 36:{44,44}]
  wire  _GEN_18 = 4'h2 == CacheLineId ? validArray_0_2 : _GEN_17; // @[icache.scala 36:{44,44}]
  wire  _GEN_19 = 4'h3 == CacheLineId ? validArray_0_3 : _GEN_18; // @[icache.scala 36:{44,44}]
  wire  _GEN_20 = 4'h4 == CacheLineId ? validArray_0_4 : _GEN_19; // @[icache.scala 36:{44,44}]
  wire  _GEN_21 = 4'h5 == CacheLineId ? validArray_0_5 : _GEN_20; // @[icache.scala 36:{44,44}]
  wire  _GEN_22 = 4'h6 == CacheLineId ? validArray_0_6 : _GEN_21; // @[icache.scala 36:{44,44}]
  wire  _GEN_23 = 4'h7 == CacheLineId ? validArray_0_7 : _GEN_22; // @[icache.scala 36:{44,44}]
  wire  _GEN_24 = 4'h8 == CacheLineId ? validArray_0_8 : _GEN_23; // @[icache.scala 36:{44,44}]
  wire  _GEN_25 = 4'h9 == CacheLineId ? validArray_0_9 : _GEN_24; // @[icache.scala 36:{44,44}]
  wire  _GEN_26 = 4'ha == CacheLineId ? validArray_0_10 : _GEN_25; // @[icache.scala 36:{44,44}]
  wire  _GEN_27 = 4'hb == CacheLineId ? validArray_0_11 : _GEN_26; // @[icache.scala 36:{44,44}]
  wire  _GEN_28 = 4'hc == CacheLineId ? validArray_0_12 : _GEN_27; // @[icache.scala 36:{44,44}]
  wire  _GEN_29 = 4'hd == CacheLineId ? validArray_0_13 : _GEN_28; // @[icache.scala 36:{44,44}]
  wire  _GEN_30 = 4'he == CacheLineId ? validArray_0_14 : _GEN_29; // @[icache.scala 36:{44,44}]
  wire  _GEN_31 = 4'hf == CacheLineId ? validArray_0_15 : _GEN_30; // @[icache.scala 36:{44,44}]
  wire  hitArray_0 = tag == _GEN_15 & _GEN_31; // @[icache.scala 36:44]
  wire [23:0] _GEN_33 = 4'h1 == CacheLineId ? tagArray_1_1 : tagArray_1_0; // @[icache.scala 36:{14,14}]
  wire [23:0] _GEN_34 = 4'h2 == CacheLineId ? tagArray_1_2 : _GEN_33; // @[icache.scala 36:{14,14}]
  wire [23:0] _GEN_35 = 4'h3 == CacheLineId ? tagArray_1_3 : _GEN_34; // @[icache.scala 36:{14,14}]
  wire [23:0] _GEN_36 = 4'h4 == CacheLineId ? tagArray_1_4 : _GEN_35; // @[icache.scala 36:{14,14}]
  wire [23:0] _GEN_37 = 4'h5 == CacheLineId ? tagArray_1_5 : _GEN_36; // @[icache.scala 36:{14,14}]
  wire [23:0] _GEN_38 = 4'h6 == CacheLineId ? tagArray_1_6 : _GEN_37; // @[icache.scala 36:{14,14}]
  wire [23:0] _GEN_39 = 4'h7 == CacheLineId ? tagArray_1_7 : _GEN_38; // @[icache.scala 36:{14,14}]
  wire [23:0] _GEN_40 = 4'h8 == CacheLineId ? tagArray_1_8 : _GEN_39; // @[icache.scala 36:{14,14}]
  wire [23:0] _GEN_41 = 4'h9 == CacheLineId ? tagArray_1_9 : _GEN_40; // @[icache.scala 36:{14,14}]
  wire [23:0] _GEN_42 = 4'ha == CacheLineId ? tagArray_1_10 : _GEN_41; // @[icache.scala 36:{14,14}]
  wire [23:0] _GEN_43 = 4'hb == CacheLineId ? tagArray_1_11 : _GEN_42; // @[icache.scala 36:{14,14}]
  wire [23:0] _GEN_44 = 4'hc == CacheLineId ? tagArray_1_12 : _GEN_43; // @[icache.scala 36:{14,14}]
  wire [23:0] _GEN_45 = 4'hd == CacheLineId ? tagArray_1_13 : _GEN_44; // @[icache.scala 36:{14,14}]
  wire [23:0] _GEN_46 = 4'he == CacheLineId ? tagArray_1_14 : _GEN_45; // @[icache.scala 36:{14,14}]
  wire [23:0] _GEN_47 = 4'hf == CacheLineId ? tagArray_1_15 : _GEN_46; // @[icache.scala 36:{14,14}]
  wire  _GEN_49 = 4'h1 == CacheLineId ? validArray_1_1 : validArray_1_0; // @[icache.scala 36:{44,44}]
  wire  _GEN_50 = 4'h2 == CacheLineId ? validArray_1_2 : _GEN_49; // @[icache.scala 36:{44,44}]
  wire  _GEN_51 = 4'h3 == CacheLineId ? validArray_1_3 : _GEN_50; // @[icache.scala 36:{44,44}]
  wire  _GEN_52 = 4'h4 == CacheLineId ? validArray_1_4 : _GEN_51; // @[icache.scala 36:{44,44}]
  wire  _GEN_53 = 4'h5 == CacheLineId ? validArray_1_5 : _GEN_52; // @[icache.scala 36:{44,44}]
  wire  _GEN_54 = 4'h6 == CacheLineId ? validArray_1_6 : _GEN_53; // @[icache.scala 36:{44,44}]
  wire  _GEN_55 = 4'h7 == CacheLineId ? validArray_1_7 : _GEN_54; // @[icache.scala 36:{44,44}]
  wire  _GEN_56 = 4'h8 == CacheLineId ? validArray_1_8 : _GEN_55; // @[icache.scala 36:{44,44}]
  wire  _GEN_57 = 4'h9 == CacheLineId ? validArray_1_9 : _GEN_56; // @[icache.scala 36:{44,44}]
  wire  _GEN_58 = 4'ha == CacheLineId ? validArray_1_10 : _GEN_57; // @[icache.scala 36:{44,44}]
  wire  _GEN_59 = 4'hb == CacheLineId ? validArray_1_11 : _GEN_58; // @[icache.scala 36:{44,44}]
  wire  _GEN_60 = 4'hc == CacheLineId ? validArray_1_12 : _GEN_59; // @[icache.scala 36:{44,44}]
  wire  _GEN_61 = 4'hd == CacheLineId ? validArray_1_13 : _GEN_60; // @[icache.scala 36:{44,44}]
  wire  _GEN_62 = 4'he == CacheLineId ? validArray_1_14 : _GEN_61; // @[icache.scala 36:{44,44}]
  wire  _GEN_63 = 4'hf == CacheLineId ? validArray_1_15 : _GEN_62; // @[icache.scala 36:{44,44}]
  wire  hitArray_1 = tag == _GEN_47 & _GEN_63; // @[icache.scala 36:44]
  wire  hit = hitArray_0 | hitArray_1; // @[icache.scala 38:33]
  reg [1:0] off; // @[icache.scala 45:24]
  reg [2:0] state_cache; // @[icache.scala 48:30]
  wire  _T_1 = from_IFU_ready & from_IFU_valid; // @[Decoupled.scala 51:35]
  wire  _T_3 = 3'h2 == state_cache; // @[icache.scala 49:26]
  wire  _state_cache_T_1 = to_sram_ar_ready & to_sram_ar_valid; // @[Decoupled.scala 51:35]
  wire [2:0] _state_cache_T_2 = _state_cache_T_1 ? 3'h3 : 3'h2; // @[icache.scala 62:31]
  wire [2:0] _state_cache_T_3 = to_sram_r_bits_last ? 3'h4 : 3'h3; // @[icache.scala 68:31]
  wire  _off_T = to_sram_r_ready & to_sram_r_valid; // @[Decoupled.scala 51:35]
  wire [1:0] _off_T_2 = off + 2'h1; // @[icache.scala 69:51]
  wire [1:0] _off_T_3 = _off_T ? _off_T_2 : off; // @[icache.scala 69:31]
  wire [2:0] _GEN_65 = 3'h4 == state_cache ? 3'h1 : state_cache; // @[icache.scala 49:26 74:25 48:30]
  wire [2:0] _GEN_66 = 3'h3 == state_cache ? _state_cache_T_3 : _GEN_65; // @[icache.scala 49:26 68:25]
  wire [1:0] _GEN_67 = 3'h3 == state_cache ? _off_T_3 : off; // @[icache.scala 45:24 49:26 69:25]
  wire  _T_6 = state_cache == 3'h3; // @[icache.scala 80:24]
  wire  _GEN_592 = 4'h0 == CacheLineId; // @[icache.scala 81:{18,50,50}]
  wire  _GEN_593 = 2'h0 == off; // @[icache.scala 81:{18,50,50}]
  wire  _GEN_595 = 2'h1 == off; // @[icache.scala 81:{18,50,50}]
  wire  _GEN_597 = 2'h2 == off; // @[icache.scala 81:{18,50,50}]
  wire  _GEN_599 = 2'h3 == off; // @[icache.scala 81:{18,50,50}]
  wire  _GEN_600 = 4'h1 == CacheLineId; // @[icache.scala 81:{18,50,50}]
  wire  _GEN_608 = 4'h2 == CacheLineId; // @[icache.scala 81:{18,50,50}]
  wire  _GEN_616 = 4'h3 == CacheLineId; // @[icache.scala 81:{18,50,50}]
  wire  _GEN_624 = 4'h4 == CacheLineId; // @[icache.scala 81:{18,50,50}]
  wire  _GEN_632 = 4'h5 == CacheLineId; // @[icache.scala 81:{18,50,50}]
  wire  _GEN_640 = 4'h6 == CacheLineId; // @[icache.scala 81:{18,50,50}]
  wire  _GEN_648 = 4'h7 == CacheLineId; // @[icache.scala 81:{18,50,50}]
  wire  _GEN_656 = 4'h8 == CacheLineId; // @[icache.scala 81:{18,50,50}]
  wire  _GEN_664 = 4'h9 == CacheLineId; // @[icache.scala 81:{18,50,50}]
  wire  _GEN_672 = 4'ha == CacheLineId; // @[icache.scala 81:{18,50,50}]
  wire  _GEN_680 = 4'hb == CacheLineId; // @[icache.scala 81:{18,50,50}]
  wire  _GEN_688 = 4'hc == CacheLineId; // @[icache.scala 81:{18,50,50}]
  wire  _GEN_696 = 4'hd == CacheLineId; // @[icache.scala 81:{18,50,50}]
  wire  _GEN_704 = 4'he == CacheLineId; // @[icache.scala 81:{18,50,50}]
  wire  _GEN_712 = 4'hf == CacheLineId; // @[icache.scala 81:{18,50,50}]
  wire  _GEN_720 = ~replace_set; // @[icache.scala 32:29 83:{50,50}]
  wire  _GEN_205 = ~replace_set & _GEN_592 | validArray_0_0; // @[icache.scala 32:29 83:{50,50}]
  wire  _GEN_206 = ~replace_set & _GEN_600 | validArray_0_1; // @[icache.scala 32:29 83:{50,50}]
  wire  _GEN_207 = ~replace_set & _GEN_608 | validArray_0_2; // @[icache.scala 32:29 83:{50,50}]
  wire  _GEN_208 = ~replace_set & _GEN_616 | validArray_0_3; // @[icache.scala 32:29 83:{50,50}]
  wire  _GEN_209 = ~replace_set & _GEN_624 | validArray_0_4; // @[icache.scala 32:29 83:{50,50}]
  wire  _GEN_210 = ~replace_set & _GEN_632 | validArray_0_5; // @[icache.scala 32:29 83:{50,50}]
  wire  _GEN_211 = ~replace_set & _GEN_640 | validArray_0_6; // @[icache.scala 32:29 83:{50,50}]
  wire  _GEN_212 = ~replace_set & _GEN_648 | validArray_0_7; // @[icache.scala 32:29 83:{50,50}]
  wire  _GEN_213 = ~replace_set & _GEN_656 | validArray_0_8; // @[icache.scala 32:29 83:{50,50}]
  wire  _GEN_214 = ~replace_set & _GEN_664 | validArray_0_9; // @[icache.scala 32:29 83:{50,50}]
  wire  _GEN_215 = ~replace_set & _GEN_672 | validArray_0_10; // @[icache.scala 32:29 83:{50,50}]
  wire  _GEN_216 = ~replace_set & _GEN_680 | validArray_0_11; // @[icache.scala 32:29 83:{50,50}]
  wire  _GEN_217 = ~replace_set & _GEN_688 | validArray_0_12; // @[icache.scala 32:29 83:{50,50}]
  wire  _GEN_218 = ~replace_set & _GEN_696 | validArray_0_13; // @[icache.scala 32:29 83:{50,50}]
  wire  _GEN_219 = ~replace_set & _GEN_704 | validArray_0_14; // @[icache.scala 32:29 83:{50,50}]
  wire  _GEN_220 = ~replace_set & _GEN_712 | validArray_0_15; // @[icache.scala 32:29 83:{50,50}]
  wire  _GEN_221 = replace_set & _GEN_592 | validArray_1_0; // @[icache.scala 32:29 83:{50,50}]
  wire  _GEN_222 = replace_set & _GEN_600 | validArray_1_1; // @[icache.scala 32:29 83:{50,50}]
  wire  _GEN_223 = replace_set & _GEN_608 | validArray_1_2; // @[icache.scala 32:29 83:{50,50}]
  wire  _GEN_224 = replace_set & _GEN_616 | validArray_1_3; // @[icache.scala 32:29 83:{50,50}]
  wire  _GEN_225 = replace_set & _GEN_624 | validArray_1_4; // @[icache.scala 32:29 83:{50,50}]
  wire  _GEN_226 = replace_set & _GEN_632 | validArray_1_5; // @[icache.scala 32:29 83:{50,50}]
  wire  _GEN_227 = replace_set & _GEN_640 | validArray_1_6; // @[icache.scala 32:29 83:{50,50}]
  wire  _GEN_228 = replace_set & _GEN_648 | validArray_1_7; // @[icache.scala 32:29 83:{50,50}]
  wire  _GEN_229 = replace_set & _GEN_656 | validArray_1_8; // @[icache.scala 32:29 83:{50,50}]
  wire  _GEN_230 = replace_set & _GEN_664 | validArray_1_9; // @[icache.scala 32:29 83:{50,50}]
  wire  _GEN_231 = replace_set & _GEN_672 | validArray_1_10; // @[icache.scala 32:29 83:{50,50}]
  wire  _GEN_232 = replace_set & _GEN_680 | validArray_1_11; // @[icache.scala 32:29 83:{50,50}]
  wire  _GEN_233 = replace_set & _GEN_688 | validArray_1_12; // @[icache.scala 32:29 83:{50,50}]
  wire  _GEN_234 = replace_set & _GEN_696 | validArray_1_13; // @[icache.scala 32:29 83:{50,50}]
  wire  _GEN_235 = replace_set & _GEN_704 | validArray_1_14; // @[icache.scala 32:29 83:{50,50}]
  wire  _GEN_236 = replace_set & _GEN_712 | validArray_1_15; // @[icache.scala 32:29 83:{50,50}]
  wire [31:0] _to_sram_ar_bits_addr_T = {{4'd0}, from_IFU_bits_addr[31:4]}; // @[icache.scala 91:91]
  wire [35:0] _GEN_849 = {_to_sram_ar_bits_addr_T, 4'h0}; // @[icache.scala 91:104]
  wire [38:0] _to_sram_ar_bits_addr_T_1 = {{3'd0}, _GEN_849}; // @[icache.scala 91:104]
  wire [38:0] _to_sram_ar_bits_addr_T_3 = _T_3 ? _to_sram_ar_bits_addr_T_1 : 39'h0; // @[Mux.scala 81:58]
  wire [1:0] _to_sram_ar_bits_len_T_1 = _T_3 ? 2'h3 : 2'h0; // @[Mux.scala 81:58]
  wire [31:0] _GEN_528 = dataArray_0_0_cachedata_MPORT_data; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_529 = _GEN_592 & 2'h1 == EntId ? dataArray_0_1_cachedata_MPORT_data : _GEN_528; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_530 = _GEN_592 & 2'h2 == EntId ? dataArray_0_2_cachedata_MPORT_data : _GEN_529; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_531 = _GEN_592 & 2'h3 == EntId ? dataArray_0_3_cachedata_MPORT_data : _GEN_530; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_532 = _GEN_600 & 2'h0 == EntId ? dataArray_1_0_cachedata_MPORT_data : _GEN_531; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_533 = _GEN_600 & 2'h1 == EntId ? dataArray_1_1_cachedata_MPORT_data : _GEN_532; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_534 = _GEN_600 & 2'h2 == EntId ? dataArray_1_2_cachedata_MPORT_data : _GEN_533; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_535 = _GEN_600 & 2'h3 == EntId ? dataArray_1_3_cachedata_MPORT_data : _GEN_534; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_536 = _GEN_608 & 2'h0 == EntId ? dataArray_2_0_cachedata_MPORT_data : _GEN_535; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_537 = _GEN_608 & 2'h1 == EntId ? dataArray_2_1_cachedata_MPORT_data : _GEN_536; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_538 = _GEN_608 & 2'h2 == EntId ? dataArray_2_2_cachedata_MPORT_data : _GEN_537; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_539 = _GEN_608 & 2'h3 == EntId ? dataArray_2_3_cachedata_MPORT_data : _GEN_538; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_540 = _GEN_616 & 2'h0 == EntId ? dataArray_3_0_cachedata_MPORT_data : _GEN_539; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_541 = _GEN_616 & 2'h1 == EntId ? dataArray_3_1_cachedata_MPORT_data : _GEN_540; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_542 = _GEN_616 & 2'h2 == EntId ? dataArray_3_2_cachedata_MPORT_data : _GEN_541; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_543 = _GEN_616 & 2'h3 == EntId ? dataArray_3_3_cachedata_MPORT_data : _GEN_542; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_544 = _GEN_624 & 2'h0 == EntId ? dataArray_4_0_cachedata_MPORT_data : _GEN_543; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_545 = _GEN_624 & 2'h1 == EntId ? dataArray_4_1_cachedata_MPORT_data : _GEN_544; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_546 = _GEN_624 & 2'h2 == EntId ? dataArray_4_2_cachedata_MPORT_data : _GEN_545; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_547 = _GEN_624 & 2'h3 == EntId ? dataArray_4_3_cachedata_MPORT_data : _GEN_546; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_548 = _GEN_632 & 2'h0 == EntId ? dataArray_5_0_cachedata_MPORT_data : _GEN_547; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_549 = _GEN_632 & 2'h1 == EntId ? dataArray_5_1_cachedata_MPORT_data : _GEN_548; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_550 = _GEN_632 & 2'h2 == EntId ? dataArray_5_2_cachedata_MPORT_data : _GEN_549; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_551 = _GEN_632 & 2'h3 == EntId ? dataArray_5_3_cachedata_MPORT_data : _GEN_550; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_552 = _GEN_640 & 2'h0 == EntId ? dataArray_6_0_cachedata_MPORT_data : _GEN_551; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_553 = _GEN_640 & 2'h1 == EntId ? dataArray_6_1_cachedata_MPORT_data : _GEN_552; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_554 = _GEN_640 & 2'h2 == EntId ? dataArray_6_2_cachedata_MPORT_data : _GEN_553; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_555 = _GEN_640 & 2'h3 == EntId ? dataArray_6_3_cachedata_MPORT_data : _GEN_554; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_556 = _GEN_648 & 2'h0 == EntId ? dataArray_7_0_cachedata_MPORT_data : _GEN_555; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_557 = _GEN_648 & 2'h1 == EntId ? dataArray_7_1_cachedata_MPORT_data : _GEN_556; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_558 = _GEN_648 & 2'h2 == EntId ? dataArray_7_2_cachedata_MPORT_data : _GEN_557; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_559 = _GEN_648 & 2'h3 == EntId ? dataArray_7_3_cachedata_MPORT_data : _GEN_558; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_560 = _GEN_656 & 2'h0 == EntId ? dataArray_8_0_cachedata_MPORT_data : _GEN_559; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_561 = _GEN_656 & 2'h1 == EntId ? dataArray_8_1_cachedata_MPORT_data : _GEN_560; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_562 = _GEN_656 & 2'h2 == EntId ? dataArray_8_2_cachedata_MPORT_data : _GEN_561; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_563 = _GEN_656 & 2'h3 == EntId ? dataArray_8_3_cachedata_MPORT_data : _GEN_562; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_564 = _GEN_664 & 2'h0 == EntId ? dataArray_9_0_cachedata_MPORT_data : _GEN_563; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_565 = _GEN_664 & 2'h1 == EntId ? dataArray_9_1_cachedata_MPORT_data : _GEN_564; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_566 = _GEN_664 & 2'h2 == EntId ? dataArray_9_2_cachedata_MPORT_data : _GEN_565; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_567 = _GEN_664 & 2'h3 == EntId ? dataArray_9_3_cachedata_MPORT_data : _GEN_566; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_568 = _GEN_672 & 2'h0 == EntId ? dataArray_10_0_cachedata_MPORT_data : _GEN_567; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_569 = _GEN_672 & 2'h1 == EntId ? dataArray_10_1_cachedata_MPORT_data : _GEN_568; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_570 = _GEN_672 & 2'h2 == EntId ? dataArray_10_2_cachedata_MPORT_data : _GEN_569; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_571 = _GEN_672 & 2'h3 == EntId ? dataArray_10_3_cachedata_MPORT_data : _GEN_570; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_572 = _GEN_680 & 2'h0 == EntId ? dataArray_11_0_cachedata_MPORT_data : _GEN_571; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_573 = _GEN_680 & 2'h1 == EntId ? dataArray_11_1_cachedata_MPORT_data : _GEN_572; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_574 = _GEN_680 & 2'h2 == EntId ? dataArray_11_2_cachedata_MPORT_data : _GEN_573; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_575 = _GEN_680 & 2'h3 == EntId ? dataArray_11_3_cachedata_MPORT_data : _GEN_574; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_576 = _GEN_688 & 2'h0 == EntId ? dataArray_12_0_cachedata_MPORT_data : _GEN_575; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_577 = _GEN_688 & 2'h1 == EntId ? dataArray_12_1_cachedata_MPORT_data : _GEN_576; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_578 = _GEN_688 & 2'h2 == EntId ? dataArray_12_2_cachedata_MPORT_data : _GEN_577; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_579 = _GEN_688 & 2'h3 == EntId ? dataArray_12_3_cachedata_MPORT_data : _GEN_578; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_580 = _GEN_696 & 2'h0 == EntId ? dataArray_13_0_cachedata_MPORT_data : _GEN_579; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_581 = _GEN_696 & 2'h1 == EntId ? dataArray_13_1_cachedata_MPORT_data : _GEN_580; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_582 = _GEN_696 & 2'h2 == EntId ? dataArray_13_2_cachedata_MPORT_data : _GEN_581; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_583 = _GEN_696 & 2'h3 == EntId ? dataArray_13_3_cachedata_MPORT_data : _GEN_582; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_584 = _GEN_704 & 2'h0 == EntId ? dataArray_14_0_cachedata_MPORT_data : _GEN_583; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_585 = _GEN_704 & 2'h1 == EntId ? dataArray_14_1_cachedata_MPORT_data : _GEN_584; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_586 = _GEN_704 & 2'h2 == EntId ? dataArray_14_2_cachedata_MPORT_data : _GEN_585; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_587 = _GEN_704 & 2'h3 == EntId ? dataArray_14_3_cachedata_MPORT_data : _GEN_586; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_588 = _GEN_712 & 2'h0 == EntId ? dataArray_15_0_cachedata_MPORT_data : _GEN_587; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_589 = _GEN_712 & 2'h1 == EntId ? dataArray_15_1_cachedata_MPORT_data : _GEN_588; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_590 = _GEN_712 & 2'h2 == EntId ? dataArray_15_2_cachedata_MPORT_data : _GEN_589; // @[icache.scala 108:{28,28}]
  wire [31:0] _GEN_591 = _GEN_712 & 2'h3 == EntId ? dataArray_15_3_cachedata_MPORT_data : _GEN_590; // @[icache.scala 108:{28,28}]
  assign dataArray_0_0_cachedata_MPORT_en = dataArray_0_0_cachedata_MPORT_en_pipe_0;
  assign dataArray_0_0_cachedata_MPORT_addr = dataArray_0_0_cachedata_MPORT_addr_pipe_0;
  assign dataArray_0_0_cachedata_MPORT_data = dataArray_0_0[dataArray_0_0_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_0_0_MPORT_data = to_sram_r_bits_data;
  assign dataArray_0_0_MPORT_addr = replace_set;
  assign dataArray_0_0_MPORT_mask = _GEN_592 & _GEN_593;
  assign dataArray_0_0_MPORT_en = _T_6 & _off_T;
  assign dataArray_0_1_cachedata_MPORT_en = dataArray_0_1_cachedata_MPORT_en_pipe_0;
  assign dataArray_0_1_cachedata_MPORT_addr = dataArray_0_1_cachedata_MPORT_addr_pipe_0;
  assign dataArray_0_1_cachedata_MPORT_data = dataArray_0_1[dataArray_0_1_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_0_1_MPORT_data = to_sram_r_bits_data;
  assign dataArray_0_1_MPORT_addr = replace_set;
  assign dataArray_0_1_MPORT_mask = _GEN_592 & _GEN_595;
  assign dataArray_0_1_MPORT_en = _T_6 & _off_T;
  assign dataArray_0_2_cachedata_MPORT_en = dataArray_0_2_cachedata_MPORT_en_pipe_0;
  assign dataArray_0_2_cachedata_MPORT_addr = dataArray_0_2_cachedata_MPORT_addr_pipe_0;
  assign dataArray_0_2_cachedata_MPORT_data = dataArray_0_2[dataArray_0_2_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_0_2_MPORT_data = to_sram_r_bits_data;
  assign dataArray_0_2_MPORT_addr = replace_set;
  assign dataArray_0_2_MPORT_mask = _GEN_592 & _GEN_597;
  assign dataArray_0_2_MPORT_en = _T_6 & _off_T;
  assign dataArray_0_3_cachedata_MPORT_en = dataArray_0_3_cachedata_MPORT_en_pipe_0;
  assign dataArray_0_3_cachedata_MPORT_addr = dataArray_0_3_cachedata_MPORT_addr_pipe_0;
  assign dataArray_0_3_cachedata_MPORT_data = dataArray_0_3[dataArray_0_3_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_0_3_MPORT_data = to_sram_r_bits_data;
  assign dataArray_0_3_MPORT_addr = replace_set;
  assign dataArray_0_3_MPORT_mask = _GEN_592 & _GEN_599;
  assign dataArray_0_3_MPORT_en = _T_6 & _off_T;
  assign dataArray_1_0_cachedata_MPORT_en = dataArray_1_0_cachedata_MPORT_en_pipe_0;
  assign dataArray_1_0_cachedata_MPORT_addr = dataArray_1_0_cachedata_MPORT_addr_pipe_0;
  assign dataArray_1_0_cachedata_MPORT_data = dataArray_1_0[dataArray_1_0_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_1_0_MPORT_data = to_sram_r_bits_data;
  assign dataArray_1_0_MPORT_addr = replace_set;
  assign dataArray_1_0_MPORT_mask = _GEN_600 & _GEN_593;
  assign dataArray_1_0_MPORT_en = _T_6 & _off_T;
  assign dataArray_1_1_cachedata_MPORT_en = dataArray_1_1_cachedata_MPORT_en_pipe_0;
  assign dataArray_1_1_cachedata_MPORT_addr = dataArray_1_1_cachedata_MPORT_addr_pipe_0;
  assign dataArray_1_1_cachedata_MPORT_data = dataArray_1_1[dataArray_1_1_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_1_1_MPORT_data = to_sram_r_bits_data;
  assign dataArray_1_1_MPORT_addr = replace_set;
  assign dataArray_1_1_MPORT_mask = _GEN_600 & _GEN_595;
  assign dataArray_1_1_MPORT_en = _T_6 & _off_T;
  assign dataArray_1_2_cachedata_MPORT_en = dataArray_1_2_cachedata_MPORT_en_pipe_0;
  assign dataArray_1_2_cachedata_MPORT_addr = dataArray_1_2_cachedata_MPORT_addr_pipe_0;
  assign dataArray_1_2_cachedata_MPORT_data = dataArray_1_2[dataArray_1_2_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_1_2_MPORT_data = to_sram_r_bits_data;
  assign dataArray_1_2_MPORT_addr = replace_set;
  assign dataArray_1_2_MPORT_mask = _GEN_600 & _GEN_597;
  assign dataArray_1_2_MPORT_en = _T_6 & _off_T;
  assign dataArray_1_3_cachedata_MPORT_en = dataArray_1_3_cachedata_MPORT_en_pipe_0;
  assign dataArray_1_3_cachedata_MPORT_addr = dataArray_1_3_cachedata_MPORT_addr_pipe_0;
  assign dataArray_1_3_cachedata_MPORT_data = dataArray_1_3[dataArray_1_3_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_1_3_MPORT_data = to_sram_r_bits_data;
  assign dataArray_1_3_MPORT_addr = replace_set;
  assign dataArray_1_3_MPORT_mask = _GEN_600 & _GEN_599;
  assign dataArray_1_3_MPORT_en = _T_6 & _off_T;
  assign dataArray_2_0_cachedata_MPORT_en = dataArray_2_0_cachedata_MPORT_en_pipe_0;
  assign dataArray_2_0_cachedata_MPORT_addr = dataArray_2_0_cachedata_MPORT_addr_pipe_0;
  assign dataArray_2_0_cachedata_MPORT_data = dataArray_2_0[dataArray_2_0_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_2_0_MPORT_data = to_sram_r_bits_data;
  assign dataArray_2_0_MPORT_addr = replace_set;
  assign dataArray_2_0_MPORT_mask = _GEN_608 & _GEN_593;
  assign dataArray_2_0_MPORT_en = _T_6 & _off_T;
  assign dataArray_2_1_cachedata_MPORT_en = dataArray_2_1_cachedata_MPORT_en_pipe_0;
  assign dataArray_2_1_cachedata_MPORT_addr = dataArray_2_1_cachedata_MPORT_addr_pipe_0;
  assign dataArray_2_1_cachedata_MPORT_data = dataArray_2_1[dataArray_2_1_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_2_1_MPORT_data = to_sram_r_bits_data;
  assign dataArray_2_1_MPORT_addr = replace_set;
  assign dataArray_2_1_MPORT_mask = _GEN_608 & _GEN_595;
  assign dataArray_2_1_MPORT_en = _T_6 & _off_T;
  assign dataArray_2_2_cachedata_MPORT_en = dataArray_2_2_cachedata_MPORT_en_pipe_0;
  assign dataArray_2_2_cachedata_MPORT_addr = dataArray_2_2_cachedata_MPORT_addr_pipe_0;
  assign dataArray_2_2_cachedata_MPORT_data = dataArray_2_2[dataArray_2_2_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_2_2_MPORT_data = to_sram_r_bits_data;
  assign dataArray_2_2_MPORT_addr = replace_set;
  assign dataArray_2_2_MPORT_mask = _GEN_608 & _GEN_597;
  assign dataArray_2_2_MPORT_en = _T_6 & _off_T;
  assign dataArray_2_3_cachedata_MPORT_en = dataArray_2_3_cachedata_MPORT_en_pipe_0;
  assign dataArray_2_3_cachedata_MPORT_addr = dataArray_2_3_cachedata_MPORT_addr_pipe_0;
  assign dataArray_2_3_cachedata_MPORT_data = dataArray_2_3[dataArray_2_3_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_2_3_MPORT_data = to_sram_r_bits_data;
  assign dataArray_2_3_MPORT_addr = replace_set;
  assign dataArray_2_3_MPORT_mask = _GEN_608 & _GEN_599;
  assign dataArray_2_3_MPORT_en = _T_6 & _off_T;
  assign dataArray_3_0_cachedata_MPORT_en = dataArray_3_0_cachedata_MPORT_en_pipe_0;
  assign dataArray_3_0_cachedata_MPORT_addr = dataArray_3_0_cachedata_MPORT_addr_pipe_0;
  assign dataArray_3_0_cachedata_MPORT_data = dataArray_3_0[dataArray_3_0_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_3_0_MPORT_data = to_sram_r_bits_data;
  assign dataArray_3_0_MPORT_addr = replace_set;
  assign dataArray_3_0_MPORT_mask = _GEN_616 & _GEN_593;
  assign dataArray_3_0_MPORT_en = _T_6 & _off_T;
  assign dataArray_3_1_cachedata_MPORT_en = dataArray_3_1_cachedata_MPORT_en_pipe_0;
  assign dataArray_3_1_cachedata_MPORT_addr = dataArray_3_1_cachedata_MPORT_addr_pipe_0;
  assign dataArray_3_1_cachedata_MPORT_data = dataArray_3_1[dataArray_3_1_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_3_1_MPORT_data = to_sram_r_bits_data;
  assign dataArray_3_1_MPORT_addr = replace_set;
  assign dataArray_3_1_MPORT_mask = _GEN_616 & _GEN_595;
  assign dataArray_3_1_MPORT_en = _T_6 & _off_T;
  assign dataArray_3_2_cachedata_MPORT_en = dataArray_3_2_cachedata_MPORT_en_pipe_0;
  assign dataArray_3_2_cachedata_MPORT_addr = dataArray_3_2_cachedata_MPORT_addr_pipe_0;
  assign dataArray_3_2_cachedata_MPORT_data = dataArray_3_2[dataArray_3_2_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_3_2_MPORT_data = to_sram_r_bits_data;
  assign dataArray_3_2_MPORT_addr = replace_set;
  assign dataArray_3_2_MPORT_mask = _GEN_616 & _GEN_597;
  assign dataArray_3_2_MPORT_en = _T_6 & _off_T;
  assign dataArray_3_3_cachedata_MPORT_en = dataArray_3_3_cachedata_MPORT_en_pipe_0;
  assign dataArray_3_3_cachedata_MPORT_addr = dataArray_3_3_cachedata_MPORT_addr_pipe_0;
  assign dataArray_3_3_cachedata_MPORT_data = dataArray_3_3[dataArray_3_3_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_3_3_MPORT_data = to_sram_r_bits_data;
  assign dataArray_3_3_MPORT_addr = replace_set;
  assign dataArray_3_3_MPORT_mask = _GEN_616 & _GEN_599;
  assign dataArray_3_3_MPORT_en = _T_6 & _off_T;
  assign dataArray_4_0_cachedata_MPORT_en = dataArray_4_0_cachedata_MPORT_en_pipe_0;
  assign dataArray_4_0_cachedata_MPORT_addr = dataArray_4_0_cachedata_MPORT_addr_pipe_0;
  assign dataArray_4_0_cachedata_MPORT_data = dataArray_4_0[dataArray_4_0_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_4_0_MPORT_data = to_sram_r_bits_data;
  assign dataArray_4_0_MPORT_addr = replace_set;
  assign dataArray_4_0_MPORT_mask = _GEN_624 & _GEN_593;
  assign dataArray_4_0_MPORT_en = _T_6 & _off_T;
  assign dataArray_4_1_cachedata_MPORT_en = dataArray_4_1_cachedata_MPORT_en_pipe_0;
  assign dataArray_4_1_cachedata_MPORT_addr = dataArray_4_1_cachedata_MPORT_addr_pipe_0;
  assign dataArray_4_1_cachedata_MPORT_data = dataArray_4_1[dataArray_4_1_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_4_1_MPORT_data = to_sram_r_bits_data;
  assign dataArray_4_1_MPORT_addr = replace_set;
  assign dataArray_4_1_MPORT_mask = _GEN_624 & _GEN_595;
  assign dataArray_4_1_MPORT_en = _T_6 & _off_T;
  assign dataArray_4_2_cachedata_MPORT_en = dataArray_4_2_cachedata_MPORT_en_pipe_0;
  assign dataArray_4_2_cachedata_MPORT_addr = dataArray_4_2_cachedata_MPORT_addr_pipe_0;
  assign dataArray_4_2_cachedata_MPORT_data = dataArray_4_2[dataArray_4_2_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_4_2_MPORT_data = to_sram_r_bits_data;
  assign dataArray_4_2_MPORT_addr = replace_set;
  assign dataArray_4_2_MPORT_mask = _GEN_624 & _GEN_597;
  assign dataArray_4_2_MPORT_en = _T_6 & _off_T;
  assign dataArray_4_3_cachedata_MPORT_en = dataArray_4_3_cachedata_MPORT_en_pipe_0;
  assign dataArray_4_3_cachedata_MPORT_addr = dataArray_4_3_cachedata_MPORT_addr_pipe_0;
  assign dataArray_4_3_cachedata_MPORT_data = dataArray_4_3[dataArray_4_3_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_4_3_MPORT_data = to_sram_r_bits_data;
  assign dataArray_4_3_MPORT_addr = replace_set;
  assign dataArray_4_3_MPORT_mask = _GEN_624 & _GEN_599;
  assign dataArray_4_3_MPORT_en = _T_6 & _off_T;
  assign dataArray_5_0_cachedata_MPORT_en = dataArray_5_0_cachedata_MPORT_en_pipe_0;
  assign dataArray_5_0_cachedata_MPORT_addr = dataArray_5_0_cachedata_MPORT_addr_pipe_0;
  assign dataArray_5_0_cachedata_MPORT_data = dataArray_5_0[dataArray_5_0_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_5_0_MPORT_data = to_sram_r_bits_data;
  assign dataArray_5_0_MPORT_addr = replace_set;
  assign dataArray_5_0_MPORT_mask = _GEN_632 & _GEN_593;
  assign dataArray_5_0_MPORT_en = _T_6 & _off_T;
  assign dataArray_5_1_cachedata_MPORT_en = dataArray_5_1_cachedata_MPORT_en_pipe_0;
  assign dataArray_5_1_cachedata_MPORT_addr = dataArray_5_1_cachedata_MPORT_addr_pipe_0;
  assign dataArray_5_1_cachedata_MPORT_data = dataArray_5_1[dataArray_5_1_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_5_1_MPORT_data = to_sram_r_bits_data;
  assign dataArray_5_1_MPORT_addr = replace_set;
  assign dataArray_5_1_MPORT_mask = _GEN_632 & _GEN_595;
  assign dataArray_5_1_MPORT_en = _T_6 & _off_T;
  assign dataArray_5_2_cachedata_MPORT_en = dataArray_5_2_cachedata_MPORT_en_pipe_0;
  assign dataArray_5_2_cachedata_MPORT_addr = dataArray_5_2_cachedata_MPORT_addr_pipe_0;
  assign dataArray_5_2_cachedata_MPORT_data = dataArray_5_2[dataArray_5_2_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_5_2_MPORT_data = to_sram_r_bits_data;
  assign dataArray_5_2_MPORT_addr = replace_set;
  assign dataArray_5_2_MPORT_mask = _GEN_632 & _GEN_597;
  assign dataArray_5_2_MPORT_en = _T_6 & _off_T;
  assign dataArray_5_3_cachedata_MPORT_en = dataArray_5_3_cachedata_MPORT_en_pipe_0;
  assign dataArray_5_3_cachedata_MPORT_addr = dataArray_5_3_cachedata_MPORT_addr_pipe_0;
  assign dataArray_5_3_cachedata_MPORT_data = dataArray_5_3[dataArray_5_3_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_5_3_MPORT_data = to_sram_r_bits_data;
  assign dataArray_5_3_MPORT_addr = replace_set;
  assign dataArray_5_3_MPORT_mask = _GEN_632 & _GEN_599;
  assign dataArray_5_3_MPORT_en = _T_6 & _off_T;
  assign dataArray_6_0_cachedata_MPORT_en = dataArray_6_0_cachedata_MPORT_en_pipe_0;
  assign dataArray_6_0_cachedata_MPORT_addr = dataArray_6_0_cachedata_MPORT_addr_pipe_0;
  assign dataArray_6_0_cachedata_MPORT_data = dataArray_6_0[dataArray_6_0_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_6_0_MPORT_data = to_sram_r_bits_data;
  assign dataArray_6_0_MPORT_addr = replace_set;
  assign dataArray_6_0_MPORT_mask = _GEN_640 & _GEN_593;
  assign dataArray_6_0_MPORT_en = _T_6 & _off_T;
  assign dataArray_6_1_cachedata_MPORT_en = dataArray_6_1_cachedata_MPORT_en_pipe_0;
  assign dataArray_6_1_cachedata_MPORT_addr = dataArray_6_1_cachedata_MPORT_addr_pipe_0;
  assign dataArray_6_1_cachedata_MPORT_data = dataArray_6_1[dataArray_6_1_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_6_1_MPORT_data = to_sram_r_bits_data;
  assign dataArray_6_1_MPORT_addr = replace_set;
  assign dataArray_6_1_MPORT_mask = _GEN_640 & _GEN_595;
  assign dataArray_6_1_MPORT_en = _T_6 & _off_T;
  assign dataArray_6_2_cachedata_MPORT_en = dataArray_6_2_cachedata_MPORT_en_pipe_0;
  assign dataArray_6_2_cachedata_MPORT_addr = dataArray_6_2_cachedata_MPORT_addr_pipe_0;
  assign dataArray_6_2_cachedata_MPORT_data = dataArray_6_2[dataArray_6_2_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_6_2_MPORT_data = to_sram_r_bits_data;
  assign dataArray_6_2_MPORT_addr = replace_set;
  assign dataArray_6_2_MPORT_mask = _GEN_640 & _GEN_597;
  assign dataArray_6_2_MPORT_en = _T_6 & _off_T;
  assign dataArray_6_3_cachedata_MPORT_en = dataArray_6_3_cachedata_MPORT_en_pipe_0;
  assign dataArray_6_3_cachedata_MPORT_addr = dataArray_6_3_cachedata_MPORT_addr_pipe_0;
  assign dataArray_6_3_cachedata_MPORT_data = dataArray_6_3[dataArray_6_3_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_6_3_MPORT_data = to_sram_r_bits_data;
  assign dataArray_6_3_MPORT_addr = replace_set;
  assign dataArray_6_3_MPORT_mask = _GEN_640 & _GEN_599;
  assign dataArray_6_3_MPORT_en = _T_6 & _off_T;
  assign dataArray_7_0_cachedata_MPORT_en = dataArray_7_0_cachedata_MPORT_en_pipe_0;
  assign dataArray_7_0_cachedata_MPORT_addr = dataArray_7_0_cachedata_MPORT_addr_pipe_0;
  assign dataArray_7_0_cachedata_MPORT_data = dataArray_7_0[dataArray_7_0_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_7_0_MPORT_data = to_sram_r_bits_data;
  assign dataArray_7_0_MPORT_addr = replace_set;
  assign dataArray_7_0_MPORT_mask = _GEN_648 & _GEN_593;
  assign dataArray_7_0_MPORT_en = _T_6 & _off_T;
  assign dataArray_7_1_cachedata_MPORT_en = dataArray_7_1_cachedata_MPORT_en_pipe_0;
  assign dataArray_7_1_cachedata_MPORT_addr = dataArray_7_1_cachedata_MPORT_addr_pipe_0;
  assign dataArray_7_1_cachedata_MPORT_data = dataArray_7_1[dataArray_7_1_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_7_1_MPORT_data = to_sram_r_bits_data;
  assign dataArray_7_1_MPORT_addr = replace_set;
  assign dataArray_7_1_MPORT_mask = _GEN_648 & _GEN_595;
  assign dataArray_7_1_MPORT_en = _T_6 & _off_T;
  assign dataArray_7_2_cachedata_MPORT_en = dataArray_7_2_cachedata_MPORT_en_pipe_0;
  assign dataArray_7_2_cachedata_MPORT_addr = dataArray_7_2_cachedata_MPORT_addr_pipe_0;
  assign dataArray_7_2_cachedata_MPORT_data = dataArray_7_2[dataArray_7_2_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_7_2_MPORT_data = to_sram_r_bits_data;
  assign dataArray_7_2_MPORT_addr = replace_set;
  assign dataArray_7_2_MPORT_mask = _GEN_648 & _GEN_597;
  assign dataArray_7_2_MPORT_en = _T_6 & _off_T;
  assign dataArray_7_3_cachedata_MPORT_en = dataArray_7_3_cachedata_MPORT_en_pipe_0;
  assign dataArray_7_3_cachedata_MPORT_addr = dataArray_7_3_cachedata_MPORT_addr_pipe_0;
  assign dataArray_7_3_cachedata_MPORT_data = dataArray_7_3[dataArray_7_3_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_7_3_MPORT_data = to_sram_r_bits_data;
  assign dataArray_7_3_MPORT_addr = replace_set;
  assign dataArray_7_3_MPORT_mask = _GEN_648 & _GEN_599;
  assign dataArray_7_3_MPORT_en = _T_6 & _off_T;
  assign dataArray_8_0_cachedata_MPORT_en = dataArray_8_0_cachedata_MPORT_en_pipe_0;
  assign dataArray_8_0_cachedata_MPORT_addr = dataArray_8_0_cachedata_MPORT_addr_pipe_0;
  assign dataArray_8_0_cachedata_MPORT_data = dataArray_8_0[dataArray_8_0_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_8_0_MPORT_data = to_sram_r_bits_data;
  assign dataArray_8_0_MPORT_addr = replace_set;
  assign dataArray_8_0_MPORT_mask = _GEN_656 & _GEN_593;
  assign dataArray_8_0_MPORT_en = _T_6 & _off_T;
  assign dataArray_8_1_cachedata_MPORT_en = dataArray_8_1_cachedata_MPORT_en_pipe_0;
  assign dataArray_8_1_cachedata_MPORT_addr = dataArray_8_1_cachedata_MPORT_addr_pipe_0;
  assign dataArray_8_1_cachedata_MPORT_data = dataArray_8_1[dataArray_8_1_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_8_1_MPORT_data = to_sram_r_bits_data;
  assign dataArray_8_1_MPORT_addr = replace_set;
  assign dataArray_8_1_MPORT_mask = _GEN_656 & _GEN_595;
  assign dataArray_8_1_MPORT_en = _T_6 & _off_T;
  assign dataArray_8_2_cachedata_MPORT_en = dataArray_8_2_cachedata_MPORT_en_pipe_0;
  assign dataArray_8_2_cachedata_MPORT_addr = dataArray_8_2_cachedata_MPORT_addr_pipe_0;
  assign dataArray_8_2_cachedata_MPORT_data = dataArray_8_2[dataArray_8_2_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_8_2_MPORT_data = to_sram_r_bits_data;
  assign dataArray_8_2_MPORT_addr = replace_set;
  assign dataArray_8_2_MPORT_mask = _GEN_656 & _GEN_597;
  assign dataArray_8_2_MPORT_en = _T_6 & _off_T;
  assign dataArray_8_3_cachedata_MPORT_en = dataArray_8_3_cachedata_MPORT_en_pipe_0;
  assign dataArray_8_3_cachedata_MPORT_addr = dataArray_8_3_cachedata_MPORT_addr_pipe_0;
  assign dataArray_8_3_cachedata_MPORT_data = dataArray_8_3[dataArray_8_3_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_8_3_MPORT_data = to_sram_r_bits_data;
  assign dataArray_8_3_MPORT_addr = replace_set;
  assign dataArray_8_3_MPORT_mask = _GEN_656 & _GEN_599;
  assign dataArray_8_3_MPORT_en = _T_6 & _off_T;
  assign dataArray_9_0_cachedata_MPORT_en = dataArray_9_0_cachedata_MPORT_en_pipe_0;
  assign dataArray_9_0_cachedata_MPORT_addr = dataArray_9_0_cachedata_MPORT_addr_pipe_0;
  assign dataArray_9_0_cachedata_MPORT_data = dataArray_9_0[dataArray_9_0_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_9_0_MPORT_data = to_sram_r_bits_data;
  assign dataArray_9_0_MPORT_addr = replace_set;
  assign dataArray_9_0_MPORT_mask = _GEN_664 & _GEN_593;
  assign dataArray_9_0_MPORT_en = _T_6 & _off_T;
  assign dataArray_9_1_cachedata_MPORT_en = dataArray_9_1_cachedata_MPORT_en_pipe_0;
  assign dataArray_9_1_cachedata_MPORT_addr = dataArray_9_1_cachedata_MPORT_addr_pipe_0;
  assign dataArray_9_1_cachedata_MPORT_data = dataArray_9_1[dataArray_9_1_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_9_1_MPORT_data = to_sram_r_bits_data;
  assign dataArray_9_1_MPORT_addr = replace_set;
  assign dataArray_9_1_MPORT_mask = _GEN_664 & _GEN_595;
  assign dataArray_9_1_MPORT_en = _T_6 & _off_T;
  assign dataArray_9_2_cachedata_MPORT_en = dataArray_9_2_cachedata_MPORT_en_pipe_0;
  assign dataArray_9_2_cachedata_MPORT_addr = dataArray_9_2_cachedata_MPORT_addr_pipe_0;
  assign dataArray_9_2_cachedata_MPORT_data = dataArray_9_2[dataArray_9_2_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_9_2_MPORT_data = to_sram_r_bits_data;
  assign dataArray_9_2_MPORT_addr = replace_set;
  assign dataArray_9_2_MPORT_mask = _GEN_664 & _GEN_597;
  assign dataArray_9_2_MPORT_en = _T_6 & _off_T;
  assign dataArray_9_3_cachedata_MPORT_en = dataArray_9_3_cachedata_MPORT_en_pipe_0;
  assign dataArray_9_3_cachedata_MPORT_addr = dataArray_9_3_cachedata_MPORT_addr_pipe_0;
  assign dataArray_9_3_cachedata_MPORT_data = dataArray_9_3[dataArray_9_3_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_9_3_MPORT_data = to_sram_r_bits_data;
  assign dataArray_9_3_MPORT_addr = replace_set;
  assign dataArray_9_3_MPORT_mask = _GEN_664 & _GEN_599;
  assign dataArray_9_3_MPORT_en = _T_6 & _off_T;
  assign dataArray_10_0_cachedata_MPORT_en = dataArray_10_0_cachedata_MPORT_en_pipe_0;
  assign dataArray_10_0_cachedata_MPORT_addr = dataArray_10_0_cachedata_MPORT_addr_pipe_0;
  assign dataArray_10_0_cachedata_MPORT_data = dataArray_10_0[dataArray_10_0_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_10_0_MPORT_data = to_sram_r_bits_data;
  assign dataArray_10_0_MPORT_addr = replace_set;
  assign dataArray_10_0_MPORT_mask = _GEN_672 & _GEN_593;
  assign dataArray_10_0_MPORT_en = _T_6 & _off_T;
  assign dataArray_10_1_cachedata_MPORT_en = dataArray_10_1_cachedata_MPORT_en_pipe_0;
  assign dataArray_10_1_cachedata_MPORT_addr = dataArray_10_1_cachedata_MPORT_addr_pipe_0;
  assign dataArray_10_1_cachedata_MPORT_data = dataArray_10_1[dataArray_10_1_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_10_1_MPORT_data = to_sram_r_bits_data;
  assign dataArray_10_1_MPORT_addr = replace_set;
  assign dataArray_10_1_MPORT_mask = _GEN_672 & _GEN_595;
  assign dataArray_10_1_MPORT_en = _T_6 & _off_T;
  assign dataArray_10_2_cachedata_MPORT_en = dataArray_10_2_cachedata_MPORT_en_pipe_0;
  assign dataArray_10_2_cachedata_MPORT_addr = dataArray_10_2_cachedata_MPORT_addr_pipe_0;
  assign dataArray_10_2_cachedata_MPORT_data = dataArray_10_2[dataArray_10_2_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_10_2_MPORT_data = to_sram_r_bits_data;
  assign dataArray_10_2_MPORT_addr = replace_set;
  assign dataArray_10_2_MPORT_mask = _GEN_672 & _GEN_597;
  assign dataArray_10_2_MPORT_en = _T_6 & _off_T;
  assign dataArray_10_3_cachedata_MPORT_en = dataArray_10_3_cachedata_MPORT_en_pipe_0;
  assign dataArray_10_3_cachedata_MPORT_addr = dataArray_10_3_cachedata_MPORT_addr_pipe_0;
  assign dataArray_10_3_cachedata_MPORT_data = dataArray_10_3[dataArray_10_3_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_10_3_MPORT_data = to_sram_r_bits_data;
  assign dataArray_10_3_MPORT_addr = replace_set;
  assign dataArray_10_3_MPORT_mask = _GEN_672 & _GEN_599;
  assign dataArray_10_3_MPORT_en = _T_6 & _off_T;
  assign dataArray_11_0_cachedata_MPORT_en = dataArray_11_0_cachedata_MPORT_en_pipe_0;
  assign dataArray_11_0_cachedata_MPORT_addr = dataArray_11_0_cachedata_MPORT_addr_pipe_0;
  assign dataArray_11_0_cachedata_MPORT_data = dataArray_11_0[dataArray_11_0_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_11_0_MPORT_data = to_sram_r_bits_data;
  assign dataArray_11_0_MPORT_addr = replace_set;
  assign dataArray_11_0_MPORT_mask = _GEN_680 & _GEN_593;
  assign dataArray_11_0_MPORT_en = _T_6 & _off_T;
  assign dataArray_11_1_cachedata_MPORT_en = dataArray_11_1_cachedata_MPORT_en_pipe_0;
  assign dataArray_11_1_cachedata_MPORT_addr = dataArray_11_1_cachedata_MPORT_addr_pipe_0;
  assign dataArray_11_1_cachedata_MPORT_data = dataArray_11_1[dataArray_11_1_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_11_1_MPORT_data = to_sram_r_bits_data;
  assign dataArray_11_1_MPORT_addr = replace_set;
  assign dataArray_11_1_MPORT_mask = _GEN_680 & _GEN_595;
  assign dataArray_11_1_MPORT_en = _T_6 & _off_T;
  assign dataArray_11_2_cachedata_MPORT_en = dataArray_11_2_cachedata_MPORT_en_pipe_0;
  assign dataArray_11_2_cachedata_MPORT_addr = dataArray_11_2_cachedata_MPORT_addr_pipe_0;
  assign dataArray_11_2_cachedata_MPORT_data = dataArray_11_2[dataArray_11_2_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_11_2_MPORT_data = to_sram_r_bits_data;
  assign dataArray_11_2_MPORT_addr = replace_set;
  assign dataArray_11_2_MPORT_mask = _GEN_680 & _GEN_597;
  assign dataArray_11_2_MPORT_en = _T_6 & _off_T;
  assign dataArray_11_3_cachedata_MPORT_en = dataArray_11_3_cachedata_MPORT_en_pipe_0;
  assign dataArray_11_3_cachedata_MPORT_addr = dataArray_11_3_cachedata_MPORT_addr_pipe_0;
  assign dataArray_11_3_cachedata_MPORT_data = dataArray_11_3[dataArray_11_3_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_11_3_MPORT_data = to_sram_r_bits_data;
  assign dataArray_11_3_MPORT_addr = replace_set;
  assign dataArray_11_3_MPORT_mask = _GEN_680 & _GEN_599;
  assign dataArray_11_3_MPORT_en = _T_6 & _off_T;
  assign dataArray_12_0_cachedata_MPORT_en = dataArray_12_0_cachedata_MPORT_en_pipe_0;
  assign dataArray_12_0_cachedata_MPORT_addr = dataArray_12_0_cachedata_MPORT_addr_pipe_0;
  assign dataArray_12_0_cachedata_MPORT_data = dataArray_12_0[dataArray_12_0_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_12_0_MPORT_data = to_sram_r_bits_data;
  assign dataArray_12_0_MPORT_addr = replace_set;
  assign dataArray_12_0_MPORT_mask = _GEN_688 & _GEN_593;
  assign dataArray_12_0_MPORT_en = _T_6 & _off_T;
  assign dataArray_12_1_cachedata_MPORT_en = dataArray_12_1_cachedata_MPORT_en_pipe_0;
  assign dataArray_12_1_cachedata_MPORT_addr = dataArray_12_1_cachedata_MPORT_addr_pipe_0;
  assign dataArray_12_1_cachedata_MPORT_data = dataArray_12_1[dataArray_12_1_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_12_1_MPORT_data = to_sram_r_bits_data;
  assign dataArray_12_1_MPORT_addr = replace_set;
  assign dataArray_12_1_MPORT_mask = _GEN_688 & _GEN_595;
  assign dataArray_12_1_MPORT_en = _T_6 & _off_T;
  assign dataArray_12_2_cachedata_MPORT_en = dataArray_12_2_cachedata_MPORT_en_pipe_0;
  assign dataArray_12_2_cachedata_MPORT_addr = dataArray_12_2_cachedata_MPORT_addr_pipe_0;
  assign dataArray_12_2_cachedata_MPORT_data = dataArray_12_2[dataArray_12_2_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_12_2_MPORT_data = to_sram_r_bits_data;
  assign dataArray_12_2_MPORT_addr = replace_set;
  assign dataArray_12_2_MPORT_mask = _GEN_688 & _GEN_597;
  assign dataArray_12_2_MPORT_en = _T_6 & _off_T;
  assign dataArray_12_3_cachedata_MPORT_en = dataArray_12_3_cachedata_MPORT_en_pipe_0;
  assign dataArray_12_3_cachedata_MPORT_addr = dataArray_12_3_cachedata_MPORT_addr_pipe_0;
  assign dataArray_12_3_cachedata_MPORT_data = dataArray_12_3[dataArray_12_3_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_12_3_MPORT_data = to_sram_r_bits_data;
  assign dataArray_12_3_MPORT_addr = replace_set;
  assign dataArray_12_3_MPORT_mask = _GEN_688 & _GEN_599;
  assign dataArray_12_3_MPORT_en = _T_6 & _off_T;
  assign dataArray_13_0_cachedata_MPORT_en = dataArray_13_0_cachedata_MPORT_en_pipe_0;
  assign dataArray_13_0_cachedata_MPORT_addr = dataArray_13_0_cachedata_MPORT_addr_pipe_0;
  assign dataArray_13_0_cachedata_MPORT_data = dataArray_13_0[dataArray_13_0_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_13_0_MPORT_data = to_sram_r_bits_data;
  assign dataArray_13_0_MPORT_addr = replace_set;
  assign dataArray_13_0_MPORT_mask = _GEN_696 & _GEN_593;
  assign dataArray_13_0_MPORT_en = _T_6 & _off_T;
  assign dataArray_13_1_cachedata_MPORT_en = dataArray_13_1_cachedata_MPORT_en_pipe_0;
  assign dataArray_13_1_cachedata_MPORT_addr = dataArray_13_1_cachedata_MPORT_addr_pipe_0;
  assign dataArray_13_1_cachedata_MPORT_data = dataArray_13_1[dataArray_13_1_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_13_1_MPORT_data = to_sram_r_bits_data;
  assign dataArray_13_1_MPORT_addr = replace_set;
  assign dataArray_13_1_MPORT_mask = _GEN_696 & _GEN_595;
  assign dataArray_13_1_MPORT_en = _T_6 & _off_T;
  assign dataArray_13_2_cachedata_MPORT_en = dataArray_13_2_cachedata_MPORT_en_pipe_0;
  assign dataArray_13_2_cachedata_MPORT_addr = dataArray_13_2_cachedata_MPORT_addr_pipe_0;
  assign dataArray_13_2_cachedata_MPORT_data = dataArray_13_2[dataArray_13_2_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_13_2_MPORT_data = to_sram_r_bits_data;
  assign dataArray_13_2_MPORT_addr = replace_set;
  assign dataArray_13_2_MPORT_mask = _GEN_696 & _GEN_597;
  assign dataArray_13_2_MPORT_en = _T_6 & _off_T;
  assign dataArray_13_3_cachedata_MPORT_en = dataArray_13_3_cachedata_MPORT_en_pipe_0;
  assign dataArray_13_3_cachedata_MPORT_addr = dataArray_13_3_cachedata_MPORT_addr_pipe_0;
  assign dataArray_13_3_cachedata_MPORT_data = dataArray_13_3[dataArray_13_3_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_13_3_MPORT_data = to_sram_r_bits_data;
  assign dataArray_13_3_MPORT_addr = replace_set;
  assign dataArray_13_3_MPORT_mask = _GEN_696 & _GEN_599;
  assign dataArray_13_3_MPORT_en = _T_6 & _off_T;
  assign dataArray_14_0_cachedata_MPORT_en = dataArray_14_0_cachedata_MPORT_en_pipe_0;
  assign dataArray_14_0_cachedata_MPORT_addr = dataArray_14_0_cachedata_MPORT_addr_pipe_0;
  assign dataArray_14_0_cachedata_MPORT_data = dataArray_14_0[dataArray_14_0_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_14_0_MPORT_data = to_sram_r_bits_data;
  assign dataArray_14_0_MPORT_addr = replace_set;
  assign dataArray_14_0_MPORT_mask = _GEN_704 & _GEN_593;
  assign dataArray_14_0_MPORT_en = _T_6 & _off_T;
  assign dataArray_14_1_cachedata_MPORT_en = dataArray_14_1_cachedata_MPORT_en_pipe_0;
  assign dataArray_14_1_cachedata_MPORT_addr = dataArray_14_1_cachedata_MPORT_addr_pipe_0;
  assign dataArray_14_1_cachedata_MPORT_data = dataArray_14_1[dataArray_14_1_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_14_1_MPORT_data = to_sram_r_bits_data;
  assign dataArray_14_1_MPORT_addr = replace_set;
  assign dataArray_14_1_MPORT_mask = _GEN_704 & _GEN_595;
  assign dataArray_14_1_MPORT_en = _T_6 & _off_T;
  assign dataArray_14_2_cachedata_MPORT_en = dataArray_14_2_cachedata_MPORT_en_pipe_0;
  assign dataArray_14_2_cachedata_MPORT_addr = dataArray_14_2_cachedata_MPORT_addr_pipe_0;
  assign dataArray_14_2_cachedata_MPORT_data = dataArray_14_2[dataArray_14_2_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_14_2_MPORT_data = to_sram_r_bits_data;
  assign dataArray_14_2_MPORT_addr = replace_set;
  assign dataArray_14_2_MPORT_mask = _GEN_704 & _GEN_597;
  assign dataArray_14_2_MPORT_en = _T_6 & _off_T;
  assign dataArray_14_3_cachedata_MPORT_en = dataArray_14_3_cachedata_MPORT_en_pipe_0;
  assign dataArray_14_3_cachedata_MPORT_addr = dataArray_14_3_cachedata_MPORT_addr_pipe_0;
  assign dataArray_14_3_cachedata_MPORT_data = dataArray_14_3[dataArray_14_3_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_14_3_MPORT_data = to_sram_r_bits_data;
  assign dataArray_14_3_MPORT_addr = replace_set;
  assign dataArray_14_3_MPORT_mask = _GEN_704 & _GEN_599;
  assign dataArray_14_3_MPORT_en = _T_6 & _off_T;
  assign dataArray_15_0_cachedata_MPORT_en = dataArray_15_0_cachedata_MPORT_en_pipe_0;
  assign dataArray_15_0_cachedata_MPORT_addr = dataArray_15_0_cachedata_MPORT_addr_pipe_0;
  assign dataArray_15_0_cachedata_MPORT_data = dataArray_15_0[dataArray_15_0_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_15_0_MPORT_data = to_sram_r_bits_data;
  assign dataArray_15_0_MPORT_addr = replace_set;
  assign dataArray_15_0_MPORT_mask = _GEN_712 & _GEN_593;
  assign dataArray_15_0_MPORT_en = _T_6 & _off_T;
  assign dataArray_15_1_cachedata_MPORT_en = dataArray_15_1_cachedata_MPORT_en_pipe_0;
  assign dataArray_15_1_cachedata_MPORT_addr = dataArray_15_1_cachedata_MPORT_addr_pipe_0;
  assign dataArray_15_1_cachedata_MPORT_data = dataArray_15_1[dataArray_15_1_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_15_1_MPORT_data = to_sram_r_bits_data;
  assign dataArray_15_1_MPORT_addr = replace_set;
  assign dataArray_15_1_MPORT_mask = _GEN_712 & _GEN_595;
  assign dataArray_15_1_MPORT_en = _T_6 & _off_T;
  assign dataArray_15_2_cachedata_MPORT_en = dataArray_15_2_cachedata_MPORT_en_pipe_0;
  assign dataArray_15_2_cachedata_MPORT_addr = dataArray_15_2_cachedata_MPORT_addr_pipe_0;
  assign dataArray_15_2_cachedata_MPORT_data = dataArray_15_2[dataArray_15_2_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_15_2_MPORT_data = to_sram_r_bits_data;
  assign dataArray_15_2_MPORT_addr = replace_set;
  assign dataArray_15_2_MPORT_mask = _GEN_712 & _GEN_597;
  assign dataArray_15_2_MPORT_en = _T_6 & _off_T;
  assign dataArray_15_3_cachedata_MPORT_en = dataArray_15_3_cachedata_MPORT_en_pipe_0;
  assign dataArray_15_3_cachedata_MPORT_addr = dataArray_15_3_cachedata_MPORT_addr_pipe_0;
  assign dataArray_15_3_cachedata_MPORT_data = dataArray_15_3[dataArray_15_3_cachedata_MPORT_addr]; // @[icache.scala 30:33]
  assign dataArray_15_3_MPORT_data = to_sram_r_bits_data;
  assign dataArray_15_3_MPORT_addr = replace_set;
  assign dataArray_15_3_MPORT_mask = _GEN_712 & _GEN_599;
  assign dataArray_15_3_MPORT_en = _T_6 & _off_T;
  assign from_IFU_ready = 3'h0 == state_cache; // @[Mux.scala 81:61]
  assign to_IFU_valid = 3'h1 == state_cache; // @[Mux.scala 81:61]
  assign to_IFU_bits_data = hit ? _GEN_591 : 32'h13; // @[icache.scala 108:28]
  assign to_sram_ar_valid = 3'h2 == state_cache; // @[Mux.scala 81:61]
  assign to_sram_ar_bits_addr = _to_sram_ar_bits_addr_T_3[31:0]; // @[icache.scala 91:27]
  assign to_sram_ar_bits_len = {{6'd0}, _to_sram_ar_bits_len_T_1}; // @[icache.scala 93:27]
  assign to_sram_r_ready = 3'h3 == state_cache; // @[Mux.scala 81:61]
  always @(posedge clock) begin
    if (dataArray_0_0_MPORT_en & dataArray_0_0_MPORT_mask) begin
      dataArray_0_0[dataArray_0_0_MPORT_addr] <= dataArray_0_0_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_0_0_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_0_0_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_0_1_MPORT_en & dataArray_0_1_MPORT_mask) begin
      dataArray_0_1[dataArray_0_1_MPORT_addr] <= dataArray_0_1_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_0_1_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_0_1_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_0_2_MPORT_en & dataArray_0_2_MPORT_mask) begin
      dataArray_0_2[dataArray_0_2_MPORT_addr] <= dataArray_0_2_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_0_2_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_0_2_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_0_3_MPORT_en & dataArray_0_3_MPORT_mask) begin
      dataArray_0_3[dataArray_0_3_MPORT_addr] <= dataArray_0_3_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_0_3_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_0_3_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_1_0_MPORT_en & dataArray_1_0_MPORT_mask) begin
      dataArray_1_0[dataArray_1_0_MPORT_addr] <= dataArray_1_0_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_1_0_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_1_0_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_1_1_MPORT_en & dataArray_1_1_MPORT_mask) begin
      dataArray_1_1[dataArray_1_1_MPORT_addr] <= dataArray_1_1_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_1_1_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_1_1_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_1_2_MPORT_en & dataArray_1_2_MPORT_mask) begin
      dataArray_1_2[dataArray_1_2_MPORT_addr] <= dataArray_1_2_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_1_2_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_1_2_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_1_3_MPORT_en & dataArray_1_3_MPORT_mask) begin
      dataArray_1_3[dataArray_1_3_MPORT_addr] <= dataArray_1_3_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_1_3_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_1_3_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_2_0_MPORT_en & dataArray_2_0_MPORT_mask) begin
      dataArray_2_0[dataArray_2_0_MPORT_addr] <= dataArray_2_0_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_2_0_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_2_0_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_2_1_MPORT_en & dataArray_2_1_MPORT_mask) begin
      dataArray_2_1[dataArray_2_1_MPORT_addr] <= dataArray_2_1_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_2_1_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_2_1_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_2_2_MPORT_en & dataArray_2_2_MPORT_mask) begin
      dataArray_2_2[dataArray_2_2_MPORT_addr] <= dataArray_2_2_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_2_2_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_2_2_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_2_3_MPORT_en & dataArray_2_3_MPORT_mask) begin
      dataArray_2_3[dataArray_2_3_MPORT_addr] <= dataArray_2_3_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_2_3_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_2_3_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_3_0_MPORT_en & dataArray_3_0_MPORT_mask) begin
      dataArray_3_0[dataArray_3_0_MPORT_addr] <= dataArray_3_0_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_3_0_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_3_0_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_3_1_MPORT_en & dataArray_3_1_MPORT_mask) begin
      dataArray_3_1[dataArray_3_1_MPORT_addr] <= dataArray_3_1_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_3_1_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_3_1_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_3_2_MPORT_en & dataArray_3_2_MPORT_mask) begin
      dataArray_3_2[dataArray_3_2_MPORT_addr] <= dataArray_3_2_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_3_2_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_3_2_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_3_3_MPORT_en & dataArray_3_3_MPORT_mask) begin
      dataArray_3_3[dataArray_3_3_MPORT_addr] <= dataArray_3_3_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_3_3_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_3_3_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_4_0_MPORT_en & dataArray_4_0_MPORT_mask) begin
      dataArray_4_0[dataArray_4_0_MPORT_addr] <= dataArray_4_0_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_4_0_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_4_0_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_4_1_MPORT_en & dataArray_4_1_MPORT_mask) begin
      dataArray_4_1[dataArray_4_1_MPORT_addr] <= dataArray_4_1_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_4_1_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_4_1_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_4_2_MPORT_en & dataArray_4_2_MPORT_mask) begin
      dataArray_4_2[dataArray_4_2_MPORT_addr] <= dataArray_4_2_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_4_2_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_4_2_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_4_3_MPORT_en & dataArray_4_3_MPORT_mask) begin
      dataArray_4_3[dataArray_4_3_MPORT_addr] <= dataArray_4_3_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_4_3_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_4_3_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_5_0_MPORT_en & dataArray_5_0_MPORT_mask) begin
      dataArray_5_0[dataArray_5_0_MPORT_addr] <= dataArray_5_0_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_5_0_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_5_0_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_5_1_MPORT_en & dataArray_5_1_MPORT_mask) begin
      dataArray_5_1[dataArray_5_1_MPORT_addr] <= dataArray_5_1_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_5_1_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_5_1_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_5_2_MPORT_en & dataArray_5_2_MPORT_mask) begin
      dataArray_5_2[dataArray_5_2_MPORT_addr] <= dataArray_5_2_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_5_2_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_5_2_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_5_3_MPORT_en & dataArray_5_3_MPORT_mask) begin
      dataArray_5_3[dataArray_5_3_MPORT_addr] <= dataArray_5_3_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_5_3_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_5_3_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_6_0_MPORT_en & dataArray_6_0_MPORT_mask) begin
      dataArray_6_0[dataArray_6_0_MPORT_addr] <= dataArray_6_0_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_6_0_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_6_0_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_6_1_MPORT_en & dataArray_6_1_MPORT_mask) begin
      dataArray_6_1[dataArray_6_1_MPORT_addr] <= dataArray_6_1_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_6_1_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_6_1_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_6_2_MPORT_en & dataArray_6_2_MPORT_mask) begin
      dataArray_6_2[dataArray_6_2_MPORT_addr] <= dataArray_6_2_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_6_2_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_6_2_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_6_3_MPORT_en & dataArray_6_3_MPORT_mask) begin
      dataArray_6_3[dataArray_6_3_MPORT_addr] <= dataArray_6_3_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_6_3_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_6_3_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_7_0_MPORT_en & dataArray_7_0_MPORT_mask) begin
      dataArray_7_0[dataArray_7_0_MPORT_addr] <= dataArray_7_0_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_7_0_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_7_0_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_7_1_MPORT_en & dataArray_7_1_MPORT_mask) begin
      dataArray_7_1[dataArray_7_1_MPORT_addr] <= dataArray_7_1_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_7_1_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_7_1_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_7_2_MPORT_en & dataArray_7_2_MPORT_mask) begin
      dataArray_7_2[dataArray_7_2_MPORT_addr] <= dataArray_7_2_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_7_2_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_7_2_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_7_3_MPORT_en & dataArray_7_3_MPORT_mask) begin
      dataArray_7_3[dataArray_7_3_MPORT_addr] <= dataArray_7_3_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_7_3_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_7_3_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_8_0_MPORT_en & dataArray_8_0_MPORT_mask) begin
      dataArray_8_0[dataArray_8_0_MPORT_addr] <= dataArray_8_0_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_8_0_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_8_0_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_8_1_MPORT_en & dataArray_8_1_MPORT_mask) begin
      dataArray_8_1[dataArray_8_1_MPORT_addr] <= dataArray_8_1_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_8_1_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_8_1_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_8_2_MPORT_en & dataArray_8_2_MPORT_mask) begin
      dataArray_8_2[dataArray_8_2_MPORT_addr] <= dataArray_8_2_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_8_2_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_8_2_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_8_3_MPORT_en & dataArray_8_3_MPORT_mask) begin
      dataArray_8_3[dataArray_8_3_MPORT_addr] <= dataArray_8_3_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_8_3_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_8_3_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_9_0_MPORT_en & dataArray_9_0_MPORT_mask) begin
      dataArray_9_0[dataArray_9_0_MPORT_addr] <= dataArray_9_0_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_9_0_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_9_0_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_9_1_MPORT_en & dataArray_9_1_MPORT_mask) begin
      dataArray_9_1[dataArray_9_1_MPORT_addr] <= dataArray_9_1_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_9_1_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_9_1_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_9_2_MPORT_en & dataArray_9_2_MPORT_mask) begin
      dataArray_9_2[dataArray_9_2_MPORT_addr] <= dataArray_9_2_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_9_2_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_9_2_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_9_3_MPORT_en & dataArray_9_3_MPORT_mask) begin
      dataArray_9_3[dataArray_9_3_MPORT_addr] <= dataArray_9_3_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_9_3_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_9_3_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_10_0_MPORT_en & dataArray_10_0_MPORT_mask) begin
      dataArray_10_0[dataArray_10_0_MPORT_addr] <= dataArray_10_0_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_10_0_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_10_0_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_10_1_MPORT_en & dataArray_10_1_MPORT_mask) begin
      dataArray_10_1[dataArray_10_1_MPORT_addr] <= dataArray_10_1_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_10_1_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_10_1_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_10_2_MPORT_en & dataArray_10_2_MPORT_mask) begin
      dataArray_10_2[dataArray_10_2_MPORT_addr] <= dataArray_10_2_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_10_2_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_10_2_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_10_3_MPORT_en & dataArray_10_3_MPORT_mask) begin
      dataArray_10_3[dataArray_10_3_MPORT_addr] <= dataArray_10_3_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_10_3_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_10_3_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_11_0_MPORT_en & dataArray_11_0_MPORT_mask) begin
      dataArray_11_0[dataArray_11_0_MPORT_addr] <= dataArray_11_0_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_11_0_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_11_0_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_11_1_MPORT_en & dataArray_11_1_MPORT_mask) begin
      dataArray_11_1[dataArray_11_1_MPORT_addr] <= dataArray_11_1_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_11_1_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_11_1_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_11_2_MPORT_en & dataArray_11_2_MPORT_mask) begin
      dataArray_11_2[dataArray_11_2_MPORT_addr] <= dataArray_11_2_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_11_2_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_11_2_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_11_3_MPORT_en & dataArray_11_3_MPORT_mask) begin
      dataArray_11_3[dataArray_11_3_MPORT_addr] <= dataArray_11_3_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_11_3_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_11_3_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_12_0_MPORT_en & dataArray_12_0_MPORT_mask) begin
      dataArray_12_0[dataArray_12_0_MPORT_addr] <= dataArray_12_0_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_12_0_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_12_0_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_12_1_MPORT_en & dataArray_12_1_MPORT_mask) begin
      dataArray_12_1[dataArray_12_1_MPORT_addr] <= dataArray_12_1_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_12_1_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_12_1_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_12_2_MPORT_en & dataArray_12_2_MPORT_mask) begin
      dataArray_12_2[dataArray_12_2_MPORT_addr] <= dataArray_12_2_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_12_2_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_12_2_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_12_3_MPORT_en & dataArray_12_3_MPORT_mask) begin
      dataArray_12_3[dataArray_12_3_MPORT_addr] <= dataArray_12_3_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_12_3_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_12_3_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_13_0_MPORT_en & dataArray_13_0_MPORT_mask) begin
      dataArray_13_0[dataArray_13_0_MPORT_addr] <= dataArray_13_0_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_13_0_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_13_0_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_13_1_MPORT_en & dataArray_13_1_MPORT_mask) begin
      dataArray_13_1[dataArray_13_1_MPORT_addr] <= dataArray_13_1_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_13_1_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_13_1_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_13_2_MPORT_en & dataArray_13_2_MPORT_mask) begin
      dataArray_13_2[dataArray_13_2_MPORT_addr] <= dataArray_13_2_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_13_2_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_13_2_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_13_3_MPORT_en & dataArray_13_3_MPORT_mask) begin
      dataArray_13_3[dataArray_13_3_MPORT_addr] <= dataArray_13_3_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_13_3_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_13_3_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_14_0_MPORT_en & dataArray_14_0_MPORT_mask) begin
      dataArray_14_0[dataArray_14_0_MPORT_addr] <= dataArray_14_0_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_14_0_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_14_0_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_14_1_MPORT_en & dataArray_14_1_MPORT_mask) begin
      dataArray_14_1[dataArray_14_1_MPORT_addr] <= dataArray_14_1_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_14_1_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_14_1_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_14_2_MPORT_en & dataArray_14_2_MPORT_mask) begin
      dataArray_14_2[dataArray_14_2_MPORT_addr] <= dataArray_14_2_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_14_2_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_14_2_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_14_3_MPORT_en & dataArray_14_3_MPORT_mask) begin
      dataArray_14_3[dataArray_14_3_MPORT_addr] <= dataArray_14_3_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_14_3_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_14_3_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_15_0_MPORT_en & dataArray_15_0_MPORT_mask) begin
      dataArray_15_0[dataArray_15_0_MPORT_addr] <= dataArray_15_0_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_15_0_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_15_0_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_15_1_MPORT_en & dataArray_15_1_MPORT_mask) begin
      dataArray_15_1[dataArray_15_1_MPORT_addr] <= dataArray_15_1_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_15_1_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_15_1_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_15_2_MPORT_en & dataArray_15_2_MPORT_mask) begin
      dataArray_15_2[dataArray_15_2_MPORT_addr] <= dataArray_15_2_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_15_2_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_15_2_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (dataArray_15_3_MPORT_en & dataArray_15_3_MPORT_mask) begin
      dataArray_15_3[dataArray_15_3_MPORT_addr] <= dataArray_15_3_MPORT_data; // @[icache.scala 30:33]
    end
    dataArray_15_3_cachedata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_15_3_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    if (reset) begin // @[icache.scala 21:30]
      replace_set <= 1'h0; // @[icache.scala 21:30]
    end else if (!(3'h0 == state_cache)) begin // @[icache.scala 49:26]
      if (!(3'h1 == state_cache)) begin // @[icache.scala 49:26]
        if (3'h2 == state_cache) begin // @[icache.scala 49:26]
          replace_set <= random_num; // @[icache.scala 64:25]
        end
      end
    end
    if (reset) begin // @[icache.scala 27:29]
      random_num <= 1'h0; // @[icache.scala 27:29]
    end else begin
      random_num <= random_num + 1'h1; // @[icache.scala 28:16]
    end
    if (reset) begin // @[icache.scala 31:29]
      tagArray_0_0 <= 24'h0; // @[icache.scala 31:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        if (_GEN_720 & _GEN_592) begin // @[icache.scala 84:50]
          tagArray_0_0 <= tag; // @[icache.scala 84:50]
        end
      end
    end
    if (reset) begin // @[icache.scala 31:29]
      tagArray_0_1 <= 24'h0; // @[icache.scala 31:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        if (_GEN_720 & _GEN_600) begin // @[icache.scala 84:50]
          tagArray_0_1 <= tag; // @[icache.scala 84:50]
        end
      end
    end
    if (reset) begin // @[icache.scala 31:29]
      tagArray_0_2 <= 24'h0; // @[icache.scala 31:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        if (_GEN_720 & _GEN_608) begin // @[icache.scala 84:50]
          tagArray_0_2 <= tag; // @[icache.scala 84:50]
        end
      end
    end
    if (reset) begin // @[icache.scala 31:29]
      tagArray_0_3 <= 24'h0; // @[icache.scala 31:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        if (_GEN_720 & _GEN_616) begin // @[icache.scala 84:50]
          tagArray_0_3 <= tag; // @[icache.scala 84:50]
        end
      end
    end
    if (reset) begin // @[icache.scala 31:29]
      tagArray_0_4 <= 24'h0; // @[icache.scala 31:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        if (_GEN_720 & _GEN_624) begin // @[icache.scala 84:50]
          tagArray_0_4 <= tag; // @[icache.scala 84:50]
        end
      end
    end
    if (reset) begin // @[icache.scala 31:29]
      tagArray_0_5 <= 24'h0; // @[icache.scala 31:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        if (_GEN_720 & _GEN_632) begin // @[icache.scala 84:50]
          tagArray_0_5 <= tag; // @[icache.scala 84:50]
        end
      end
    end
    if (reset) begin // @[icache.scala 31:29]
      tagArray_0_6 <= 24'h0; // @[icache.scala 31:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        if (_GEN_720 & _GEN_640) begin // @[icache.scala 84:50]
          tagArray_0_6 <= tag; // @[icache.scala 84:50]
        end
      end
    end
    if (reset) begin // @[icache.scala 31:29]
      tagArray_0_7 <= 24'h0; // @[icache.scala 31:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        if (_GEN_720 & _GEN_648) begin // @[icache.scala 84:50]
          tagArray_0_7 <= tag; // @[icache.scala 84:50]
        end
      end
    end
    if (reset) begin // @[icache.scala 31:29]
      tagArray_0_8 <= 24'h0; // @[icache.scala 31:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        if (_GEN_720 & _GEN_656) begin // @[icache.scala 84:50]
          tagArray_0_8 <= tag; // @[icache.scala 84:50]
        end
      end
    end
    if (reset) begin // @[icache.scala 31:29]
      tagArray_0_9 <= 24'h0; // @[icache.scala 31:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        if (_GEN_720 & _GEN_664) begin // @[icache.scala 84:50]
          tagArray_0_9 <= tag; // @[icache.scala 84:50]
        end
      end
    end
    if (reset) begin // @[icache.scala 31:29]
      tagArray_0_10 <= 24'h0; // @[icache.scala 31:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        if (_GEN_720 & _GEN_672) begin // @[icache.scala 84:50]
          tagArray_0_10 <= tag; // @[icache.scala 84:50]
        end
      end
    end
    if (reset) begin // @[icache.scala 31:29]
      tagArray_0_11 <= 24'h0; // @[icache.scala 31:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        if (_GEN_720 & _GEN_680) begin // @[icache.scala 84:50]
          tagArray_0_11 <= tag; // @[icache.scala 84:50]
        end
      end
    end
    if (reset) begin // @[icache.scala 31:29]
      tagArray_0_12 <= 24'h0; // @[icache.scala 31:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        if (_GEN_720 & _GEN_688) begin // @[icache.scala 84:50]
          tagArray_0_12 <= tag; // @[icache.scala 84:50]
        end
      end
    end
    if (reset) begin // @[icache.scala 31:29]
      tagArray_0_13 <= 24'h0; // @[icache.scala 31:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        if (_GEN_720 & _GEN_696) begin // @[icache.scala 84:50]
          tagArray_0_13 <= tag; // @[icache.scala 84:50]
        end
      end
    end
    if (reset) begin // @[icache.scala 31:29]
      tagArray_0_14 <= 24'h0; // @[icache.scala 31:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        if (_GEN_720 & _GEN_704) begin // @[icache.scala 84:50]
          tagArray_0_14 <= tag; // @[icache.scala 84:50]
        end
      end
    end
    if (reset) begin // @[icache.scala 31:29]
      tagArray_0_15 <= 24'h0; // @[icache.scala 31:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        if (_GEN_720 & _GEN_712) begin // @[icache.scala 84:50]
          tagArray_0_15 <= tag; // @[icache.scala 84:50]
        end
      end
    end
    if (reset) begin // @[icache.scala 31:29]
      tagArray_1_0 <= 24'h0; // @[icache.scala 31:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        if (replace_set & _GEN_592) begin // @[icache.scala 84:50]
          tagArray_1_0 <= tag; // @[icache.scala 84:50]
        end
      end
    end
    if (reset) begin // @[icache.scala 31:29]
      tagArray_1_1 <= 24'h0; // @[icache.scala 31:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        if (replace_set & _GEN_600) begin // @[icache.scala 84:50]
          tagArray_1_1 <= tag; // @[icache.scala 84:50]
        end
      end
    end
    if (reset) begin // @[icache.scala 31:29]
      tagArray_1_2 <= 24'h0; // @[icache.scala 31:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        if (replace_set & _GEN_608) begin // @[icache.scala 84:50]
          tagArray_1_2 <= tag; // @[icache.scala 84:50]
        end
      end
    end
    if (reset) begin // @[icache.scala 31:29]
      tagArray_1_3 <= 24'h0; // @[icache.scala 31:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        if (replace_set & _GEN_616) begin // @[icache.scala 84:50]
          tagArray_1_3 <= tag; // @[icache.scala 84:50]
        end
      end
    end
    if (reset) begin // @[icache.scala 31:29]
      tagArray_1_4 <= 24'h0; // @[icache.scala 31:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        if (replace_set & _GEN_624) begin // @[icache.scala 84:50]
          tagArray_1_4 <= tag; // @[icache.scala 84:50]
        end
      end
    end
    if (reset) begin // @[icache.scala 31:29]
      tagArray_1_5 <= 24'h0; // @[icache.scala 31:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        if (replace_set & _GEN_632) begin // @[icache.scala 84:50]
          tagArray_1_5 <= tag; // @[icache.scala 84:50]
        end
      end
    end
    if (reset) begin // @[icache.scala 31:29]
      tagArray_1_6 <= 24'h0; // @[icache.scala 31:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        if (replace_set & _GEN_640) begin // @[icache.scala 84:50]
          tagArray_1_6 <= tag; // @[icache.scala 84:50]
        end
      end
    end
    if (reset) begin // @[icache.scala 31:29]
      tagArray_1_7 <= 24'h0; // @[icache.scala 31:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        if (replace_set & _GEN_648) begin // @[icache.scala 84:50]
          tagArray_1_7 <= tag; // @[icache.scala 84:50]
        end
      end
    end
    if (reset) begin // @[icache.scala 31:29]
      tagArray_1_8 <= 24'h0; // @[icache.scala 31:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        if (replace_set & _GEN_656) begin // @[icache.scala 84:50]
          tagArray_1_8 <= tag; // @[icache.scala 84:50]
        end
      end
    end
    if (reset) begin // @[icache.scala 31:29]
      tagArray_1_9 <= 24'h0; // @[icache.scala 31:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        if (replace_set & _GEN_664) begin // @[icache.scala 84:50]
          tagArray_1_9 <= tag; // @[icache.scala 84:50]
        end
      end
    end
    if (reset) begin // @[icache.scala 31:29]
      tagArray_1_10 <= 24'h0; // @[icache.scala 31:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        if (replace_set & _GEN_672) begin // @[icache.scala 84:50]
          tagArray_1_10 <= tag; // @[icache.scala 84:50]
        end
      end
    end
    if (reset) begin // @[icache.scala 31:29]
      tagArray_1_11 <= 24'h0; // @[icache.scala 31:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        if (replace_set & _GEN_680) begin // @[icache.scala 84:50]
          tagArray_1_11 <= tag; // @[icache.scala 84:50]
        end
      end
    end
    if (reset) begin // @[icache.scala 31:29]
      tagArray_1_12 <= 24'h0; // @[icache.scala 31:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        if (replace_set & _GEN_688) begin // @[icache.scala 84:50]
          tagArray_1_12 <= tag; // @[icache.scala 84:50]
        end
      end
    end
    if (reset) begin // @[icache.scala 31:29]
      tagArray_1_13 <= 24'h0; // @[icache.scala 31:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        if (replace_set & _GEN_696) begin // @[icache.scala 84:50]
          tagArray_1_13 <= tag; // @[icache.scala 84:50]
        end
      end
    end
    if (reset) begin // @[icache.scala 31:29]
      tagArray_1_14 <= 24'h0; // @[icache.scala 31:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        if (replace_set & _GEN_704) begin // @[icache.scala 84:50]
          tagArray_1_14 <= tag; // @[icache.scala 84:50]
        end
      end
    end
    if (reset) begin // @[icache.scala 31:29]
      tagArray_1_15 <= 24'h0; // @[icache.scala 31:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        if (replace_set & _GEN_712) begin // @[icache.scala 84:50]
          tagArray_1_15 <= tag; // @[icache.scala 84:50]
        end
      end
    end
    if (reset) begin // @[icache.scala 32:29]
      validArray_0_0 <= 1'h0; // @[icache.scala 32:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        validArray_0_0 <= _GEN_205;
      end
    end
    if (reset) begin // @[icache.scala 32:29]
      validArray_0_1 <= 1'h0; // @[icache.scala 32:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        validArray_0_1 <= _GEN_206;
      end
    end
    if (reset) begin // @[icache.scala 32:29]
      validArray_0_2 <= 1'h0; // @[icache.scala 32:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        validArray_0_2 <= _GEN_207;
      end
    end
    if (reset) begin // @[icache.scala 32:29]
      validArray_0_3 <= 1'h0; // @[icache.scala 32:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        validArray_0_3 <= _GEN_208;
      end
    end
    if (reset) begin // @[icache.scala 32:29]
      validArray_0_4 <= 1'h0; // @[icache.scala 32:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        validArray_0_4 <= _GEN_209;
      end
    end
    if (reset) begin // @[icache.scala 32:29]
      validArray_0_5 <= 1'h0; // @[icache.scala 32:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        validArray_0_5 <= _GEN_210;
      end
    end
    if (reset) begin // @[icache.scala 32:29]
      validArray_0_6 <= 1'h0; // @[icache.scala 32:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        validArray_0_6 <= _GEN_211;
      end
    end
    if (reset) begin // @[icache.scala 32:29]
      validArray_0_7 <= 1'h0; // @[icache.scala 32:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        validArray_0_7 <= _GEN_212;
      end
    end
    if (reset) begin // @[icache.scala 32:29]
      validArray_0_8 <= 1'h0; // @[icache.scala 32:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        validArray_0_8 <= _GEN_213;
      end
    end
    if (reset) begin // @[icache.scala 32:29]
      validArray_0_9 <= 1'h0; // @[icache.scala 32:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        validArray_0_9 <= _GEN_214;
      end
    end
    if (reset) begin // @[icache.scala 32:29]
      validArray_0_10 <= 1'h0; // @[icache.scala 32:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        validArray_0_10 <= _GEN_215;
      end
    end
    if (reset) begin // @[icache.scala 32:29]
      validArray_0_11 <= 1'h0; // @[icache.scala 32:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        validArray_0_11 <= _GEN_216;
      end
    end
    if (reset) begin // @[icache.scala 32:29]
      validArray_0_12 <= 1'h0; // @[icache.scala 32:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        validArray_0_12 <= _GEN_217;
      end
    end
    if (reset) begin // @[icache.scala 32:29]
      validArray_0_13 <= 1'h0; // @[icache.scala 32:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        validArray_0_13 <= _GEN_218;
      end
    end
    if (reset) begin // @[icache.scala 32:29]
      validArray_0_14 <= 1'h0; // @[icache.scala 32:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        validArray_0_14 <= _GEN_219;
      end
    end
    if (reset) begin // @[icache.scala 32:29]
      validArray_0_15 <= 1'h0; // @[icache.scala 32:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        validArray_0_15 <= _GEN_220;
      end
    end
    if (reset) begin // @[icache.scala 32:29]
      validArray_1_0 <= 1'h0; // @[icache.scala 32:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        validArray_1_0 <= _GEN_221;
      end
    end
    if (reset) begin // @[icache.scala 32:29]
      validArray_1_1 <= 1'h0; // @[icache.scala 32:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        validArray_1_1 <= _GEN_222;
      end
    end
    if (reset) begin // @[icache.scala 32:29]
      validArray_1_2 <= 1'h0; // @[icache.scala 32:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        validArray_1_2 <= _GEN_223;
      end
    end
    if (reset) begin // @[icache.scala 32:29]
      validArray_1_3 <= 1'h0; // @[icache.scala 32:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        validArray_1_3 <= _GEN_224;
      end
    end
    if (reset) begin // @[icache.scala 32:29]
      validArray_1_4 <= 1'h0; // @[icache.scala 32:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        validArray_1_4 <= _GEN_225;
      end
    end
    if (reset) begin // @[icache.scala 32:29]
      validArray_1_5 <= 1'h0; // @[icache.scala 32:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        validArray_1_5 <= _GEN_226;
      end
    end
    if (reset) begin // @[icache.scala 32:29]
      validArray_1_6 <= 1'h0; // @[icache.scala 32:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        validArray_1_6 <= _GEN_227;
      end
    end
    if (reset) begin // @[icache.scala 32:29]
      validArray_1_7 <= 1'h0; // @[icache.scala 32:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        validArray_1_7 <= _GEN_228;
      end
    end
    if (reset) begin // @[icache.scala 32:29]
      validArray_1_8 <= 1'h0; // @[icache.scala 32:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        validArray_1_8 <= _GEN_229;
      end
    end
    if (reset) begin // @[icache.scala 32:29]
      validArray_1_9 <= 1'h0; // @[icache.scala 32:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        validArray_1_9 <= _GEN_230;
      end
    end
    if (reset) begin // @[icache.scala 32:29]
      validArray_1_10 <= 1'h0; // @[icache.scala 32:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        validArray_1_10 <= _GEN_231;
      end
    end
    if (reset) begin // @[icache.scala 32:29]
      validArray_1_11 <= 1'h0; // @[icache.scala 32:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        validArray_1_11 <= _GEN_232;
      end
    end
    if (reset) begin // @[icache.scala 32:29]
      validArray_1_12 <= 1'h0; // @[icache.scala 32:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        validArray_1_12 <= _GEN_233;
      end
    end
    if (reset) begin // @[icache.scala 32:29]
      validArray_1_13 <= 1'h0; // @[icache.scala 32:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        validArray_1_13 <= _GEN_234;
      end
    end
    if (reset) begin // @[icache.scala 32:29]
      validArray_1_14 <= 1'h0; // @[icache.scala 32:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        validArray_1_14 <= _GEN_235;
      end
    end
    if (reset) begin // @[icache.scala 32:29]
      validArray_1_15 <= 1'h0; // @[icache.scala 32:29]
    end else if (state_cache == 3'h3 & _off_T) begin // @[icache.scala 80:58]
      if (to_sram_r_bits_last) begin // @[icache.scala 82:35]
        validArray_1_15 <= _GEN_236;
      end
    end
    if (reset) begin // @[icache.scala 45:24]
      off <= 2'h0; // @[icache.scala 45:24]
    end else if (!(3'h0 == state_cache)) begin // @[icache.scala 49:26]
      if (!(3'h1 == state_cache)) begin // @[icache.scala 49:26]
        if (3'h2 == state_cache) begin // @[icache.scala 49:26]
          off <= 2'h0; // @[icache.scala 63:25]
        end else begin
          off <= _GEN_67;
        end
      end
    end
    if (reset) begin // @[icache.scala 48:30]
      state_cache <= 3'h0; // @[icache.scala 48:30]
    end else if (3'h0 == state_cache) begin // @[icache.scala 49:26]
      if (_T_1) begin // @[icache.scala 51:34]
        if (hit) begin // @[icache.scala 52:35]
          state_cache <= 3'h1;
        end else begin
          state_cache <= 3'h2;
        end
      end else begin
        state_cache <= 3'h0; // @[icache.scala 54:29]
      end
    end else if (3'h1 == state_cache) begin // @[icache.scala 49:26]
      state_cache <= 3'h0; // @[icache.scala 58:25]
    end else if (3'h2 == state_cache) begin // @[icache.scala 49:26]
      state_cache <= _state_cache_T_2; // @[icache.scala 62:25]
    end else begin
      state_cache <= _GEN_66;
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
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_0_0[initvar] = _RAND_0[31:0];
  _RAND_3 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_0_1[initvar] = _RAND_3[31:0];
  _RAND_6 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_0_2[initvar] = _RAND_6[31:0];
  _RAND_9 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_0_3[initvar] = _RAND_9[31:0];
  _RAND_12 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_1_0[initvar] = _RAND_12[31:0];
  _RAND_15 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_1_1[initvar] = _RAND_15[31:0];
  _RAND_18 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_1_2[initvar] = _RAND_18[31:0];
  _RAND_21 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_1_3[initvar] = _RAND_21[31:0];
  _RAND_24 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_2_0[initvar] = _RAND_24[31:0];
  _RAND_27 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_2_1[initvar] = _RAND_27[31:0];
  _RAND_30 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_2_2[initvar] = _RAND_30[31:0];
  _RAND_33 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_2_3[initvar] = _RAND_33[31:0];
  _RAND_36 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_3_0[initvar] = _RAND_36[31:0];
  _RAND_39 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_3_1[initvar] = _RAND_39[31:0];
  _RAND_42 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_3_2[initvar] = _RAND_42[31:0];
  _RAND_45 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_3_3[initvar] = _RAND_45[31:0];
  _RAND_48 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_4_0[initvar] = _RAND_48[31:0];
  _RAND_51 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_4_1[initvar] = _RAND_51[31:0];
  _RAND_54 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_4_2[initvar] = _RAND_54[31:0];
  _RAND_57 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_4_3[initvar] = _RAND_57[31:0];
  _RAND_60 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_5_0[initvar] = _RAND_60[31:0];
  _RAND_63 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_5_1[initvar] = _RAND_63[31:0];
  _RAND_66 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_5_2[initvar] = _RAND_66[31:0];
  _RAND_69 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_5_3[initvar] = _RAND_69[31:0];
  _RAND_72 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_6_0[initvar] = _RAND_72[31:0];
  _RAND_75 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_6_1[initvar] = _RAND_75[31:0];
  _RAND_78 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_6_2[initvar] = _RAND_78[31:0];
  _RAND_81 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_6_3[initvar] = _RAND_81[31:0];
  _RAND_84 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_7_0[initvar] = _RAND_84[31:0];
  _RAND_87 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_7_1[initvar] = _RAND_87[31:0];
  _RAND_90 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_7_2[initvar] = _RAND_90[31:0];
  _RAND_93 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_7_3[initvar] = _RAND_93[31:0];
  _RAND_96 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_8_0[initvar] = _RAND_96[31:0];
  _RAND_99 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_8_1[initvar] = _RAND_99[31:0];
  _RAND_102 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_8_2[initvar] = _RAND_102[31:0];
  _RAND_105 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_8_3[initvar] = _RAND_105[31:0];
  _RAND_108 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_9_0[initvar] = _RAND_108[31:0];
  _RAND_111 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_9_1[initvar] = _RAND_111[31:0];
  _RAND_114 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_9_2[initvar] = _RAND_114[31:0];
  _RAND_117 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_9_3[initvar] = _RAND_117[31:0];
  _RAND_120 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_10_0[initvar] = _RAND_120[31:0];
  _RAND_123 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_10_1[initvar] = _RAND_123[31:0];
  _RAND_126 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_10_2[initvar] = _RAND_126[31:0];
  _RAND_129 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_10_3[initvar] = _RAND_129[31:0];
  _RAND_132 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_11_0[initvar] = _RAND_132[31:0];
  _RAND_135 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_11_1[initvar] = _RAND_135[31:0];
  _RAND_138 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_11_2[initvar] = _RAND_138[31:0];
  _RAND_141 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_11_3[initvar] = _RAND_141[31:0];
  _RAND_144 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_12_0[initvar] = _RAND_144[31:0];
  _RAND_147 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_12_1[initvar] = _RAND_147[31:0];
  _RAND_150 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_12_2[initvar] = _RAND_150[31:0];
  _RAND_153 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_12_3[initvar] = _RAND_153[31:0];
  _RAND_156 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_13_0[initvar] = _RAND_156[31:0];
  _RAND_159 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_13_1[initvar] = _RAND_159[31:0];
  _RAND_162 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_13_2[initvar] = _RAND_162[31:0];
  _RAND_165 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_13_3[initvar] = _RAND_165[31:0];
  _RAND_168 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_14_0[initvar] = _RAND_168[31:0];
  _RAND_171 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_14_1[initvar] = _RAND_171[31:0];
  _RAND_174 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_14_2[initvar] = _RAND_174[31:0];
  _RAND_177 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_14_3[initvar] = _RAND_177[31:0];
  _RAND_180 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_15_0[initvar] = _RAND_180[31:0];
  _RAND_183 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_15_1[initvar] = _RAND_183[31:0];
  _RAND_186 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_15_2[initvar] = _RAND_186[31:0];
  _RAND_189 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_15_3[initvar] = _RAND_189[31:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  dataArray_0_0_cachedata_MPORT_en_pipe_0 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  dataArray_0_0_cachedata_MPORT_addr_pipe_0 = _RAND_2[0:0];
  _RAND_4 = {1{`RANDOM}};
  dataArray_0_1_cachedata_MPORT_en_pipe_0 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  dataArray_0_1_cachedata_MPORT_addr_pipe_0 = _RAND_5[0:0];
  _RAND_7 = {1{`RANDOM}};
  dataArray_0_2_cachedata_MPORT_en_pipe_0 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  dataArray_0_2_cachedata_MPORT_addr_pipe_0 = _RAND_8[0:0];
  _RAND_10 = {1{`RANDOM}};
  dataArray_0_3_cachedata_MPORT_en_pipe_0 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  dataArray_0_3_cachedata_MPORT_addr_pipe_0 = _RAND_11[0:0];
  _RAND_13 = {1{`RANDOM}};
  dataArray_1_0_cachedata_MPORT_en_pipe_0 = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  dataArray_1_0_cachedata_MPORT_addr_pipe_0 = _RAND_14[0:0];
  _RAND_16 = {1{`RANDOM}};
  dataArray_1_1_cachedata_MPORT_en_pipe_0 = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  dataArray_1_1_cachedata_MPORT_addr_pipe_0 = _RAND_17[0:0];
  _RAND_19 = {1{`RANDOM}};
  dataArray_1_2_cachedata_MPORT_en_pipe_0 = _RAND_19[0:0];
  _RAND_20 = {1{`RANDOM}};
  dataArray_1_2_cachedata_MPORT_addr_pipe_0 = _RAND_20[0:0];
  _RAND_22 = {1{`RANDOM}};
  dataArray_1_3_cachedata_MPORT_en_pipe_0 = _RAND_22[0:0];
  _RAND_23 = {1{`RANDOM}};
  dataArray_1_3_cachedata_MPORT_addr_pipe_0 = _RAND_23[0:0];
  _RAND_25 = {1{`RANDOM}};
  dataArray_2_0_cachedata_MPORT_en_pipe_0 = _RAND_25[0:0];
  _RAND_26 = {1{`RANDOM}};
  dataArray_2_0_cachedata_MPORT_addr_pipe_0 = _RAND_26[0:0];
  _RAND_28 = {1{`RANDOM}};
  dataArray_2_1_cachedata_MPORT_en_pipe_0 = _RAND_28[0:0];
  _RAND_29 = {1{`RANDOM}};
  dataArray_2_1_cachedata_MPORT_addr_pipe_0 = _RAND_29[0:0];
  _RAND_31 = {1{`RANDOM}};
  dataArray_2_2_cachedata_MPORT_en_pipe_0 = _RAND_31[0:0];
  _RAND_32 = {1{`RANDOM}};
  dataArray_2_2_cachedata_MPORT_addr_pipe_0 = _RAND_32[0:0];
  _RAND_34 = {1{`RANDOM}};
  dataArray_2_3_cachedata_MPORT_en_pipe_0 = _RAND_34[0:0];
  _RAND_35 = {1{`RANDOM}};
  dataArray_2_3_cachedata_MPORT_addr_pipe_0 = _RAND_35[0:0];
  _RAND_37 = {1{`RANDOM}};
  dataArray_3_0_cachedata_MPORT_en_pipe_0 = _RAND_37[0:0];
  _RAND_38 = {1{`RANDOM}};
  dataArray_3_0_cachedata_MPORT_addr_pipe_0 = _RAND_38[0:0];
  _RAND_40 = {1{`RANDOM}};
  dataArray_3_1_cachedata_MPORT_en_pipe_0 = _RAND_40[0:0];
  _RAND_41 = {1{`RANDOM}};
  dataArray_3_1_cachedata_MPORT_addr_pipe_0 = _RAND_41[0:0];
  _RAND_43 = {1{`RANDOM}};
  dataArray_3_2_cachedata_MPORT_en_pipe_0 = _RAND_43[0:0];
  _RAND_44 = {1{`RANDOM}};
  dataArray_3_2_cachedata_MPORT_addr_pipe_0 = _RAND_44[0:0];
  _RAND_46 = {1{`RANDOM}};
  dataArray_3_3_cachedata_MPORT_en_pipe_0 = _RAND_46[0:0];
  _RAND_47 = {1{`RANDOM}};
  dataArray_3_3_cachedata_MPORT_addr_pipe_0 = _RAND_47[0:0];
  _RAND_49 = {1{`RANDOM}};
  dataArray_4_0_cachedata_MPORT_en_pipe_0 = _RAND_49[0:0];
  _RAND_50 = {1{`RANDOM}};
  dataArray_4_0_cachedata_MPORT_addr_pipe_0 = _RAND_50[0:0];
  _RAND_52 = {1{`RANDOM}};
  dataArray_4_1_cachedata_MPORT_en_pipe_0 = _RAND_52[0:0];
  _RAND_53 = {1{`RANDOM}};
  dataArray_4_1_cachedata_MPORT_addr_pipe_0 = _RAND_53[0:0];
  _RAND_55 = {1{`RANDOM}};
  dataArray_4_2_cachedata_MPORT_en_pipe_0 = _RAND_55[0:0];
  _RAND_56 = {1{`RANDOM}};
  dataArray_4_2_cachedata_MPORT_addr_pipe_0 = _RAND_56[0:0];
  _RAND_58 = {1{`RANDOM}};
  dataArray_4_3_cachedata_MPORT_en_pipe_0 = _RAND_58[0:0];
  _RAND_59 = {1{`RANDOM}};
  dataArray_4_3_cachedata_MPORT_addr_pipe_0 = _RAND_59[0:0];
  _RAND_61 = {1{`RANDOM}};
  dataArray_5_0_cachedata_MPORT_en_pipe_0 = _RAND_61[0:0];
  _RAND_62 = {1{`RANDOM}};
  dataArray_5_0_cachedata_MPORT_addr_pipe_0 = _RAND_62[0:0];
  _RAND_64 = {1{`RANDOM}};
  dataArray_5_1_cachedata_MPORT_en_pipe_0 = _RAND_64[0:0];
  _RAND_65 = {1{`RANDOM}};
  dataArray_5_1_cachedata_MPORT_addr_pipe_0 = _RAND_65[0:0];
  _RAND_67 = {1{`RANDOM}};
  dataArray_5_2_cachedata_MPORT_en_pipe_0 = _RAND_67[0:0];
  _RAND_68 = {1{`RANDOM}};
  dataArray_5_2_cachedata_MPORT_addr_pipe_0 = _RAND_68[0:0];
  _RAND_70 = {1{`RANDOM}};
  dataArray_5_3_cachedata_MPORT_en_pipe_0 = _RAND_70[0:0];
  _RAND_71 = {1{`RANDOM}};
  dataArray_5_3_cachedata_MPORT_addr_pipe_0 = _RAND_71[0:0];
  _RAND_73 = {1{`RANDOM}};
  dataArray_6_0_cachedata_MPORT_en_pipe_0 = _RAND_73[0:0];
  _RAND_74 = {1{`RANDOM}};
  dataArray_6_0_cachedata_MPORT_addr_pipe_0 = _RAND_74[0:0];
  _RAND_76 = {1{`RANDOM}};
  dataArray_6_1_cachedata_MPORT_en_pipe_0 = _RAND_76[0:0];
  _RAND_77 = {1{`RANDOM}};
  dataArray_6_1_cachedata_MPORT_addr_pipe_0 = _RAND_77[0:0];
  _RAND_79 = {1{`RANDOM}};
  dataArray_6_2_cachedata_MPORT_en_pipe_0 = _RAND_79[0:0];
  _RAND_80 = {1{`RANDOM}};
  dataArray_6_2_cachedata_MPORT_addr_pipe_0 = _RAND_80[0:0];
  _RAND_82 = {1{`RANDOM}};
  dataArray_6_3_cachedata_MPORT_en_pipe_0 = _RAND_82[0:0];
  _RAND_83 = {1{`RANDOM}};
  dataArray_6_3_cachedata_MPORT_addr_pipe_0 = _RAND_83[0:0];
  _RAND_85 = {1{`RANDOM}};
  dataArray_7_0_cachedata_MPORT_en_pipe_0 = _RAND_85[0:0];
  _RAND_86 = {1{`RANDOM}};
  dataArray_7_0_cachedata_MPORT_addr_pipe_0 = _RAND_86[0:0];
  _RAND_88 = {1{`RANDOM}};
  dataArray_7_1_cachedata_MPORT_en_pipe_0 = _RAND_88[0:0];
  _RAND_89 = {1{`RANDOM}};
  dataArray_7_1_cachedata_MPORT_addr_pipe_0 = _RAND_89[0:0];
  _RAND_91 = {1{`RANDOM}};
  dataArray_7_2_cachedata_MPORT_en_pipe_0 = _RAND_91[0:0];
  _RAND_92 = {1{`RANDOM}};
  dataArray_7_2_cachedata_MPORT_addr_pipe_0 = _RAND_92[0:0];
  _RAND_94 = {1{`RANDOM}};
  dataArray_7_3_cachedata_MPORT_en_pipe_0 = _RAND_94[0:0];
  _RAND_95 = {1{`RANDOM}};
  dataArray_7_3_cachedata_MPORT_addr_pipe_0 = _RAND_95[0:0];
  _RAND_97 = {1{`RANDOM}};
  dataArray_8_0_cachedata_MPORT_en_pipe_0 = _RAND_97[0:0];
  _RAND_98 = {1{`RANDOM}};
  dataArray_8_0_cachedata_MPORT_addr_pipe_0 = _RAND_98[0:0];
  _RAND_100 = {1{`RANDOM}};
  dataArray_8_1_cachedata_MPORT_en_pipe_0 = _RAND_100[0:0];
  _RAND_101 = {1{`RANDOM}};
  dataArray_8_1_cachedata_MPORT_addr_pipe_0 = _RAND_101[0:0];
  _RAND_103 = {1{`RANDOM}};
  dataArray_8_2_cachedata_MPORT_en_pipe_0 = _RAND_103[0:0];
  _RAND_104 = {1{`RANDOM}};
  dataArray_8_2_cachedata_MPORT_addr_pipe_0 = _RAND_104[0:0];
  _RAND_106 = {1{`RANDOM}};
  dataArray_8_3_cachedata_MPORT_en_pipe_0 = _RAND_106[0:0];
  _RAND_107 = {1{`RANDOM}};
  dataArray_8_3_cachedata_MPORT_addr_pipe_0 = _RAND_107[0:0];
  _RAND_109 = {1{`RANDOM}};
  dataArray_9_0_cachedata_MPORT_en_pipe_0 = _RAND_109[0:0];
  _RAND_110 = {1{`RANDOM}};
  dataArray_9_0_cachedata_MPORT_addr_pipe_0 = _RAND_110[0:0];
  _RAND_112 = {1{`RANDOM}};
  dataArray_9_1_cachedata_MPORT_en_pipe_0 = _RAND_112[0:0];
  _RAND_113 = {1{`RANDOM}};
  dataArray_9_1_cachedata_MPORT_addr_pipe_0 = _RAND_113[0:0];
  _RAND_115 = {1{`RANDOM}};
  dataArray_9_2_cachedata_MPORT_en_pipe_0 = _RAND_115[0:0];
  _RAND_116 = {1{`RANDOM}};
  dataArray_9_2_cachedata_MPORT_addr_pipe_0 = _RAND_116[0:0];
  _RAND_118 = {1{`RANDOM}};
  dataArray_9_3_cachedata_MPORT_en_pipe_0 = _RAND_118[0:0];
  _RAND_119 = {1{`RANDOM}};
  dataArray_9_3_cachedata_MPORT_addr_pipe_0 = _RAND_119[0:0];
  _RAND_121 = {1{`RANDOM}};
  dataArray_10_0_cachedata_MPORT_en_pipe_0 = _RAND_121[0:0];
  _RAND_122 = {1{`RANDOM}};
  dataArray_10_0_cachedata_MPORT_addr_pipe_0 = _RAND_122[0:0];
  _RAND_124 = {1{`RANDOM}};
  dataArray_10_1_cachedata_MPORT_en_pipe_0 = _RAND_124[0:0];
  _RAND_125 = {1{`RANDOM}};
  dataArray_10_1_cachedata_MPORT_addr_pipe_0 = _RAND_125[0:0];
  _RAND_127 = {1{`RANDOM}};
  dataArray_10_2_cachedata_MPORT_en_pipe_0 = _RAND_127[0:0];
  _RAND_128 = {1{`RANDOM}};
  dataArray_10_2_cachedata_MPORT_addr_pipe_0 = _RAND_128[0:0];
  _RAND_130 = {1{`RANDOM}};
  dataArray_10_3_cachedata_MPORT_en_pipe_0 = _RAND_130[0:0];
  _RAND_131 = {1{`RANDOM}};
  dataArray_10_3_cachedata_MPORT_addr_pipe_0 = _RAND_131[0:0];
  _RAND_133 = {1{`RANDOM}};
  dataArray_11_0_cachedata_MPORT_en_pipe_0 = _RAND_133[0:0];
  _RAND_134 = {1{`RANDOM}};
  dataArray_11_0_cachedata_MPORT_addr_pipe_0 = _RAND_134[0:0];
  _RAND_136 = {1{`RANDOM}};
  dataArray_11_1_cachedata_MPORT_en_pipe_0 = _RAND_136[0:0];
  _RAND_137 = {1{`RANDOM}};
  dataArray_11_1_cachedata_MPORT_addr_pipe_0 = _RAND_137[0:0];
  _RAND_139 = {1{`RANDOM}};
  dataArray_11_2_cachedata_MPORT_en_pipe_0 = _RAND_139[0:0];
  _RAND_140 = {1{`RANDOM}};
  dataArray_11_2_cachedata_MPORT_addr_pipe_0 = _RAND_140[0:0];
  _RAND_142 = {1{`RANDOM}};
  dataArray_11_3_cachedata_MPORT_en_pipe_0 = _RAND_142[0:0];
  _RAND_143 = {1{`RANDOM}};
  dataArray_11_3_cachedata_MPORT_addr_pipe_0 = _RAND_143[0:0];
  _RAND_145 = {1{`RANDOM}};
  dataArray_12_0_cachedata_MPORT_en_pipe_0 = _RAND_145[0:0];
  _RAND_146 = {1{`RANDOM}};
  dataArray_12_0_cachedata_MPORT_addr_pipe_0 = _RAND_146[0:0];
  _RAND_148 = {1{`RANDOM}};
  dataArray_12_1_cachedata_MPORT_en_pipe_0 = _RAND_148[0:0];
  _RAND_149 = {1{`RANDOM}};
  dataArray_12_1_cachedata_MPORT_addr_pipe_0 = _RAND_149[0:0];
  _RAND_151 = {1{`RANDOM}};
  dataArray_12_2_cachedata_MPORT_en_pipe_0 = _RAND_151[0:0];
  _RAND_152 = {1{`RANDOM}};
  dataArray_12_2_cachedata_MPORT_addr_pipe_0 = _RAND_152[0:0];
  _RAND_154 = {1{`RANDOM}};
  dataArray_12_3_cachedata_MPORT_en_pipe_0 = _RAND_154[0:0];
  _RAND_155 = {1{`RANDOM}};
  dataArray_12_3_cachedata_MPORT_addr_pipe_0 = _RAND_155[0:0];
  _RAND_157 = {1{`RANDOM}};
  dataArray_13_0_cachedata_MPORT_en_pipe_0 = _RAND_157[0:0];
  _RAND_158 = {1{`RANDOM}};
  dataArray_13_0_cachedata_MPORT_addr_pipe_0 = _RAND_158[0:0];
  _RAND_160 = {1{`RANDOM}};
  dataArray_13_1_cachedata_MPORT_en_pipe_0 = _RAND_160[0:0];
  _RAND_161 = {1{`RANDOM}};
  dataArray_13_1_cachedata_MPORT_addr_pipe_0 = _RAND_161[0:0];
  _RAND_163 = {1{`RANDOM}};
  dataArray_13_2_cachedata_MPORT_en_pipe_0 = _RAND_163[0:0];
  _RAND_164 = {1{`RANDOM}};
  dataArray_13_2_cachedata_MPORT_addr_pipe_0 = _RAND_164[0:0];
  _RAND_166 = {1{`RANDOM}};
  dataArray_13_3_cachedata_MPORT_en_pipe_0 = _RAND_166[0:0];
  _RAND_167 = {1{`RANDOM}};
  dataArray_13_3_cachedata_MPORT_addr_pipe_0 = _RAND_167[0:0];
  _RAND_169 = {1{`RANDOM}};
  dataArray_14_0_cachedata_MPORT_en_pipe_0 = _RAND_169[0:0];
  _RAND_170 = {1{`RANDOM}};
  dataArray_14_0_cachedata_MPORT_addr_pipe_0 = _RAND_170[0:0];
  _RAND_172 = {1{`RANDOM}};
  dataArray_14_1_cachedata_MPORT_en_pipe_0 = _RAND_172[0:0];
  _RAND_173 = {1{`RANDOM}};
  dataArray_14_1_cachedata_MPORT_addr_pipe_0 = _RAND_173[0:0];
  _RAND_175 = {1{`RANDOM}};
  dataArray_14_2_cachedata_MPORT_en_pipe_0 = _RAND_175[0:0];
  _RAND_176 = {1{`RANDOM}};
  dataArray_14_2_cachedata_MPORT_addr_pipe_0 = _RAND_176[0:0];
  _RAND_178 = {1{`RANDOM}};
  dataArray_14_3_cachedata_MPORT_en_pipe_0 = _RAND_178[0:0];
  _RAND_179 = {1{`RANDOM}};
  dataArray_14_3_cachedata_MPORT_addr_pipe_0 = _RAND_179[0:0];
  _RAND_181 = {1{`RANDOM}};
  dataArray_15_0_cachedata_MPORT_en_pipe_0 = _RAND_181[0:0];
  _RAND_182 = {1{`RANDOM}};
  dataArray_15_0_cachedata_MPORT_addr_pipe_0 = _RAND_182[0:0];
  _RAND_184 = {1{`RANDOM}};
  dataArray_15_1_cachedata_MPORT_en_pipe_0 = _RAND_184[0:0];
  _RAND_185 = {1{`RANDOM}};
  dataArray_15_1_cachedata_MPORT_addr_pipe_0 = _RAND_185[0:0];
  _RAND_187 = {1{`RANDOM}};
  dataArray_15_2_cachedata_MPORT_en_pipe_0 = _RAND_187[0:0];
  _RAND_188 = {1{`RANDOM}};
  dataArray_15_2_cachedata_MPORT_addr_pipe_0 = _RAND_188[0:0];
  _RAND_190 = {1{`RANDOM}};
  dataArray_15_3_cachedata_MPORT_en_pipe_0 = _RAND_190[0:0];
  _RAND_191 = {1{`RANDOM}};
  dataArray_15_3_cachedata_MPORT_addr_pipe_0 = _RAND_191[0:0];
  _RAND_192 = {1{`RANDOM}};
  replace_set = _RAND_192[0:0];
  _RAND_193 = {1{`RANDOM}};
  random_num = _RAND_193[0:0];
  _RAND_194 = {1{`RANDOM}};
  tagArray_0_0 = _RAND_194[23:0];
  _RAND_195 = {1{`RANDOM}};
  tagArray_0_1 = _RAND_195[23:0];
  _RAND_196 = {1{`RANDOM}};
  tagArray_0_2 = _RAND_196[23:0];
  _RAND_197 = {1{`RANDOM}};
  tagArray_0_3 = _RAND_197[23:0];
  _RAND_198 = {1{`RANDOM}};
  tagArray_0_4 = _RAND_198[23:0];
  _RAND_199 = {1{`RANDOM}};
  tagArray_0_5 = _RAND_199[23:0];
  _RAND_200 = {1{`RANDOM}};
  tagArray_0_6 = _RAND_200[23:0];
  _RAND_201 = {1{`RANDOM}};
  tagArray_0_7 = _RAND_201[23:0];
  _RAND_202 = {1{`RANDOM}};
  tagArray_0_8 = _RAND_202[23:0];
  _RAND_203 = {1{`RANDOM}};
  tagArray_0_9 = _RAND_203[23:0];
  _RAND_204 = {1{`RANDOM}};
  tagArray_0_10 = _RAND_204[23:0];
  _RAND_205 = {1{`RANDOM}};
  tagArray_0_11 = _RAND_205[23:0];
  _RAND_206 = {1{`RANDOM}};
  tagArray_0_12 = _RAND_206[23:0];
  _RAND_207 = {1{`RANDOM}};
  tagArray_0_13 = _RAND_207[23:0];
  _RAND_208 = {1{`RANDOM}};
  tagArray_0_14 = _RAND_208[23:0];
  _RAND_209 = {1{`RANDOM}};
  tagArray_0_15 = _RAND_209[23:0];
  _RAND_210 = {1{`RANDOM}};
  tagArray_1_0 = _RAND_210[23:0];
  _RAND_211 = {1{`RANDOM}};
  tagArray_1_1 = _RAND_211[23:0];
  _RAND_212 = {1{`RANDOM}};
  tagArray_1_2 = _RAND_212[23:0];
  _RAND_213 = {1{`RANDOM}};
  tagArray_1_3 = _RAND_213[23:0];
  _RAND_214 = {1{`RANDOM}};
  tagArray_1_4 = _RAND_214[23:0];
  _RAND_215 = {1{`RANDOM}};
  tagArray_1_5 = _RAND_215[23:0];
  _RAND_216 = {1{`RANDOM}};
  tagArray_1_6 = _RAND_216[23:0];
  _RAND_217 = {1{`RANDOM}};
  tagArray_1_7 = _RAND_217[23:0];
  _RAND_218 = {1{`RANDOM}};
  tagArray_1_8 = _RAND_218[23:0];
  _RAND_219 = {1{`RANDOM}};
  tagArray_1_9 = _RAND_219[23:0];
  _RAND_220 = {1{`RANDOM}};
  tagArray_1_10 = _RAND_220[23:0];
  _RAND_221 = {1{`RANDOM}};
  tagArray_1_11 = _RAND_221[23:0];
  _RAND_222 = {1{`RANDOM}};
  tagArray_1_12 = _RAND_222[23:0];
  _RAND_223 = {1{`RANDOM}};
  tagArray_1_13 = _RAND_223[23:0];
  _RAND_224 = {1{`RANDOM}};
  tagArray_1_14 = _RAND_224[23:0];
  _RAND_225 = {1{`RANDOM}};
  tagArray_1_15 = _RAND_225[23:0];
  _RAND_226 = {1{`RANDOM}};
  validArray_0_0 = _RAND_226[0:0];
  _RAND_227 = {1{`RANDOM}};
  validArray_0_1 = _RAND_227[0:0];
  _RAND_228 = {1{`RANDOM}};
  validArray_0_2 = _RAND_228[0:0];
  _RAND_229 = {1{`RANDOM}};
  validArray_0_3 = _RAND_229[0:0];
  _RAND_230 = {1{`RANDOM}};
  validArray_0_4 = _RAND_230[0:0];
  _RAND_231 = {1{`RANDOM}};
  validArray_0_5 = _RAND_231[0:0];
  _RAND_232 = {1{`RANDOM}};
  validArray_0_6 = _RAND_232[0:0];
  _RAND_233 = {1{`RANDOM}};
  validArray_0_7 = _RAND_233[0:0];
  _RAND_234 = {1{`RANDOM}};
  validArray_0_8 = _RAND_234[0:0];
  _RAND_235 = {1{`RANDOM}};
  validArray_0_9 = _RAND_235[0:0];
  _RAND_236 = {1{`RANDOM}};
  validArray_0_10 = _RAND_236[0:0];
  _RAND_237 = {1{`RANDOM}};
  validArray_0_11 = _RAND_237[0:0];
  _RAND_238 = {1{`RANDOM}};
  validArray_0_12 = _RAND_238[0:0];
  _RAND_239 = {1{`RANDOM}};
  validArray_0_13 = _RAND_239[0:0];
  _RAND_240 = {1{`RANDOM}};
  validArray_0_14 = _RAND_240[0:0];
  _RAND_241 = {1{`RANDOM}};
  validArray_0_15 = _RAND_241[0:0];
  _RAND_242 = {1{`RANDOM}};
  validArray_1_0 = _RAND_242[0:0];
  _RAND_243 = {1{`RANDOM}};
  validArray_1_1 = _RAND_243[0:0];
  _RAND_244 = {1{`RANDOM}};
  validArray_1_2 = _RAND_244[0:0];
  _RAND_245 = {1{`RANDOM}};
  validArray_1_3 = _RAND_245[0:0];
  _RAND_246 = {1{`RANDOM}};
  validArray_1_4 = _RAND_246[0:0];
  _RAND_247 = {1{`RANDOM}};
  validArray_1_5 = _RAND_247[0:0];
  _RAND_248 = {1{`RANDOM}};
  validArray_1_6 = _RAND_248[0:0];
  _RAND_249 = {1{`RANDOM}};
  validArray_1_7 = _RAND_249[0:0];
  _RAND_250 = {1{`RANDOM}};
  validArray_1_8 = _RAND_250[0:0];
  _RAND_251 = {1{`RANDOM}};
  validArray_1_9 = _RAND_251[0:0];
  _RAND_252 = {1{`RANDOM}};
  validArray_1_10 = _RAND_252[0:0];
  _RAND_253 = {1{`RANDOM}};
  validArray_1_11 = _RAND_253[0:0];
  _RAND_254 = {1{`RANDOM}};
  validArray_1_12 = _RAND_254[0:0];
  _RAND_255 = {1{`RANDOM}};
  validArray_1_13 = _RAND_255[0:0];
  _RAND_256 = {1{`RANDOM}};
  validArray_1_14 = _RAND_256[0:0];
  _RAND_257 = {1{`RANDOM}};
  validArray_1_15 = _RAND_257[0:0];
  _RAND_258 = {1{`RANDOM}};
  off = _RAND_258[1:0];
  _RAND_259 = {1{`RANDOM}};
  state_cache = _RAND_259[2:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module sram_axi_rw(
  input         clock,
  input         reset,
  output        axi_ar_ready,
  input         axi_ar_valid,
  input  [31:0] axi_ar_bits_addr,
  input  [7:0]  axi_ar_bits_len,
  input         axi_r_ready,
  output        axi_r_valid,
  output [31:0] axi_r_bits_data,
  output        axi_r_bits_last,
  output        axi_aw_ready,
  input         axi_aw_valid,
  input  [31:0] axi_aw_bits_addr,
  output        axi_w_ready,
  input         axi_w_valid,
  input  [31:0] axi_w_bits_data,
  input  [3:0]  axi_w_bits_strb,
  output        axi_b_valid
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  wire  RamBB_i1_clock; // @[sram_Axi.scala 155:26]
  wire [31:0] RamBB_i1_addr; // @[sram_Axi.scala 155:26]
  wire  RamBB_i1_mem_wen; // @[sram_Axi.scala 155:26]
  wire  RamBB_i1_valid; // @[sram_Axi.scala 155:26]
  wire [31:0] RamBB_i1_wdata; // @[sram_Axi.scala 155:26]
  wire [3:0] RamBB_i1_wmask; // @[sram_Axi.scala 155:26]
  wire [31:0] RamBB_i1_rdata; // @[sram_Axi.scala 155:26]
  reg  delay; // @[sram_Axi.scala 89:24]
  reg [7:0] reg_AxLen; // @[sram_Axi.scala 92:28]
  reg [31:0] reg_addr; // @[sram_Axi.scala 93:28]
  reg [1:0] reg_burst; // @[sram_Axi.scala 94:28]
  reg [2:0] state_sram; // @[sram_Axi.scala 98:29]
  wire  _T_1 = axi_ar_ready & axi_ar_valid; // @[Decoupled.scala 51:35]
  wire  _T_2 = axi_aw_ready & axi_aw_valid; // @[Decoupled.scala 51:35]
  wire  _T_4 = ~delay; // @[sram_Axi.scala 118:25]
  wire  _state_sram_T = reg_AxLen == 8'h0; // @[sram_Axi.scala 119:45]
  wire [2:0] _state_sram_T_1 = reg_AxLen == 8'h0 ? 3'h3 : 3'h2; // @[sram_Axi.scala 119:34]
  wire  _delay_T_1 = delay - 1'h1; // @[sram_Axi.scala 123:28]
  wire  _T_5 = 3'h2 == state_sram; // @[sram_Axi.scala 99:25]
  wire  _state_sram_T_2 = reg_AxLen == 8'h1; // @[sram_Axi.scala 126:42]
  wire [2:0] _state_sram_T_3 = reg_AxLen == 8'h1 ? 3'h3 : 3'h2; // @[sram_Axi.scala 126:31]
  wire  _reg_AxLen_T = axi_r_ready & axi_r_valid; // @[Decoupled.scala 51:35]
  wire [7:0] _reg_AxLen_T_2 = reg_AxLen - 8'h1; // @[sram_Axi.scala 127:53]
  wire [7:0] _reg_AxLen_T_3 = _reg_AxLen_T ? _reg_AxLen_T_2 : reg_AxLen; // @[sram_Axi.scala 127:31]
  wire [31:0] _reg_addr_T_2 = reg_addr + 32'h4; // @[sram_Axi.scala 129:53]
  wire [31:0] _reg_addr_T_3 = _reg_AxLen_T ? _reg_addr_T_2 : reg_addr; // @[sram_Axi.scala 129:30]
  wire [31:0] _reg_addr_T_5 = 2'h1 == reg_burst ? _reg_addr_T_3 : reg_addr; // @[Mux.scala 81:58]
  wire  _T_6 = 3'h3 == state_sram; // @[sram_Axi.scala 99:25]
  wire [2:0] _state_sram_T_5 = _state_sram_T ? 3'h6 : 3'h5; // @[sram_Axi.scala 137:34]
  wire [2:0] _GEN_9 = _T_4 ? _state_sram_T_5 : 3'h4; // @[sram_Axi.scala 136:34 137:28 139:28]
  wire  _T_9 = 3'h5 == state_sram; // @[sram_Axi.scala 99:25]
  wire [2:0] _state_sram_T_7 = _state_sram_T_2 ? 3'h6 : 3'h5; // @[sram_Axi.scala 144:31]
  wire  _reg_AxLen_T_4 = axi_w_ready & axi_w_valid; // @[Decoupled.scala 51:35]
  wire [7:0] _reg_AxLen_T_7 = _reg_AxLen_T_4 ? _reg_AxLen_T_2 : reg_AxLen; // @[sram_Axi.scala 145:31]
  wire [31:0] _reg_addr_T_9 = _reg_AxLen_T_4 ? _reg_addr_T_2 : reg_addr; // @[sram_Axi.scala 147:30]
  wire [31:0] _reg_addr_T_11 = 2'h1 == reg_burst ? _reg_addr_T_9 : reg_addr; // @[Mux.scala 81:58]
  wire  _T_10 = 3'h6 == state_sram; // @[sram_Axi.scala 99:25]
  wire [2:0] _GEN_10 = 3'h6 == state_sram ? 3'h0 : state_sram; // @[sram_Axi.scala 151:24 99:25 98:29]
  wire [2:0] _GEN_11 = 3'h5 == state_sram ? _state_sram_T_7 : _GEN_10; // @[sram_Axi.scala 144:25 99:25]
  wire [7:0] _GEN_12 = 3'h5 == state_sram ? _reg_AxLen_T_7 : reg_AxLen; // @[sram_Axi.scala 145:25 99:25 92:28]
  wire [31:0] _GEN_13 = 3'h5 == state_sram ? _reg_addr_T_11 : reg_addr; // @[sram_Axi.scala 146:25 99:25 93:28]
  wire [2:0] _GEN_14 = 3'h4 == state_sram ? _GEN_9 : _GEN_11; // @[sram_Axi.scala 99:25]
  wire  _GEN_15 = 3'h4 == state_sram ? _delay_T_1 : delay; // @[sram_Axi.scala 141:19 89:24 99:25]
  wire [7:0] _GEN_16 = 3'h4 == state_sram ? reg_AxLen : _GEN_12; // @[sram_Axi.scala 99:25 92:28]
  wire [31:0] _GEN_17 = 3'h4 == state_sram ? reg_addr : _GEN_13; // @[sram_Axi.scala 99:25 93:28]
  wire [2:0] _GEN_18 = 3'h3 == state_sram ? 3'h0 : _GEN_14; // @[sram_Axi.scala 133:24 99:25]
  wire  _GEN_19 = 3'h3 == state_sram ? delay : _GEN_15; // @[sram_Axi.scala 89:24 99:25]
  wire [7:0] _GEN_20 = 3'h3 == state_sram ? reg_AxLen : _GEN_16; // @[sram_Axi.scala 99:25 92:28]
  wire [31:0] _GEN_21 = 3'h3 == state_sram ? reg_addr : _GEN_17; // @[sram_Axi.scala 99:25 93:28]
  RamBB RamBB_i1 ( // @[sram_Axi.scala 155:26]
    .clock(RamBB_i1_clock),
    .addr(RamBB_i1_addr),
    .mem_wen(RamBB_i1_mem_wen),
    .valid(RamBB_i1_valid),
    .wdata(RamBB_i1_wdata),
    .wmask(RamBB_i1_wmask),
    .rdata(RamBB_i1_rdata)
  );
  assign axi_ar_ready = 3'h0 == state_sram; // @[Mux.scala 81:61]
  assign axi_r_valid = _T_6 | _T_5; // @[Mux.scala 81:58]
  assign axi_r_bits_data = RamBB_i1_rdata; // @[sram_Axi.scala 174:21]
  assign axi_r_bits_last = state_sram == 3'h3; // @[sram_Axi.scala 176:39]
  assign axi_aw_ready = 3'h0 == state_sram; // @[Mux.scala 81:61]
  assign axi_w_ready = _T_10 | _T_9; // @[Mux.scala 81:58]
  assign axi_b_valid = 3'h6 == state_sram; // @[Mux.scala 81:61]
  assign RamBB_i1_clock = clock; // @[sram_Axi.scala 156:25]
  assign RamBB_i1_addr = reg_addr; // @[sram_Axi.scala 157:25]
  assign RamBB_i1_mem_wen = _T_10 | _T_9; // @[Mux.scala 81:58]
  assign RamBB_i1_valid = _T_10 | (_T_9 | (_T_6 | _T_5)); // @[Mux.scala 81:58]
  assign RamBB_i1_wdata = axi_w_bits_data; // @[sram_Axi.scala 168:25]
  assign RamBB_i1_wmask = axi_w_bits_strb; // @[sram_Axi.scala 169:25]
  always @(posedge clock) begin
    if (reset) begin // @[sram_Axi.scala 89:24]
      delay <= 1'h0; // @[sram_Axi.scala 89:24]
    end else if (3'h0 == state_sram) begin // @[sram_Axi.scala 99:25]
      delay <= 1'h0; // @[sram_Axi.scala 101:19]
    end else if (3'h1 == state_sram) begin // @[sram_Axi.scala 99:25]
      delay <= delay - 1'h1; // @[sram_Axi.scala 123:19]
    end else if (!(3'h2 == state_sram)) begin // @[sram_Axi.scala 99:25]
      delay <= _GEN_19;
    end
    if (reset) begin // @[sram_Axi.scala 92:28]
      reg_AxLen <= 8'h0; // @[sram_Axi.scala 92:28]
    end else if (3'h0 == state_sram) begin // @[sram_Axi.scala 99:25]
      if (_T_1) begin // @[sram_Axi.scala 103:32]
        reg_AxLen <= axi_ar_bits_len; // @[sram_Axi.scala 105:28]
      end else if (_T_2) begin // @[sram_Axi.scala 108:39]
        reg_AxLen <= 8'h0; // @[sram_Axi.scala 110:28]
      end
    end else if (!(3'h1 == state_sram)) begin // @[sram_Axi.scala 99:25]
      if (3'h2 == state_sram) begin // @[sram_Axi.scala 99:25]
        reg_AxLen <= _reg_AxLen_T_3; // @[sram_Axi.scala 127:25]
      end else begin
        reg_AxLen <= _GEN_20;
      end
    end
    if (reset) begin // @[sram_Axi.scala 93:28]
      reg_addr <= 32'h0; // @[sram_Axi.scala 93:28]
    end else if (3'h0 == state_sram) begin // @[sram_Axi.scala 99:25]
      if (_T_1) begin // @[sram_Axi.scala 103:32]
        reg_addr <= axi_ar_bits_addr; // @[sram_Axi.scala 106:28]
      end else if (_T_2) begin // @[sram_Axi.scala 108:39]
        reg_addr <= axi_aw_bits_addr; // @[sram_Axi.scala 111:28]
      end
    end else if (!(3'h1 == state_sram)) begin // @[sram_Axi.scala 99:25]
      if (3'h2 == state_sram) begin // @[sram_Axi.scala 99:25]
        reg_addr <= _reg_addr_T_5; // @[sram_Axi.scala 128:25]
      end else begin
        reg_addr <= _GEN_21;
      end
    end
    if (reset) begin // @[sram_Axi.scala 94:28]
      reg_burst <= 2'h3; // @[sram_Axi.scala 94:28]
    end else if (3'h0 == state_sram) begin // @[sram_Axi.scala 99:25]
      if (_T_1) begin // @[sram_Axi.scala 103:32]
        reg_burst <= 2'h1; // @[sram_Axi.scala 107:28]
      end else if (_T_2) begin // @[sram_Axi.scala 108:39]
        reg_burst <= 2'h0; // @[sram_Axi.scala 112:28]
      end
    end
    if (reset) begin // @[sram_Axi.scala 98:29]
      state_sram <= 3'h0; // @[sram_Axi.scala 98:29]
    end else if (3'h0 == state_sram) begin // @[sram_Axi.scala 99:25]
      if (_T_1) begin // @[sram_Axi.scala 103:32]
        state_sram <= 3'h1; // @[sram_Axi.scala 104:28]
      end else if (_T_2) begin // @[sram_Axi.scala 108:39]
        state_sram <= 3'h4; // @[sram_Axi.scala 109:28]
      end else begin
        state_sram <= 3'h0; // @[sram_Axi.scala 114:28]
      end
    end else if (3'h1 == state_sram) begin // @[sram_Axi.scala 99:25]
      if (~delay) begin // @[sram_Axi.scala 118:34]
        state_sram <= _state_sram_T_1; // @[sram_Axi.scala 119:28]
      end else begin
        state_sram <= 3'h1; // @[sram_Axi.scala 121:28]
      end
    end else if (3'h2 == state_sram) begin // @[sram_Axi.scala 99:25]
      state_sram <= _state_sram_T_3; // @[sram_Axi.scala 126:25]
    end else begin
      state_sram <= _GEN_18;
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
  delay = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  reg_AxLen = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  reg_addr = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  reg_burst = _RAND_3[1:0];
  _RAND_4 = {1{`RANDOM}};
  state_sram = _RAND_4[2:0];
`endif // RANDOMIZE_REG_INIT
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
  output [31:0] io_out_pc,
  output [31:0] io_out_difftest_mcause,
  output [31:0] io_out_difftest_mepc,
  output [31:0] io_out_difftest_mstatus,
  output [31:0] io_out_difftest_mtvec,
  output        io_out_wb
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
`endif // RANDOMIZE_REG_INIT
  wire  IDU_i_from_IFU_valid; // @[core.scala 34:27]
  wire [31:0] IDU_i_from_IFU_bits_inst; // @[core.scala 34:27]
  wire [31:0] IDU_i_from_IFU_bits_pc; // @[core.scala 34:27]
  wire  IDU_i_to_ISU_valid; // @[core.scala 34:27]
  wire [31:0] IDU_i_to_ISU_bits_imm; // @[core.scala 34:27]
  wire [31:0] IDU_i_to_ISU_bits_pc; // @[core.scala 34:27]
  wire [4:0] IDU_i_to_ISU_bits_rs1; // @[core.scala 34:27]
  wire [4:0] IDU_i_to_ISU_bits_rs2; // @[core.scala 34:27]
  wire [4:0] IDU_i_to_ISU_bits_rd; // @[core.scala 34:27]
  wire  IDU_i_to_ISU_bits_ctrl_sig_reg_wen; // @[core.scala 34:27]
  wire [2:0] IDU_i_to_ISU_bits_ctrl_sig_fu_op; // @[core.scala 34:27]
  wire  IDU_i_to_ISU_bits_ctrl_sig_mem_wen; // @[core.scala 34:27]
  wire  IDU_i_to_ISU_bits_ctrl_sig_is_ebreak; // @[core.scala 34:27]
  wire  IDU_i_to_ISU_bits_ctrl_sig_not_impl; // @[core.scala 34:27]
  wire [1:0] IDU_i_to_ISU_bits_ctrl_sig_src1_op; // @[core.scala 34:27]
  wire [1:0] IDU_i_to_ISU_bits_ctrl_sig_src2_op; // @[core.scala 34:27]
  wire [3:0] IDU_i_to_ISU_bits_ctrl_sig_alu_op; // @[core.scala 34:27]
  wire [3:0] IDU_i_to_ISU_bits_ctrl_sig_lsu_op; // @[core.scala 34:27]
  wire [3:0] IDU_i_to_ISU_bits_ctrl_sig_bru_op; // @[core.scala 34:27]
  wire [2:0] IDU_i_to_ISU_bits_ctrl_sig_csr_op; // @[core.scala 34:27]
  wire [3:0] IDU_i_to_ISU_bits_ctrl_sig_mdu_op; // @[core.scala 34:27]
  wire  ISU_i_clock; // @[core.scala 35:27]
  wire  ISU_i_reset; // @[core.scala 35:27]
  wire  ISU_i_from_IDU_valid; // @[core.scala 35:27]
  wire [31:0] ISU_i_from_IDU_bits_imm; // @[core.scala 35:27]
  wire [31:0] ISU_i_from_IDU_bits_pc; // @[core.scala 35:27]
  wire [4:0] ISU_i_from_IDU_bits_rs1; // @[core.scala 35:27]
  wire [4:0] ISU_i_from_IDU_bits_rs2; // @[core.scala 35:27]
  wire [4:0] ISU_i_from_IDU_bits_rd; // @[core.scala 35:27]
  wire  ISU_i_from_IDU_bits_ctrl_sig_reg_wen; // @[core.scala 35:27]
  wire [2:0] ISU_i_from_IDU_bits_ctrl_sig_fu_op; // @[core.scala 35:27]
  wire  ISU_i_from_IDU_bits_ctrl_sig_mem_wen; // @[core.scala 35:27]
  wire  ISU_i_from_IDU_bits_ctrl_sig_is_ebreak; // @[core.scala 35:27]
  wire  ISU_i_from_IDU_bits_ctrl_sig_not_impl; // @[core.scala 35:27]
  wire [1:0] ISU_i_from_IDU_bits_ctrl_sig_src1_op; // @[core.scala 35:27]
  wire [1:0] ISU_i_from_IDU_bits_ctrl_sig_src2_op; // @[core.scala 35:27]
  wire [3:0] ISU_i_from_IDU_bits_ctrl_sig_alu_op; // @[core.scala 35:27]
  wire [3:0] ISU_i_from_IDU_bits_ctrl_sig_lsu_op; // @[core.scala 35:27]
  wire [3:0] ISU_i_from_IDU_bits_ctrl_sig_bru_op; // @[core.scala 35:27]
  wire [2:0] ISU_i_from_IDU_bits_ctrl_sig_csr_op; // @[core.scala 35:27]
  wire [3:0] ISU_i_from_IDU_bits_ctrl_sig_mdu_op; // @[core.scala 35:27]
  wire  ISU_i_from_WBU_bits_reg_wen; // @[core.scala 35:27]
  wire [31:0] ISU_i_from_WBU_bits_wdata; // @[core.scala 35:27]
  wire [4:0] ISU_i_from_WBU_bits_rd; // @[core.scala 35:27]
  wire  ISU_i_to_EXU_valid; // @[core.scala 35:27]
  wire [31:0] ISU_i_to_EXU_bits_imm; // @[core.scala 35:27]
  wire [31:0] ISU_i_to_EXU_bits_pc; // @[core.scala 35:27]
  wire [31:0] ISU_i_to_EXU_bits_rdata1; // @[core.scala 35:27]
  wire [31:0] ISU_i_to_EXU_bits_rdata2; // @[core.scala 35:27]
  wire [4:0] ISU_i_to_EXU_bits_rd; // @[core.scala 35:27]
  wire  ISU_i_to_EXU_bits_ctrl_sig_reg_wen; // @[core.scala 35:27]
  wire [2:0] ISU_i_to_EXU_bits_ctrl_sig_fu_op; // @[core.scala 35:27]
  wire  ISU_i_to_EXU_bits_ctrl_sig_mem_wen; // @[core.scala 35:27]
  wire  ISU_i_to_EXU_bits_ctrl_sig_is_ebreak; // @[core.scala 35:27]
  wire  ISU_i_to_EXU_bits_ctrl_sig_not_impl; // @[core.scala 35:27]
  wire [1:0] ISU_i_to_EXU_bits_ctrl_sig_src1_op; // @[core.scala 35:27]
  wire [1:0] ISU_i_to_EXU_bits_ctrl_sig_src2_op; // @[core.scala 35:27]
  wire [3:0] ISU_i_to_EXU_bits_ctrl_sig_alu_op; // @[core.scala 35:27]
  wire [3:0] ISU_i_to_EXU_bits_ctrl_sig_lsu_op; // @[core.scala 35:27]
  wire [3:0] ISU_i_to_EXU_bits_ctrl_sig_bru_op; // @[core.scala 35:27]
  wire [2:0] ISU_i_to_EXU_bits_ctrl_sig_csr_op; // @[core.scala 35:27]
  wire [3:0] ISU_i_to_EXU_bits_ctrl_sig_mdu_op; // @[core.scala 35:27]
  wire  EXU_i_clock; // @[core.scala 36:27]
  wire  EXU_i_reset; // @[core.scala 36:27]
  wire  EXU_i_from_ISU_ready; // @[core.scala 36:27]
  wire  EXU_i_from_ISU_valid; // @[core.scala 36:27]
  wire [31:0] EXU_i_from_ISU_bits_imm; // @[core.scala 36:27]
  wire [31:0] EXU_i_from_ISU_bits_pc; // @[core.scala 36:27]
  wire [31:0] EXU_i_from_ISU_bits_rdata1; // @[core.scala 36:27]
  wire [31:0] EXU_i_from_ISU_bits_rdata2; // @[core.scala 36:27]
  wire [4:0] EXU_i_from_ISU_bits_rd; // @[core.scala 36:27]
  wire  EXU_i_from_ISU_bits_ctrl_sig_reg_wen; // @[core.scala 36:27]
  wire [2:0] EXU_i_from_ISU_bits_ctrl_sig_fu_op; // @[core.scala 36:27]
  wire  EXU_i_from_ISU_bits_ctrl_sig_mem_wen; // @[core.scala 36:27]
  wire  EXU_i_from_ISU_bits_ctrl_sig_is_ebreak; // @[core.scala 36:27]
  wire  EXU_i_from_ISU_bits_ctrl_sig_not_impl; // @[core.scala 36:27]
  wire [1:0] EXU_i_from_ISU_bits_ctrl_sig_src1_op; // @[core.scala 36:27]
  wire [1:0] EXU_i_from_ISU_bits_ctrl_sig_src2_op; // @[core.scala 36:27]
  wire [3:0] EXU_i_from_ISU_bits_ctrl_sig_alu_op; // @[core.scala 36:27]
  wire [3:0] EXU_i_from_ISU_bits_ctrl_sig_lsu_op; // @[core.scala 36:27]
  wire [3:0] EXU_i_from_ISU_bits_ctrl_sig_bru_op; // @[core.scala 36:27]
  wire [2:0] EXU_i_from_ISU_bits_ctrl_sig_csr_op; // @[core.scala 36:27]
  wire [3:0] EXU_i_from_ISU_bits_ctrl_sig_mdu_op; // @[core.scala 36:27]
  wire  EXU_i_to_WBU_valid; // @[core.scala 36:27]
  wire [31:0] EXU_i_to_WBU_bits_alu_result; // @[core.scala 36:27]
  wire [31:0] EXU_i_to_WBU_bits_mdu_result; // @[core.scala 36:27]
  wire [31:0] EXU_i_to_WBU_bits_lsu_rdata; // @[core.scala 36:27]
  wire [31:0] EXU_i_to_WBU_bits_csr_rdata; // @[core.scala 36:27]
  wire [31:0] EXU_i_to_WBU_bits_pc; // @[core.scala 36:27]
  wire  EXU_i_to_WBU_bits_reg_wen; // @[core.scala 36:27]
  wire [4:0] EXU_i_to_WBU_bits_rd; // @[core.scala 36:27]
  wire [2:0] EXU_i_to_WBU_bits_fu_op; // @[core.scala 36:27]
  wire  EXU_i_to_IFU_bits_bru_ctrl_br; // @[core.scala 36:27]
  wire [31:0] EXU_i_to_IFU_bits_bru_addr; // @[core.scala 36:27]
  wire  EXU_i_to_IFU_bits_csr_ctrl_br; // @[core.scala 36:27]
  wire [31:0] EXU_i_to_IFU_bits_csr_addr; // @[core.scala 36:27]
  wire [31:0] EXU_i_difftest_mcause; // @[core.scala 36:27]
  wire [31:0] EXU_i_difftest_mepc; // @[core.scala 36:27]
  wire [31:0] EXU_i_difftest_mstatus; // @[core.scala 36:27]
  wire [31:0] EXU_i_difftest_mtvec; // @[core.scala 36:27]
  wire  EXU_i_lsu_axi_master_ar_ready; // @[core.scala 36:27]
  wire  EXU_i_lsu_axi_master_ar_valid; // @[core.scala 36:27]
  wire [31:0] EXU_i_lsu_axi_master_ar_bits_addr; // @[core.scala 36:27]
  wire  EXU_i_lsu_axi_master_r_ready; // @[core.scala 36:27]
  wire  EXU_i_lsu_axi_master_r_valid; // @[core.scala 36:27]
  wire [31:0] EXU_i_lsu_axi_master_r_bits_data; // @[core.scala 36:27]
  wire  EXU_i_lsu_axi_master_aw_ready; // @[core.scala 36:27]
  wire  EXU_i_lsu_axi_master_aw_valid; // @[core.scala 36:27]
  wire [31:0] EXU_i_lsu_axi_master_aw_bits_addr; // @[core.scala 36:27]
  wire  EXU_i_lsu_axi_master_w_valid; // @[core.scala 36:27]
  wire [31:0] EXU_i_lsu_axi_master_w_bits_data; // @[core.scala 36:27]
  wire [3:0] EXU_i_lsu_axi_master_w_bits_strb; // @[core.scala 36:27]
  wire  EXU_i_lsu_axi_master_b_valid; // @[core.scala 36:27]
  wire  WBU_i_from_EXU_ready; // @[core.scala 37:27]
  wire  WBU_i_from_EXU_valid; // @[core.scala 37:27]
  wire [31:0] WBU_i_from_EXU_bits_alu_result; // @[core.scala 37:27]
  wire [31:0] WBU_i_from_EXU_bits_mdu_result; // @[core.scala 37:27]
  wire [31:0] WBU_i_from_EXU_bits_lsu_rdata; // @[core.scala 37:27]
  wire [31:0] WBU_i_from_EXU_bits_csr_rdata; // @[core.scala 37:27]
  wire [31:0] WBU_i_from_EXU_bits_pc; // @[core.scala 37:27]
  wire  WBU_i_from_EXU_bits_reg_wen; // @[core.scala 37:27]
  wire [4:0] WBU_i_from_EXU_bits_rd; // @[core.scala 37:27]
  wire [2:0] WBU_i_from_EXU_bits_fu_op; // @[core.scala 37:27]
  wire  WBU_i_to_ISU_bits_reg_wen; // @[core.scala 37:27]
  wire [31:0] WBU_i_to_ISU_bits_wdata; // @[core.scala 37:27]
  wire [4:0] WBU_i_to_ISU_bits_rd; // @[core.scala 37:27]
  wire  WBU_i_to_IFU_valid; // @[core.scala 37:27]
  wire  IFU_i_clock; // @[core.scala 50:27]
  wire  IFU_i_reset; // @[core.scala 50:27]
  wire  IFU_i_to_IDU_valid; // @[core.scala 50:27]
  wire [31:0] IFU_i_to_IDU_bits_inst; // @[core.scala 50:27]
  wire [31:0] IFU_i_to_IDU_bits_pc; // @[core.scala 50:27]
  wire  IFU_i_from_EXU_bits_bru_ctrl_br; // @[core.scala 50:27]
  wire [31:0] IFU_i_from_EXU_bits_bru_addr; // @[core.scala 50:27]
  wire  IFU_i_from_EXU_bits_csr_ctrl_br; // @[core.scala 50:27]
  wire [31:0] IFU_i_from_EXU_bits_csr_addr; // @[core.scala 50:27]
  wire  IFU_i_from_WBU_ready; // @[core.scala 50:27]
  wire  IFU_i_from_WBU_valid; // @[core.scala 50:27]
  wire  IFU_i_to_cache_ready; // @[core.scala 50:27]
  wire  IFU_i_to_cache_valid; // @[core.scala 50:27]
  wire [31:0] IFU_i_to_cache_bits_addr; // @[core.scala 50:27]
  wire  IFU_i_from_cache_ready; // @[core.scala 50:27]
  wire  IFU_i_from_cache_valid; // @[core.scala 50:27]
  wire [31:0] IFU_i_from_cache_bits_data; // @[core.scala 50:27]
  wire  icache_clock; // @[core.scala 51:27]
  wire  icache_reset; // @[core.scala 51:27]
  wire  icache_from_IFU_ready; // @[core.scala 51:27]
  wire  icache_from_IFU_valid; // @[core.scala 51:27]
  wire [31:0] icache_from_IFU_bits_addr; // @[core.scala 51:27]
  wire  icache_to_IFU_valid; // @[core.scala 51:27]
  wire [31:0] icache_to_IFU_bits_data; // @[core.scala 51:27]
  wire  icache_to_sram_ar_ready; // @[core.scala 51:27]
  wire  icache_to_sram_ar_valid; // @[core.scala 51:27]
  wire [31:0] icache_to_sram_ar_bits_addr; // @[core.scala 51:27]
  wire [7:0] icache_to_sram_ar_bits_len; // @[core.scala 51:27]
  wire  icache_to_sram_r_ready; // @[core.scala 51:27]
  wire  icache_to_sram_r_valid; // @[core.scala 51:27]
  wire [31:0] icache_to_sram_r_bits_data; // @[core.scala 51:27]
  wire  icache_to_sram_r_bits_last; // @[core.scala 51:27]
  wire  sram_i_clock; // @[core.scala 52:27]
  wire  sram_i_reset; // @[core.scala 52:27]
  wire  sram_i_axi_ar_ready; // @[core.scala 52:27]
  wire  sram_i_axi_ar_valid; // @[core.scala 52:27]
  wire [31:0] sram_i_axi_ar_bits_addr; // @[core.scala 52:27]
  wire [7:0] sram_i_axi_ar_bits_len; // @[core.scala 52:27]
  wire  sram_i_axi_r_ready; // @[core.scala 52:27]
  wire  sram_i_axi_r_valid; // @[core.scala 52:27]
  wire [31:0] sram_i_axi_r_bits_data; // @[core.scala 52:27]
  wire  sram_i_axi_r_bits_last; // @[core.scala 52:27]
  wire  sram_i_axi_aw_ready; // @[core.scala 52:27]
  wire  sram_i_axi_aw_valid; // @[core.scala 52:27]
  wire [31:0] sram_i_axi_aw_bits_addr; // @[core.scala 52:27]
  wire  sram_i_axi_w_ready; // @[core.scala 52:27]
  wire  sram_i_axi_w_valid; // @[core.scala 52:27]
  wire [31:0] sram_i_axi_w_bits_data; // @[core.scala 52:27]
  wire [3:0] sram_i_axi_w_bits_strb; // @[core.scala 52:27]
  wire  sram_i_axi_b_valid; // @[core.scala 52:27]
  wire  sram_i2_clock; // @[core.scala 58:27]
  wire  sram_i2_reset; // @[core.scala 58:27]
  wire  sram_i2_axi_ar_ready; // @[core.scala 58:27]
  wire  sram_i2_axi_ar_valid; // @[core.scala 58:27]
  wire [31:0] sram_i2_axi_ar_bits_addr; // @[core.scala 58:27]
  wire [7:0] sram_i2_axi_ar_bits_len; // @[core.scala 58:27]
  wire  sram_i2_axi_r_ready; // @[core.scala 58:27]
  wire  sram_i2_axi_r_valid; // @[core.scala 58:27]
  wire [31:0] sram_i2_axi_r_bits_data; // @[core.scala 58:27]
  wire  sram_i2_axi_r_bits_last; // @[core.scala 58:27]
  wire  sram_i2_axi_aw_ready; // @[core.scala 58:27]
  wire  sram_i2_axi_aw_valid; // @[core.scala 58:27]
  wire [31:0] sram_i2_axi_aw_bits_addr; // @[core.scala 58:27]
  wire  sram_i2_axi_w_ready; // @[core.scala 58:27]
  wire  sram_i2_axi_w_valid; // @[core.scala 58:27]
  wire [31:0] sram_i2_axi_w_bits_data; // @[core.scala 58:27]
  wire [3:0] sram_i2_axi_w_bits_strb; // @[core.scala 58:27]
  wire  sram_i2_axi_b_valid; // @[core.scala 58:27]
  wire  _EXU_i_from_ISU_bits_T = ISU_i_to_EXU_valid & EXU_i_from_ISU_ready; // @[Connect.scala 26:58]
  reg [31:0] EXU_i_from_ISU_bits_r_imm; // @[Reg.scala 19:16]
  reg [31:0] EXU_i_from_ISU_bits_r_pc; // @[Reg.scala 19:16]
  reg [31:0] EXU_i_from_ISU_bits_r_rdata1; // @[Reg.scala 19:16]
  reg [31:0] EXU_i_from_ISU_bits_r_rdata2; // @[Reg.scala 19:16]
  reg [4:0] EXU_i_from_ISU_bits_r_rd; // @[Reg.scala 19:16]
  reg  EXU_i_from_ISU_bits_r_ctrl_sig_reg_wen; // @[Reg.scala 19:16]
  reg [2:0] EXU_i_from_ISU_bits_r_ctrl_sig_fu_op; // @[Reg.scala 19:16]
  reg  EXU_i_from_ISU_bits_r_ctrl_sig_mem_wen; // @[Reg.scala 19:16]
  reg  EXU_i_from_ISU_bits_r_ctrl_sig_is_ebreak; // @[Reg.scala 19:16]
  reg  EXU_i_from_ISU_bits_r_ctrl_sig_not_impl; // @[Reg.scala 19:16]
  reg [1:0] EXU_i_from_ISU_bits_r_ctrl_sig_src1_op; // @[Reg.scala 19:16]
  reg [1:0] EXU_i_from_ISU_bits_r_ctrl_sig_src2_op; // @[Reg.scala 19:16]
  reg [3:0] EXU_i_from_ISU_bits_r_ctrl_sig_alu_op; // @[Reg.scala 19:16]
  reg [3:0] EXU_i_from_ISU_bits_r_ctrl_sig_lsu_op; // @[Reg.scala 19:16]
  reg [3:0] EXU_i_from_ISU_bits_r_ctrl_sig_bru_op; // @[Reg.scala 19:16]
  reg [2:0] EXU_i_from_ISU_bits_r_ctrl_sig_csr_op; // @[Reg.scala 19:16]
  reg [3:0] EXU_i_from_ISU_bits_r_ctrl_sig_mdu_op; // @[Reg.scala 19:16]
  IDU IDU_i ( // @[core.scala 34:27]
    .from_IFU_valid(IDU_i_from_IFU_valid),
    .from_IFU_bits_inst(IDU_i_from_IFU_bits_inst),
    .from_IFU_bits_pc(IDU_i_from_IFU_bits_pc),
    .to_ISU_valid(IDU_i_to_ISU_valid),
    .to_ISU_bits_imm(IDU_i_to_ISU_bits_imm),
    .to_ISU_bits_pc(IDU_i_to_ISU_bits_pc),
    .to_ISU_bits_rs1(IDU_i_to_ISU_bits_rs1),
    .to_ISU_bits_rs2(IDU_i_to_ISU_bits_rs2),
    .to_ISU_bits_rd(IDU_i_to_ISU_bits_rd),
    .to_ISU_bits_ctrl_sig_reg_wen(IDU_i_to_ISU_bits_ctrl_sig_reg_wen),
    .to_ISU_bits_ctrl_sig_fu_op(IDU_i_to_ISU_bits_ctrl_sig_fu_op),
    .to_ISU_bits_ctrl_sig_mem_wen(IDU_i_to_ISU_bits_ctrl_sig_mem_wen),
    .to_ISU_bits_ctrl_sig_is_ebreak(IDU_i_to_ISU_bits_ctrl_sig_is_ebreak),
    .to_ISU_bits_ctrl_sig_not_impl(IDU_i_to_ISU_bits_ctrl_sig_not_impl),
    .to_ISU_bits_ctrl_sig_src1_op(IDU_i_to_ISU_bits_ctrl_sig_src1_op),
    .to_ISU_bits_ctrl_sig_src2_op(IDU_i_to_ISU_bits_ctrl_sig_src2_op),
    .to_ISU_bits_ctrl_sig_alu_op(IDU_i_to_ISU_bits_ctrl_sig_alu_op),
    .to_ISU_bits_ctrl_sig_lsu_op(IDU_i_to_ISU_bits_ctrl_sig_lsu_op),
    .to_ISU_bits_ctrl_sig_bru_op(IDU_i_to_ISU_bits_ctrl_sig_bru_op),
    .to_ISU_bits_ctrl_sig_csr_op(IDU_i_to_ISU_bits_ctrl_sig_csr_op),
    .to_ISU_bits_ctrl_sig_mdu_op(IDU_i_to_ISU_bits_ctrl_sig_mdu_op)
  );
  ISU ISU_i ( // @[core.scala 35:27]
    .clock(ISU_i_clock),
    .reset(ISU_i_reset),
    .from_IDU_valid(ISU_i_from_IDU_valid),
    .from_IDU_bits_imm(ISU_i_from_IDU_bits_imm),
    .from_IDU_bits_pc(ISU_i_from_IDU_bits_pc),
    .from_IDU_bits_rs1(ISU_i_from_IDU_bits_rs1),
    .from_IDU_bits_rs2(ISU_i_from_IDU_bits_rs2),
    .from_IDU_bits_rd(ISU_i_from_IDU_bits_rd),
    .from_IDU_bits_ctrl_sig_reg_wen(ISU_i_from_IDU_bits_ctrl_sig_reg_wen),
    .from_IDU_bits_ctrl_sig_fu_op(ISU_i_from_IDU_bits_ctrl_sig_fu_op),
    .from_IDU_bits_ctrl_sig_mem_wen(ISU_i_from_IDU_bits_ctrl_sig_mem_wen),
    .from_IDU_bits_ctrl_sig_is_ebreak(ISU_i_from_IDU_bits_ctrl_sig_is_ebreak),
    .from_IDU_bits_ctrl_sig_not_impl(ISU_i_from_IDU_bits_ctrl_sig_not_impl),
    .from_IDU_bits_ctrl_sig_src1_op(ISU_i_from_IDU_bits_ctrl_sig_src1_op),
    .from_IDU_bits_ctrl_sig_src2_op(ISU_i_from_IDU_bits_ctrl_sig_src2_op),
    .from_IDU_bits_ctrl_sig_alu_op(ISU_i_from_IDU_bits_ctrl_sig_alu_op),
    .from_IDU_bits_ctrl_sig_lsu_op(ISU_i_from_IDU_bits_ctrl_sig_lsu_op),
    .from_IDU_bits_ctrl_sig_bru_op(ISU_i_from_IDU_bits_ctrl_sig_bru_op),
    .from_IDU_bits_ctrl_sig_csr_op(ISU_i_from_IDU_bits_ctrl_sig_csr_op),
    .from_IDU_bits_ctrl_sig_mdu_op(ISU_i_from_IDU_bits_ctrl_sig_mdu_op),
    .from_WBU_bits_reg_wen(ISU_i_from_WBU_bits_reg_wen),
    .from_WBU_bits_wdata(ISU_i_from_WBU_bits_wdata),
    .from_WBU_bits_rd(ISU_i_from_WBU_bits_rd),
    .to_EXU_valid(ISU_i_to_EXU_valid),
    .to_EXU_bits_imm(ISU_i_to_EXU_bits_imm),
    .to_EXU_bits_pc(ISU_i_to_EXU_bits_pc),
    .to_EXU_bits_rdata1(ISU_i_to_EXU_bits_rdata1),
    .to_EXU_bits_rdata2(ISU_i_to_EXU_bits_rdata2),
    .to_EXU_bits_rd(ISU_i_to_EXU_bits_rd),
    .to_EXU_bits_ctrl_sig_reg_wen(ISU_i_to_EXU_bits_ctrl_sig_reg_wen),
    .to_EXU_bits_ctrl_sig_fu_op(ISU_i_to_EXU_bits_ctrl_sig_fu_op),
    .to_EXU_bits_ctrl_sig_mem_wen(ISU_i_to_EXU_bits_ctrl_sig_mem_wen),
    .to_EXU_bits_ctrl_sig_is_ebreak(ISU_i_to_EXU_bits_ctrl_sig_is_ebreak),
    .to_EXU_bits_ctrl_sig_not_impl(ISU_i_to_EXU_bits_ctrl_sig_not_impl),
    .to_EXU_bits_ctrl_sig_src1_op(ISU_i_to_EXU_bits_ctrl_sig_src1_op),
    .to_EXU_bits_ctrl_sig_src2_op(ISU_i_to_EXU_bits_ctrl_sig_src2_op),
    .to_EXU_bits_ctrl_sig_alu_op(ISU_i_to_EXU_bits_ctrl_sig_alu_op),
    .to_EXU_bits_ctrl_sig_lsu_op(ISU_i_to_EXU_bits_ctrl_sig_lsu_op),
    .to_EXU_bits_ctrl_sig_bru_op(ISU_i_to_EXU_bits_ctrl_sig_bru_op),
    .to_EXU_bits_ctrl_sig_csr_op(ISU_i_to_EXU_bits_ctrl_sig_csr_op),
    .to_EXU_bits_ctrl_sig_mdu_op(ISU_i_to_EXU_bits_ctrl_sig_mdu_op)
  );
  EXU EXU_i ( // @[core.scala 36:27]
    .clock(EXU_i_clock),
    .reset(EXU_i_reset),
    .from_ISU_ready(EXU_i_from_ISU_ready),
    .from_ISU_valid(EXU_i_from_ISU_valid),
    .from_ISU_bits_imm(EXU_i_from_ISU_bits_imm),
    .from_ISU_bits_pc(EXU_i_from_ISU_bits_pc),
    .from_ISU_bits_rdata1(EXU_i_from_ISU_bits_rdata1),
    .from_ISU_bits_rdata2(EXU_i_from_ISU_bits_rdata2),
    .from_ISU_bits_rd(EXU_i_from_ISU_bits_rd),
    .from_ISU_bits_ctrl_sig_reg_wen(EXU_i_from_ISU_bits_ctrl_sig_reg_wen),
    .from_ISU_bits_ctrl_sig_fu_op(EXU_i_from_ISU_bits_ctrl_sig_fu_op),
    .from_ISU_bits_ctrl_sig_mem_wen(EXU_i_from_ISU_bits_ctrl_sig_mem_wen),
    .from_ISU_bits_ctrl_sig_is_ebreak(EXU_i_from_ISU_bits_ctrl_sig_is_ebreak),
    .from_ISU_bits_ctrl_sig_not_impl(EXU_i_from_ISU_bits_ctrl_sig_not_impl),
    .from_ISU_bits_ctrl_sig_src1_op(EXU_i_from_ISU_bits_ctrl_sig_src1_op),
    .from_ISU_bits_ctrl_sig_src2_op(EXU_i_from_ISU_bits_ctrl_sig_src2_op),
    .from_ISU_bits_ctrl_sig_alu_op(EXU_i_from_ISU_bits_ctrl_sig_alu_op),
    .from_ISU_bits_ctrl_sig_lsu_op(EXU_i_from_ISU_bits_ctrl_sig_lsu_op),
    .from_ISU_bits_ctrl_sig_bru_op(EXU_i_from_ISU_bits_ctrl_sig_bru_op),
    .from_ISU_bits_ctrl_sig_csr_op(EXU_i_from_ISU_bits_ctrl_sig_csr_op),
    .from_ISU_bits_ctrl_sig_mdu_op(EXU_i_from_ISU_bits_ctrl_sig_mdu_op),
    .to_WBU_valid(EXU_i_to_WBU_valid),
    .to_WBU_bits_alu_result(EXU_i_to_WBU_bits_alu_result),
    .to_WBU_bits_mdu_result(EXU_i_to_WBU_bits_mdu_result),
    .to_WBU_bits_lsu_rdata(EXU_i_to_WBU_bits_lsu_rdata),
    .to_WBU_bits_csr_rdata(EXU_i_to_WBU_bits_csr_rdata),
    .to_WBU_bits_pc(EXU_i_to_WBU_bits_pc),
    .to_WBU_bits_reg_wen(EXU_i_to_WBU_bits_reg_wen),
    .to_WBU_bits_rd(EXU_i_to_WBU_bits_rd),
    .to_WBU_bits_fu_op(EXU_i_to_WBU_bits_fu_op),
    .to_IFU_bits_bru_ctrl_br(EXU_i_to_IFU_bits_bru_ctrl_br),
    .to_IFU_bits_bru_addr(EXU_i_to_IFU_bits_bru_addr),
    .to_IFU_bits_csr_ctrl_br(EXU_i_to_IFU_bits_csr_ctrl_br),
    .to_IFU_bits_csr_addr(EXU_i_to_IFU_bits_csr_addr),
    .difftest_mcause(EXU_i_difftest_mcause),
    .difftest_mepc(EXU_i_difftest_mepc),
    .difftest_mstatus(EXU_i_difftest_mstatus),
    .difftest_mtvec(EXU_i_difftest_mtvec),
    .lsu_axi_master_ar_ready(EXU_i_lsu_axi_master_ar_ready),
    .lsu_axi_master_ar_valid(EXU_i_lsu_axi_master_ar_valid),
    .lsu_axi_master_ar_bits_addr(EXU_i_lsu_axi_master_ar_bits_addr),
    .lsu_axi_master_r_ready(EXU_i_lsu_axi_master_r_ready),
    .lsu_axi_master_r_valid(EXU_i_lsu_axi_master_r_valid),
    .lsu_axi_master_r_bits_data(EXU_i_lsu_axi_master_r_bits_data),
    .lsu_axi_master_aw_ready(EXU_i_lsu_axi_master_aw_ready),
    .lsu_axi_master_aw_valid(EXU_i_lsu_axi_master_aw_valid),
    .lsu_axi_master_aw_bits_addr(EXU_i_lsu_axi_master_aw_bits_addr),
    .lsu_axi_master_w_valid(EXU_i_lsu_axi_master_w_valid),
    .lsu_axi_master_w_bits_data(EXU_i_lsu_axi_master_w_bits_data),
    .lsu_axi_master_w_bits_strb(EXU_i_lsu_axi_master_w_bits_strb),
    .lsu_axi_master_b_valid(EXU_i_lsu_axi_master_b_valid)
  );
  WBU WBU_i ( // @[core.scala 37:27]
    .from_EXU_ready(WBU_i_from_EXU_ready),
    .from_EXU_valid(WBU_i_from_EXU_valid),
    .from_EXU_bits_alu_result(WBU_i_from_EXU_bits_alu_result),
    .from_EXU_bits_mdu_result(WBU_i_from_EXU_bits_mdu_result),
    .from_EXU_bits_lsu_rdata(WBU_i_from_EXU_bits_lsu_rdata),
    .from_EXU_bits_csr_rdata(WBU_i_from_EXU_bits_csr_rdata),
    .from_EXU_bits_pc(WBU_i_from_EXU_bits_pc),
    .from_EXU_bits_reg_wen(WBU_i_from_EXU_bits_reg_wen),
    .from_EXU_bits_rd(WBU_i_from_EXU_bits_rd),
    .from_EXU_bits_fu_op(WBU_i_from_EXU_bits_fu_op),
    .to_ISU_bits_reg_wen(WBU_i_to_ISU_bits_reg_wen),
    .to_ISU_bits_wdata(WBU_i_to_ISU_bits_wdata),
    .to_ISU_bits_rd(WBU_i_to_ISU_bits_rd),
    .to_IFU_valid(WBU_i_to_IFU_valid)
  );
  IFU_cache IFU_i ( // @[core.scala 50:27]
    .clock(IFU_i_clock),
    .reset(IFU_i_reset),
    .to_IDU_valid(IFU_i_to_IDU_valid),
    .to_IDU_bits_inst(IFU_i_to_IDU_bits_inst),
    .to_IDU_bits_pc(IFU_i_to_IDU_bits_pc),
    .from_EXU_bits_bru_ctrl_br(IFU_i_from_EXU_bits_bru_ctrl_br),
    .from_EXU_bits_bru_addr(IFU_i_from_EXU_bits_bru_addr),
    .from_EXU_bits_csr_ctrl_br(IFU_i_from_EXU_bits_csr_ctrl_br),
    .from_EXU_bits_csr_addr(IFU_i_from_EXU_bits_csr_addr),
    .from_WBU_ready(IFU_i_from_WBU_ready),
    .from_WBU_valid(IFU_i_from_WBU_valid),
    .to_cache_ready(IFU_i_to_cache_ready),
    .to_cache_valid(IFU_i_to_cache_valid),
    .to_cache_bits_addr(IFU_i_to_cache_bits_addr),
    .from_cache_ready(IFU_i_from_cache_ready),
    .from_cache_valid(IFU_i_from_cache_valid),
    .from_cache_bits_data(IFU_i_from_cache_bits_data)
  );
  I_Cache icache ( // @[core.scala 51:27]
    .clock(icache_clock),
    .reset(icache_reset),
    .from_IFU_ready(icache_from_IFU_ready),
    .from_IFU_valid(icache_from_IFU_valid),
    .from_IFU_bits_addr(icache_from_IFU_bits_addr),
    .to_IFU_valid(icache_to_IFU_valid),
    .to_IFU_bits_data(icache_to_IFU_bits_data),
    .to_sram_ar_ready(icache_to_sram_ar_ready),
    .to_sram_ar_valid(icache_to_sram_ar_valid),
    .to_sram_ar_bits_addr(icache_to_sram_ar_bits_addr),
    .to_sram_ar_bits_len(icache_to_sram_ar_bits_len),
    .to_sram_r_ready(icache_to_sram_r_ready),
    .to_sram_r_valid(icache_to_sram_r_valid),
    .to_sram_r_bits_data(icache_to_sram_r_bits_data),
    .to_sram_r_bits_last(icache_to_sram_r_bits_last)
  );
  sram_axi_rw sram_i ( // @[core.scala 52:27]
    .clock(sram_i_clock),
    .reset(sram_i_reset),
    .axi_ar_ready(sram_i_axi_ar_ready),
    .axi_ar_valid(sram_i_axi_ar_valid),
    .axi_ar_bits_addr(sram_i_axi_ar_bits_addr),
    .axi_ar_bits_len(sram_i_axi_ar_bits_len),
    .axi_r_ready(sram_i_axi_r_ready),
    .axi_r_valid(sram_i_axi_r_valid),
    .axi_r_bits_data(sram_i_axi_r_bits_data),
    .axi_r_bits_last(sram_i_axi_r_bits_last),
    .axi_aw_ready(sram_i_axi_aw_ready),
    .axi_aw_valid(sram_i_axi_aw_valid),
    .axi_aw_bits_addr(sram_i_axi_aw_bits_addr),
    .axi_w_ready(sram_i_axi_w_ready),
    .axi_w_valid(sram_i_axi_w_valid),
    .axi_w_bits_data(sram_i_axi_w_bits_data),
    .axi_w_bits_strb(sram_i_axi_w_bits_strb),
    .axi_b_valid(sram_i_axi_b_valid)
  );
  sram_axi_rw sram_i2 ( // @[core.scala 58:27]
    .clock(sram_i2_clock),
    .reset(sram_i2_reset),
    .axi_ar_ready(sram_i2_axi_ar_ready),
    .axi_ar_valid(sram_i2_axi_ar_valid),
    .axi_ar_bits_addr(sram_i2_axi_ar_bits_addr),
    .axi_ar_bits_len(sram_i2_axi_ar_bits_len),
    .axi_r_ready(sram_i2_axi_r_ready),
    .axi_r_valid(sram_i2_axi_r_valid),
    .axi_r_bits_data(sram_i2_axi_r_bits_data),
    .axi_r_bits_last(sram_i2_axi_r_bits_last),
    .axi_aw_ready(sram_i2_axi_aw_ready),
    .axi_aw_valid(sram_i2_axi_aw_valid),
    .axi_aw_bits_addr(sram_i2_axi_aw_bits_addr),
    .axi_w_ready(sram_i2_axi_w_ready),
    .axi_w_valid(sram_i2_axi_w_valid),
    .axi_w_bits_data(sram_i2_axi_w_bits_data),
    .axi_w_bits_strb(sram_i2_axi_w_bits_strb),
    .axi_b_valid(sram_i2_axi_b_valid)
  );
  assign io_out_inst = IFU_i_to_IDU_bits_inst; // @[core.scala 83:20]
  assign io_out_pc = IFU_i_to_IDU_bits_pc; // @[core.scala 84:20]
  assign io_out_difftest_mcause = EXU_i_difftest_mcause; // @[core.scala 87:21]
  assign io_out_difftest_mepc = EXU_i_difftest_mepc; // @[core.scala 87:21]
  assign io_out_difftest_mstatus = EXU_i_difftest_mstatus; // @[core.scala 87:21]
  assign io_out_difftest_mtvec = EXU_i_difftest_mtvec; // @[core.scala 87:21]
  assign io_out_wb = WBU_i_to_IFU_valid; // @[core.scala 85:20]
  assign IDU_i_from_IFU_valid = IFU_i_to_IDU_valid; // @[Connect.scala 16:22]
  assign IDU_i_from_IFU_bits_inst = IFU_i_to_IDU_bits_inst; // @[Connect.scala 15:22]
  assign IDU_i_from_IFU_bits_pc = IFU_i_to_IDU_bits_pc; // @[Connect.scala 15:22]
  assign ISU_i_clock = clock;
  assign ISU_i_reset = reset;
  assign ISU_i_from_IDU_valid = IDU_i_to_ISU_valid; // @[Connect.scala 16:22]
  assign ISU_i_from_IDU_bits_imm = IDU_i_to_ISU_bits_imm; // @[Connect.scala 15:22]
  assign ISU_i_from_IDU_bits_pc = IDU_i_to_ISU_bits_pc; // @[Connect.scala 15:22]
  assign ISU_i_from_IDU_bits_rs1 = IDU_i_to_ISU_bits_rs1; // @[Connect.scala 15:22]
  assign ISU_i_from_IDU_bits_rs2 = IDU_i_to_ISU_bits_rs2; // @[Connect.scala 15:22]
  assign ISU_i_from_IDU_bits_rd = IDU_i_to_ISU_bits_rd; // @[Connect.scala 15:22]
  assign ISU_i_from_IDU_bits_ctrl_sig_reg_wen = IDU_i_to_ISU_bits_ctrl_sig_reg_wen; // @[Connect.scala 15:22]
  assign ISU_i_from_IDU_bits_ctrl_sig_fu_op = IDU_i_to_ISU_bits_ctrl_sig_fu_op; // @[Connect.scala 15:22]
  assign ISU_i_from_IDU_bits_ctrl_sig_mem_wen = IDU_i_to_ISU_bits_ctrl_sig_mem_wen; // @[Connect.scala 15:22]
  assign ISU_i_from_IDU_bits_ctrl_sig_is_ebreak = IDU_i_to_ISU_bits_ctrl_sig_is_ebreak; // @[Connect.scala 15:22]
  assign ISU_i_from_IDU_bits_ctrl_sig_not_impl = IDU_i_to_ISU_bits_ctrl_sig_not_impl; // @[Connect.scala 15:22]
  assign ISU_i_from_IDU_bits_ctrl_sig_src1_op = IDU_i_to_ISU_bits_ctrl_sig_src1_op; // @[Connect.scala 15:22]
  assign ISU_i_from_IDU_bits_ctrl_sig_src2_op = IDU_i_to_ISU_bits_ctrl_sig_src2_op; // @[Connect.scala 15:22]
  assign ISU_i_from_IDU_bits_ctrl_sig_alu_op = IDU_i_to_ISU_bits_ctrl_sig_alu_op; // @[Connect.scala 15:22]
  assign ISU_i_from_IDU_bits_ctrl_sig_lsu_op = IDU_i_to_ISU_bits_ctrl_sig_lsu_op; // @[Connect.scala 15:22]
  assign ISU_i_from_IDU_bits_ctrl_sig_bru_op = IDU_i_to_ISU_bits_ctrl_sig_bru_op; // @[Connect.scala 15:22]
  assign ISU_i_from_IDU_bits_ctrl_sig_csr_op = IDU_i_to_ISU_bits_ctrl_sig_csr_op; // @[Connect.scala 15:22]
  assign ISU_i_from_IDU_bits_ctrl_sig_mdu_op = IDU_i_to_ISU_bits_ctrl_sig_mdu_op; // @[Connect.scala 15:22]
  assign ISU_i_from_WBU_bits_reg_wen = WBU_i_to_ISU_bits_reg_wen; // @[Connect.scala 15:22]
  assign ISU_i_from_WBU_bits_wdata = WBU_i_to_ISU_bits_wdata; // @[Connect.scala 15:22]
  assign ISU_i_from_WBU_bits_rd = WBU_i_to_ISU_bits_rd; // @[Connect.scala 15:22]
  assign EXU_i_clock = clock;
  assign EXU_i_reset = reset;
  assign EXU_i_from_ISU_valid = ISU_i_to_EXU_valid; // @[Connect.scala 27:22]
  assign EXU_i_from_ISU_bits_imm = EXU_i_from_ISU_bits_r_imm; // @[Connect.scala 26:22]
  assign EXU_i_from_ISU_bits_pc = EXU_i_from_ISU_bits_r_pc; // @[Connect.scala 26:22]
  assign EXU_i_from_ISU_bits_rdata1 = EXU_i_from_ISU_bits_r_rdata1; // @[Connect.scala 26:22]
  assign EXU_i_from_ISU_bits_rdata2 = EXU_i_from_ISU_bits_r_rdata2; // @[Connect.scala 26:22]
  assign EXU_i_from_ISU_bits_rd = EXU_i_from_ISU_bits_r_rd; // @[Connect.scala 26:22]
  assign EXU_i_from_ISU_bits_ctrl_sig_reg_wen = EXU_i_from_ISU_bits_r_ctrl_sig_reg_wen; // @[Connect.scala 26:22]
  assign EXU_i_from_ISU_bits_ctrl_sig_fu_op = EXU_i_from_ISU_bits_r_ctrl_sig_fu_op; // @[Connect.scala 26:22]
  assign EXU_i_from_ISU_bits_ctrl_sig_mem_wen = EXU_i_from_ISU_bits_r_ctrl_sig_mem_wen; // @[Connect.scala 26:22]
  assign EXU_i_from_ISU_bits_ctrl_sig_is_ebreak = EXU_i_from_ISU_bits_r_ctrl_sig_is_ebreak; // @[Connect.scala 26:22]
  assign EXU_i_from_ISU_bits_ctrl_sig_not_impl = EXU_i_from_ISU_bits_r_ctrl_sig_not_impl; // @[Connect.scala 26:22]
  assign EXU_i_from_ISU_bits_ctrl_sig_src1_op = EXU_i_from_ISU_bits_r_ctrl_sig_src1_op; // @[Connect.scala 26:22]
  assign EXU_i_from_ISU_bits_ctrl_sig_src2_op = EXU_i_from_ISU_bits_r_ctrl_sig_src2_op; // @[Connect.scala 26:22]
  assign EXU_i_from_ISU_bits_ctrl_sig_alu_op = EXU_i_from_ISU_bits_r_ctrl_sig_alu_op; // @[Connect.scala 26:22]
  assign EXU_i_from_ISU_bits_ctrl_sig_lsu_op = EXU_i_from_ISU_bits_r_ctrl_sig_lsu_op; // @[Connect.scala 26:22]
  assign EXU_i_from_ISU_bits_ctrl_sig_bru_op = EXU_i_from_ISU_bits_r_ctrl_sig_bru_op; // @[Connect.scala 26:22]
  assign EXU_i_from_ISU_bits_ctrl_sig_csr_op = EXU_i_from_ISU_bits_r_ctrl_sig_csr_op; // @[Connect.scala 26:22]
  assign EXU_i_from_ISU_bits_ctrl_sig_mdu_op = EXU_i_from_ISU_bits_r_ctrl_sig_mdu_op; // @[Connect.scala 26:22]
  assign EXU_i_lsu_axi_master_ar_ready = sram_i2_axi_ar_ready; // @[Connect.scala 17:22]
  assign EXU_i_lsu_axi_master_r_valid = sram_i2_axi_r_valid; // @[Connect.scala 16:22]
  assign EXU_i_lsu_axi_master_r_bits_data = sram_i2_axi_r_bits_data; // @[Connect.scala 15:22]
  assign EXU_i_lsu_axi_master_aw_ready = sram_i2_axi_aw_ready; // @[Connect.scala 17:22]
  assign EXU_i_lsu_axi_master_b_valid = sram_i2_axi_b_valid; // @[Connect.scala 16:22]
  assign WBU_i_from_EXU_valid = EXU_i_to_WBU_valid; // @[Connect.scala 16:22]
  assign WBU_i_from_EXU_bits_alu_result = EXU_i_to_WBU_bits_alu_result; // @[Connect.scala 15:22]
  assign WBU_i_from_EXU_bits_mdu_result = EXU_i_to_WBU_bits_mdu_result; // @[Connect.scala 15:22]
  assign WBU_i_from_EXU_bits_lsu_rdata = EXU_i_to_WBU_bits_lsu_rdata; // @[Connect.scala 15:22]
  assign WBU_i_from_EXU_bits_csr_rdata = EXU_i_to_WBU_bits_csr_rdata; // @[Connect.scala 15:22]
  assign WBU_i_from_EXU_bits_pc = EXU_i_to_WBU_bits_pc; // @[Connect.scala 15:22]
  assign WBU_i_from_EXU_bits_reg_wen = EXU_i_to_WBU_bits_reg_wen; // @[Connect.scala 15:22]
  assign WBU_i_from_EXU_bits_rd = EXU_i_to_WBU_bits_rd; // @[Connect.scala 15:22]
  assign WBU_i_from_EXU_bits_fu_op = EXU_i_to_WBU_bits_fu_op; // @[Connect.scala 15:22]
  assign IFU_i_clock = clock;
  assign IFU_i_reset = reset;
  assign IFU_i_from_EXU_bits_bru_ctrl_br = EXU_i_to_IFU_bits_bru_ctrl_br; // @[Connect.scala 15:22]
  assign IFU_i_from_EXU_bits_bru_addr = EXU_i_to_IFU_bits_bru_addr; // @[Connect.scala 15:22]
  assign IFU_i_from_EXU_bits_csr_ctrl_br = EXU_i_to_IFU_bits_csr_ctrl_br; // @[Connect.scala 15:22]
  assign IFU_i_from_EXU_bits_csr_addr = EXU_i_to_IFU_bits_csr_addr; // @[Connect.scala 15:22]
  assign IFU_i_from_WBU_valid = WBU_i_to_IFU_valid; // @[Connect.scala 16:22]
  assign IFU_i_to_cache_ready = icache_from_IFU_ready; // @[Connect.scala 17:22]
  assign IFU_i_from_cache_valid = icache_to_IFU_valid; // @[Connect.scala 16:22]
  assign IFU_i_from_cache_bits_data = icache_to_IFU_bits_data; // @[Connect.scala 15:22]
  assign icache_clock = clock;
  assign icache_reset = reset;
  assign icache_from_IFU_valid = IFU_i_to_cache_valid; // @[Connect.scala 16:22]
  assign icache_from_IFU_bits_addr = IFU_i_to_cache_bits_addr; // @[Connect.scala 15:22]
  assign icache_to_sram_ar_ready = sram_i_axi_ar_ready; // @[Connect.scala 17:22]
  assign icache_to_sram_r_valid = sram_i_axi_r_valid; // @[Connect.scala 16:22]
  assign icache_to_sram_r_bits_data = sram_i_axi_r_bits_data; // @[Connect.scala 15:22]
  assign icache_to_sram_r_bits_last = sram_i_axi_r_bits_last; // @[Connect.scala 15:22]
  assign sram_i_clock = clock;
  assign sram_i_reset = reset;
  assign sram_i_axi_ar_valid = icache_to_sram_ar_valid; // @[Connect.scala 16:22]
  assign sram_i_axi_ar_bits_addr = icache_to_sram_ar_bits_addr; // @[Connect.scala 15:22]
  assign sram_i_axi_ar_bits_len = icache_to_sram_ar_bits_len; // @[Connect.scala 15:22]
  assign sram_i_axi_r_ready = icache_to_sram_r_ready; // @[Connect.scala 17:22]
  assign sram_i_axi_aw_valid = 1'h0; // @[Connect.scala 16:22]
  assign sram_i_axi_aw_bits_addr = 32'h0; // @[Connect.scala 15:22]
  assign sram_i_axi_w_valid = 1'h0; // @[Connect.scala 16:22]
  assign sram_i_axi_w_bits_data = 32'h0; // @[Connect.scala 15:22]
  assign sram_i_axi_w_bits_strb = 4'h0; // @[Connect.scala 15:22]
  assign sram_i2_clock = clock;
  assign sram_i2_reset = reset;
  assign sram_i2_axi_ar_valid = EXU_i_lsu_axi_master_ar_valid; // @[Connect.scala 16:22]
  assign sram_i2_axi_ar_bits_addr = EXU_i_lsu_axi_master_ar_bits_addr; // @[Connect.scala 15:22]
  assign sram_i2_axi_ar_bits_len = 8'h0; // @[Connect.scala 15:22]
  assign sram_i2_axi_r_ready = EXU_i_lsu_axi_master_r_ready; // @[Connect.scala 17:22]
  assign sram_i2_axi_aw_valid = EXU_i_lsu_axi_master_aw_valid; // @[Connect.scala 16:22]
  assign sram_i2_axi_aw_bits_addr = EXU_i_lsu_axi_master_aw_bits_addr; // @[Connect.scala 15:22]
  assign sram_i2_axi_w_valid = EXU_i_lsu_axi_master_w_valid; // @[Connect.scala 16:22]
  assign sram_i2_axi_w_bits_data = EXU_i_lsu_axi_master_w_bits_data; // @[Connect.scala 15:22]
  assign sram_i2_axi_w_bits_strb = EXU_i_lsu_axi_master_w_bits_strb; // @[Connect.scala 15:22]
  always @(posedge clock) begin
    if (_EXU_i_from_ISU_bits_T) begin // @[Reg.scala 20:18]
      EXU_i_from_ISU_bits_r_imm <= ISU_i_to_EXU_bits_imm; // @[Reg.scala 20:22]
    end
    if (_EXU_i_from_ISU_bits_T) begin // @[Reg.scala 20:18]
      EXU_i_from_ISU_bits_r_pc <= ISU_i_to_EXU_bits_pc; // @[Reg.scala 20:22]
    end
    if (_EXU_i_from_ISU_bits_T) begin // @[Reg.scala 20:18]
      EXU_i_from_ISU_bits_r_rdata1 <= ISU_i_to_EXU_bits_rdata1; // @[Reg.scala 20:22]
    end
    if (_EXU_i_from_ISU_bits_T) begin // @[Reg.scala 20:18]
      EXU_i_from_ISU_bits_r_rdata2 <= ISU_i_to_EXU_bits_rdata2; // @[Reg.scala 20:22]
    end
    if (_EXU_i_from_ISU_bits_T) begin // @[Reg.scala 20:18]
      EXU_i_from_ISU_bits_r_rd <= ISU_i_to_EXU_bits_rd; // @[Reg.scala 20:22]
    end
    if (_EXU_i_from_ISU_bits_T) begin // @[Reg.scala 20:18]
      EXU_i_from_ISU_bits_r_ctrl_sig_reg_wen <= ISU_i_to_EXU_bits_ctrl_sig_reg_wen; // @[Reg.scala 20:22]
    end
    if (_EXU_i_from_ISU_bits_T) begin // @[Reg.scala 20:18]
      EXU_i_from_ISU_bits_r_ctrl_sig_fu_op <= ISU_i_to_EXU_bits_ctrl_sig_fu_op; // @[Reg.scala 20:22]
    end
    if (_EXU_i_from_ISU_bits_T) begin // @[Reg.scala 20:18]
      EXU_i_from_ISU_bits_r_ctrl_sig_mem_wen <= ISU_i_to_EXU_bits_ctrl_sig_mem_wen; // @[Reg.scala 20:22]
    end
    if (_EXU_i_from_ISU_bits_T) begin // @[Reg.scala 20:18]
      EXU_i_from_ISU_bits_r_ctrl_sig_is_ebreak <= ISU_i_to_EXU_bits_ctrl_sig_is_ebreak; // @[Reg.scala 20:22]
    end
    if (_EXU_i_from_ISU_bits_T) begin // @[Reg.scala 20:18]
      EXU_i_from_ISU_bits_r_ctrl_sig_not_impl <= ISU_i_to_EXU_bits_ctrl_sig_not_impl; // @[Reg.scala 20:22]
    end
    if (_EXU_i_from_ISU_bits_T) begin // @[Reg.scala 20:18]
      EXU_i_from_ISU_bits_r_ctrl_sig_src1_op <= ISU_i_to_EXU_bits_ctrl_sig_src1_op; // @[Reg.scala 20:22]
    end
    if (_EXU_i_from_ISU_bits_T) begin // @[Reg.scala 20:18]
      EXU_i_from_ISU_bits_r_ctrl_sig_src2_op <= ISU_i_to_EXU_bits_ctrl_sig_src2_op; // @[Reg.scala 20:22]
    end
    if (_EXU_i_from_ISU_bits_T) begin // @[Reg.scala 20:18]
      EXU_i_from_ISU_bits_r_ctrl_sig_alu_op <= ISU_i_to_EXU_bits_ctrl_sig_alu_op; // @[Reg.scala 20:22]
    end
    if (_EXU_i_from_ISU_bits_T) begin // @[Reg.scala 20:18]
      EXU_i_from_ISU_bits_r_ctrl_sig_lsu_op <= ISU_i_to_EXU_bits_ctrl_sig_lsu_op; // @[Reg.scala 20:22]
    end
    if (_EXU_i_from_ISU_bits_T) begin // @[Reg.scala 20:18]
      EXU_i_from_ISU_bits_r_ctrl_sig_bru_op <= ISU_i_to_EXU_bits_ctrl_sig_bru_op; // @[Reg.scala 20:22]
    end
    if (_EXU_i_from_ISU_bits_T) begin // @[Reg.scala 20:18]
      EXU_i_from_ISU_bits_r_ctrl_sig_csr_op <= ISU_i_to_EXU_bits_ctrl_sig_csr_op; // @[Reg.scala 20:22]
    end
    if (_EXU_i_from_ISU_bits_T) begin // @[Reg.scala 20:18]
      EXU_i_from_ISU_bits_r_ctrl_sig_mdu_op <= ISU_i_to_EXU_bits_ctrl_sig_mdu_op; // @[Reg.scala 20:22]
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
  EXU_i_from_ISU_bits_r_imm = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  EXU_i_from_ISU_bits_r_pc = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  EXU_i_from_ISU_bits_r_rdata1 = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  EXU_i_from_ISU_bits_r_rdata2 = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  EXU_i_from_ISU_bits_r_rd = _RAND_4[4:0];
  _RAND_5 = {1{`RANDOM}};
  EXU_i_from_ISU_bits_r_ctrl_sig_reg_wen = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  EXU_i_from_ISU_bits_r_ctrl_sig_fu_op = _RAND_6[2:0];
  _RAND_7 = {1{`RANDOM}};
  EXU_i_from_ISU_bits_r_ctrl_sig_mem_wen = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  EXU_i_from_ISU_bits_r_ctrl_sig_is_ebreak = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  EXU_i_from_ISU_bits_r_ctrl_sig_not_impl = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  EXU_i_from_ISU_bits_r_ctrl_sig_src1_op = _RAND_10[1:0];
  _RAND_11 = {1{`RANDOM}};
  EXU_i_from_ISU_bits_r_ctrl_sig_src2_op = _RAND_11[1:0];
  _RAND_12 = {1{`RANDOM}};
  EXU_i_from_ISU_bits_r_ctrl_sig_alu_op = _RAND_12[3:0];
  _RAND_13 = {1{`RANDOM}};
  EXU_i_from_ISU_bits_r_ctrl_sig_lsu_op = _RAND_13[3:0];
  _RAND_14 = {1{`RANDOM}};
  EXU_i_from_ISU_bits_r_ctrl_sig_bru_op = _RAND_14[3:0];
  _RAND_15 = {1{`RANDOM}};
  EXU_i_from_ISU_bits_r_ctrl_sig_csr_op = _RAND_15[2:0];
  _RAND_16 = {1{`RANDOM}};
  EXU_i_from_ISU_bits_r_ctrl_sig_mdu_op = _RAND_16[3:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
