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
module Lsu_cache(
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
  input         to_cache_ready,
  output        to_cache_valid,
  output [31:0] to_cache_bits_addr,
  output [31:0] to_cache_bits_wdata,
  output        to_cache_bits_is_write,
  output [31:0] to_cache_bits_wmask,
  output        from_cache_ready,
  input         from_cache_valid,
  input  [31:0] from_cache_bits_data,
  input         from_cache_bits_bresp
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [2:0] state_lsu; // @[lsu.scala 306:28]
  wire  _T_1 = 3'h1 == state_lsu; // @[lsu.scala 307:24]
  wire  _state_lsu_T = to_cache_ready & to_cache_valid; // @[Decoupled.scala 51:35]
  wire  _T_2 = 3'h2 == state_lsu; // @[lsu.scala 307:24]
  wire  _state_lsu_T_2 = from_cache_ready & from_cache_valid; // @[Decoupled.scala 51:35]
  wire [2:0] _state_lsu_T_3 = _state_lsu_T_2 ? 3'h5 : 3'h2; // @[lsu.scala 323:29]
  wire  _T_3 = 3'h3 == state_lsu; // @[lsu.scala 307:24]
  wire [2:0] _state_lsu_T_5 = _state_lsu_T ? 3'h4 : 3'h3; // @[lsu.scala 328:29]
  wire  _T_4 = 3'h4 == state_lsu; // @[lsu.scala 307:24]
  wire [2:0] _state_lsu_T_8 = _state_lsu_T_2 & from_cache_bits_bresp ? 3'h5 : 3'h4; // @[lsu.scala 331:29]
  wire [2:0] _GEN_2 = 3'h5 == state_lsu ? 3'h0 : state_lsu; // @[lsu.scala 307:24 335:23 306:28]
  wire [2:0] _GEN_3 = 3'h4 == state_lsu ? _state_lsu_T_8 : _GEN_2; // @[lsu.scala 307:24 331:23]
  wire [2:0] _GEN_4 = 3'h3 == state_lsu ? _state_lsu_T_5 : _GEN_3; // @[lsu.scala 307:24 328:23]
  wire [1:0] addr_low_2 = io_in_addr[1:0]; // @[lsu.scala 342:31]
  wire [23:0] _lb_rdata_T_2 = from_cache_bits_data[7] ? 24'hffffff : 24'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _lb_rdata_T_4 = {_lb_rdata_T_2,from_cache_bits_data[7:0]}; // @[Cat.scala 33:92]
  wire [23:0] _lb_rdata_T_7 = from_cache_bits_data[15] ? 24'hffffff : 24'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _lb_rdata_T_9 = {_lb_rdata_T_7,from_cache_bits_data[15:8]}; // @[Cat.scala 33:92]
  wire [23:0] _lb_rdata_T_12 = from_cache_bits_data[23] ? 24'hffffff : 24'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _lb_rdata_T_14 = {_lb_rdata_T_12,from_cache_bits_data[23:16]}; // @[Cat.scala 33:92]
  wire [23:0] _lb_rdata_T_17 = from_cache_bits_data[31] ? 24'hffffff : 24'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _lb_rdata_T_19 = {_lb_rdata_T_17,from_cache_bits_data[31:24]}; // @[Cat.scala 33:92]
  wire [31:0] _lb_rdata_T_21 = 2'h1 == addr_low_2 ? _lb_rdata_T_9 : _lb_rdata_T_4; // @[Mux.scala 81:58]
  wire [31:0] _lb_rdata_T_23 = 2'h2 == addr_low_2 ? _lb_rdata_T_14 : _lb_rdata_T_21; // @[Mux.scala 81:58]
  wire [31:0] lb_rdata = 2'h3 == addr_low_2 ? _lb_rdata_T_19 : _lb_rdata_T_23; // @[Mux.scala 81:58]
  wire [31:0] _lbu_rdata_T_2 = {24'h0,from_cache_bits_data[7:0]}; // @[Cat.scala 33:92]
  wire [31:0] _lbu_rdata_T_5 = {24'h0,from_cache_bits_data[15:8]}; // @[Cat.scala 33:92]
  wire [31:0] _lbu_rdata_T_8 = {24'h0,from_cache_bits_data[23:16]}; // @[Cat.scala 33:92]
  wire [31:0] _lbu_rdata_T_11 = {24'h0,from_cache_bits_data[31:24]}; // @[Cat.scala 33:92]
  wire [31:0] _lbu_rdata_T_13 = 2'h1 == addr_low_2 ? _lbu_rdata_T_5 : _lbu_rdata_T_2; // @[Mux.scala 81:58]
  wire [31:0] _lbu_rdata_T_15 = 2'h2 == addr_low_2 ? _lbu_rdata_T_8 : _lbu_rdata_T_13; // @[Mux.scala 81:58]
  wire [31:0] lbu_rdata = 2'h3 == addr_low_2 ? _lbu_rdata_T_11 : _lbu_rdata_T_15; // @[Mux.scala 81:58]
  wire [15:0] _lh_rdata_T_2 = from_cache_bits_data[15] ? 16'hffff : 16'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _lh_rdata_T_4 = {_lh_rdata_T_2,from_cache_bits_data[15:0]}; // @[Cat.scala 33:92]
  wire [15:0] _lh_rdata_T_7 = from_cache_bits_data[31] ? 16'hffff : 16'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _lh_rdata_T_9 = {_lh_rdata_T_7,from_cache_bits_data[31:16]}; // @[Cat.scala 33:92]
  wire [31:0] _lh_rdata_T_11 = 2'h0 == addr_low_2 ? _lh_rdata_T_4 : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] lh_rdata = 2'h2 == addr_low_2 ? _lh_rdata_T_9 : _lh_rdata_T_11; // @[Mux.scala 81:58]
  wire [31:0] _lhu_rdata_T_2 = {16'h0,from_cache_bits_data[15:0]}; // @[Cat.scala 33:92]
  wire [31:0] _lhu_rdata_T_5 = {16'h0,from_cache_bits_data[31:16]}; // @[Cat.scala 33:92]
  wire [31:0] _lhu_rdata_T_7 = 2'h0 == addr_low_2 ? _lhu_rdata_T_2 : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] lhu_rdata = 2'h2 == addr_low_2 ? _lhu_rdata_T_5 : _lhu_rdata_T_7; // @[Mux.scala 81:58]
  wire [15:0] _sb_wmask_T_1 = 2'h1 == addr_low_2 ? 16'hff00 : 16'hff; // @[Mux.scala 81:58]
  wire [23:0] _sb_wmask_T_3 = 2'h2 == addr_low_2 ? 24'hff0000 : {{8'd0}, _sb_wmask_T_1}; // @[Mux.scala 81:58]
  wire [31:0] _sb_wmask_T_5 = 2'h3 == addr_low_2 ? 32'hff000000 : {{8'd0}, _sb_wmask_T_3}; // @[Mux.scala 81:58]
  wire [15:0] _sh_wmask_T_1 = 2'h0 == addr_low_2 ? 16'hffff : 16'h0; // @[Mux.scala 81:58]
  wire [31:0] _sh_wmask_T_3 = 2'h2 == addr_low_2 ? 32'hffff0000 : {{16'd0}, _sh_wmask_T_1}; // @[Mux.scala 81:58]
  wire [3:0] sb_wmask = _sb_wmask_T_5[3:0]; // @[lsu.scala 382:24 386:17]
  wire [3:0] _wmask_T_1 = 4'h6 == io_in_op ? sb_wmask : 4'h0; // @[Mux.scala 81:58]
  wire [3:0] sh_wmask = _sh_wmask_T_3[3:0]; // @[lsu.scala 383:24 393:17]
  wire [3:0] _wmask_T_3 = 4'h7 == io_in_op ? sh_wmask : _wmask_T_1; // @[Mux.scala 81:58]
  wire [3:0] wmask = 4'h8 == io_in_op ? 4'hf : _wmask_T_3; // @[Mux.scala 81:58]
  wire [31:0] _io_out_rdata_T_3 = 4'h1 == io_in_op ? lb_rdata : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _io_out_rdata_T_5 = 4'h4 == io_in_op ? lbu_rdata : _io_out_rdata_T_3; // @[Mux.scala 81:58]
  wire [31:0] _io_out_rdata_T_7 = 4'h2 == io_in_op ? lh_rdata : _io_out_rdata_T_5; // @[Mux.scala 81:58]
  wire [31:0] _io_out_rdata_T_9 = 4'h5 == io_in_op ? lhu_rdata : _io_out_rdata_T_7; // @[Mux.scala 81:58]
  assign io_out_rdata = 4'h3 == io_in_op ? from_cache_bits_data : _io_out_rdata_T_9; // @[Mux.scala 81:58]
  assign io_out_end = 3'h5 == state_lsu; // @[Mux.scala 81:61]
  assign io_out_idle = 3'h0 == state_lsu; // @[Mux.scala 81:61]
  assign to_cache_valid = _T_3 | _T_1; // @[Mux.scala 81:58]
  assign to_cache_bits_addr = io_in_addr; // @[lsu.scala 421:28]
  assign to_cache_bits_wdata = io_in_wdata; // @[lsu.scala 422:28]
  assign to_cache_bits_is_write = _T_4 | _T_3; // @[Mux.scala 81:58]
  assign to_cache_bits_wmask = {{28'd0}, wmask}; // @[lsu.scala 423:28]
  assign from_cache_ready = _T_4 | _T_2; // @[Mux.scala 81:58]
  always @(posedge clock) begin
    if (reset) begin // @[lsu.scala 306:28]
      state_lsu <= 3'h0; // @[lsu.scala 306:28]
    end else if (3'h0 == state_lsu) begin // @[lsu.scala 307:24]
      if (io_in_valid) begin // @[lsu.scala 309:32]
        if (io_in_mem_wen) begin // @[lsu.scala 310:38]
          state_lsu <= 3'h3; // @[lsu.scala 311:31]
        end else begin
          state_lsu <= 3'h1; // @[lsu.scala 313:31]
        end
      end else begin
        state_lsu <= 3'h0; // @[lsu.scala 316:27]
      end
    end else if (3'h1 == state_lsu) begin // @[lsu.scala 307:24]
      if (_state_lsu_T) begin // @[lsu.scala 320:29]
        state_lsu <= 3'h2;
      end else begin
        state_lsu <= 3'h1;
      end
    end else if (3'h2 == state_lsu) begin // @[lsu.scala 307:24]
      state_lsu <= _state_lsu_T_3; // @[lsu.scala 323:23]
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
  input         lsu_to_cache_ready,
  output        lsu_to_cache_valid,
  output [31:0] lsu_to_cache_bits_addr,
  output [31:0] lsu_to_cache_bits_wdata,
  output        lsu_to_cache_bits_is_write,
  output [31:0] lsu_to_cache_bits_wmask,
  input         lsu_from_cache_valid,
  input  [31:0] lsu_from_cache_bits_data,
  input         lsu_from_cache_bits_bresp
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
  wire  Lsu_i_clock; // @[EXU.scala 28:35]
  wire  Lsu_i_reset; // @[EXU.scala 28:35]
  wire  Lsu_i_io_in_valid; // @[EXU.scala 28:35]
  wire  Lsu_i_io_in_mem_wen; // @[EXU.scala 28:35]
  wire [31:0] Lsu_i_io_in_addr; // @[EXU.scala 28:35]
  wire [31:0] Lsu_i_io_in_wdata; // @[EXU.scala 28:35]
  wire [3:0] Lsu_i_io_in_op; // @[EXU.scala 28:35]
  wire [31:0] Lsu_i_io_out_rdata; // @[EXU.scala 28:35]
  wire  Lsu_i_io_out_end; // @[EXU.scala 28:35]
  wire  Lsu_i_io_out_idle; // @[EXU.scala 28:35]
  wire  Lsu_i_to_cache_ready; // @[EXU.scala 28:35]
  wire  Lsu_i_to_cache_valid; // @[EXU.scala 28:35]
  wire [31:0] Lsu_i_to_cache_bits_addr; // @[EXU.scala 28:35]
  wire [31:0] Lsu_i_to_cache_bits_wdata; // @[EXU.scala 28:35]
  wire  Lsu_i_to_cache_bits_is_write; // @[EXU.scala 28:35]
  wire [31:0] Lsu_i_to_cache_bits_wmask; // @[EXU.scala 28:35]
  wire  Lsu_i_from_cache_ready; // @[EXU.scala 28:35]
  wire  Lsu_i_from_cache_valid; // @[EXU.scala 28:35]
  wire [31:0] Lsu_i_from_cache_bits_data; // @[EXU.scala 28:35]
  wire  Lsu_i_from_cache_bits_bresp; // @[EXU.scala 28:35]
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
  Lsu_cache Lsu_i ( // @[EXU.scala 28:35]
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
    .to_cache_ready(Lsu_i_to_cache_ready),
    .to_cache_valid(Lsu_i_to_cache_valid),
    .to_cache_bits_addr(Lsu_i_to_cache_bits_addr),
    .to_cache_bits_wdata(Lsu_i_to_cache_bits_wdata),
    .to_cache_bits_is_write(Lsu_i_to_cache_bits_is_write),
    .to_cache_bits_wmask(Lsu_i_to_cache_bits_wmask),
    .from_cache_ready(Lsu_i_from_cache_ready),
    .from_cache_valid(Lsu_i_from_cache_valid),
    .from_cache_bits_data(Lsu_i_from_cache_bits_data),
    .from_cache_bits_bresp(Lsu_i_from_cache_bits_bresp)
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
  assign lsu_to_cache_valid = Lsu_i_to_cache_valid; // @[EXU.scala 122:20]
  assign lsu_to_cache_bits_addr = Lsu_i_to_cache_bits_addr; // @[EXU.scala 122:20]
  assign lsu_to_cache_bits_wdata = Lsu_i_to_cache_bits_wdata; // @[EXU.scala 122:20]
  assign lsu_to_cache_bits_is_write = Lsu_i_to_cache_bits_is_write; // @[EXU.scala 122:20]
  assign lsu_to_cache_bits_wmask = Lsu_i_to_cache_bits_wmask; // @[EXU.scala 122:20]
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
  assign Lsu_i_to_cache_ready = lsu_to_cache_ready; // @[EXU.scala 122:20]
  assign Lsu_i_from_cache_valid = lsu_from_cache_valid; // @[EXU.scala 123:20]
  assign Lsu_i_from_cache_bits_data = lsu_from_cache_bits_data; // @[EXU.scala 123:20]
  assign Lsu_i_from_cache_bits_bresp = lsu_from_cache_bits_bresp; // @[EXU.scala 123:20]
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
module IFU(
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
  input         axi_ar_ready,
  output        axi_ar_valid,
  output [31:0] axi_ar_bits_addr,
  output        axi_r_ready,
  input         axi_r_valid,
  input  [31:0] axi_r_bits_data
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] reg_PC; // @[IFU.scala 34:26]
  wire [31:0] _next_PC_T_1 = reg_PC + 32'h4; // @[IFU.scala 42:27]
  wire  _reg_PC_T = from_WBU_ready & from_WBU_valid; // @[Decoupled.scala 51:35]
  reg [1:0] state_ifu; // @[IFU.scala 50:28]
  wire  _state_ifu_T = axi_ar_ready & axi_ar_valid; // @[Decoupled.scala 51:35]
  wire [1:0] _state_ifu_T_1 = _state_ifu_T ? 2'h1 : 2'h0; // @[IFU.scala 52:26]
  wire  _state_ifu_T_2 = axi_r_ready & axi_r_valid; // @[Decoupled.scala 51:35]
  assign to_IDU_valid = 2'h2 == state_ifu; // @[Mux.scala 81:61]
  assign to_IDU_bits_inst = to_IDU_valid ? axi_r_bits_data : 32'h13; // @[IFU.scala 70:28]
  assign to_IDU_bits_pc = reg_PC; // @[IFU.scala 71:22]
  assign from_WBU_ready = 2'h2 == state_ifu; // @[Mux.scala 81:61]
  assign axi_ar_valid = 2'h0 == state_ifu; // @[Mux.scala 81:61]
  assign axi_ar_bits_addr = reg_PC; // @[IFU.scala 59:22]
  assign axi_r_ready = 2'h1 == state_ifu; // @[Mux.scala 81:61]
  always @(posedge clock) begin
    if (reset) begin // @[IFU.scala 34:26]
      reg_PC <= 32'h80000000; // @[IFU.scala 34:26]
    end else if (_reg_PC_T) begin // @[IFU.scala 46:18]
      if (from_EXU_bits_bru_ctrl_br) begin // @[IFU.scala 37:38]
        reg_PC <= from_EXU_bits_bru_addr; // @[IFU.scala 38:17]
      end else if (from_EXU_bits_csr_ctrl_br) begin // @[IFU.scala 39:45]
        reg_PC <= from_EXU_bits_csr_addr; // @[IFU.scala 40:17]
      end else begin
        reg_PC <= _next_PC_T_1; // @[IFU.scala 42:17]
      end
    end
    if (reset) begin // @[IFU.scala 50:28]
      state_ifu <= 2'h0; // @[IFU.scala 50:28]
    end else if (2'h2 == state_ifu) begin // @[Mux.scala 81:58]
      if (_reg_PC_T) begin // @[IFU.scala 54:28]
        state_ifu <= 2'h0;
      end else begin
        state_ifu <= 2'h2;
      end
    end else if (2'h1 == state_ifu) begin // @[Mux.scala 81:58]
      if (_state_ifu_T_2) begin // @[IFU.scala 53:28]
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
module SRAM(
  input         clock,
  input         reset,
  output        axi_ar_ready,
  input         axi_ar_valid,
  input  [31:0] axi_ar_bits_addr,
  input         axi_r_ready,
  output        axi_r_valid,
  output [31:0] axi_r_bits_data
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire  RamBB_i1_clock; // @[sram_AxiLite.scala 77:26]
  wire [31:0] RamBB_i1_addr; // @[sram_AxiLite.scala 77:26]
  wire  RamBB_i1_mem_wen; // @[sram_AxiLite.scala 77:26]
  wire  RamBB_i1_valid; // @[sram_AxiLite.scala 77:26]
  wire [31:0] RamBB_i1_wdata; // @[sram_AxiLite.scala 77:26]
  wire [3:0] RamBB_i1_wmask; // @[sram_AxiLite.scala 77:26]
  wire [31:0] RamBB_i1_rdata; // @[sram_AxiLite.scala 77:26]
  reg  delay; // @[sram_AxiLite.scala 42:24]
  reg [2:0] state; // @[sram_AxiLite.scala 46:24]
  wire  _T_1 = axi_ar_ready & axi_ar_valid; // @[Decoupled.scala 51:35]
  wire  _state_T = ~delay; // @[sram_AxiLite.scala 62:32]
  wire  _delay_T_1 = delay - 1'h1; // @[sram_AxiLite.scala 63:28]
  wire  _T_6 = 3'h2 == state; // @[sram_AxiLite.scala 47:20]
  wire  _state_T_2 = axi_r_ready & axi_r_valid; // @[Decoupled.scala 51:35]
  wire [2:0] _state_T_3 = _state_T_2 ? 3'h0 : 3'h2; // @[sram_AxiLite.scala 66:25]
  wire [2:0] _state_T_5 = _state_T ? 3'h4 : 3'h3; // @[sram_AxiLite.scala 69:25]
  wire  _T_8 = 3'h4 == state; // @[sram_AxiLite.scala 47:20]
  wire [2:0] _GEN_2 = 3'h4 == state ? 3'h4 : state; // @[sram_AxiLite.scala 47:20 73:19 46:24]
  wire [2:0] _GEN_3 = 3'h3 == state ? _state_T_5 : _GEN_2; // @[sram_AxiLite.scala 47:20 69:19]
  wire  _GEN_4 = 3'h3 == state ? _delay_T_1 : delay; // @[sram_AxiLite.scala 47:20 70:19 42:24]
  wire [31:0] _RamBB_i1_io_addr_T_1 = _T_6 ? axi_ar_bits_addr : 32'h0; // @[Mux.scala 81:58]
  RamBB RamBB_i1 ( // @[sram_AxiLite.scala 77:26]
    .clock(RamBB_i1_clock),
    .addr(RamBB_i1_addr),
    .mem_wen(RamBB_i1_mem_wen),
    .valid(RamBB_i1_valid),
    .wdata(RamBB_i1_wdata),
    .wmask(RamBB_i1_wmask),
    .rdata(RamBB_i1_rdata)
  );
  assign axi_ar_ready = 3'h0 == state; // @[Mux.scala 81:61]
  assign axi_r_valid = 3'h2 == state; // @[Mux.scala 81:61]
  assign axi_r_bits_data = RamBB_i1_rdata; // @[sram_AxiLite.scala 96:21]
  assign RamBB_i1_clock = clock; // @[sram_AxiLite.scala 78:25]
  assign RamBB_i1_addr = _T_8 ? 32'h0 : _RamBB_i1_io_addr_T_1; // @[Mux.scala 81:58]
  assign RamBB_i1_mem_wen = 3'h4 == state; // @[Mux.scala 81:61]
  assign RamBB_i1_valid = _T_8 | _T_6; // @[Mux.scala 81:58]
  assign RamBB_i1_wdata = 32'h0; // @[sram_AxiLite.scala 90:25]
  assign RamBB_i1_wmask = 4'h0; // @[sram_AxiLite.scala 91:25]
  always @(posedge clock) begin
    if (reset) begin // @[sram_AxiLite.scala 42:24]
      delay <= 1'h0; // @[sram_AxiLite.scala 42:24]
    end else if (3'h0 == state) begin // @[sram_AxiLite.scala 47:20]
      delay <= 1'h0; // @[sram_AxiLite.scala 49:19]
    end else if (3'h1 == state) begin // @[sram_AxiLite.scala 47:20]
      delay <= delay - 1'h1; // @[sram_AxiLite.scala 63:19]
    end else if (!(3'h2 == state)) begin // @[sram_AxiLite.scala 47:20]
      delay <= _GEN_4;
    end
    if (reset) begin // @[sram_AxiLite.scala 46:24]
      state <= 3'h0; // @[sram_AxiLite.scala 46:24]
    end else if (3'h0 == state) begin // @[sram_AxiLite.scala 47:20]
      if (_T_1) begin // @[sram_AxiLite.scala 51:32]
        state <= 3'h1; // @[sram_AxiLite.scala 52:23]
      end else begin
        state <= 3'h0;
      end
    end else if (3'h1 == state) begin // @[sram_AxiLite.scala 47:20]
      if (~delay) begin // @[sram_AxiLite.scala 62:25]
        state <= 3'h2;
      end else begin
        state <= 3'h1;
      end
    end else if (3'h2 == state) begin // @[sram_AxiLite.scala 47:20]
      state <= _state_T_3; // @[sram_AxiLite.scala 66:19]
    end else begin
      state <= _GEN_3;
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
  state = _RAND_1[2:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module D_Cache(
  input         clock,
  input         reset,
  output        from_LSU_ready,
  input         from_LSU_valid,
  input  [31:0] from_LSU_bits_addr,
  input  [31:0] from_LSU_bits_wdata,
  input         from_LSU_bits_is_write,
  input  [31:0] from_LSU_bits_wmask,
  output        to_LSU_valid,
  output [31:0] to_LSU_bits_data,
  output        to_LSU_bits_bresp,
  input         to_sram_ar_ready,
  output        to_sram_ar_valid,
  output [31:0] to_sram_ar_bits_addr,
  output [7:0]  to_sram_ar_bits_len,
  output        to_sram_r_ready,
  input         to_sram_r_valid,
  input  [31:0] to_sram_r_bits_data,
  input         to_sram_r_bits_last,
  input         to_sram_aw_ready,
  output        to_sram_aw_valid,
  output [31:0] to_sram_aw_bits_addr,
  output [7:0]  to_sram_aw_bits_len,
  input         to_sram_w_ready,
  output        to_sram_w_valid,
  output [31:0] to_sram_w_bits_data,
  output        to_sram_w_bits_last
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_42;
  reg [31:0] _RAND_49;
  reg [31:0] _RAND_56;
  reg [31:0] _RAND_63;
  reg [31:0] _RAND_70;
  reg [31:0] _RAND_77;
  reg [31:0] _RAND_84;
  reg [31:0] _RAND_91;
  reg [31:0] _RAND_98;
  reg [31:0] _RAND_105;
  reg [31:0] _RAND_112;
  reg [31:0] _RAND_119;
  reg [31:0] _RAND_126;
  reg [31:0] _RAND_133;
  reg [31:0] _RAND_140;
  reg [31:0] _RAND_147;
  reg [31:0] _RAND_154;
  reg [31:0] _RAND_161;
  reg [31:0] _RAND_168;
  reg [31:0] _RAND_175;
  reg [31:0] _RAND_182;
  reg [31:0] _RAND_189;
  reg [31:0] _RAND_196;
  reg [31:0] _RAND_203;
  reg [31:0] _RAND_210;
  reg [31:0] _RAND_217;
  reg [31:0] _RAND_224;
  reg [31:0] _RAND_231;
  reg [31:0] _RAND_238;
  reg [31:0] _RAND_245;
  reg [31:0] _RAND_252;
  reg [31:0] _RAND_259;
  reg [31:0] _RAND_266;
  reg [31:0] _RAND_273;
  reg [31:0] _RAND_280;
  reg [31:0] _RAND_287;
  reg [31:0] _RAND_294;
  reg [31:0] _RAND_301;
  reg [31:0] _RAND_308;
  reg [31:0] _RAND_315;
  reg [31:0] _RAND_322;
  reg [31:0] _RAND_329;
  reg [31:0] _RAND_336;
  reg [31:0] _RAND_343;
  reg [31:0] _RAND_350;
  reg [31:0] _RAND_357;
  reg [31:0] _RAND_364;
  reg [31:0] _RAND_371;
  reg [31:0] _RAND_378;
  reg [31:0] _RAND_385;
  reg [31:0] _RAND_392;
  reg [31:0] _RAND_399;
  reg [31:0] _RAND_406;
  reg [31:0] _RAND_413;
  reg [31:0] _RAND_420;
  reg [31:0] _RAND_427;
  reg [31:0] _RAND_434;
  reg [31:0] _RAND_441;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [31:0] _RAND_33;
  reg [31:0] _RAND_34;
  reg [31:0] _RAND_36;
  reg [31:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [31:0] _RAND_39;
  reg [31:0] _RAND_40;
  reg [31:0] _RAND_41;
  reg [31:0] _RAND_43;
  reg [31:0] _RAND_44;
  reg [31:0] _RAND_45;
  reg [31:0] _RAND_46;
  reg [31:0] _RAND_47;
  reg [31:0] _RAND_48;
  reg [31:0] _RAND_50;
  reg [31:0] _RAND_51;
  reg [31:0] _RAND_52;
  reg [31:0] _RAND_53;
  reg [31:0] _RAND_54;
  reg [31:0] _RAND_55;
  reg [31:0] _RAND_57;
  reg [31:0] _RAND_58;
  reg [31:0] _RAND_59;
  reg [31:0] _RAND_60;
  reg [31:0] _RAND_61;
  reg [31:0] _RAND_62;
  reg [31:0] _RAND_64;
  reg [31:0] _RAND_65;
  reg [31:0] _RAND_66;
  reg [31:0] _RAND_67;
  reg [31:0] _RAND_68;
  reg [31:0] _RAND_69;
  reg [31:0] _RAND_71;
  reg [31:0] _RAND_72;
  reg [31:0] _RAND_73;
  reg [31:0] _RAND_74;
  reg [31:0] _RAND_75;
  reg [31:0] _RAND_76;
  reg [31:0] _RAND_78;
  reg [31:0] _RAND_79;
  reg [31:0] _RAND_80;
  reg [31:0] _RAND_81;
  reg [31:0] _RAND_82;
  reg [31:0] _RAND_83;
  reg [31:0] _RAND_85;
  reg [31:0] _RAND_86;
  reg [31:0] _RAND_87;
  reg [31:0] _RAND_88;
  reg [31:0] _RAND_89;
  reg [31:0] _RAND_90;
  reg [31:0] _RAND_92;
  reg [31:0] _RAND_93;
  reg [31:0] _RAND_94;
  reg [31:0] _RAND_95;
  reg [31:0] _RAND_96;
  reg [31:0] _RAND_97;
  reg [31:0] _RAND_99;
  reg [31:0] _RAND_100;
  reg [31:0] _RAND_101;
  reg [31:0] _RAND_102;
  reg [31:0] _RAND_103;
  reg [31:0] _RAND_104;
  reg [31:0] _RAND_106;
  reg [31:0] _RAND_107;
  reg [31:0] _RAND_108;
  reg [31:0] _RAND_109;
  reg [31:0] _RAND_110;
  reg [31:0] _RAND_111;
  reg [31:0] _RAND_113;
  reg [31:0] _RAND_114;
  reg [31:0] _RAND_115;
  reg [31:0] _RAND_116;
  reg [31:0] _RAND_117;
  reg [31:0] _RAND_118;
  reg [31:0] _RAND_120;
  reg [31:0] _RAND_121;
  reg [31:0] _RAND_122;
  reg [31:0] _RAND_123;
  reg [31:0] _RAND_124;
  reg [31:0] _RAND_125;
  reg [31:0] _RAND_127;
  reg [31:0] _RAND_128;
  reg [31:0] _RAND_129;
  reg [31:0] _RAND_130;
  reg [31:0] _RAND_131;
  reg [31:0] _RAND_132;
  reg [31:0] _RAND_134;
  reg [31:0] _RAND_135;
  reg [31:0] _RAND_136;
  reg [31:0] _RAND_137;
  reg [31:0] _RAND_138;
  reg [31:0] _RAND_139;
  reg [31:0] _RAND_141;
  reg [31:0] _RAND_142;
  reg [31:0] _RAND_143;
  reg [31:0] _RAND_144;
  reg [31:0] _RAND_145;
  reg [31:0] _RAND_146;
  reg [31:0] _RAND_148;
  reg [31:0] _RAND_149;
  reg [31:0] _RAND_150;
  reg [31:0] _RAND_151;
  reg [31:0] _RAND_152;
  reg [31:0] _RAND_153;
  reg [31:0] _RAND_155;
  reg [31:0] _RAND_156;
  reg [31:0] _RAND_157;
  reg [31:0] _RAND_158;
  reg [31:0] _RAND_159;
  reg [31:0] _RAND_160;
  reg [31:0] _RAND_162;
  reg [31:0] _RAND_163;
  reg [31:0] _RAND_164;
  reg [31:0] _RAND_165;
  reg [31:0] _RAND_166;
  reg [31:0] _RAND_167;
  reg [31:0] _RAND_169;
  reg [31:0] _RAND_170;
  reg [31:0] _RAND_171;
  reg [31:0] _RAND_172;
  reg [31:0] _RAND_173;
  reg [31:0] _RAND_174;
  reg [31:0] _RAND_176;
  reg [31:0] _RAND_177;
  reg [31:0] _RAND_178;
  reg [31:0] _RAND_179;
  reg [31:0] _RAND_180;
  reg [31:0] _RAND_181;
  reg [31:0] _RAND_183;
  reg [31:0] _RAND_184;
  reg [31:0] _RAND_185;
  reg [31:0] _RAND_186;
  reg [31:0] _RAND_187;
  reg [31:0] _RAND_188;
  reg [31:0] _RAND_190;
  reg [31:0] _RAND_191;
  reg [31:0] _RAND_192;
  reg [31:0] _RAND_193;
  reg [31:0] _RAND_194;
  reg [31:0] _RAND_195;
  reg [31:0] _RAND_197;
  reg [31:0] _RAND_198;
  reg [31:0] _RAND_199;
  reg [31:0] _RAND_200;
  reg [31:0] _RAND_201;
  reg [31:0] _RAND_202;
  reg [31:0] _RAND_204;
  reg [31:0] _RAND_205;
  reg [31:0] _RAND_206;
  reg [31:0] _RAND_207;
  reg [31:0] _RAND_208;
  reg [31:0] _RAND_209;
  reg [31:0] _RAND_211;
  reg [31:0] _RAND_212;
  reg [31:0] _RAND_213;
  reg [31:0] _RAND_214;
  reg [31:0] _RAND_215;
  reg [31:0] _RAND_216;
  reg [31:0] _RAND_218;
  reg [31:0] _RAND_219;
  reg [31:0] _RAND_220;
  reg [31:0] _RAND_221;
  reg [31:0] _RAND_222;
  reg [31:0] _RAND_223;
  reg [31:0] _RAND_225;
  reg [31:0] _RAND_226;
  reg [31:0] _RAND_227;
  reg [31:0] _RAND_228;
  reg [31:0] _RAND_229;
  reg [31:0] _RAND_230;
  reg [31:0] _RAND_232;
  reg [31:0] _RAND_233;
  reg [31:0] _RAND_234;
  reg [31:0] _RAND_235;
  reg [31:0] _RAND_236;
  reg [31:0] _RAND_237;
  reg [31:0] _RAND_239;
  reg [31:0] _RAND_240;
  reg [31:0] _RAND_241;
  reg [31:0] _RAND_242;
  reg [31:0] _RAND_243;
  reg [31:0] _RAND_244;
  reg [31:0] _RAND_246;
  reg [31:0] _RAND_247;
  reg [31:0] _RAND_248;
  reg [31:0] _RAND_249;
  reg [31:0] _RAND_250;
  reg [31:0] _RAND_251;
  reg [31:0] _RAND_253;
  reg [31:0] _RAND_254;
  reg [31:0] _RAND_255;
  reg [31:0] _RAND_256;
  reg [31:0] _RAND_257;
  reg [31:0] _RAND_258;
  reg [31:0] _RAND_260;
  reg [31:0] _RAND_261;
  reg [31:0] _RAND_262;
  reg [31:0] _RAND_263;
  reg [31:0] _RAND_264;
  reg [31:0] _RAND_265;
  reg [31:0] _RAND_267;
  reg [31:0] _RAND_268;
  reg [31:0] _RAND_269;
  reg [31:0] _RAND_270;
  reg [31:0] _RAND_271;
  reg [31:0] _RAND_272;
  reg [31:0] _RAND_274;
  reg [31:0] _RAND_275;
  reg [31:0] _RAND_276;
  reg [31:0] _RAND_277;
  reg [31:0] _RAND_278;
  reg [31:0] _RAND_279;
  reg [31:0] _RAND_281;
  reg [31:0] _RAND_282;
  reg [31:0] _RAND_283;
  reg [31:0] _RAND_284;
  reg [31:0] _RAND_285;
  reg [31:0] _RAND_286;
  reg [31:0] _RAND_288;
  reg [31:0] _RAND_289;
  reg [31:0] _RAND_290;
  reg [31:0] _RAND_291;
  reg [31:0] _RAND_292;
  reg [31:0] _RAND_293;
  reg [31:0] _RAND_295;
  reg [31:0] _RAND_296;
  reg [31:0] _RAND_297;
  reg [31:0] _RAND_298;
  reg [31:0] _RAND_299;
  reg [31:0] _RAND_300;
  reg [31:0] _RAND_302;
  reg [31:0] _RAND_303;
  reg [31:0] _RAND_304;
  reg [31:0] _RAND_305;
  reg [31:0] _RAND_306;
  reg [31:0] _RAND_307;
  reg [31:0] _RAND_309;
  reg [31:0] _RAND_310;
  reg [31:0] _RAND_311;
  reg [31:0] _RAND_312;
  reg [31:0] _RAND_313;
  reg [31:0] _RAND_314;
  reg [31:0] _RAND_316;
  reg [31:0] _RAND_317;
  reg [31:0] _RAND_318;
  reg [31:0] _RAND_319;
  reg [31:0] _RAND_320;
  reg [31:0] _RAND_321;
  reg [31:0] _RAND_323;
  reg [31:0] _RAND_324;
  reg [31:0] _RAND_325;
  reg [31:0] _RAND_326;
  reg [31:0] _RAND_327;
  reg [31:0] _RAND_328;
  reg [31:0] _RAND_330;
  reg [31:0] _RAND_331;
  reg [31:0] _RAND_332;
  reg [31:0] _RAND_333;
  reg [31:0] _RAND_334;
  reg [31:0] _RAND_335;
  reg [31:0] _RAND_337;
  reg [31:0] _RAND_338;
  reg [31:0] _RAND_339;
  reg [31:0] _RAND_340;
  reg [31:0] _RAND_341;
  reg [31:0] _RAND_342;
  reg [31:0] _RAND_344;
  reg [31:0] _RAND_345;
  reg [31:0] _RAND_346;
  reg [31:0] _RAND_347;
  reg [31:0] _RAND_348;
  reg [31:0] _RAND_349;
  reg [31:0] _RAND_351;
  reg [31:0] _RAND_352;
  reg [31:0] _RAND_353;
  reg [31:0] _RAND_354;
  reg [31:0] _RAND_355;
  reg [31:0] _RAND_356;
  reg [31:0] _RAND_358;
  reg [31:0] _RAND_359;
  reg [31:0] _RAND_360;
  reg [31:0] _RAND_361;
  reg [31:0] _RAND_362;
  reg [31:0] _RAND_363;
  reg [31:0] _RAND_365;
  reg [31:0] _RAND_366;
  reg [31:0] _RAND_367;
  reg [31:0] _RAND_368;
  reg [31:0] _RAND_369;
  reg [31:0] _RAND_370;
  reg [31:0] _RAND_372;
  reg [31:0] _RAND_373;
  reg [31:0] _RAND_374;
  reg [31:0] _RAND_375;
  reg [31:0] _RAND_376;
  reg [31:0] _RAND_377;
  reg [31:0] _RAND_379;
  reg [31:0] _RAND_380;
  reg [31:0] _RAND_381;
  reg [31:0] _RAND_382;
  reg [31:0] _RAND_383;
  reg [31:0] _RAND_384;
  reg [31:0] _RAND_386;
  reg [31:0] _RAND_387;
  reg [31:0] _RAND_388;
  reg [31:0] _RAND_389;
  reg [31:0] _RAND_390;
  reg [31:0] _RAND_391;
  reg [31:0] _RAND_393;
  reg [31:0] _RAND_394;
  reg [31:0] _RAND_395;
  reg [31:0] _RAND_396;
  reg [31:0] _RAND_397;
  reg [31:0] _RAND_398;
  reg [31:0] _RAND_400;
  reg [31:0] _RAND_401;
  reg [31:0] _RAND_402;
  reg [31:0] _RAND_403;
  reg [31:0] _RAND_404;
  reg [31:0] _RAND_405;
  reg [31:0] _RAND_407;
  reg [31:0] _RAND_408;
  reg [31:0] _RAND_409;
  reg [31:0] _RAND_410;
  reg [31:0] _RAND_411;
  reg [31:0] _RAND_412;
  reg [31:0] _RAND_414;
  reg [31:0] _RAND_415;
  reg [31:0] _RAND_416;
  reg [31:0] _RAND_417;
  reg [31:0] _RAND_418;
  reg [31:0] _RAND_419;
  reg [31:0] _RAND_421;
  reg [31:0] _RAND_422;
  reg [31:0] _RAND_423;
  reg [31:0] _RAND_424;
  reg [31:0] _RAND_425;
  reg [31:0] _RAND_426;
  reg [31:0] _RAND_428;
  reg [31:0] _RAND_429;
  reg [31:0] _RAND_430;
  reg [31:0] _RAND_431;
  reg [31:0] _RAND_432;
  reg [31:0] _RAND_433;
  reg [31:0] _RAND_435;
  reg [31:0] _RAND_436;
  reg [31:0] _RAND_437;
  reg [31:0] _RAND_438;
  reg [31:0] _RAND_439;
  reg [31:0] _RAND_440;
  reg [31:0] _RAND_442;
  reg [31:0] _RAND_443;
  reg [31:0] _RAND_444;
  reg [31:0] _RAND_445;
  reg [31:0] _RAND_446;
  reg [31:0] _RAND_447;
  reg [31:0] _RAND_448;
  reg [31:0] _RAND_449;
  reg [31:0] _RAND_450;
  reg [31:0] _RAND_451;
  reg [31:0] _RAND_452;
  reg [31:0] _RAND_453;
  reg [31:0] _RAND_454;
  reg [31:0] _RAND_455;
  reg [31:0] _RAND_456;
  reg [31:0] _RAND_457;
  reg [31:0] _RAND_458;
  reg [31:0] _RAND_459;
  reg [31:0] _RAND_460;
  reg [31:0] _RAND_461;
  reg [31:0] _RAND_462;
  reg [31:0] _RAND_463;
  reg [31:0] _RAND_464;
  reg [31:0] _RAND_465;
  reg [31:0] _RAND_466;
  reg [31:0] _RAND_467;
  reg [31:0] _RAND_468;
  reg [31:0] _RAND_469;
  reg [31:0] _RAND_470;
  reg [31:0] _RAND_471;
  reg [31:0] _RAND_472;
  reg [31:0] _RAND_473;
  reg [31:0] _RAND_474;
  reg [31:0] _RAND_475;
  reg [31:0] _RAND_476;
  reg [31:0] _RAND_477;
  reg [31:0] _RAND_478;
  reg [31:0] _RAND_479;
  reg [31:0] _RAND_480;
  reg [31:0] _RAND_481;
  reg [31:0] _RAND_482;
  reg [31:0] _RAND_483;
  reg [31:0] _RAND_484;
  reg [31:0] _RAND_485;
  reg [31:0] _RAND_486;
  reg [31:0] _RAND_487;
  reg [31:0] _RAND_488;
  reg [31:0] _RAND_489;
  reg [31:0] _RAND_490;
  reg [31:0] _RAND_491;
  reg [31:0] _RAND_492;
  reg [31:0] _RAND_493;
  reg [31:0] _RAND_494;
  reg [31:0] _RAND_495;
  reg [31:0] _RAND_496;
  reg [31:0] _RAND_497;
  reg [31:0] _RAND_498;
  reg [31:0] _RAND_499;
  reg [31:0] _RAND_500;
  reg [31:0] _RAND_501;
  reg [31:0] _RAND_502;
  reg [31:0] _RAND_503;
  reg [31:0] _RAND_504;
  reg [31:0] _RAND_505;
  reg [31:0] _RAND_506;
  reg [31:0] _RAND_507;
  reg [31:0] _RAND_508;
  reg [31:0] _RAND_509;
  reg [31:0] _RAND_510;
  reg [31:0] _RAND_511;
  reg [31:0] _RAND_512;
  reg [31:0] _RAND_513;
  reg [31:0] _RAND_514;
  reg [31:0] _RAND_515;
  reg [31:0] _RAND_516;
  reg [31:0] _RAND_517;
  reg [31:0] _RAND_518;
  reg [31:0] _RAND_519;
  reg [31:0] _RAND_520;
  reg [31:0] _RAND_521;
  reg [31:0] _RAND_522;
  reg [31:0] _RAND_523;
  reg [31:0] _RAND_524;
  reg [31:0] _RAND_525;
  reg [31:0] _RAND_526;
  reg [31:0] _RAND_527;
  reg [31:0] _RAND_528;
  reg [31:0] _RAND_529;
  reg [31:0] _RAND_530;
  reg [31:0] _RAND_531;
  reg [31:0] _RAND_532;
  reg [31:0] _RAND_533;
  reg [31:0] _RAND_534;
  reg [31:0] _RAND_535;
  reg [31:0] _RAND_536;
  reg [31:0] _RAND_537;
  reg [31:0] _RAND_538;
  reg [31:0] _RAND_539;
  reg [31:0] _RAND_540;
  reg [31:0] _RAND_541;
  reg [31:0] _RAND_542;
  reg [31:0] _RAND_543;
  reg [31:0] _RAND_544;
  reg [31:0] _RAND_545;
  reg [31:0] _RAND_546;
  reg [31:0] _RAND_547;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] dataArray_0_0 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_0_0_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_0_0_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_0_0_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_0_0_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_0_0_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_0_0_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_0_0_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_0_0_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_0_0_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_0_0_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_0_0_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_0_0_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_0_0_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_0_0_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_0_0_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_0_0_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_0_0_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_0_0_cachedata_MPORT_en_pipe_0;
  reg  dataArray_0_0_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_0_0_outdata_MPORT_en_pipe_0;
  reg  dataArray_0_0_outdata_MPORT_addr_pipe_0;
  reg  dataArray_0_0_toMemData_MPORT_en_pipe_0;
  reg  dataArray_0_0_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_0_1 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_0_1_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_0_1_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_0_1_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_0_1_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_0_1_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_0_1_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_0_1_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_0_1_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_0_1_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_0_1_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_0_1_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_0_1_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_0_1_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_0_1_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_0_1_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_0_1_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_0_1_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_0_1_cachedata_MPORT_en_pipe_0;
  reg  dataArray_0_1_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_0_1_outdata_MPORT_en_pipe_0;
  reg  dataArray_0_1_outdata_MPORT_addr_pipe_0;
  reg  dataArray_0_1_toMemData_MPORT_en_pipe_0;
  reg  dataArray_0_1_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_0_2 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_0_2_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_0_2_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_0_2_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_0_2_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_0_2_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_0_2_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_0_2_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_0_2_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_0_2_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_0_2_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_0_2_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_0_2_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_0_2_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_0_2_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_0_2_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_0_2_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_0_2_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_0_2_cachedata_MPORT_en_pipe_0;
  reg  dataArray_0_2_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_0_2_outdata_MPORT_en_pipe_0;
  reg  dataArray_0_2_outdata_MPORT_addr_pipe_0;
  reg  dataArray_0_2_toMemData_MPORT_en_pipe_0;
  reg  dataArray_0_2_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_0_3 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_0_3_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_0_3_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_0_3_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_0_3_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_0_3_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_0_3_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_0_3_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_0_3_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_0_3_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_0_3_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_0_3_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_0_3_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_0_3_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_0_3_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_0_3_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_0_3_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_0_3_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_0_3_cachedata_MPORT_en_pipe_0;
  reg  dataArray_0_3_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_0_3_outdata_MPORT_en_pipe_0;
  reg  dataArray_0_3_outdata_MPORT_addr_pipe_0;
  reg  dataArray_0_3_toMemData_MPORT_en_pipe_0;
  reg  dataArray_0_3_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_1_0 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_1_0_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_1_0_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_1_0_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_1_0_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_1_0_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_1_0_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_1_0_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_1_0_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_1_0_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_1_0_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_1_0_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_1_0_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_1_0_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_1_0_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_1_0_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_1_0_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_1_0_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_1_0_cachedata_MPORT_en_pipe_0;
  reg  dataArray_1_0_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_1_0_outdata_MPORT_en_pipe_0;
  reg  dataArray_1_0_outdata_MPORT_addr_pipe_0;
  reg  dataArray_1_0_toMemData_MPORT_en_pipe_0;
  reg  dataArray_1_0_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_1_1 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_1_1_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_1_1_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_1_1_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_1_1_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_1_1_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_1_1_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_1_1_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_1_1_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_1_1_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_1_1_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_1_1_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_1_1_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_1_1_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_1_1_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_1_1_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_1_1_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_1_1_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_1_1_cachedata_MPORT_en_pipe_0;
  reg  dataArray_1_1_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_1_1_outdata_MPORT_en_pipe_0;
  reg  dataArray_1_1_outdata_MPORT_addr_pipe_0;
  reg  dataArray_1_1_toMemData_MPORT_en_pipe_0;
  reg  dataArray_1_1_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_1_2 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_1_2_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_1_2_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_1_2_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_1_2_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_1_2_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_1_2_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_1_2_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_1_2_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_1_2_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_1_2_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_1_2_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_1_2_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_1_2_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_1_2_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_1_2_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_1_2_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_1_2_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_1_2_cachedata_MPORT_en_pipe_0;
  reg  dataArray_1_2_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_1_2_outdata_MPORT_en_pipe_0;
  reg  dataArray_1_2_outdata_MPORT_addr_pipe_0;
  reg  dataArray_1_2_toMemData_MPORT_en_pipe_0;
  reg  dataArray_1_2_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_1_3 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_1_3_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_1_3_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_1_3_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_1_3_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_1_3_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_1_3_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_1_3_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_1_3_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_1_3_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_1_3_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_1_3_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_1_3_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_1_3_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_1_3_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_1_3_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_1_3_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_1_3_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_1_3_cachedata_MPORT_en_pipe_0;
  reg  dataArray_1_3_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_1_3_outdata_MPORT_en_pipe_0;
  reg  dataArray_1_3_outdata_MPORT_addr_pipe_0;
  reg  dataArray_1_3_toMemData_MPORT_en_pipe_0;
  reg  dataArray_1_3_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_2_0 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_2_0_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_2_0_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_2_0_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_2_0_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_2_0_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_2_0_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_2_0_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_2_0_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_2_0_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_2_0_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_2_0_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_2_0_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_2_0_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_2_0_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_2_0_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_2_0_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_2_0_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_2_0_cachedata_MPORT_en_pipe_0;
  reg  dataArray_2_0_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_2_0_outdata_MPORT_en_pipe_0;
  reg  dataArray_2_0_outdata_MPORT_addr_pipe_0;
  reg  dataArray_2_0_toMemData_MPORT_en_pipe_0;
  reg  dataArray_2_0_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_2_1 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_2_1_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_2_1_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_2_1_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_2_1_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_2_1_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_2_1_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_2_1_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_2_1_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_2_1_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_2_1_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_2_1_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_2_1_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_2_1_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_2_1_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_2_1_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_2_1_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_2_1_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_2_1_cachedata_MPORT_en_pipe_0;
  reg  dataArray_2_1_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_2_1_outdata_MPORT_en_pipe_0;
  reg  dataArray_2_1_outdata_MPORT_addr_pipe_0;
  reg  dataArray_2_1_toMemData_MPORT_en_pipe_0;
  reg  dataArray_2_1_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_2_2 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_2_2_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_2_2_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_2_2_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_2_2_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_2_2_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_2_2_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_2_2_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_2_2_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_2_2_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_2_2_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_2_2_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_2_2_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_2_2_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_2_2_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_2_2_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_2_2_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_2_2_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_2_2_cachedata_MPORT_en_pipe_0;
  reg  dataArray_2_2_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_2_2_outdata_MPORT_en_pipe_0;
  reg  dataArray_2_2_outdata_MPORT_addr_pipe_0;
  reg  dataArray_2_2_toMemData_MPORT_en_pipe_0;
  reg  dataArray_2_2_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_2_3 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_2_3_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_2_3_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_2_3_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_2_3_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_2_3_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_2_3_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_2_3_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_2_3_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_2_3_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_2_3_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_2_3_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_2_3_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_2_3_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_2_3_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_2_3_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_2_3_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_2_3_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_2_3_cachedata_MPORT_en_pipe_0;
  reg  dataArray_2_3_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_2_3_outdata_MPORT_en_pipe_0;
  reg  dataArray_2_3_outdata_MPORT_addr_pipe_0;
  reg  dataArray_2_3_toMemData_MPORT_en_pipe_0;
  reg  dataArray_2_3_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_3_0 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_3_0_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_3_0_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_3_0_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_3_0_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_3_0_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_3_0_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_3_0_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_3_0_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_3_0_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_3_0_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_3_0_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_3_0_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_3_0_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_3_0_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_3_0_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_3_0_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_3_0_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_3_0_cachedata_MPORT_en_pipe_0;
  reg  dataArray_3_0_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_3_0_outdata_MPORT_en_pipe_0;
  reg  dataArray_3_0_outdata_MPORT_addr_pipe_0;
  reg  dataArray_3_0_toMemData_MPORT_en_pipe_0;
  reg  dataArray_3_0_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_3_1 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_3_1_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_3_1_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_3_1_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_3_1_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_3_1_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_3_1_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_3_1_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_3_1_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_3_1_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_3_1_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_3_1_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_3_1_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_3_1_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_3_1_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_3_1_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_3_1_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_3_1_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_3_1_cachedata_MPORT_en_pipe_0;
  reg  dataArray_3_1_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_3_1_outdata_MPORT_en_pipe_0;
  reg  dataArray_3_1_outdata_MPORT_addr_pipe_0;
  reg  dataArray_3_1_toMemData_MPORT_en_pipe_0;
  reg  dataArray_3_1_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_3_2 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_3_2_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_3_2_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_3_2_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_3_2_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_3_2_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_3_2_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_3_2_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_3_2_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_3_2_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_3_2_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_3_2_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_3_2_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_3_2_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_3_2_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_3_2_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_3_2_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_3_2_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_3_2_cachedata_MPORT_en_pipe_0;
  reg  dataArray_3_2_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_3_2_outdata_MPORT_en_pipe_0;
  reg  dataArray_3_2_outdata_MPORT_addr_pipe_0;
  reg  dataArray_3_2_toMemData_MPORT_en_pipe_0;
  reg  dataArray_3_2_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_3_3 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_3_3_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_3_3_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_3_3_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_3_3_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_3_3_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_3_3_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_3_3_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_3_3_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_3_3_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_3_3_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_3_3_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_3_3_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_3_3_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_3_3_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_3_3_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_3_3_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_3_3_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_3_3_cachedata_MPORT_en_pipe_0;
  reg  dataArray_3_3_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_3_3_outdata_MPORT_en_pipe_0;
  reg  dataArray_3_3_outdata_MPORT_addr_pipe_0;
  reg  dataArray_3_3_toMemData_MPORT_en_pipe_0;
  reg  dataArray_3_3_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_4_0 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_4_0_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_4_0_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_4_0_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_4_0_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_4_0_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_4_0_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_4_0_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_4_0_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_4_0_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_4_0_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_4_0_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_4_0_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_4_0_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_4_0_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_4_0_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_4_0_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_4_0_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_4_0_cachedata_MPORT_en_pipe_0;
  reg  dataArray_4_0_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_4_0_outdata_MPORT_en_pipe_0;
  reg  dataArray_4_0_outdata_MPORT_addr_pipe_0;
  reg  dataArray_4_0_toMemData_MPORT_en_pipe_0;
  reg  dataArray_4_0_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_4_1 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_4_1_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_4_1_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_4_1_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_4_1_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_4_1_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_4_1_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_4_1_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_4_1_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_4_1_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_4_1_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_4_1_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_4_1_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_4_1_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_4_1_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_4_1_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_4_1_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_4_1_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_4_1_cachedata_MPORT_en_pipe_0;
  reg  dataArray_4_1_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_4_1_outdata_MPORT_en_pipe_0;
  reg  dataArray_4_1_outdata_MPORT_addr_pipe_0;
  reg  dataArray_4_1_toMemData_MPORT_en_pipe_0;
  reg  dataArray_4_1_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_4_2 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_4_2_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_4_2_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_4_2_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_4_2_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_4_2_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_4_2_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_4_2_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_4_2_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_4_2_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_4_2_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_4_2_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_4_2_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_4_2_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_4_2_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_4_2_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_4_2_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_4_2_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_4_2_cachedata_MPORT_en_pipe_0;
  reg  dataArray_4_2_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_4_2_outdata_MPORT_en_pipe_0;
  reg  dataArray_4_2_outdata_MPORT_addr_pipe_0;
  reg  dataArray_4_2_toMemData_MPORT_en_pipe_0;
  reg  dataArray_4_2_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_4_3 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_4_3_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_4_3_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_4_3_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_4_3_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_4_3_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_4_3_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_4_3_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_4_3_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_4_3_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_4_3_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_4_3_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_4_3_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_4_3_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_4_3_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_4_3_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_4_3_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_4_3_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_4_3_cachedata_MPORT_en_pipe_0;
  reg  dataArray_4_3_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_4_3_outdata_MPORT_en_pipe_0;
  reg  dataArray_4_3_outdata_MPORT_addr_pipe_0;
  reg  dataArray_4_3_toMemData_MPORT_en_pipe_0;
  reg  dataArray_4_3_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_5_0 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_5_0_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_5_0_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_5_0_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_5_0_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_5_0_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_5_0_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_5_0_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_5_0_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_5_0_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_5_0_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_5_0_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_5_0_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_5_0_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_5_0_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_5_0_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_5_0_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_5_0_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_5_0_cachedata_MPORT_en_pipe_0;
  reg  dataArray_5_0_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_5_0_outdata_MPORT_en_pipe_0;
  reg  dataArray_5_0_outdata_MPORT_addr_pipe_0;
  reg  dataArray_5_0_toMemData_MPORT_en_pipe_0;
  reg  dataArray_5_0_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_5_1 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_5_1_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_5_1_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_5_1_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_5_1_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_5_1_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_5_1_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_5_1_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_5_1_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_5_1_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_5_1_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_5_1_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_5_1_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_5_1_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_5_1_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_5_1_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_5_1_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_5_1_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_5_1_cachedata_MPORT_en_pipe_0;
  reg  dataArray_5_1_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_5_1_outdata_MPORT_en_pipe_0;
  reg  dataArray_5_1_outdata_MPORT_addr_pipe_0;
  reg  dataArray_5_1_toMemData_MPORT_en_pipe_0;
  reg  dataArray_5_1_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_5_2 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_5_2_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_5_2_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_5_2_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_5_2_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_5_2_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_5_2_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_5_2_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_5_2_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_5_2_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_5_2_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_5_2_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_5_2_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_5_2_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_5_2_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_5_2_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_5_2_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_5_2_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_5_2_cachedata_MPORT_en_pipe_0;
  reg  dataArray_5_2_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_5_2_outdata_MPORT_en_pipe_0;
  reg  dataArray_5_2_outdata_MPORT_addr_pipe_0;
  reg  dataArray_5_2_toMemData_MPORT_en_pipe_0;
  reg  dataArray_5_2_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_5_3 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_5_3_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_5_3_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_5_3_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_5_3_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_5_3_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_5_3_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_5_3_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_5_3_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_5_3_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_5_3_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_5_3_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_5_3_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_5_3_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_5_3_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_5_3_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_5_3_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_5_3_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_5_3_cachedata_MPORT_en_pipe_0;
  reg  dataArray_5_3_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_5_3_outdata_MPORT_en_pipe_0;
  reg  dataArray_5_3_outdata_MPORT_addr_pipe_0;
  reg  dataArray_5_3_toMemData_MPORT_en_pipe_0;
  reg  dataArray_5_3_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_6_0 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_6_0_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_6_0_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_6_0_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_6_0_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_6_0_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_6_0_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_6_0_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_6_0_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_6_0_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_6_0_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_6_0_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_6_0_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_6_0_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_6_0_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_6_0_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_6_0_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_6_0_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_6_0_cachedata_MPORT_en_pipe_0;
  reg  dataArray_6_0_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_6_0_outdata_MPORT_en_pipe_0;
  reg  dataArray_6_0_outdata_MPORT_addr_pipe_0;
  reg  dataArray_6_0_toMemData_MPORT_en_pipe_0;
  reg  dataArray_6_0_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_6_1 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_6_1_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_6_1_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_6_1_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_6_1_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_6_1_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_6_1_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_6_1_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_6_1_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_6_1_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_6_1_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_6_1_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_6_1_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_6_1_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_6_1_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_6_1_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_6_1_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_6_1_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_6_1_cachedata_MPORT_en_pipe_0;
  reg  dataArray_6_1_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_6_1_outdata_MPORT_en_pipe_0;
  reg  dataArray_6_1_outdata_MPORT_addr_pipe_0;
  reg  dataArray_6_1_toMemData_MPORT_en_pipe_0;
  reg  dataArray_6_1_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_6_2 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_6_2_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_6_2_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_6_2_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_6_2_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_6_2_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_6_2_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_6_2_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_6_2_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_6_2_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_6_2_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_6_2_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_6_2_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_6_2_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_6_2_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_6_2_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_6_2_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_6_2_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_6_2_cachedata_MPORT_en_pipe_0;
  reg  dataArray_6_2_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_6_2_outdata_MPORT_en_pipe_0;
  reg  dataArray_6_2_outdata_MPORT_addr_pipe_0;
  reg  dataArray_6_2_toMemData_MPORT_en_pipe_0;
  reg  dataArray_6_2_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_6_3 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_6_3_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_6_3_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_6_3_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_6_3_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_6_3_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_6_3_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_6_3_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_6_3_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_6_3_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_6_3_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_6_3_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_6_3_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_6_3_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_6_3_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_6_3_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_6_3_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_6_3_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_6_3_cachedata_MPORT_en_pipe_0;
  reg  dataArray_6_3_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_6_3_outdata_MPORT_en_pipe_0;
  reg  dataArray_6_3_outdata_MPORT_addr_pipe_0;
  reg  dataArray_6_3_toMemData_MPORT_en_pipe_0;
  reg  dataArray_6_3_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_7_0 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_7_0_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_7_0_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_7_0_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_7_0_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_7_0_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_7_0_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_7_0_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_7_0_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_7_0_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_7_0_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_7_0_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_7_0_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_7_0_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_7_0_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_7_0_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_7_0_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_7_0_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_7_0_cachedata_MPORT_en_pipe_0;
  reg  dataArray_7_0_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_7_0_outdata_MPORT_en_pipe_0;
  reg  dataArray_7_0_outdata_MPORT_addr_pipe_0;
  reg  dataArray_7_0_toMemData_MPORT_en_pipe_0;
  reg  dataArray_7_0_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_7_1 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_7_1_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_7_1_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_7_1_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_7_1_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_7_1_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_7_1_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_7_1_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_7_1_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_7_1_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_7_1_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_7_1_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_7_1_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_7_1_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_7_1_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_7_1_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_7_1_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_7_1_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_7_1_cachedata_MPORT_en_pipe_0;
  reg  dataArray_7_1_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_7_1_outdata_MPORT_en_pipe_0;
  reg  dataArray_7_1_outdata_MPORT_addr_pipe_0;
  reg  dataArray_7_1_toMemData_MPORT_en_pipe_0;
  reg  dataArray_7_1_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_7_2 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_7_2_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_7_2_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_7_2_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_7_2_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_7_2_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_7_2_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_7_2_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_7_2_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_7_2_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_7_2_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_7_2_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_7_2_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_7_2_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_7_2_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_7_2_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_7_2_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_7_2_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_7_2_cachedata_MPORT_en_pipe_0;
  reg  dataArray_7_2_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_7_2_outdata_MPORT_en_pipe_0;
  reg  dataArray_7_2_outdata_MPORT_addr_pipe_0;
  reg  dataArray_7_2_toMemData_MPORT_en_pipe_0;
  reg  dataArray_7_2_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_7_3 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_7_3_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_7_3_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_7_3_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_7_3_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_7_3_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_7_3_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_7_3_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_7_3_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_7_3_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_7_3_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_7_3_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_7_3_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_7_3_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_7_3_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_7_3_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_7_3_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_7_3_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_7_3_cachedata_MPORT_en_pipe_0;
  reg  dataArray_7_3_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_7_3_outdata_MPORT_en_pipe_0;
  reg  dataArray_7_3_outdata_MPORT_addr_pipe_0;
  reg  dataArray_7_3_toMemData_MPORT_en_pipe_0;
  reg  dataArray_7_3_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_8_0 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_8_0_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_8_0_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_8_0_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_8_0_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_8_0_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_8_0_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_8_0_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_8_0_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_8_0_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_8_0_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_8_0_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_8_0_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_8_0_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_8_0_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_8_0_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_8_0_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_8_0_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_8_0_cachedata_MPORT_en_pipe_0;
  reg  dataArray_8_0_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_8_0_outdata_MPORT_en_pipe_0;
  reg  dataArray_8_0_outdata_MPORT_addr_pipe_0;
  reg  dataArray_8_0_toMemData_MPORT_en_pipe_0;
  reg  dataArray_8_0_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_8_1 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_8_1_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_8_1_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_8_1_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_8_1_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_8_1_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_8_1_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_8_1_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_8_1_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_8_1_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_8_1_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_8_1_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_8_1_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_8_1_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_8_1_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_8_1_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_8_1_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_8_1_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_8_1_cachedata_MPORT_en_pipe_0;
  reg  dataArray_8_1_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_8_1_outdata_MPORT_en_pipe_0;
  reg  dataArray_8_1_outdata_MPORT_addr_pipe_0;
  reg  dataArray_8_1_toMemData_MPORT_en_pipe_0;
  reg  dataArray_8_1_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_8_2 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_8_2_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_8_2_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_8_2_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_8_2_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_8_2_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_8_2_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_8_2_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_8_2_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_8_2_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_8_2_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_8_2_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_8_2_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_8_2_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_8_2_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_8_2_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_8_2_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_8_2_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_8_2_cachedata_MPORT_en_pipe_0;
  reg  dataArray_8_2_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_8_2_outdata_MPORT_en_pipe_0;
  reg  dataArray_8_2_outdata_MPORT_addr_pipe_0;
  reg  dataArray_8_2_toMemData_MPORT_en_pipe_0;
  reg  dataArray_8_2_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_8_3 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_8_3_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_8_3_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_8_3_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_8_3_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_8_3_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_8_3_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_8_3_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_8_3_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_8_3_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_8_3_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_8_3_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_8_3_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_8_3_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_8_3_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_8_3_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_8_3_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_8_3_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_8_3_cachedata_MPORT_en_pipe_0;
  reg  dataArray_8_3_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_8_3_outdata_MPORT_en_pipe_0;
  reg  dataArray_8_3_outdata_MPORT_addr_pipe_0;
  reg  dataArray_8_3_toMemData_MPORT_en_pipe_0;
  reg  dataArray_8_3_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_9_0 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_9_0_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_9_0_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_9_0_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_9_0_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_9_0_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_9_0_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_9_0_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_9_0_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_9_0_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_9_0_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_9_0_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_9_0_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_9_0_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_9_0_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_9_0_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_9_0_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_9_0_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_9_0_cachedata_MPORT_en_pipe_0;
  reg  dataArray_9_0_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_9_0_outdata_MPORT_en_pipe_0;
  reg  dataArray_9_0_outdata_MPORT_addr_pipe_0;
  reg  dataArray_9_0_toMemData_MPORT_en_pipe_0;
  reg  dataArray_9_0_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_9_1 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_9_1_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_9_1_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_9_1_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_9_1_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_9_1_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_9_1_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_9_1_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_9_1_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_9_1_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_9_1_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_9_1_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_9_1_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_9_1_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_9_1_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_9_1_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_9_1_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_9_1_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_9_1_cachedata_MPORT_en_pipe_0;
  reg  dataArray_9_1_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_9_1_outdata_MPORT_en_pipe_0;
  reg  dataArray_9_1_outdata_MPORT_addr_pipe_0;
  reg  dataArray_9_1_toMemData_MPORT_en_pipe_0;
  reg  dataArray_9_1_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_9_2 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_9_2_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_9_2_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_9_2_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_9_2_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_9_2_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_9_2_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_9_2_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_9_2_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_9_2_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_9_2_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_9_2_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_9_2_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_9_2_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_9_2_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_9_2_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_9_2_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_9_2_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_9_2_cachedata_MPORT_en_pipe_0;
  reg  dataArray_9_2_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_9_2_outdata_MPORT_en_pipe_0;
  reg  dataArray_9_2_outdata_MPORT_addr_pipe_0;
  reg  dataArray_9_2_toMemData_MPORT_en_pipe_0;
  reg  dataArray_9_2_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_9_3 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_9_3_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_9_3_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_9_3_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_9_3_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_9_3_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_9_3_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_9_3_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_9_3_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_9_3_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_9_3_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_9_3_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_9_3_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_9_3_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_9_3_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_9_3_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_9_3_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_9_3_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_9_3_cachedata_MPORT_en_pipe_0;
  reg  dataArray_9_3_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_9_3_outdata_MPORT_en_pipe_0;
  reg  dataArray_9_3_outdata_MPORT_addr_pipe_0;
  reg  dataArray_9_3_toMemData_MPORT_en_pipe_0;
  reg  dataArray_9_3_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_10_0 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_10_0_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_10_0_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_10_0_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_10_0_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_10_0_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_10_0_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_10_0_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_10_0_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_10_0_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_10_0_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_10_0_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_10_0_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_10_0_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_10_0_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_10_0_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_10_0_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_10_0_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_10_0_cachedata_MPORT_en_pipe_0;
  reg  dataArray_10_0_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_10_0_outdata_MPORT_en_pipe_0;
  reg  dataArray_10_0_outdata_MPORT_addr_pipe_0;
  reg  dataArray_10_0_toMemData_MPORT_en_pipe_0;
  reg  dataArray_10_0_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_10_1 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_10_1_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_10_1_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_10_1_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_10_1_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_10_1_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_10_1_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_10_1_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_10_1_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_10_1_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_10_1_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_10_1_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_10_1_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_10_1_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_10_1_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_10_1_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_10_1_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_10_1_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_10_1_cachedata_MPORT_en_pipe_0;
  reg  dataArray_10_1_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_10_1_outdata_MPORT_en_pipe_0;
  reg  dataArray_10_1_outdata_MPORT_addr_pipe_0;
  reg  dataArray_10_1_toMemData_MPORT_en_pipe_0;
  reg  dataArray_10_1_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_10_2 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_10_2_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_10_2_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_10_2_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_10_2_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_10_2_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_10_2_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_10_2_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_10_2_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_10_2_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_10_2_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_10_2_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_10_2_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_10_2_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_10_2_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_10_2_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_10_2_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_10_2_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_10_2_cachedata_MPORT_en_pipe_0;
  reg  dataArray_10_2_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_10_2_outdata_MPORT_en_pipe_0;
  reg  dataArray_10_2_outdata_MPORT_addr_pipe_0;
  reg  dataArray_10_2_toMemData_MPORT_en_pipe_0;
  reg  dataArray_10_2_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_10_3 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_10_3_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_10_3_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_10_3_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_10_3_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_10_3_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_10_3_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_10_3_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_10_3_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_10_3_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_10_3_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_10_3_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_10_3_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_10_3_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_10_3_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_10_3_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_10_3_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_10_3_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_10_3_cachedata_MPORT_en_pipe_0;
  reg  dataArray_10_3_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_10_3_outdata_MPORT_en_pipe_0;
  reg  dataArray_10_3_outdata_MPORT_addr_pipe_0;
  reg  dataArray_10_3_toMemData_MPORT_en_pipe_0;
  reg  dataArray_10_3_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_11_0 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_11_0_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_11_0_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_11_0_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_11_0_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_11_0_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_11_0_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_11_0_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_11_0_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_11_0_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_11_0_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_11_0_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_11_0_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_11_0_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_11_0_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_11_0_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_11_0_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_11_0_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_11_0_cachedata_MPORT_en_pipe_0;
  reg  dataArray_11_0_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_11_0_outdata_MPORT_en_pipe_0;
  reg  dataArray_11_0_outdata_MPORT_addr_pipe_0;
  reg  dataArray_11_0_toMemData_MPORT_en_pipe_0;
  reg  dataArray_11_0_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_11_1 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_11_1_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_11_1_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_11_1_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_11_1_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_11_1_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_11_1_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_11_1_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_11_1_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_11_1_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_11_1_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_11_1_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_11_1_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_11_1_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_11_1_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_11_1_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_11_1_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_11_1_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_11_1_cachedata_MPORT_en_pipe_0;
  reg  dataArray_11_1_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_11_1_outdata_MPORT_en_pipe_0;
  reg  dataArray_11_1_outdata_MPORT_addr_pipe_0;
  reg  dataArray_11_1_toMemData_MPORT_en_pipe_0;
  reg  dataArray_11_1_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_11_2 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_11_2_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_11_2_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_11_2_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_11_2_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_11_2_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_11_2_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_11_2_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_11_2_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_11_2_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_11_2_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_11_2_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_11_2_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_11_2_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_11_2_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_11_2_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_11_2_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_11_2_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_11_2_cachedata_MPORT_en_pipe_0;
  reg  dataArray_11_2_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_11_2_outdata_MPORT_en_pipe_0;
  reg  dataArray_11_2_outdata_MPORT_addr_pipe_0;
  reg  dataArray_11_2_toMemData_MPORT_en_pipe_0;
  reg  dataArray_11_2_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_11_3 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_11_3_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_11_3_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_11_3_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_11_3_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_11_3_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_11_3_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_11_3_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_11_3_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_11_3_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_11_3_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_11_3_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_11_3_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_11_3_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_11_3_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_11_3_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_11_3_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_11_3_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_11_3_cachedata_MPORT_en_pipe_0;
  reg  dataArray_11_3_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_11_3_outdata_MPORT_en_pipe_0;
  reg  dataArray_11_3_outdata_MPORT_addr_pipe_0;
  reg  dataArray_11_3_toMemData_MPORT_en_pipe_0;
  reg  dataArray_11_3_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_12_0 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_12_0_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_12_0_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_12_0_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_12_0_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_12_0_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_12_0_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_12_0_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_12_0_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_12_0_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_12_0_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_12_0_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_12_0_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_12_0_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_12_0_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_12_0_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_12_0_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_12_0_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_12_0_cachedata_MPORT_en_pipe_0;
  reg  dataArray_12_0_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_12_0_outdata_MPORT_en_pipe_0;
  reg  dataArray_12_0_outdata_MPORT_addr_pipe_0;
  reg  dataArray_12_0_toMemData_MPORT_en_pipe_0;
  reg  dataArray_12_0_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_12_1 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_12_1_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_12_1_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_12_1_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_12_1_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_12_1_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_12_1_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_12_1_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_12_1_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_12_1_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_12_1_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_12_1_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_12_1_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_12_1_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_12_1_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_12_1_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_12_1_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_12_1_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_12_1_cachedata_MPORT_en_pipe_0;
  reg  dataArray_12_1_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_12_1_outdata_MPORT_en_pipe_0;
  reg  dataArray_12_1_outdata_MPORT_addr_pipe_0;
  reg  dataArray_12_1_toMemData_MPORT_en_pipe_0;
  reg  dataArray_12_1_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_12_2 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_12_2_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_12_2_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_12_2_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_12_2_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_12_2_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_12_2_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_12_2_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_12_2_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_12_2_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_12_2_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_12_2_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_12_2_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_12_2_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_12_2_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_12_2_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_12_2_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_12_2_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_12_2_cachedata_MPORT_en_pipe_0;
  reg  dataArray_12_2_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_12_2_outdata_MPORT_en_pipe_0;
  reg  dataArray_12_2_outdata_MPORT_addr_pipe_0;
  reg  dataArray_12_2_toMemData_MPORT_en_pipe_0;
  reg  dataArray_12_2_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_12_3 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_12_3_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_12_3_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_12_3_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_12_3_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_12_3_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_12_3_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_12_3_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_12_3_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_12_3_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_12_3_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_12_3_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_12_3_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_12_3_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_12_3_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_12_3_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_12_3_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_12_3_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_12_3_cachedata_MPORT_en_pipe_0;
  reg  dataArray_12_3_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_12_3_outdata_MPORT_en_pipe_0;
  reg  dataArray_12_3_outdata_MPORT_addr_pipe_0;
  reg  dataArray_12_3_toMemData_MPORT_en_pipe_0;
  reg  dataArray_12_3_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_13_0 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_13_0_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_13_0_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_13_0_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_13_0_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_13_0_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_13_0_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_13_0_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_13_0_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_13_0_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_13_0_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_13_0_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_13_0_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_13_0_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_13_0_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_13_0_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_13_0_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_13_0_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_13_0_cachedata_MPORT_en_pipe_0;
  reg  dataArray_13_0_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_13_0_outdata_MPORT_en_pipe_0;
  reg  dataArray_13_0_outdata_MPORT_addr_pipe_0;
  reg  dataArray_13_0_toMemData_MPORT_en_pipe_0;
  reg  dataArray_13_0_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_13_1 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_13_1_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_13_1_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_13_1_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_13_1_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_13_1_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_13_1_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_13_1_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_13_1_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_13_1_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_13_1_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_13_1_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_13_1_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_13_1_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_13_1_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_13_1_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_13_1_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_13_1_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_13_1_cachedata_MPORT_en_pipe_0;
  reg  dataArray_13_1_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_13_1_outdata_MPORT_en_pipe_0;
  reg  dataArray_13_1_outdata_MPORT_addr_pipe_0;
  reg  dataArray_13_1_toMemData_MPORT_en_pipe_0;
  reg  dataArray_13_1_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_13_2 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_13_2_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_13_2_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_13_2_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_13_2_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_13_2_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_13_2_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_13_2_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_13_2_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_13_2_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_13_2_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_13_2_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_13_2_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_13_2_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_13_2_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_13_2_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_13_2_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_13_2_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_13_2_cachedata_MPORT_en_pipe_0;
  reg  dataArray_13_2_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_13_2_outdata_MPORT_en_pipe_0;
  reg  dataArray_13_2_outdata_MPORT_addr_pipe_0;
  reg  dataArray_13_2_toMemData_MPORT_en_pipe_0;
  reg  dataArray_13_2_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_13_3 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_13_3_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_13_3_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_13_3_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_13_3_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_13_3_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_13_3_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_13_3_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_13_3_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_13_3_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_13_3_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_13_3_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_13_3_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_13_3_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_13_3_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_13_3_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_13_3_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_13_3_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_13_3_cachedata_MPORT_en_pipe_0;
  reg  dataArray_13_3_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_13_3_outdata_MPORT_en_pipe_0;
  reg  dataArray_13_3_outdata_MPORT_addr_pipe_0;
  reg  dataArray_13_3_toMemData_MPORT_en_pipe_0;
  reg  dataArray_13_3_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_14_0 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_14_0_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_14_0_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_14_0_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_14_0_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_14_0_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_14_0_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_14_0_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_14_0_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_14_0_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_14_0_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_14_0_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_14_0_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_14_0_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_14_0_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_14_0_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_14_0_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_14_0_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_14_0_cachedata_MPORT_en_pipe_0;
  reg  dataArray_14_0_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_14_0_outdata_MPORT_en_pipe_0;
  reg  dataArray_14_0_outdata_MPORT_addr_pipe_0;
  reg  dataArray_14_0_toMemData_MPORT_en_pipe_0;
  reg  dataArray_14_0_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_14_1 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_14_1_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_14_1_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_14_1_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_14_1_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_14_1_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_14_1_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_14_1_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_14_1_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_14_1_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_14_1_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_14_1_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_14_1_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_14_1_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_14_1_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_14_1_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_14_1_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_14_1_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_14_1_cachedata_MPORT_en_pipe_0;
  reg  dataArray_14_1_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_14_1_outdata_MPORT_en_pipe_0;
  reg  dataArray_14_1_outdata_MPORT_addr_pipe_0;
  reg  dataArray_14_1_toMemData_MPORT_en_pipe_0;
  reg  dataArray_14_1_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_14_2 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_14_2_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_14_2_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_14_2_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_14_2_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_14_2_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_14_2_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_14_2_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_14_2_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_14_2_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_14_2_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_14_2_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_14_2_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_14_2_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_14_2_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_14_2_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_14_2_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_14_2_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_14_2_cachedata_MPORT_en_pipe_0;
  reg  dataArray_14_2_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_14_2_outdata_MPORT_en_pipe_0;
  reg  dataArray_14_2_outdata_MPORT_addr_pipe_0;
  reg  dataArray_14_2_toMemData_MPORT_en_pipe_0;
  reg  dataArray_14_2_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_14_3 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_14_3_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_14_3_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_14_3_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_14_3_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_14_3_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_14_3_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_14_3_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_14_3_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_14_3_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_14_3_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_14_3_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_14_3_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_14_3_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_14_3_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_14_3_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_14_3_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_14_3_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_14_3_cachedata_MPORT_en_pipe_0;
  reg  dataArray_14_3_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_14_3_outdata_MPORT_en_pipe_0;
  reg  dataArray_14_3_outdata_MPORT_addr_pipe_0;
  reg  dataArray_14_3_toMemData_MPORT_en_pipe_0;
  reg  dataArray_14_3_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_15_0 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_15_0_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_15_0_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_15_0_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_15_0_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_15_0_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_15_0_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_15_0_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_15_0_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_15_0_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_15_0_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_15_0_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_15_0_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_15_0_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_15_0_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_15_0_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_15_0_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_15_0_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_15_0_cachedata_MPORT_en_pipe_0;
  reg  dataArray_15_0_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_15_0_outdata_MPORT_en_pipe_0;
  reg  dataArray_15_0_outdata_MPORT_addr_pipe_0;
  reg  dataArray_15_0_toMemData_MPORT_en_pipe_0;
  reg  dataArray_15_0_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_15_1 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_15_1_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_15_1_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_15_1_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_15_1_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_15_1_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_15_1_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_15_1_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_15_1_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_15_1_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_15_1_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_15_1_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_15_1_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_15_1_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_15_1_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_15_1_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_15_1_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_15_1_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_15_1_cachedata_MPORT_en_pipe_0;
  reg  dataArray_15_1_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_15_1_outdata_MPORT_en_pipe_0;
  reg  dataArray_15_1_outdata_MPORT_addr_pipe_0;
  reg  dataArray_15_1_toMemData_MPORT_en_pipe_0;
  reg  dataArray_15_1_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_15_2 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_15_2_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_15_2_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_15_2_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_15_2_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_15_2_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_15_2_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_15_2_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_15_2_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_15_2_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_15_2_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_15_2_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_15_2_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_15_2_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_15_2_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_15_2_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_15_2_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_15_2_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_15_2_cachedata_MPORT_en_pipe_0;
  reg  dataArray_15_2_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_15_2_outdata_MPORT_en_pipe_0;
  reg  dataArray_15_2_outdata_MPORT_addr_pipe_0;
  reg  dataArray_15_2_toMemData_MPORT_en_pipe_0;
  reg  dataArray_15_2_toMemData_MPORT_addr_pipe_0;
  reg [31:0] dataArray_15_3 [0:1]; // @[dcache.scala 29:33]
  wire  dataArray_15_3_cachedata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_15_3_cachedata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_15_3_cachedata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_15_3_outdata_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_15_3_outdata_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_15_3_outdata_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_15_3_toMemData_MPORT_en; // @[dcache.scala 29:33]
  wire  dataArray_15_3_toMemData_MPORT_addr; // @[dcache.scala 29:33]
  wire [31:0] dataArray_15_3_toMemData_MPORT_data; // @[dcache.scala 29:33]
  wire [31:0] dataArray_15_3_MPORT_data; // @[dcache.scala 29:33]
  wire  dataArray_15_3_MPORT_addr; // @[dcache.scala 29:33]
  wire  dataArray_15_3_MPORT_mask; // @[dcache.scala 29:33]
  wire  dataArray_15_3_MPORT_en; // @[dcache.scala 29:33]
  wire [31:0] dataArray_15_3_MPORT_1_data; // @[dcache.scala 29:33]
  wire  dataArray_15_3_MPORT_1_addr; // @[dcache.scala 29:33]
  wire  dataArray_15_3_MPORT_1_mask; // @[dcache.scala 29:33]
  wire  dataArray_15_3_MPORT_1_en; // @[dcache.scala 29:33]
  reg  dataArray_15_3_cachedata_MPORT_en_pipe_0;
  reg  dataArray_15_3_cachedata_MPORT_addr_pipe_0;
  reg  dataArray_15_3_outdata_MPORT_en_pipe_0;
  reg  dataArray_15_3_outdata_MPORT_addr_pipe_0;
  reg  dataArray_15_3_toMemData_MPORT_en_pipe_0;
  reg  dataArray_15_3_toMemData_MPORT_addr_pipe_0;
  reg  replace_set; // @[dcache.scala 19:30]
  wire [1:0] ByteId = from_LSU_bits_addr[1:0]; // @[dcache.scala 20:41]
  wire [1:0] EntId = from_LSU_bits_addr[3:2]; // @[dcache.scala 21:41]
  wire [3:0] CacheLineId = from_LSU_bits_addr[7:4]; // @[dcache.scala 22:41]
  wire [23:0] tag = from_LSU_bits_addr[31:8]; // @[dcache.scala 23:41]
  reg  random_num; // @[dcache.scala 26:29]
  reg [23:0] tagArray_0_0; // @[dcache.scala 30:29]
  reg [23:0] tagArray_0_1; // @[dcache.scala 30:29]
  reg [23:0] tagArray_0_2; // @[dcache.scala 30:29]
  reg [23:0] tagArray_0_3; // @[dcache.scala 30:29]
  reg [23:0] tagArray_0_4; // @[dcache.scala 30:29]
  reg [23:0] tagArray_0_5; // @[dcache.scala 30:29]
  reg [23:0] tagArray_0_6; // @[dcache.scala 30:29]
  reg [23:0] tagArray_0_7; // @[dcache.scala 30:29]
  reg [23:0] tagArray_0_8; // @[dcache.scala 30:29]
  reg [23:0] tagArray_0_9; // @[dcache.scala 30:29]
  reg [23:0] tagArray_0_10; // @[dcache.scala 30:29]
  reg [23:0] tagArray_0_11; // @[dcache.scala 30:29]
  reg [23:0] tagArray_0_12; // @[dcache.scala 30:29]
  reg [23:0] tagArray_0_13; // @[dcache.scala 30:29]
  reg [23:0] tagArray_0_14; // @[dcache.scala 30:29]
  reg [23:0] tagArray_0_15; // @[dcache.scala 30:29]
  reg [23:0] tagArray_1_0; // @[dcache.scala 30:29]
  reg [23:0] tagArray_1_1; // @[dcache.scala 30:29]
  reg [23:0] tagArray_1_2; // @[dcache.scala 30:29]
  reg [23:0] tagArray_1_3; // @[dcache.scala 30:29]
  reg [23:0] tagArray_1_4; // @[dcache.scala 30:29]
  reg [23:0] tagArray_1_5; // @[dcache.scala 30:29]
  reg [23:0] tagArray_1_6; // @[dcache.scala 30:29]
  reg [23:0] tagArray_1_7; // @[dcache.scala 30:29]
  reg [23:0] tagArray_1_8; // @[dcache.scala 30:29]
  reg [23:0] tagArray_1_9; // @[dcache.scala 30:29]
  reg [23:0] tagArray_1_10; // @[dcache.scala 30:29]
  reg [23:0] tagArray_1_11; // @[dcache.scala 30:29]
  reg [23:0] tagArray_1_12; // @[dcache.scala 30:29]
  reg [23:0] tagArray_1_13; // @[dcache.scala 30:29]
  reg [23:0] tagArray_1_14; // @[dcache.scala 30:29]
  reg [23:0] tagArray_1_15; // @[dcache.scala 30:29]
  reg  validArray_0_0; // @[dcache.scala 31:29]
  reg  validArray_0_1; // @[dcache.scala 31:29]
  reg  validArray_0_2; // @[dcache.scala 31:29]
  reg  validArray_0_3; // @[dcache.scala 31:29]
  reg  validArray_0_4; // @[dcache.scala 31:29]
  reg  validArray_0_5; // @[dcache.scala 31:29]
  reg  validArray_0_6; // @[dcache.scala 31:29]
  reg  validArray_0_7; // @[dcache.scala 31:29]
  reg  validArray_0_8; // @[dcache.scala 31:29]
  reg  validArray_0_9; // @[dcache.scala 31:29]
  reg  validArray_0_10; // @[dcache.scala 31:29]
  reg  validArray_0_11; // @[dcache.scala 31:29]
  reg  validArray_0_12; // @[dcache.scala 31:29]
  reg  validArray_0_13; // @[dcache.scala 31:29]
  reg  validArray_0_14; // @[dcache.scala 31:29]
  reg  validArray_0_15; // @[dcache.scala 31:29]
  reg  validArray_1_0; // @[dcache.scala 31:29]
  reg  validArray_1_1; // @[dcache.scala 31:29]
  reg  validArray_1_2; // @[dcache.scala 31:29]
  reg  validArray_1_3; // @[dcache.scala 31:29]
  reg  validArray_1_4; // @[dcache.scala 31:29]
  reg  validArray_1_5; // @[dcache.scala 31:29]
  reg  validArray_1_6; // @[dcache.scala 31:29]
  reg  validArray_1_7; // @[dcache.scala 31:29]
  reg  validArray_1_8; // @[dcache.scala 31:29]
  reg  validArray_1_9; // @[dcache.scala 31:29]
  reg  validArray_1_10; // @[dcache.scala 31:29]
  reg  validArray_1_11; // @[dcache.scala 31:29]
  reg  validArray_1_12; // @[dcache.scala 31:29]
  reg  validArray_1_13; // @[dcache.scala 31:29]
  reg  validArray_1_14; // @[dcache.scala 31:29]
  reg  validArray_1_15; // @[dcache.scala 31:29]
  reg  dirtyArray_0_0; // @[dcache.scala 32:29]
  reg  dirtyArray_0_1; // @[dcache.scala 32:29]
  reg  dirtyArray_0_2; // @[dcache.scala 32:29]
  reg  dirtyArray_0_3; // @[dcache.scala 32:29]
  reg  dirtyArray_0_4; // @[dcache.scala 32:29]
  reg  dirtyArray_0_5; // @[dcache.scala 32:29]
  reg  dirtyArray_0_6; // @[dcache.scala 32:29]
  reg  dirtyArray_0_7; // @[dcache.scala 32:29]
  reg  dirtyArray_0_8; // @[dcache.scala 32:29]
  reg  dirtyArray_0_9; // @[dcache.scala 32:29]
  reg  dirtyArray_0_10; // @[dcache.scala 32:29]
  reg  dirtyArray_0_11; // @[dcache.scala 32:29]
  reg  dirtyArray_0_12; // @[dcache.scala 32:29]
  reg  dirtyArray_0_13; // @[dcache.scala 32:29]
  reg  dirtyArray_0_14; // @[dcache.scala 32:29]
  reg  dirtyArray_0_15; // @[dcache.scala 32:29]
  reg  dirtyArray_1_0; // @[dcache.scala 32:29]
  reg  dirtyArray_1_1; // @[dcache.scala 32:29]
  reg  dirtyArray_1_2; // @[dcache.scala 32:29]
  reg  dirtyArray_1_3; // @[dcache.scala 32:29]
  reg  dirtyArray_1_4; // @[dcache.scala 32:29]
  reg  dirtyArray_1_5; // @[dcache.scala 32:29]
  reg  dirtyArray_1_6; // @[dcache.scala 32:29]
  reg  dirtyArray_1_7; // @[dcache.scala 32:29]
  reg  dirtyArray_1_8; // @[dcache.scala 32:29]
  reg  dirtyArray_1_9; // @[dcache.scala 32:29]
  reg  dirtyArray_1_10; // @[dcache.scala 32:29]
  reg  dirtyArray_1_11; // @[dcache.scala 32:29]
  reg  dirtyArray_1_12; // @[dcache.scala 32:29]
  reg  dirtyArray_1_13; // @[dcache.scala 32:29]
  reg  dirtyArray_1_14; // @[dcache.scala 32:29]
  reg  dirtyArray_1_15; // @[dcache.scala 32:29]
  wire [23:0] _GEN_1 = 4'h1 == CacheLineId ? tagArray_0_1 : tagArray_0_0; // @[dcache.scala 35:{14,14}]
  wire [23:0] _GEN_2 = 4'h2 == CacheLineId ? tagArray_0_2 : _GEN_1; // @[dcache.scala 35:{14,14}]
  wire [23:0] _GEN_3 = 4'h3 == CacheLineId ? tagArray_0_3 : _GEN_2; // @[dcache.scala 35:{14,14}]
  wire [23:0] _GEN_4 = 4'h4 == CacheLineId ? tagArray_0_4 : _GEN_3; // @[dcache.scala 35:{14,14}]
  wire [23:0] _GEN_5 = 4'h5 == CacheLineId ? tagArray_0_5 : _GEN_4; // @[dcache.scala 35:{14,14}]
  wire [23:0] _GEN_6 = 4'h6 == CacheLineId ? tagArray_0_6 : _GEN_5; // @[dcache.scala 35:{14,14}]
  wire [23:0] _GEN_7 = 4'h7 == CacheLineId ? tagArray_0_7 : _GEN_6; // @[dcache.scala 35:{14,14}]
  wire [23:0] _GEN_8 = 4'h8 == CacheLineId ? tagArray_0_8 : _GEN_7; // @[dcache.scala 35:{14,14}]
  wire [23:0] _GEN_9 = 4'h9 == CacheLineId ? tagArray_0_9 : _GEN_8; // @[dcache.scala 35:{14,14}]
  wire [23:0] _GEN_10 = 4'ha == CacheLineId ? tagArray_0_10 : _GEN_9; // @[dcache.scala 35:{14,14}]
  wire [23:0] _GEN_11 = 4'hb == CacheLineId ? tagArray_0_11 : _GEN_10; // @[dcache.scala 35:{14,14}]
  wire [23:0] _GEN_12 = 4'hc == CacheLineId ? tagArray_0_12 : _GEN_11; // @[dcache.scala 35:{14,14}]
  wire [23:0] _GEN_13 = 4'hd == CacheLineId ? tagArray_0_13 : _GEN_12; // @[dcache.scala 35:{14,14}]
  wire [23:0] _GEN_14 = 4'he == CacheLineId ? tagArray_0_14 : _GEN_13; // @[dcache.scala 35:{14,14}]
  wire [23:0] _GEN_15 = 4'hf == CacheLineId ? tagArray_0_15 : _GEN_14; // @[dcache.scala 35:{14,14}]
  wire  _GEN_17 = 4'h1 == CacheLineId ? validArray_0_1 : validArray_0_0; // @[dcache.scala 35:{44,44}]
  wire  _GEN_18 = 4'h2 == CacheLineId ? validArray_0_2 : _GEN_17; // @[dcache.scala 35:{44,44}]
  wire  _GEN_19 = 4'h3 == CacheLineId ? validArray_0_3 : _GEN_18; // @[dcache.scala 35:{44,44}]
  wire  _GEN_20 = 4'h4 == CacheLineId ? validArray_0_4 : _GEN_19; // @[dcache.scala 35:{44,44}]
  wire  _GEN_21 = 4'h5 == CacheLineId ? validArray_0_5 : _GEN_20; // @[dcache.scala 35:{44,44}]
  wire  _GEN_22 = 4'h6 == CacheLineId ? validArray_0_6 : _GEN_21; // @[dcache.scala 35:{44,44}]
  wire  _GEN_23 = 4'h7 == CacheLineId ? validArray_0_7 : _GEN_22; // @[dcache.scala 35:{44,44}]
  wire  _GEN_24 = 4'h8 == CacheLineId ? validArray_0_8 : _GEN_23; // @[dcache.scala 35:{44,44}]
  wire  _GEN_25 = 4'h9 == CacheLineId ? validArray_0_9 : _GEN_24; // @[dcache.scala 35:{44,44}]
  wire  _GEN_26 = 4'ha == CacheLineId ? validArray_0_10 : _GEN_25; // @[dcache.scala 35:{44,44}]
  wire  _GEN_27 = 4'hb == CacheLineId ? validArray_0_11 : _GEN_26; // @[dcache.scala 35:{44,44}]
  wire  _GEN_28 = 4'hc == CacheLineId ? validArray_0_12 : _GEN_27; // @[dcache.scala 35:{44,44}]
  wire  _GEN_29 = 4'hd == CacheLineId ? validArray_0_13 : _GEN_28; // @[dcache.scala 35:{44,44}]
  wire  _GEN_30 = 4'he == CacheLineId ? validArray_0_14 : _GEN_29; // @[dcache.scala 35:{44,44}]
  wire  _GEN_31 = 4'hf == CacheLineId ? validArray_0_15 : _GEN_30; // @[dcache.scala 35:{44,44}]
  wire  hitArray_0 = tag == _GEN_15 & _GEN_31; // @[dcache.scala 35:44]
  wire [23:0] _GEN_33 = 4'h1 == CacheLineId ? tagArray_1_1 : tagArray_1_0; // @[dcache.scala 35:{14,14}]
  wire [23:0] _GEN_34 = 4'h2 == CacheLineId ? tagArray_1_2 : _GEN_33; // @[dcache.scala 35:{14,14}]
  wire [23:0] _GEN_35 = 4'h3 == CacheLineId ? tagArray_1_3 : _GEN_34; // @[dcache.scala 35:{14,14}]
  wire [23:0] _GEN_36 = 4'h4 == CacheLineId ? tagArray_1_4 : _GEN_35; // @[dcache.scala 35:{14,14}]
  wire [23:0] _GEN_37 = 4'h5 == CacheLineId ? tagArray_1_5 : _GEN_36; // @[dcache.scala 35:{14,14}]
  wire [23:0] _GEN_38 = 4'h6 == CacheLineId ? tagArray_1_6 : _GEN_37; // @[dcache.scala 35:{14,14}]
  wire [23:0] _GEN_39 = 4'h7 == CacheLineId ? tagArray_1_7 : _GEN_38; // @[dcache.scala 35:{14,14}]
  wire [23:0] _GEN_40 = 4'h8 == CacheLineId ? tagArray_1_8 : _GEN_39; // @[dcache.scala 35:{14,14}]
  wire [23:0] _GEN_41 = 4'h9 == CacheLineId ? tagArray_1_9 : _GEN_40; // @[dcache.scala 35:{14,14}]
  wire [23:0] _GEN_42 = 4'ha == CacheLineId ? tagArray_1_10 : _GEN_41; // @[dcache.scala 35:{14,14}]
  wire [23:0] _GEN_43 = 4'hb == CacheLineId ? tagArray_1_11 : _GEN_42; // @[dcache.scala 35:{14,14}]
  wire [23:0] _GEN_44 = 4'hc == CacheLineId ? tagArray_1_12 : _GEN_43; // @[dcache.scala 35:{14,14}]
  wire [23:0] _GEN_45 = 4'hd == CacheLineId ? tagArray_1_13 : _GEN_44; // @[dcache.scala 35:{14,14}]
  wire [23:0] _GEN_46 = 4'he == CacheLineId ? tagArray_1_14 : _GEN_45; // @[dcache.scala 35:{14,14}]
  wire [23:0] _GEN_47 = 4'hf == CacheLineId ? tagArray_1_15 : _GEN_46; // @[dcache.scala 35:{14,14}]
  wire  _GEN_49 = 4'h1 == CacheLineId ? validArray_1_1 : validArray_1_0; // @[dcache.scala 35:{44,44}]
  wire  _GEN_50 = 4'h2 == CacheLineId ? validArray_1_2 : _GEN_49; // @[dcache.scala 35:{44,44}]
  wire  _GEN_51 = 4'h3 == CacheLineId ? validArray_1_3 : _GEN_50; // @[dcache.scala 35:{44,44}]
  wire  _GEN_52 = 4'h4 == CacheLineId ? validArray_1_4 : _GEN_51; // @[dcache.scala 35:{44,44}]
  wire  _GEN_53 = 4'h5 == CacheLineId ? validArray_1_5 : _GEN_52; // @[dcache.scala 35:{44,44}]
  wire  _GEN_54 = 4'h6 == CacheLineId ? validArray_1_6 : _GEN_53; // @[dcache.scala 35:{44,44}]
  wire  _GEN_55 = 4'h7 == CacheLineId ? validArray_1_7 : _GEN_54; // @[dcache.scala 35:{44,44}]
  wire  _GEN_56 = 4'h8 == CacheLineId ? validArray_1_8 : _GEN_55; // @[dcache.scala 35:{44,44}]
  wire  _GEN_57 = 4'h9 == CacheLineId ? validArray_1_9 : _GEN_56; // @[dcache.scala 35:{44,44}]
  wire  _GEN_58 = 4'ha == CacheLineId ? validArray_1_10 : _GEN_57; // @[dcache.scala 35:{44,44}]
  wire  _GEN_59 = 4'hb == CacheLineId ? validArray_1_11 : _GEN_58; // @[dcache.scala 35:{44,44}]
  wire  _GEN_60 = 4'hc == CacheLineId ? validArray_1_12 : _GEN_59; // @[dcache.scala 35:{44,44}]
  wire  _GEN_61 = 4'hd == CacheLineId ? validArray_1_13 : _GEN_60; // @[dcache.scala 35:{44,44}]
  wire  _GEN_62 = 4'he == CacheLineId ? validArray_1_14 : _GEN_61; // @[dcache.scala 35:{44,44}]
  wire  _GEN_63 = 4'hf == CacheLineId ? validArray_1_15 : _GEN_62; // @[dcache.scala 35:{44,44}]
  wire  hitArray_1 = tag == _GEN_47 & _GEN_63; // @[dcache.scala 35:44]
  wire  hit = hitArray_0 | hitArray_1; // @[dcache.scala 37:33]
  wire  SetId = _GEN_47 == tag; // @[Mux.scala 81:61]
  reg [1:0] off; // @[dcache.scala 46:24]
  reg [3:0] state_dcache; // @[dcache.scala 49:31]
  wire  _T_1 = from_LSU_ready & from_LSU_valid; // @[Decoupled.scala 51:35]
  wire [3:0] _state_dcache_T = from_LSU_bits_is_write ? 4'h2 : 4'h1; // @[dcache.scala 54:40]
  wire  _T_2 = 4'h1 == state_dcache; // @[dcache.scala 50:27]
  wire  _T_3 = 4'h2 == state_dcache; // @[dcache.scala 50:27]
  wire  _GEN_1086 = ~replace_set; // @[dcache.scala 70:{32,32}]
  wire  _GEN_1087 = 4'h1 == CacheLineId; // @[dcache.scala 70:{32,32}]
  wire  _GEN_69 = ~replace_set & 4'h1 == CacheLineId ? dirtyArray_0_1 : dirtyArray_0_0; // @[dcache.scala 70:{32,32}]
  wire  _GEN_1089 = 4'h2 == CacheLineId; // @[dcache.scala 70:{32,32}]
  wire  _GEN_70 = ~replace_set & 4'h2 == CacheLineId ? dirtyArray_0_2 : _GEN_69; // @[dcache.scala 70:{32,32}]
  wire  _GEN_1091 = 4'h3 == CacheLineId; // @[dcache.scala 70:{32,32}]
  wire  _GEN_71 = ~replace_set & 4'h3 == CacheLineId ? dirtyArray_0_3 : _GEN_70; // @[dcache.scala 70:{32,32}]
  wire  _GEN_1093 = 4'h4 == CacheLineId; // @[dcache.scala 70:{32,32}]
  wire  _GEN_72 = ~replace_set & 4'h4 == CacheLineId ? dirtyArray_0_4 : _GEN_71; // @[dcache.scala 70:{32,32}]
  wire  _GEN_1095 = 4'h5 == CacheLineId; // @[dcache.scala 70:{32,32}]
  wire  _GEN_73 = ~replace_set & 4'h5 == CacheLineId ? dirtyArray_0_5 : _GEN_72; // @[dcache.scala 70:{32,32}]
  wire  _GEN_1097 = 4'h6 == CacheLineId; // @[dcache.scala 70:{32,32}]
  wire  _GEN_74 = ~replace_set & 4'h6 == CacheLineId ? dirtyArray_0_6 : _GEN_73; // @[dcache.scala 70:{32,32}]
  wire  _GEN_1099 = 4'h7 == CacheLineId; // @[dcache.scala 70:{32,32}]
  wire  _GEN_75 = ~replace_set & 4'h7 == CacheLineId ? dirtyArray_0_7 : _GEN_74; // @[dcache.scala 70:{32,32}]
  wire  _GEN_1101 = 4'h8 == CacheLineId; // @[dcache.scala 70:{32,32}]
  wire  _GEN_76 = ~replace_set & 4'h8 == CacheLineId ? dirtyArray_0_8 : _GEN_75; // @[dcache.scala 70:{32,32}]
  wire  _GEN_1103 = 4'h9 == CacheLineId; // @[dcache.scala 70:{32,32}]
  wire  _GEN_77 = ~replace_set & 4'h9 == CacheLineId ? dirtyArray_0_9 : _GEN_76; // @[dcache.scala 70:{32,32}]
  wire  _GEN_1105 = 4'ha == CacheLineId; // @[dcache.scala 70:{32,32}]
  wire  _GEN_78 = ~replace_set & 4'ha == CacheLineId ? dirtyArray_0_10 : _GEN_77; // @[dcache.scala 70:{32,32}]
  wire  _GEN_1107 = 4'hb == CacheLineId; // @[dcache.scala 70:{32,32}]
  wire  _GEN_79 = ~replace_set & 4'hb == CacheLineId ? dirtyArray_0_11 : _GEN_78; // @[dcache.scala 70:{32,32}]
  wire  _GEN_1109 = 4'hc == CacheLineId; // @[dcache.scala 70:{32,32}]
  wire  _GEN_80 = ~replace_set & 4'hc == CacheLineId ? dirtyArray_0_12 : _GEN_79; // @[dcache.scala 70:{32,32}]
  wire  _GEN_1111 = 4'hd == CacheLineId; // @[dcache.scala 70:{32,32}]
  wire  _GEN_81 = ~replace_set & 4'hd == CacheLineId ? dirtyArray_0_13 : _GEN_80; // @[dcache.scala 70:{32,32}]
  wire  _GEN_1113 = 4'he == CacheLineId; // @[dcache.scala 70:{32,32}]
  wire  _GEN_82 = ~replace_set & 4'he == CacheLineId ? dirtyArray_0_14 : _GEN_81; // @[dcache.scala 70:{32,32}]
  wire  _GEN_1115 = 4'hf == CacheLineId; // @[dcache.scala 70:{32,32}]
  wire  _GEN_83 = ~replace_set & 4'hf == CacheLineId ? dirtyArray_0_15 : _GEN_82; // @[dcache.scala 70:{32,32}]
  wire  _GEN_1116 = 4'h0 == CacheLineId; // @[dcache.scala 70:{32,32}]
  wire  _GEN_84 = replace_set & 4'h0 == CacheLineId ? dirtyArray_1_0 : _GEN_83; // @[dcache.scala 70:{32,32}]
  wire  _GEN_85 = replace_set & 4'h1 == CacheLineId ? dirtyArray_1_1 : _GEN_84; // @[dcache.scala 70:{32,32}]
  wire  _GEN_86 = replace_set & 4'h2 == CacheLineId ? dirtyArray_1_2 : _GEN_85; // @[dcache.scala 70:{32,32}]
  wire  _GEN_87 = replace_set & 4'h3 == CacheLineId ? dirtyArray_1_3 : _GEN_86; // @[dcache.scala 70:{32,32}]
  wire  _GEN_88 = replace_set & 4'h4 == CacheLineId ? dirtyArray_1_4 : _GEN_87; // @[dcache.scala 70:{32,32}]
  wire  _GEN_89 = replace_set & 4'h5 == CacheLineId ? dirtyArray_1_5 : _GEN_88; // @[dcache.scala 70:{32,32}]
  wire  _GEN_90 = replace_set & 4'h6 == CacheLineId ? dirtyArray_1_6 : _GEN_89; // @[dcache.scala 70:{32,32}]
  wire  _GEN_91 = replace_set & 4'h7 == CacheLineId ? dirtyArray_1_7 : _GEN_90; // @[dcache.scala 70:{32,32}]
  wire  _GEN_92 = replace_set & 4'h8 == CacheLineId ? dirtyArray_1_8 : _GEN_91; // @[dcache.scala 70:{32,32}]
  wire  _GEN_93 = replace_set & 4'h9 == CacheLineId ? dirtyArray_1_9 : _GEN_92; // @[dcache.scala 70:{32,32}]
  wire  _GEN_94 = replace_set & 4'ha == CacheLineId ? dirtyArray_1_10 : _GEN_93; // @[dcache.scala 70:{32,32}]
  wire  _GEN_95 = replace_set & 4'hb == CacheLineId ? dirtyArray_1_11 : _GEN_94; // @[dcache.scala 70:{32,32}]
  wire  _GEN_96 = replace_set & 4'hc == CacheLineId ? dirtyArray_1_12 : _GEN_95; // @[dcache.scala 70:{32,32}]
  wire  _GEN_97 = replace_set & 4'hd == CacheLineId ? dirtyArray_1_13 : _GEN_96; // @[dcache.scala 70:{32,32}]
  wire  _GEN_98 = replace_set & 4'he == CacheLineId ? dirtyArray_1_14 : _GEN_97; // @[dcache.scala 70:{32,32}]
  wire  _GEN_99 = replace_set & 4'hf == CacheLineId ? dirtyArray_1_15 : _GEN_98; // @[dcache.scala 70:{32,32}]
  wire [3:0] _state_dcache_T_1 = _GEN_99 ? 4'h4 : 4'h7; // @[dcache.scala 70:32]
  wire  _state_dcache_T_2 = to_sram_aw_ready & to_sram_aw_valid; // @[Decoupled.scala 51:35]
  wire [3:0] _state_dcache_T_3 = _state_dcache_T_2 ? 4'h5 : 4'h4; // @[dcache.scala 73:32]
  wire [3:0] _state_dcache_T_4 = to_sram_w_bits_last ? 4'h6 : 4'h5; // @[dcache.scala 77:32]
  wire  _off_T = to_sram_w_ready & to_sram_w_valid; // @[Decoupled.scala 51:35]
  wire [1:0] _off_T_2 = off + 2'h1; // @[dcache.scala 78:52]
  wire [1:0] _off_T_3 = _off_T ? _off_T_2 : off; // @[dcache.scala 78:32]
  wire  _T_8 = 4'h7 == state_dcache; // @[dcache.scala 50:27]
  wire  _state_dcache_T_5 = to_sram_ar_ready & to_sram_ar_valid; // @[Decoupled.scala 51:35]
  wire [3:0] _state_dcache_T_6 = _state_dcache_T_5 ? 4'h8 : 4'h7; // @[dcache.scala 85:32]
  wire [3:0] _state_dcache_T_7 = to_sram_r_bits_last ? 4'h9 : 4'h8; // @[dcache.scala 90:32]
  wire  _off_T_4 = to_sram_r_ready & to_sram_r_valid; // @[Decoupled.scala 51:35]
  wire [1:0] _off_T_7 = _off_T_4 ? _off_T_2 : off; // @[dcache.scala 91:32]
  wire [3:0] _GEN_100 = 4'h9 == state_dcache ? _state_dcache_T : state_dcache; // @[dcache.scala 50:27 96:26 49:31]
  wire [3:0] _GEN_101 = 4'h8 == state_dcache ? _state_dcache_T_7 : _GEN_100; // @[dcache.scala 50:27 90:26]
  wire [1:0] _GEN_102 = 4'h8 == state_dcache ? _off_T_7 : off; // @[dcache.scala 46:24 50:27 91:26]
  wire [3:0] _GEN_103 = 4'h7 == state_dcache ? _state_dcache_T_6 : _GEN_101; // @[dcache.scala 50:27 85:26]
  wire [1:0] _GEN_104 = 4'h7 == state_dcache ? 2'h0 : _GEN_102; // @[dcache.scala 50:27 86:25]
  wire [3:0] _GEN_105 = 4'h6 == state_dcache ? 4'h7 : _GEN_103; // @[dcache.scala 50:27 81:26]
  wire [1:0] _GEN_106 = 4'h6 == state_dcache ? off : _GEN_104; // @[dcache.scala 46:24 50:27]
  wire [3:0] _GEN_107 = 4'h5 == state_dcache ? _state_dcache_T_4 : _GEN_105; // @[dcache.scala 50:27 77:26]
  wire [1:0] _GEN_108 = 4'h5 == state_dcache ? _off_T_3 : _GEN_106; // @[dcache.scala 50:27 78:26]
  wire [3:0] _GEN_109 = 4'h4 == state_dcache ? _state_dcache_T_3 : _GEN_107; // @[dcache.scala 50:27 73:26]
  wire [1:0] _GEN_110 = 4'h4 == state_dcache ? 2'h0 : _GEN_108; // @[dcache.scala 50:27 74:26]
  wire [3:0] _GEN_111 = 4'h3 == state_dcache ? _state_dcache_T_1 : _GEN_109; // @[dcache.scala 50:27 70:26]
  wire [1:0] _GEN_112 = 4'h3 == state_dcache ? off : _GEN_110; // @[dcache.scala 46:24 50:27]
  wire  _T_11 = state_dcache == 4'h8; // @[dcache.scala 104:25]
  wire  _GEN_1133 = 2'h0 == off; // @[dcache.scala 105:{18,50,50}]
  wire  _GEN_1135 = 2'h1 == off; // @[dcache.scala 105:{18,50,50}]
  wire  _GEN_1137 = 2'h2 == off; // @[dcache.scala 105:{18,50,50}]
  wire  _GEN_1139 = 2'h3 == off; // @[dcache.scala 105:{18,50,50}]
  wire  _GEN_248 = _GEN_1086 & _GEN_1116 | validArray_0_0; // @[dcache.scala 107:{50,50} 31:29]
  wire  _GEN_249 = _GEN_1086 & _GEN_1087 | validArray_0_1; // @[dcache.scala 107:{50,50} 31:29]
  wire  _GEN_250 = _GEN_1086 & _GEN_1089 | validArray_0_2; // @[dcache.scala 107:{50,50} 31:29]
  wire  _GEN_251 = _GEN_1086 & _GEN_1091 | validArray_0_3; // @[dcache.scala 107:{50,50} 31:29]
  wire  _GEN_252 = _GEN_1086 & _GEN_1093 | validArray_0_4; // @[dcache.scala 107:{50,50} 31:29]
  wire  _GEN_253 = _GEN_1086 & _GEN_1095 | validArray_0_5; // @[dcache.scala 107:{50,50} 31:29]
  wire  _GEN_254 = _GEN_1086 & _GEN_1097 | validArray_0_6; // @[dcache.scala 107:{50,50} 31:29]
  wire  _GEN_255 = _GEN_1086 & _GEN_1099 | validArray_0_7; // @[dcache.scala 107:{50,50} 31:29]
  wire  _GEN_256 = _GEN_1086 & _GEN_1101 | validArray_0_8; // @[dcache.scala 107:{50,50} 31:29]
  wire  _GEN_257 = _GEN_1086 & _GEN_1103 | validArray_0_9; // @[dcache.scala 107:{50,50} 31:29]
  wire  _GEN_258 = _GEN_1086 & _GEN_1105 | validArray_0_10; // @[dcache.scala 107:{50,50} 31:29]
  wire  _GEN_259 = _GEN_1086 & _GEN_1107 | validArray_0_11; // @[dcache.scala 107:{50,50} 31:29]
  wire  _GEN_260 = _GEN_1086 & _GEN_1109 | validArray_0_12; // @[dcache.scala 107:{50,50} 31:29]
  wire  _GEN_261 = _GEN_1086 & _GEN_1111 | validArray_0_13; // @[dcache.scala 107:{50,50} 31:29]
  wire  _GEN_262 = _GEN_1086 & _GEN_1113 | validArray_0_14; // @[dcache.scala 107:{50,50} 31:29]
  wire  _GEN_263 = _GEN_1086 & _GEN_1115 | validArray_0_15; // @[dcache.scala 107:{50,50} 31:29]
  wire  _GEN_264 = replace_set & _GEN_1116 | validArray_1_0; // @[dcache.scala 107:{50,50} 31:29]
  wire  _GEN_265 = replace_set & _GEN_1087 | validArray_1_1; // @[dcache.scala 107:{50,50} 31:29]
  wire  _GEN_266 = replace_set & _GEN_1089 | validArray_1_2; // @[dcache.scala 107:{50,50} 31:29]
  wire  _GEN_267 = replace_set & _GEN_1091 | validArray_1_3; // @[dcache.scala 107:{50,50} 31:29]
  wire  _GEN_268 = replace_set & _GEN_1093 | validArray_1_4; // @[dcache.scala 107:{50,50} 31:29]
  wire  _GEN_269 = replace_set & _GEN_1095 | validArray_1_5; // @[dcache.scala 107:{50,50} 31:29]
  wire  _GEN_270 = replace_set & _GEN_1097 | validArray_1_6; // @[dcache.scala 107:{50,50} 31:29]
  wire  _GEN_271 = replace_set & _GEN_1099 | validArray_1_7; // @[dcache.scala 107:{50,50} 31:29]
  wire  _GEN_272 = replace_set & _GEN_1101 | validArray_1_8; // @[dcache.scala 107:{50,50} 31:29]
  wire  _GEN_273 = replace_set & _GEN_1103 | validArray_1_9; // @[dcache.scala 107:{50,50} 31:29]
  wire  _GEN_274 = replace_set & _GEN_1105 | validArray_1_10; // @[dcache.scala 107:{50,50} 31:29]
  wire  _GEN_275 = replace_set & _GEN_1107 | validArray_1_11; // @[dcache.scala 107:{50,50} 31:29]
  wire  _GEN_276 = replace_set & _GEN_1109 | validArray_1_12; // @[dcache.scala 107:{50,50} 31:29]
  wire  _GEN_277 = replace_set & _GEN_1111 | validArray_1_13; // @[dcache.scala 107:{50,50} 31:29]
  wire  _GEN_278 = replace_set & _GEN_1113 | validArray_1_14; // @[dcache.scala 107:{50,50} 31:29]
  wire  _GEN_279 = replace_set & _GEN_1115 | validArray_1_15; // @[dcache.scala 107:{50,50} 31:29]
  wire [5:0] _indata_T = 4'h8 * ByteId; // @[dcache.scala 116:45]
  wire [94:0] _GEN_2240 = {{63'd0}, from_LSU_bits_wdata}; // @[dcache.scala 116:28]
  wire [94:0] _indata_T_1 = _GEN_2240 << _indata_T; // @[dcache.scala 116:28]
  wire [94:0] _GEN_1388 = {{63'd0}, from_LSU_bits_wmask}; // @[dcache.scala 116:56]
  wire [94:0] _indata_T_2 = _indata_T_1 & _GEN_1388; // @[dcache.scala 116:56]
  wire [31:0] _indata_T_3 = ~from_LSU_bits_wmask; // @[dcache.scala 116:78]
  wire [31:0] _GEN_571 = dataArray_0_0_outdata_MPORT_data; // @[dcache.scala 116:{76,76}]
  wire  _GEN_1390 = 2'h1 == EntId; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_572 = _GEN_1116 & 2'h1 == EntId ? dataArray_0_1_outdata_MPORT_data : _GEN_571; // @[dcache.scala 116:{76,76}]
  wire  _GEN_1392 = 2'h2 == EntId; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_573 = _GEN_1116 & 2'h2 == EntId ? dataArray_0_2_outdata_MPORT_data : _GEN_572; // @[dcache.scala 116:{76,76}]
  wire  _GEN_1394 = 2'h3 == EntId; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_574 = _GEN_1116 & 2'h3 == EntId ? dataArray_0_3_outdata_MPORT_data : _GEN_573; // @[dcache.scala 116:{76,76}]
  wire  _GEN_1396 = 2'h0 == EntId; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_575 = _GEN_1087 & 2'h0 == EntId ? dataArray_1_0_outdata_MPORT_data : _GEN_574; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_576 = _GEN_1087 & 2'h1 == EntId ? dataArray_1_1_outdata_MPORT_data : _GEN_575; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_577 = _GEN_1087 & 2'h2 == EntId ? dataArray_1_2_outdata_MPORT_data : _GEN_576; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_578 = _GEN_1087 & 2'h3 == EntId ? dataArray_1_3_outdata_MPORT_data : _GEN_577; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_579 = _GEN_1089 & 2'h0 == EntId ? dataArray_2_0_outdata_MPORT_data : _GEN_578; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_580 = _GEN_1089 & 2'h1 == EntId ? dataArray_2_1_outdata_MPORT_data : _GEN_579; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_581 = _GEN_1089 & 2'h2 == EntId ? dataArray_2_2_outdata_MPORT_data : _GEN_580; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_582 = _GEN_1089 & 2'h3 == EntId ? dataArray_2_3_outdata_MPORT_data : _GEN_581; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_583 = _GEN_1091 & 2'h0 == EntId ? dataArray_3_0_outdata_MPORT_data : _GEN_582; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_584 = _GEN_1091 & 2'h1 == EntId ? dataArray_3_1_outdata_MPORT_data : _GEN_583; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_585 = _GEN_1091 & 2'h2 == EntId ? dataArray_3_2_outdata_MPORT_data : _GEN_584; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_586 = _GEN_1091 & 2'h3 == EntId ? dataArray_3_3_outdata_MPORT_data : _GEN_585; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_587 = _GEN_1093 & 2'h0 == EntId ? dataArray_4_0_outdata_MPORT_data : _GEN_586; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_588 = _GEN_1093 & 2'h1 == EntId ? dataArray_4_1_outdata_MPORT_data : _GEN_587; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_589 = _GEN_1093 & 2'h2 == EntId ? dataArray_4_2_outdata_MPORT_data : _GEN_588; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_590 = _GEN_1093 & 2'h3 == EntId ? dataArray_4_3_outdata_MPORT_data : _GEN_589; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_591 = _GEN_1095 & 2'h0 == EntId ? dataArray_5_0_outdata_MPORT_data : _GEN_590; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_592 = _GEN_1095 & 2'h1 == EntId ? dataArray_5_1_outdata_MPORT_data : _GEN_591; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_593 = _GEN_1095 & 2'h2 == EntId ? dataArray_5_2_outdata_MPORT_data : _GEN_592; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_594 = _GEN_1095 & 2'h3 == EntId ? dataArray_5_3_outdata_MPORT_data : _GEN_593; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_595 = _GEN_1097 & 2'h0 == EntId ? dataArray_6_0_outdata_MPORT_data : _GEN_594; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_596 = _GEN_1097 & 2'h1 == EntId ? dataArray_6_1_outdata_MPORT_data : _GEN_595; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_597 = _GEN_1097 & 2'h2 == EntId ? dataArray_6_2_outdata_MPORT_data : _GEN_596; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_598 = _GEN_1097 & 2'h3 == EntId ? dataArray_6_3_outdata_MPORT_data : _GEN_597; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_599 = _GEN_1099 & 2'h0 == EntId ? dataArray_7_0_outdata_MPORT_data : _GEN_598; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_600 = _GEN_1099 & 2'h1 == EntId ? dataArray_7_1_outdata_MPORT_data : _GEN_599; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_601 = _GEN_1099 & 2'h2 == EntId ? dataArray_7_2_outdata_MPORT_data : _GEN_600; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_602 = _GEN_1099 & 2'h3 == EntId ? dataArray_7_3_outdata_MPORT_data : _GEN_601; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_603 = _GEN_1101 & 2'h0 == EntId ? dataArray_8_0_outdata_MPORT_data : _GEN_602; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_604 = _GEN_1101 & 2'h1 == EntId ? dataArray_8_1_outdata_MPORT_data : _GEN_603; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_605 = _GEN_1101 & 2'h2 == EntId ? dataArray_8_2_outdata_MPORT_data : _GEN_604; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_606 = _GEN_1101 & 2'h3 == EntId ? dataArray_8_3_outdata_MPORT_data : _GEN_605; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_607 = _GEN_1103 & 2'h0 == EntId ? dataArray_9_0_outdata_MPORT_data : _GEN_606; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_608 = _GEN_1103 & 2'h1 == EntId ? dataArray_9_1_outdata_MPORT_data : _GEN_607; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_609 = _GEN_1103 & 2'h2 == EntId ? dataArray_9_2_outdata_MPORT_data : _GEN_608; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_610 = _GEN_1103 & 2'h3 == EntId ? dataArray_9_3_outdata_MPORT_data : _GEN_609; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_611 = _GEN_1105 & 2'h0 == EntId ? dataArray_10_0_outdata_MPORT_data : _GEN_610; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_612 = _GEN_1105 & 2'h1 == EntId ? dataArray_10_1_outdata_MPORT_data : _GEN_611; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_613 = _GEN_1105 & 2'h2 == EntId ? dataArray_10_2_outdata_MPORT_data : _GEN_612; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_614 = _GEN_1105 & 2'h3 == EntId ? dataArray_10_3_outdata_MPORT_data : _GEN_613; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_615 = _GEN_1107 & 2'h0 == EntId ? dataArray_11_0_outdata_MPORT_data : _GEN_614; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_616 = _GEN_1107 & 2'h1 == EntId ? dataArray_11_1_outdata_MPORT_data : _GEN_615; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_617 = _GEN_1107 & 2'h2 == EntId ? dataArray_11_2_outdata_MPORT_data : _GEN_616; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_618 = _GEN_1107 & 2'h3 == EntId ? dataArray_11_3_outdata_MPORT_data : _GEN_617; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_619 = _GEN_1109 & 2'h0 == EntId ? dataArray_12_0_outdata_MPORT_data : _GEN_618; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_620 = _GEN_1109 & 2'h1 == EntId ? dataArray_12_1_outdata_MPORT_data : _GEN_619; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_621 = _GEN_1109 & 2'h2 == EntId ? dataArray_12_2_outdata_MPORT_data : _GEN_620; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_622 = _GEN_1109 & 2'h3 == EntId ? dataArray_12_3_outdata_MPORT_data : _GEN_621; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_623 = _GEN_1111 & 2'h0 == EntId ? dataArray_13_0_outdata_MPORT_data : _GEN_622; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_624 = _GEN_1111 & 2'h1 == EntId ? dataArray_13_1_outdata_MPORT_data : _GEN_623; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_625 = _GEN_1111 & 2'h2 == EntId ? dataArray_13_2_outdata_MPORT_data : _GEN_624; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_626 = _GEN_1111 & 2'h3 == EntId ? dataArray_13_3_outdata_MPORT_data : _GEN_625; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_627 = _GEN_1113 & 2'h0 == EntId ? dataArray_14_0_outdata_MPORT_data : _GEN_626; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_628 = _GEN_1113 & 2'h1 == EntId ? dataArray_14_1_outdata_MPORT_data : _GEN_627; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_629 = _GEN_1113 & 2'h2 == EntId ? dataArray_14_2_outdata_MPORT_data : _GEN_628; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_630 = _GEN_1113 & 2'h3 == EntId ? dataArray_14_3_outdata_MPORT_data : _GEN_629; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_631 = _GEN_1115 & 2'h0 == EntId ? dataArray_15_0_outdata_MPORT_data : _GEN_630; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_632 = _GEN_1115 & 2'h1 == EntId ? dataArray_15_1_outdata_MPORT_data : _GEN_631; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_633 = _GEN_1115 & 2'h2 == EntId ? dataArray_15_2_outdata_MPORT_data : _GEN_632; // @[dcache.scala 116:{76,76}]
  wire [31:0] _GEN_634 = _GEN_1115 & 2'h3 == EntId ? dataArray_15_3_outdata_MPORT_data : _GEN_633; // @[dcache.scala 116:{76,76}]
  wire [31:0] _indata_T_4 = _GEN_634 & _indata_T_3; // @[dcache.scala 116:76]
  wire [94:0] _GEN_1515 = {{63'd0}, _indata_T_4}; // @[dcache.scala 116:65]
  wire [94:0] indata = _indata_T_2 | _GEN_1515; // @[dcache.scala 116:65]
  wire  _GEN_763 = ~SetId & _GEN_1116 | dirtyArray_0_0; // @[dcache.scala 119:{46,46} 32:29]
  wire  _GEN_764 = ~SetId & _GEN_1087 | dirtyArray_0_1; // @[dcache.scala 119:{46,46} 32:29]
  wire  _GEN_765 = ~SetId & _GEN_1089 | dirtyArray_0_2; // @[dcache.scala 119:{46,46} 32:29]
  wire  _GEN_766 = ~SetId & _GEN_1091 | dirtyArray_0_3; // @[dcache.scala 119:{46,46} 32:29]
  wire  _GEN_767 = ~SetId & _GEN_1093 | dirtyArray_0_4; // @[dcache.scala 119:{46,46} 32:29]
  wire  _GEN_768 = ~SetId & _GEN_1095 | dirtyArray_0_5; // @[dcache.scala 119:{46,46} 32:29]
  wire  _GEN_769 = ~SetId & _GEN_1097 | dirtyArray_0_6; // @[dcache.scala 119:{46,46} 32:29]
  wire  _GEN_770 = ~SetId & _GEN_1099 | dirtyArray_0_7; // @[dcache.scala 119:{46,46} 32:29]
  wire  _GEN_771 = ~SetId & _GEN_1101 | dirtyArray_0_8; // @[dcache.scala 119:{46,46} 32:29]
  wire  _GEN_772 = ~SetId & _GEN_1103 | dirtyArray_0_9; // @[dcache.scala 119:{46,46} 32:29]
  wire  _GEN_773 = ~SetId & _GEN_1105 | dirtyArray_0_10; // @[dcache.scala 119:{46,46} 32:29]
  wire  _GEN_774 = ~SetId & _GEN_1107 | dirtyArray_0_11; // @[dcache.scala 119:{46,46} 32:29]
  wire  _GEN_775 = ~SetId & _GEN_1109 | dirtyArray_0_12; // @[dcache.scala 119:{46,46} 32:29]
  wire  _GEN_776 = ~SetId & _GEN_1111 | dirtyArray_0_13; // @[dcache.scala 119:{46,46} 32:29]
  wire  _GEN_777 = ~SetId & _GEN_1113 | dirtyArray_0_14; // @[dcache.scala 119:{46,46} 32:29]
  wire  _GEN_778 = ~SetId & _GEN_1115 | dirtyArray_0_15; // @[dcache.scala 119:{46,46} 32:29]
  wire  _GEN_779 = SetId & _GEN_1116 | dirtyArray_1_0; // @[dcache.scala 119:{46,46} 32:29]
  wire  _GEN_780 = SetId & _GEN_1087 | dirtyArray_1_1; // @[dcache.scala 119:{46,46} 32:29]
  wire  _GEN_781 = SetId & _GEN_1089 | dirtyArray_1_2; // @[dcache.scala 119:{46,46} 32:29]
  wire  _GEN_782 = SetId & _GEN_1091 | dirtyArray_1_3; // @[dcache.scala 119:{46,46} 32:29]
  wire  _GEN_783 = SetId & _GEN_1093 | dirtyArray_1_4; // @[dcache.scala 119:{46,46} 32:29]
  wire  _GEN_784 = SetId & _GEN_1095 | dirtyArray_1_5; // @[dcache.scala 119:{46,46} 32:29]
  wire  _GEN_785 = SetId & _GEN_1097 | dirtyArray_1_6; // @[dcache.scala 119:{46,46} 32:29]
  wire  _GEN_786 = SetId & _GEN_1099 | dirtyArray_1_7; // @[dcache.scala 119:{46,46} 32:29]
  wire  _GEN_787 = SetId & _GEN_1101 | dirtyArray_1_8; // @[dcache.scala 119:{46,46} 32:29]
  wire  _GEN_788 = SetId & _GEN_1103 | dirtyArray_1_9; // @[dcache.scala 119:{46,46} 32:29]
  wire  _GEN_789 = SetId & _GEN_1105 | dirtyArray_1_10; // @[dcache.scala 119:{46,46} 32:29]
  wire  _GEN_790 = SetId & _GEN_1107 | dirtyArray_1_11; // @[dcache.scala 119:{46,46} 32:29]
  wire  _GEN_791 = SetId & _GEN_1109 | dirtyArray_1_12; // @[dcache.scala 119:{46,46} 32:29]
  wire  _GEN_792 = SetId & _GEN_1111 | dirtyArray_1_13; // @[dcache.scala 119:{46,46} 32:29]
  wire  _GEN_793 = SetId & _GEN_1113 | dirtyArray_1_14; // @[dcache.scala 119:{46,46} 32:29]
  wire  _GEN_794 = SetId & _GEN_1115 | dirtyArray_1_15; // @[dcache.scala 119:{46,46} 32:29]
  wire [31:0] _to_sram_ar_bits_addr_T = {{4'd0}, from_LSU_bits_addr[31:4]}; // @[dcache.scala 129:93]
  wire [35:0] _GEN_1725 = {_to_sram_ar_bits_addr_T, 4'h0}; // @[dcache.scala 129:106]
  wire [38:0] _to_sram_ar_bits_addr_T_1 = {{3'd0}, _GEN_1725}; // @[dcache.scala 129:106]
  wire [38:0] _to_sram_ar_bits_addr_T_3 = _T_8 ? _to_sram_ar_bits_addr_T_1 : 39'h0; // @[Mux.scala 81:58]
  wire [1:0] _to_sram_ar_bits_len_T_1 = _T_8 ? 2'h3 : 2'h0; // @[Mux.scala 81:58]
  wire [31:0] _GEN_958 = dataArray_0_0_toMemData_MPORT_data; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_959 = _GEN_1116 & _GEN_1135 ? dataArray_0_1_toMemData_MPORT_data : _GEN_958; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_960 = _GEN_1116 & _GEN_1137 ? dataArray_0_2_toMemData_MPORT_data : _GEN_959; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_961 = _GEN_1116 & _GEN_1139 ? dataArray_0_3_toMemData_MPORT_data : _GEN_960; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_962 = _GEN_1087 & _GEN_1133 ? dataArray_1_0_toMemData_MPORT_data : _GEN_961; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_963 = _GEN_1087 & _GEN_1135 ? dataArray_1_1_toMemData_MPORT_data : _GEN_962; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_964 = _GEN_1087 & _GEN_1137 ? dataArray_1_2_toMemData_MPORT_data : _GEN_963; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_965 = _GEN_1087 & _GEN_1139 ? dataArray_1_3_toMemData_MPORT_data : _GEN_964; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_966 = _GEN_1089 & _GEN_1133 ? dataArray_2_0_toMemData_MPORT_data : _GEN_965; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_967 = _GEN_1089 & _GEN_1135 ? dataArray_2_1_toMemData_MPORT_data : _GEN_966; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_968 = _GEN_1089 & _GEN_1137 ? dataArray_2_2_toMemData_MPORT_data : _GEN_967; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_969 = _GEN_1089 & _GEN_1139 ? dataArray_2_3_toMemData_MPORT_data : _GEN_968; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_970 = _GEN_1091 & _GEN_1133 ? dataArray_3_0_toMemData_MPORT_data : _GEN_969; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_971 = _GEN_1091 & _GEN_1135 ? dataArray_3_1_toMemData_MPORT_data : _GEN_970; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_972 = _GEN_1091 & _GEN_1137 ? dataArray_3_2_toMemData_MPORT_data : _GEN_971; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_973 = _GEN_1091 & _GEN_1139 ? dataArray_3_3_toMemData_MPORT_data : _GEN_972; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_974 = _GEN_1093 & _GEN_1133 ? dataArray_4_0_toMemData_MPORT_data : _GEN_973; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_975 = _GEN_1093 & _GEN_1135 ? dataArray_4_1_toMemData_MPORT_data : _GEN_974; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_976 = _GEN_1093 & _GEN_1137 ? dataArray_4_2_toMemData_MPORT_data : _GEN_975; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_977 = _GEN_1093 & _GEN_1139 ? dataArray_4_3_toMemData_MPORT_data : _GEN_976; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_978 = _GEN_1095 & _GEN_1133 ? dataArray_5_0_toMemData_MPORT_data : _GEN_977; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_979 = _GEN_1095 & _GEN_1135 ? dataArray_5_1_toMemData_MPORT_data : _GEN_978; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_980 = _GEN_1095 & _GEN_1137 ? dataArray_5_2_toMemData_MPORT_data : _GEN_979; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_981 = _GEN_1095 & _GEN_1139 ? dataArray_5_3_toMemData_MPORT_data : _GEN_980; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_982 = _GEN_1097 & _GEN_1133 ? dataArray_6_0_toMemData_MPORT_data : _GEN_981; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_983 = _GEN_1097 & _GEN_1135 ? dataArray_6_1_toMemData_MPORT_data : _GEN_982; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_984 = _GEN_1097 & _GEN_1137 ? dataArray_6_2_toMemData_MPORT_data : _GEN_983; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_985 = _GEN_1097 & _GEN_1139 ? dataArray_6_3_toMemData_MPORT_data : _GEN_984; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_986 = _GEN_1099 & _GEN_1133 ? dataArray_7_0_toMemData_MPORT_data : _GEN_985; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_987 = _GEN_1099 & _GEN_1135 ? dataArray_7_1_toMemData_MPORT_data : _GEN_986; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_988 = _GEN_1099 & _GEN_1137 ? dataArray_7_2_toMemData_MPORT_data : _GEN_987; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_989 = _GEN_1099 & _GEN_1139 ? dataArray_7_3_toMemData_MPORT_data : _GEN_988; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_990 = _GEN_1101 & _GEN_1133 ? dataArray_8_0_toMemData_MPORT_data : _GEN_989; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_991 = _GEN_1101 & _GEN_1135 ? dataArray_8_1_toMemData_MPORT_data : _GEN_990; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_992 = _GEN_1101 & _GEN_1137 ? dataArray_8_2_toMemData_MPORT_data : _GEN_991; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_993 = _GEN_1101 & _GEN_1139 ? dataArray_8_3_toMemData_MPORT_data : _GEN_992; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_994 = _GEN_1103 & _GEN_1133 ? dataArray_9_0_toMemData_MPORT_data : _GEN_993; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_995 = _GEN_1103 & _GEN_1135 ? dataArray_9_1_toMemData_MPORT_data : _GEN_994; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_996 = _GEN_1103 & _GEN_1137 ? dataArray_9_2_toMemData_MPORT_data : _GEN_995; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_997 = _GEN_1103 & _GEN_1139 ? dataArray_9_3_toMemData_MPORT_data : _GEN_996; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_998 = _GEN_1105 & _GEN_1133 ? dataArray_10_0_toMemData_MPORT_data : _GEN_997; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_999 = _GEN_1105 & _GEN_1135 ? dataArray_10_1_toMemData_MPORT_data : _GEN_998; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_1000 = _GEN_1105 & _GEN_1137 ? dataArray_10_2_toMemData_MPORT_data : _GEN_999; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_1001 = _GEN_1105 & _GEN_1139 ? dataArray_10_3_toMemData_MPORT_data : _GEN_1000; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_1002 = _GEN_1107 & _GEN_1133 ? dataArray_11_0_toMemData_MPORT_data : _GEN_1001; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_1003 = _GEN_1107 & _GEN_1135 ? dataArray_11_1_toMemData_MPORT_data : _GEN_1002; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_1004 = _GEN_1107 & _GEN_1137 ? dataArray_11_2_toMemData_MPORT_data : _GEN_1003; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_1005 = _GEN_1107 & _GEN_1139 ? dataArray_11_3_toMemData_MPORT_data : _GEN_1004; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_1006 = _GEN_1109 & _GEN_1133 ? dataArray_12_0_toMemData_MPORT_data : _GEN_1005; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_1007 = _GEN_1109 & _GEN_1135 ? dataArray_12_1_toMemData_MPORT_data : _GEN_1006; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_1008 = _GEN_1109 & _GEN_1137 ? dataArray_12_2_toMemData_MPORT_data : _GEN_1007; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_1009 = _GEN_1109 & _GEN_1139 ? dataArray_12_3_toMemData_MPORT_data : _GEN_1008; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_1010 = _GEN_1111 & _GEN_1133 ? dataArray_13_0_toMemData_MPORT_data : _GEN_1009; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_1011 = _GEN_1111 & _GEN_1135 ? dataArray_13_1_toMemData_MPORT_data : _GEN_1010; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_1012 = _GEN_1111 & _GEN_1137 ? dataArray_13_2_toMemData_MPORT_data : _GEN_1011; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_1013 = _GEN_1111 & _GEN_1139 ? dataArray_13_3_toMemData_MPORT_data : _GEN_1012; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_1014 = _GEN_1113 & _GEN_1133 ? dataArray_14_0_toMemData_MPORT_data : _GEN_1013; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_1015 = _GEN_1113 & _GEN_1135 ? dataArray_14_1_toMemData_MPORT_data : _GEN_1014; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_1016 = _GEN_1113 & _GEN_1137 ? dataArray_14_2_toMemData_MPORT_data : _GEN_1015; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_1017 = _GEN_1113 & _GEN_1139 ? dataArray_14_3_toMemData_MPORT_data : _GEN_1016; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_1018 = _GEN_1115 & _GEN_1133 ? dataArray_15_0_toMemData_MPORT_data : _GEN_1017; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_1019 = _GEN_1115 & _GEN_1135 ? dataArray_15_1_toMemData_MPORT_data : _GEN_1018; // @[dcache.scala 140:{27,27}]
  wire [31:0] _GEN_1020 = _GEN_1115 & _GEN_1137 ? dataArray_15_2_toMemData_MPORT_data : _GEN_1019; // @[dcache.scala 140:{27,27}]
  wire [2:0] _GEN_1854 = {{1'd0}, off}; // @[dcache.scala 142:34]
  wire [31:0] _GEN_1022 = dataArray_0_0_cachedata_MPORT_data; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1023 = _GEN_1116 & _GEN_1390 ? dataArray_0_1_cachedata_MPORT_data : _GEN_1022; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1024 = _GEN_1116 & _GEN_1392 ? dataArray_0_2_cachedata_MPORT_data : _GEN_1023; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1025 = _GEN_1116 & _GEN_1394 ? dataArray_0_3_cachedata_MPORT_data : _GEN_1024; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1026 = _GEN_1087 & _GEN_1396 ? dataArray_1_0_cachedata_MPORT_data : _GEN_1025; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1027 = _GEN_1087 & _GEN_1390 ? dataArray_1_1_cachedata_MPORT_data : _GEN_1026; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1028 = _GEN_1087 & _GEN_1392 ? dataArray_1_2_cachedata_MPORT_data : _GEN_1027; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1029 = _GEN_1087 & _GEN_1394 ? dataArray_1_3_cachedata_MPORT_data : _GEN_1028; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1030 = _GEN_1089 & _GEN_1396 ? dataArray_2_0_cachedata_MPORT_data : _GEN_1029; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1031 = _GEN_1089 & _GEN_1390 ? dataArray_2_1_cachedata_MPORT_data : _GEN_1030; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1032 = _GEN_1089 & _GEN_1392 ? dataArray_2_2_cachedata_MPORT_data : _GEN_1031; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1033 = _GEN_1089 & _GEN_1394 ? dataArray_2_3_cachedata_MPORT_data : _GEN_1032; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1034 = _GEN_1091 & _GEN_1396 ? dataArray_3_0_cachedata_MPORT_data : _GEN_1033; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1035 = _GEN_1091 & _GEN_1390 ? dataArray_3_1_cachedata_MPORT_data : _GEN_1034; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1036 = _GEN_1091 & _GEN_1392 ? dataArray_3_2_cachedata_MPORT_data : _GEN_1035; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1037 = _GEN_1091 & _GEN_1394 ? dataArray_3_3_cachedata_MPORT_data : _GEN_1036; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1038 = _GEN_1093 & _GEN_1396 ? dataArray_4_0_cachedata_MPORT_data : _GEN_1037; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1039 = _GEN_1093 & _GEN_1390 ? dataArray_4_1_cachedata_MPORT_data : _GEN_1038; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1040 = _GEN_1093 & _GEN_1392 ? dataArray_4_2_cachedata_MPORT_data : _GEN_1039; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1041 = _GEN_1093 & _GEN_1394 ? dataArray_4_3_cachedata_MPORT_data : _GEN_1040; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1042 = _GEN_1095 & _GEN_1396 ? dataArray_5_0_cachedata_MPORT_data : _GEN_1041; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1043 = _GEN_1095 & _GEN_1390 ? dataArray_5_1_cachedata_MPORT_data : _GEN_1042; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1044 = _GEN_1095 & _GEN_1392 ? dataArray_5_2_cachedata_MPORT_data : _GEN_1043; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1045 = _GEN_1095 & _GEN_1394 ? dataArray_5_3_cachedata_MPORT_data : _GEN_1044; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1046 = _GEN_1097 & _GEN_1396 ? dataArray_6_0_cachedata_MPORT_data : _GEN_1045; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1047 = _GEN_1097 & _GEN_1390 ? dataArray_6_1_cachedata_MPORT_data : _GEN_1046; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1048 = _GEN_1097 & _GEN_1392 ? dataArray_6_2_cachedata_MPORT_data : _GEN_1047; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1049 = _GEN_1097 & _GEN_1394 ? dataArray_6_3_cachedata_MPORT_data : _GEN_1048; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1050 = _GEN_1099 & _GEN_1396 ? dataArray_7_0_cachedata_MPORT_data : _GEN_1049; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1051 = _GEN_1099 & _GEN_1390 ? dataArray_7_1_cachedata_MPORT_data : _GEN_1050; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1052 = _GEN_1099 & _GEN_1392 ? dataArray_7_2_cachedata_MPORT_data : _GEN_1051; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1053 = _GEN_1099 & _GEN_1394 ? dataArray_7_3_cachedata_MPORT_data : _GEN_1052; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1054 = _GEN_1101 & _GEN_1396 ? dataArray_8_0_cachedata_MPORT_data : _GEN_1053; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1055 = _GEN_1101 & _GEN_1390 ? dataArray_8_1_cachedata_MPORT_data : _GEN_1054; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1056 = _GEN_1101 & _GEN_1392 ? dataArray_8_2_cachedata_MPORT_data : _GEN_1055; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1057 = _GEN_1101 & _GEN_1394 ? dataArray_8_3_cachedata_MPORT_data : _GEN_1056; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1058 = _GEN_1103 & _GEN_1396 ? dataArray_9_0_cachedata_MPORT_data : _GEN_1057; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1059 = _GEN_1103 & _GEN_1390 ? dataArray_9_1_cachedata_MPORT_data : _GEN_1058; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1060 = _GEN_1103 & _GEN_1392 ? dataArray_9_2_cachedata_MPORT_data : _GEN_1059; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1061 = _GEN_1103 & _GEN_1394 ? dataArray_9_3_cachedata_MPORT_data : _GEN_1060; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1062 = _GEN_1105 & _GEN_1396 ? dataArray_10_0_cachedata_MPORT_data : _GEN_1061; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1063 = _GEN_1105 & _GEN_1390 ? dataArray_10_1_cachedata_MPORT_data : _GEN_1062; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1064 = _GEN_1105 & _GEN_1392 ? dataArray_10_2_cachedata_MPORT_data : _GEN_1063; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1065 = _GEN_1105 & _GEN_1394 ? dataArray_10_3_cachedata_MPORT_data : _GEN_1064; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1066 = _GEN_1107 & _GEN_1396 ? dataArray_11_0_cachedata_MPORT_data : _GEN_1065; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1067 = _GEN_1107 & _GEN_1390 ? dataArray_11_1_cachedata_MPORT_data : _GEN_1066; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1068 = _GEN_1107 & _GEN_1392 ? dataArray_11_2_cachedata_MPORT_data : _GEN_1067; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1069 = _GEN_1107 & _GEN_1394 ? dataArray_11_3_cachedata_MPORT_data : _GEN_1068; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1070 = _GEN_1109 & _GEN_1396 ? dataArray_12_0_cachedata_MPORT_data : _GEN_1069; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1071 = _GEN_1109 & _GEN_1390 ? dataArray_12_1_cachedata_MPORT_data : _GEN_1070; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1072 = _GEN_1109 & _GEN_1392 ? dataArray_12_2_cachedata_MPORT_data : _GEN_1071; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1073 = _GEN_1109 & _GEN_1394 ? dataArray_12_3_cachedata_MPORT_data : _GEN_1072; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1074 = _GEN_1111 & _GEN_1396 ? dataArray_13_0_cachedata_MPORT_data : _GEN_1073; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1075 = _GEN_1111 & _GEN_1390 ? dataArray_13_1_cachedata_MPORT_data : _GEN_1074; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1076 = _GEN_1111 & _GEN_1392 ? dataArray_13_2_cachedata_MPORT_data : _GEN_1075; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1077 = _GEN_1111 & _GEN_1394 ? dataArray_13_3_cachedata_MPORT_data : _GEN_1076; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1078 = _GEN_1113 & _GEN_1396 ? dataArray_14_0_cachedata_MPORT_data : _GEN_1077; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1079 = _GEN_1113 & _GEN_1390 ? dataArray_14_1_cachedata_MPORT_data : _GEN_1078; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1080 = _GEN_1113 & _GEN_1392 ? dataArray_14_2_cachedata_MPORT_data : _GEN_1079; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1081 = _GEN_1113 & _GEN_1394 ? dataArray_14_3_cachedata_MPORT_data : _GEN_1080; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1082 = _GEN_1115 & _GEN_1396 ? dataArray_15_0_cachedata_MPORT_data : _GEN_1081; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1083 = _GEN_1115 & _GEN_1390 ? dataArray_15_1_cachedata_MPORT_data : _GEN_1082; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1084 = _GEN_1115 & _GEN_1392 ? dataArray_15_2_cachedata_MPORT_data : _GEN_1083; // @[dcache.scala 145:{29,29}]
  wire [31:0] _GEN_1085 = _GEN_1115 & _GEN_1394 ? dataArray_15_3_cachedata_MPORT_data : _GEN_1084; // @[dcache.scala 145:{29,29}]
  assign dataArray_0_0_cachedata_MPORT_en = dataArray_0_0_cachedata_MPORT_en_pipe_0;
  assign dataArray_0_0_cachedata_MPORT_addr = dataArray_0_0_cachedata_MPORT_addr_pipe_0;
  assign dataArray_0_0_cachedata_MPORT_data = dataArray_0_0[dataArray_0_0_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_0_0_outdata_MPORT_en = dataArray_0_0_outdata_MPORT_en_pipe_0;
  assign dataArray_0_0_outdata_MPORT_addr = dataArray_0_0_outdata_MPORT_addr_pipe_0;
  assign dataArray_0_0_outdata_MPORT_data = dataArray_0_0[dataArray_0_0_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_0_0_toMemData_MPORT_en = dataArray_0_0_toMemData_MPORT_en_pipe_0;
  assign dataArray_0_0_toMemData_MPORT_addr = dataArray_0_0_toMemData_MPORT_addr_pipe_0;
  assign dataArray_0_0_toMemData_MPORT_data = dataArray_0_0[dataArray_0_0_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_0_0_MPORT_data = to_sram_r_bits_data;
  assign dataArray_0_0_MPORT_addr = replace_set;
  assign dataArray_0_0_MPORT_mask = _GEN_1116 & _GEN_1133;
  assign dataArray_0_0_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_0_0_MPORT_1_data = indata[31:0];
  assign dataArray_0_0_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_0_0_MPORT_1_mask = _GEN_1116 & _GEN_1396;
  assign dataArray_0_0_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_0_1_cachedata_MPORT_en = dataArray_0_1_cachedata_MPORT_en_pipe_0;
  assign dataArray_0_1_cachedata_MPORT_addr = dataArray_0_1_cachedata_MPORT_addr_pipe_0;
  assign dataArray_0_1_cachedata_MPORT_data = dataArray_0_1[dataArray_0_1_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_0_1_outdata_MPORT_en = dataArray_0_1_outdata_MPORT_en_pipe_0;
  assign dataArray_0_1_outdata_MPORT_addr = dataArray_0_1_outdata_MPORT_addr_pipe_0;
  assign dataArray_0_1_outdata_MPORT_data = dataArray_0_1[dataArray_0_1_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_0_1_toMemData_MPORT_en = dataArray_0_1_toMemData_MPORT_en_pipe_0;
  assign dataArray_0_1_toMemData_MPORT_addr = dataArray_0_1_toMemData_MPORT_addr_pipe_0;
  assign dataArray_0_1_toMemData_MPORT_data = dataArray_0_1[dataArray_0_1_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_0_1_MPORT_data = to_sram_r_bits_data;
  assign dataArray_0_1_MPORT_addr = replace_set;
  assign dataArray_0_1_MPORT_mask = _GEN_1116 & _GEN_1135;
  assign dataArray_0_1_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_0_1_MPORT_1_data = indata[31:0];
  assign dataArray_0_1_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_0_1_MPORT_1_mask = _GEN_1116 & _GEN_1390;
  assign dataArray_0_1_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_0_2_cachedata_MPORT_en = dataArray_0_2_cachedata_MPORT_en_pipe_0;
  assign dataArray_0_2_cachedata_MPORT_addr = dataArray_0_2_cachedata_MPORT_addr_pipe_0;
  assign dataArray_0_2_cachedata_MPORT_data = dataArray_0_2[dataArray_0_2_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_0_2_outdata_MPORT_en = dataArray_0_2_outdata_MPORT_en_pipe_0;
  assign dataArray_0_2_outdata_MPORT_addr = dataArray_0_2_outdata_MPORT_addr_pipe_0;
  assign dataArray_0_2_outdata_MPORT_data = dataArray_0_2[dataArray_0_2_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_0_2_toMemData_MPORT_en = dataArray_0_2_toMemData_MPORT_en_pipe_0;
  assign dataArray_0_2_toMemData_MPORT_addr = dataArray_0_2_toMemData_MPORT_addr_pipe_0;
  assign dataArray_0_2_toMemData_MPORT_data = dataArray_0_2[dataArray_0_2_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_0_2_MPORT_data = to_sram_r_bits_data;
  assign dataArray_0_2_MPORT_addr = replace_set;
  assign dataArray_0_2_MPORT_mask = _GEN_1116 & _GEN_1137;
  assign dataArray_0_2_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_0_2_MPORT_1_data = indata[31:0];
  assign dataArray_0_2_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_0_2_MPORT_1_mask = _GEN_1116 & _GEN_1392;
  assign dataArray_0_2_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_0_3_cachedata_MPORT_en = dataArray_0_3_cachedata_MPORT_en_pipe_0;
  assign dataArray_0_3_cachedata_MPORT_addr = dataArray_0_3_cachedata_MPORT_addr_pipe_0;
  assign dataArray_0_3_cachedata_MPORT_data = dataArray_0_3[dataArray_0_3_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_0_3_outdata_MPORT_en = dataArray_0_3_outdata_MPORT_en_pipe_0;
  assign dataArray_0_3_outdata_MPORT_addr = dataArray_0_3_outdata_MPORT_addr_pipe_0;
  assign dataArray_0_3_outdata_MPORT_data = dataArray_0_3[dataArray_0_3_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_0_3_toMemData_MPORT_en = dataArray_0_3_toMemData_MPORT_en_pipe_0;
  assign dataArray_0_3_toMemData_MPORT_addr = dataArray_0_3_toMemData_MPORT_addr_pipe_0;
  assign dataArray_0_3_toMemData_MPORT_data = dataArray_0_3[dataArray_0_3_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_0_3_MPORT_data = to_sram_r_bits_data;
  assign dataArray_0_3_MPORT_addr = replace_set;
  assign dataArray_0_3_MPORT_mask = _GEN_1116 & _GEN_1139;
  assign dataArray_0_3_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_0_3_MPORT_1_data = indata[31:0];
  assign dataArray_0_3_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_0_3_MPORT_1_mask = _GEN_1116 & _GEN_1394;
  assign dataArray_0_3_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_1_0_cachedata_MPORT_en = dataArray_1_0_cachedata_MPORT_en_pipe_0;
  assign dataArray_1_0_cachedata_MPORT_addr = dataArray_1_0_cachedata_MPORT_addr_pipe_0;
  assign dataArray_1_0_cachedata_MPORT_data = dataArray_1_0[dataArray_1_0_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_1_0_outdata_MPORT_en = dataArray_1_0_outdata_MPORT_en_pipe_0;
  assign dataArray_1_0_outdata_MPORT_addr = dataArray_1_0_outdata_MPORT_addr_pipe_0;
  assign dataArray_1_0_outdata_MPORT_data = dataArray_1_0[dataArray_1_0_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_1_0_toMemData_MPORT_en = dataArray_1_0_toMemData_MPORT_en_pipe_0;
  assign dataArray_1_0_toMemData_MPORT_addr = dataArray_1_0_toMemData_MPORT_addr_pipe_0;
  assign dataArray_1_0_toMemData_MPORT_data = dataArray_1_0[dataArray_1_0_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_1_0_MPORT_data = to_sram_r_bits_data;
  assign dataArray_1_0_MPORT_addr = replace_set;
  assign dataArray_1_0_MPORT_mask = _GEN_1087 & _GEN_1133;
  assign dataArray_1_0_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_1_0_MPORT_1_data = indata[31:0];
  assign dataArray_1_0_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_1_0_MPORT_1_mask = _GEN_1087 & _GEN_1396;
  assign dataArray_1_0_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_1_1_cachedata_MPORT_en = dataArray_1_1_cachedata_MPORT_en_pipe_0;
  assign dataArray_1_1_cachedata_MPORT_addr = dataArray_1_1_cachedata_MPORT_addr_pipe_0;
  assign dataArray_1_1_cachedata_MPORT_data = dataArray_1_1[dataArray_1_1_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_1_1_outdata_MPORT_en = dataArray_1_1_outdata_MPORT_en_pipe_0;
  assign dataArray_1_1_outdata_MPORT_addr = dataArray_1_1_outdata_MPORT_addr_pipe_0;
  assign dataArray_1_1_outdata_MPORT_data = dataArray_1_1[dataArray_1_1_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_1_1_toMemData_MPORT_en = dataArray_1_1_toMemData_MPORT_en_pipe_0;
  assign dataArray_1_1_toMemData_MPORT_addr = dataArray_1_1_toMemData_MPORT_addr_pipe_0;
  assign dataArray_1_1_toMemData_MPORT_data = dataArray_1_1[dataArray_1_1_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_1_1_MPORT_data = to_sram_r_bits_data;
  assign dataArray_1_1_MPORT_addr = replace_set;
  assign dataArray_1_1_MPORT_mask = _GEN_1087 & _GEN_1135;
  assign dataArray_1_1_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_1_1_MPORT_1_data = indata[31:0];
  assign dataArray_1_1_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_1_1_MPORT_1_mask = _GEN_1087 & _GEN_1390;
  assign dataArray_1_1_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_1_2_cachedata_MPORT_en = dataArray_1_2_cachedata_MPORT_en_pipe_0;
  assign dataArray_1_2_cachedata_MPORT_addr = dataArray_1_2_cachedata_MPORT_addr_pipe_0;
  assign dataArray_1_2_cachedata_MPORT_data = dataArray_1_2[dataArray_1_2_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_1_2_outdata_MPORT_en = dataArray_1_2_outdata_MPORT_en_pipe_0;
  assign dataArray_1_2_outdata_MPORT_addr = dataArray_1_2_outdata_MPORT_addr_pipe_0;
  assign dataArray_1_2_outdata_MPORT_data = dataArray_1_2[dataArray_1_2_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_1_2_toMemData_MPORT_en = dataArray_1_2_toMemData_MPORT_en_pipe_0;
  assign dataArray_1_2_toMemData_MPORT_addr = dataArray_1_2_toMemData_MPORT_addr_pipe_0;
  assign dataArray_1_2_toMemData_MPORT_data = dataArray_1_2[dataArray_1_2_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_1_2_MPORT_data = to_sram_r_bits_data;
  assign dataArray_1_2_MPORT_addr = replace_set;
  assign dataArray_1_2_MPORT_mask = _GEN_1087 & _GEN_1137;
  assign dataArray_1_2_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_1_2_MPORT_1_data = indata[31:0];
  assign dataArray_1_2_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_1_2_MPORT_1_mask = _GEN_1087 & _GEN_1392;
  assign dataArray_1_2_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_1_3_cachedata_MPORT_en = dataArray_1_3_cachedata_MPORT_en_pipe_0;
  assign dataArray_1_3_cachedata_MPORT_addr = dataArray_1_3_cachedata_MPORT_addr_pipe_0;
  assign dataArray_1_3_cachedata_MPORT_data = dataArray_1_3[dataArray_1_3_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_1_3_outdata_MPORT_en = dataArray_1_3_outdata_MPORT_en_pipe_0;
  assign dataArray_1_3_outdata_MPORT_addr = dataArray_1_3_outdata_MPORT_addr_pipe_0;
  assign dataArray_1_3_outdata_MPORT_data = dataArray_1_3[dataArray_1_3_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_1_3_toMemData_MPORT_en = dataArray_1_3_toMemData_MPORT_en_pipe_0;
  assign dataArray_1_3_toMemData_MPORT_addr = dataArray_1_3_toMemData_MPORT_addr_pipe_0;
  assign dataArray_1_3_toMemData_MPORT_data = dataArray_1_3[dataArray_1_3_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_1_3_MPORT_data = to_sram_r_bits_data;
  assign dataArray_1_3_MPORT_addr = replace_set;
  assign dataArray_1_3_MPORT_mask = _GEN_1087 & _GEN_1139;
  assign dataArray_1_3_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_1_3_MPORT_1_data = indata[31:0];
  assign dataArray_1_3_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_1_3_MPORT_1_mask = _GEN_1087 & _GEN_1394;
  assign dataArray_1_3_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_2_0_cachedata_MPORT_en = dataArray_2_0_cachedata_MPORT_en_pipe_0;
  assign dataArray_2_0_cachedata_MPORT_addr = dataArray_2_0_cachedata_MPORT_addr_pipe_0;
  assign dataArray_2_0_cachedata_MPORT_data = dataArray_2_0[dataArray_2_0_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_2_0_outdata_MPORT_en = dataArray_2_0_outdata_MPORT_en_pipe_0;
  assign dataArray_2_0_outdata_MPORT_addr = dataArray_2_0_outdata_MPORT_addr_pipe_0;
  assign dataArray_2_0_outdata_MPORT_data = dataArray_2_0[dataArray_2_0_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_2_0_toMemData_MPORT_en = dataArray_2_0_toMemData_MPORT_en_pipe_0;
  assign dataArray_2_0_toMemData_MPORT_addr = dataArray_2_0_toMemData_MPORT_addr_pipe_0;
  assign dataArray_2_0_toMemData_MPORT_data = dataArray_2_0[dataArray_2_0_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_2_0_MPORT_data = to_sram_r_bits_data;
  assign dataArray_2_0_MPORT_addr = replace_set;
  assign dataArray_2_0_MPORT_mask = _GEN_1089 & _GEN_1133;
  assign dataArray_2_0_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_2_0_MPORT_1_data = indata[31:0];
  assign dataArray_2_0_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_2_0_MPORT_1_mask = _GEN_1089 & _GEN_1396;
  assign dataArray_2_0_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_2_1_cachedata_MPORT_en = dataArray_2_1_cachedata_MPORT_en_pipe_0;
  assign dataArray_2_1_cachedata_MPORT_addr = dataArray_2_1_cachedata_MPORT_addr_pipe_0;
  assign dataArray_2_1_cachedata_MPORT_data = dataArray_2_1[dataArray_2_1_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_2_1_outdata_MPORT_en = dataArray_2_1_outdata_MPORT_en_pipe_0;
  assign dataArray_2_1_outdata_MPORT_addr = dataArray_2_1_outdata_MPORT_addr_pipe_0;
  assign dataArray_2_1_outdata_MPORT_data = dataArray_2_1[dataArray_2_1_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_2_1_toMemData_MPORT_en = dataArray_2_1_toMemData_MPORT_en_pipe_0;
  assign dataArray_2_1_toMemData_MPORT_addr = dataArray_2_1_toMemData_MPORT_addr_pipe_0;
  assign dataArray_2_1_toMemData_MPORT_data = dataArray_2_1[dataArray_2_1_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_2_1_MPORT_data = to_sram_r_bits_data;
  assign dataArray_2_1_MPORT_addr = replace_set;
  assign dataArray_2_1_MPORT_mask = _GEN_1089 & _GEN_1135;
  assign dataArray_2_1_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_2_1_MPORT_1_data = indata[31:0];
  assign dataArray_2_1_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_2_1_MPORT_1_mask = _GEN_1089 & _GEN_1390;
  assign dataArray_2_1_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_2_2_cachedata_MPORT_en = dataArray_2_2_cachedata_MPORT_en_pipe_0;
  assign dataArray_2_2_cachedata_MPORT_addr = dataArray_2_2_cachedata_MPORT_addr_pipe_0;
  assign dataArray_2_2_cachedata_MPORT_data = dataArray_2_2[dataArray_2_2_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_2_2_outdata_MPORT_en = dataArray_2_2_outdata_MPORT_en_pipe_0;
  assign dataArray_2_2_outdata_MPORT_addr = dataArray_2_2_outdata_MPORT_addr_pipe_0;
  assign dataArray_2_2_outdata_MPORT_data = dataArray_2_2[dataArray_2_2_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_2_2_toMemData_MPORT_en = dataArray_2_2_toMemData_MPORT_en_pipe_0;
  assign dataArray_2_2_toMemData_MPORT_addr = dataArray_2_2_toMemData_MPORT_addr_pipe_0;
  assign dataArray_2_2_toMemData_MPORT_data = dataArray_2_2[dataArray_2_2_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_2_2_MPORT_data = to_sram_r_bits_data;
  assign dataArray_2_2_MPORT_addr = replace_set;
  assign dataArray_2_2_MPORT_mask = _GEN_1089 & _GEN_1137;
  assign dataArray_2_2_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_2_2_MPORT_1_data = indata[31:0];
  assign dataArray_2_2_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_2_2_MPORT_1_mask = _GEN_1089 & _GEN_1392;
  assign dataArray_2_2_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_2_3_cachedata_MPORT_en = dataArray_2_3_cachedata_MPORT_en_pipe_0;
  assign dataArray_2_3_cachedata_MPORT_addr = dataArray_2_3_cachedata_MPORT_addr_pipe_0;
  assign dataArray_2_3_cachedata_MPORT_data = dataArray_2_3[dataArray_2_3_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_2_3_outdata_MPORT_en = dataArray_2_3_outdata_MPORT_en_pipe_0;
  assign dataArray_2_3_outdata_MPORT_addr = dataArray_2_3_outdata_MPORT_addr_pipe_0;
  assign dataArray_2_3_outdata_MPORT_data = dataArray_2_3[dataArray_2_3_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_2_3_toMemData_MPORT_en = dataArray_2_3_toMemData_MPORT_en_pipe_0;
  assign dataArray_2_3_toMemData_MPORT_addr = dataArray_2_3_toMemData_MPORT_addr_pipe_0;
  assign dataArray_2_3_toMemData_MPORT_data = dataArray_2_3[dataArray_2_3_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_2_3_MPORT_data = to_sram_r_bits_data;
  assign dataArray_2_3_MPORT_addr = replace_set;
  assign dataArray_2_3_MPORT_mask = _GEN_1089 & _GEN_1139;
  assign dataArray_2_3_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_2_3_MPORT_1_data = indata[31:0];
  assign dataArray_2_3_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_2_3_MPORT_1_mask = _GEN_1089 & _GEN_1394;
  assign dataArray_2_3_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_3_0_cachedata_MPORT_en = dataArray_3_0_cachedata_MPORT_en_pipe_0;
  assign dataArray_3_0_cachedata_MPORT_addr = dataArray_3_0_cachedata_MPORT_addr_pipe_0;
  assign dataArray_3_0_cachedata_MPORT_data = dataArray_3_0[dataArray_3_0_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_3_0_outdata_MPORT_en = dataArray_3_0_outdata_MPORT_en_pipe_0;
  assign dataArray_3_0_outdata_MPORT_addr = dataArray_3_0_outdata_MPORT_addr_pipe_0;
  assign dataArray_3_0_outdata_MPORT_data = dataArray_3_0[dataArray_3_0_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_3_0_toMemData_MPORT_en = dataArray_3_0_toMemData_MPORT_en_pipe_0;
  assign dataArray_3_0_toMemData_MPORT_addr = dataArray_3_0_toMemData_MPORT_addr_pipe_0;
  assign dataArray_3_0_toMemData_MPORT_data = dataArray_3_0[dataArray_3_0_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_3_0_MPORT_data = to_sram_r_bits_data;
  assign dataArray_3_0_MPORT_addr = replace_set;
  assign dataArray_3_0_MPORT_mask = _GEN_1091 & _GEN_1133;
  assign dataArray_3_0_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_3_0_MPORT_1_data = indata[31:0];
  assign dataArray_3_0_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_3_0_MPORT_1_mask = _GEN_1091 & _GEN_1396;
  assign dataArray_3_0_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_3_1_cachedata_MPORT_en = dataArray_3_1_cachedata_MPORT_en_pipe_0;
  assign dataArray_3_1_cachedata_MPORT_addr = dataArray_3_1_cachedata_MPORT_addr_pipe_0;
  assign dataArray_3_1_cachedata_MPORT_data = dataArray_3_1[dataArray_3_1_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_3_1_outdata_MPORT_en = dataArray_3_1_outdata_MPORT_en_pipe_0;
  assign dataArray_3_1_outdata_MPORT_addr = dataArray_3_1_outdata_MPORT_addr_pipe_0;
  assign dataArray_3_1_outdata_MPORT_data = dataArray_3_1[dataArray_3_1_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_3_1_toMemData_MPORT_en = dataArray_3_1_toMemData_MPORT_en_pipe_0;
  assign dataArray_3_1_toMemData_MPORT_addr = dataArray_3_1_toMemData_MPORT_addr_pipe_0;
  assign dataArray_3_1_toMemData_MPORT_data = dataArray_3_1[dataArray_3_1_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_3_1_MPORT_data = to_sram_r_bits_data;
  assign dataArray_3_1_MPORT_addr = replace_set;
  assign dataArray_3_1_MPORT_mask = _GEN_1091 & _GEN_1135;
  assign dataArray_3_1_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_3_1_MPORT_1_data = indata[31:0];
  assign dataArray_3_1_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_3_1_MPORT_1_mask = _GEN_1091 & _GEN_1390;
  assign dataArray_3_1_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_3_2_cachedata_MPORT_en = dataArray_3_2_cachedata_MPORT_en_pipe_0;
  assign dataArray_3_2_cachedata_MPORT_addr = dataArray_3_2_cachedata_MPORT_addr_pipe_0;
  assign dataArray_3_2_cachedata_MPORT_data = dataArray_3_2[dataArray_3_2_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_3_2_outdata_MPORT_en = dataArray_3_2_outdata_MPORT_en_pipe_0;
  assign dataArray_3_2_outdata_MPORT_addr = dataArray_3_2_outdata_MPORT_addr_pipe_0;
  assign dataArray_3_2_outdata_MPORT_data = dataArray_3_2[dataArray_3_2_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_3_2_toMemData_MPORT_en = dataArray_3_2_toMemData_MPORT_en_pipe_0;
  assign dataArray_3_2_toMemData_MPORT_addr = dataArray_3_2_toMemData_MPORT_addr_pipe_0;
  assign dataArray_3_2_toMemData_MPORT_data = dataArray_3_2[dataArray_3_2_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_3_2_MPORT_data = to_sram_r_bits_data;
  assign dataArray_3_2_MPORT_addr = replace_set;
  assign dataArray_3_2_MPORT_mask = _GEN_1091 & _GEN_1137;
  assign dataArray_3_2_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_3_2_MPORT_1_data = indata[31:0];
  assign dataArray_3_2_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_3_2_MPORT_1_mask = _GEN_1091 & _GEN_1392;
  assign dataArray_3_2_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_3_3_cachedata_MPORT_en = dataArray_3_3_cachedata_MPORT_en_pipe_0;
  assign dataArray_3_3_cachedata_MPORT_addr = dataArray_3_3_cachedata_MPORT_addr_pipe_0;
  assign dataArray_3_3_cachedata_MPORT_data = dataArray_3_3[dataArray_3_3_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_3_3_outdata_MPORT_en = dataArray_3_3_outdata_MPORT_en_pipe_0;
  assign dataArray_3_3_outdata_MPORT_addr = dataArray_3_3_outdata_MPORT_addr_pipe_0;
  assign dataArray_3_3_outdata_MPORT_data = dataArray_3_3[dataArray_3_3_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_3_3_toMemData_MPORT_en = dataArray_3_3_toMemData_MPORT_en_pipe_0;
  assign dataArray_3_3_toMemData_MPORT_addr = dataArray_3_3_toMemData_MPORT_addr_pipe_0;
  assign dataArray_3_3_toMemData_MPORT_data = dataArray_3_3[dataArray_3_3_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_3_3_MPORT_data = to_sram_r_bits_data;
  assign dataArray_3_3_MPORT_addr = replace_set;
  assign dataArray_3_3_MPORT_mask = _GEN_1091 & _GEN_1139;
  assign dataArray_3_3_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_3_3_MPORT_1_data = indata[31:0];
  assign dataArray_3_3_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_3_3_MPORT_1_mask = _GEN_1091 & _GEN_1394;
  assign dataArray_3_3_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_4_0_cachedata_MPORT_en = dataArray_4_0_cachedata_MPORT_en_pipe_0;
  assign dataArray_4_0_cachedata_MPORT_addr = dataArray_4_0_cachedata_MPORT_addr_pipe_0;
  assign dataArray_4_0_cachedata_MPORT_data = dataArray_4_0[dataArray_4_0_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_4_0_outdata_MPORT_en = dataArray_4_0_outdata_MPORT_en_pipe_0;
  assign dataArray_4_0_outdata_MPORT_addr = dataArray_4_0_outdata_MPORT_addr_pipe_0;
  assign dataArray_4_0_outdata_MPORT_data = dataArray_4_0[dataArray_4_0_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_4_0_toMemData_MPORT_en = dataArray_4_0_toMemData_MPORT_en_pipe_0;
  assign dataArray_4_0_toMemData_MPORT_addr = dataArray_4_0_toMemData_MPORT_addr_pipe_0;
  assign dataArray_4_0_toMemData_MPORT_data = dataArray_4_0[dataArray_4_0_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_4_0_MPORT_data = to_sram_r_bits_data;
  assign dataArray_4_0_MPORT_addr = replace_set;
  assign dataArray_4_0_MPORT_mask = _GEN_1093 & _GEN_1133;
  assign dataArray_4_0_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_4_0_MPORT_1_data = indata[31:0];
  assign dataArray_4_0_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_4_0_MPORT_1_mask = _GEN_1093 & _GEN_1396;
  assign dataArray_4_0_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_4_1_cachedata_MPORT_en = dataArray_4_1_cachedata_MPORT_en_pipe_0;
  assign dataArray_4_1_cachedata_MPORT_addr = dataArray_4_1_cachedata_MPORT_addr_pipe_0;
  assign dataArray_4_1_cachedata_MPORT_data = dataArray_4_1[dataArray_4_1_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_4_1_outdata_MPORT_en = dataArray_4_1_outdata_MPORT_en_pipe_0;
  assign dataArray_4_1_outdata_MPORT_addr = dataArray_4_1_outdata_MPORT_addr_pipe_0;
  assign dataArray_4_1_outdata_MPORT_data = dataArray_4_1[dataArray_4_1_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_4_1_toMemData_MPORT_en = dataArray_4_1_toMemData_MPORT_en_pipe_0;
  assign dataArray_4_1_toMemData_MPORT_addr = dataArray_4_1_toMemData_MPORT_addr_pipe_0;
  assign dataArray_4_1_toMemData_MPORT_data = dataArray_4_1[dataArray_4_1_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_4_1_MPORT_data = to_sram_r_bits_data;
  assign dataArray_4_1_MPORT_addr = replace_set;
  assign dataArray_4_1_MPORT_mask = _GEN_1093 & _GEN_1135;
  assign dataArray_4_1_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_4_1_MPORT_1_data = indata[31:0];
  assign dataArray_4_1_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_4_1_MPORT_1_mask = _GEN_1093 & _GEN_1390;
  assign dataArray_4_1_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_4_2_cachedata_MPORT_en = dataArray_4_2_cachedata_MPORT_en_pipe_0;
  assign dataArray_4_2_cachedata_MPORT_addr = dataArray_4_2_cachedata_MPORT_addr_pipe_0;
  assign dataArray_4_2_cachedata_MPORT_data = dataArray_4_2[dataArray_4_2_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_4_2_outdata_MPORT_en = dataArray_4_2_outdata_MPORT_en_pipe_0;
  assign dataArray_4_2_outdata_MPORT_addr = dataArray_4_2_outdata_MPORT_addr_pipe_0;
  assign dataArray_4_2_outdata_MPORT_data = dataArray_4_2[dataArray_4_2_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_4_2_toMemData_MPORT_en = dataArray_4_2_toMemData_MPORT_en_pipe_0;
  assign dataArray_4_2_toMemData_MPORT_addr = dataArray_4_2_toMemData_MPORT_addr_pipe_0;
  assign dataArray_4_2_toMemData_MPORT_data = dataArray_4_2[dataArray_4_2_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_4_2_MPORT_data = to_sram_r_bits_data;
  assign dataArray_4_2_MPORT_addr = replace_set;
  assign dataArray_4_2_MPORT_mask = _GEN_1093 & _GEN_1137;
  assign dataArray_4_2_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_4_2_MPORT_1_data = indata[31:0];
  assign dataArray_4_2_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_4_2_MPORT_1_mask = _GEN_1093 & _GEN_1392;
  assign dataArray_4_2_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_4_3_cachedata_MPORT_en = dataArray_4_3_cachedata_MPORT_en_pipe_0;
  assign dataArray_4_3_cachedata_MPORT_addr = dataArray_4_3_cachedata_MPORT_addr_pipe_0;
  assign dataArray_4_3_cachedata_MPORT_data = dataArray_4_3[dataArray_4_3_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_4_3_outdata_MPORT_en = dataArray_4_3_outdata_MPORT_en_pipe_0;
  assign dataArray_4_3_outdata_MPORT_addr = dataArray_4_3_outdata_MPORT_addr_pipe_0;
  assign dataArray_4_3_outdata_MPORT_data = dataArray_4_3[dataArray_4_3_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_4_3_toMemData_MPORT_en = dataArray_4_3_toMemData_MPORT_en_pipe_0;
  assign dataArray_4_3_toMemData_MPORT_addr = dataArray_4_3_toMemData_MPORT_addr_pipe_0;
  assign dataArray_4_3_toMemData_MPORT_data = dataArray_4_3[dataArray_4_3_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_4_3_MPORT_data = to_sram_r_bits_data;
  assign dataArray_4_3_MPORT_addr = replace_set;
  assign dataArray_4_3_MPORT_mask = _GEN_1093 & _GEN_1139;
  assign dataArray_4_3_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_4_3_MPORT_1_data = indata[31:0];
  assign dataArray_4_3_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_4_3_MPORT_1_mask = _GEN_1093 & _GEN_1394;
  assign dataArray_4_3_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_5_0_cachedata_MPORT_en = dataArray_5_0_cachedata_MPORT_en_pipe_0;
  assign dataArray_5_0_cachedata_MPORT_addr = dataArray_5_0_cachedata_MPORT_addr_pipe_0;
  assign dataArray_5_0_cachedata_MPORT_data = dataArray_5_0[dataArray_5_0_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_5_0_outdata_MPORT_en = dataArray_5_0_outdata_MPORT_en_pipe_0;
  assign dataArray_5_0_outdata_MPORT_addr = dataArray_5_0_outdata_MPORT_addr_pipe_0;
  assign dataArray_5_0_outdata_MPORT_data = dataArray_5_0[dataArray_5_0_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_5_0_toMemData_MPORT_en = dataArray_5_0_toMemData_MPORT_en_pipe_0;
  assign dataArray_5_0_toMemData_MPORT_addr = dataArray_5_0_toMemData_MPORT_addr_pipe_0;
  assign dataArray_5_0_toMemData_MPORT_data = dataArray_5_0[dataArray_5_0_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_5_0_MPORT_data = to_sram_r_bits_data;
  assign dataArray_5_0_MPORT_addr = replace_set;
  assign dataArray_5_0_MPORT_mask = _GEN_1095 & _GEN_1133;
  assign dataArray_5_0_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_5_0_MPORT_1_data = indata[31:0];
  assign dataArray_5_0_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_5_0_MPORT_1_mask = _GEN_1095 & _GEN_1396;
  assign dataArray_5_0_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_5_1_cachedata_MPORT_en = dataArray_5_1_cachedata_MPORT_en_pipe_0;
  assign dataArray_5_1_cachedata_MPORT_addr = dataArray_5_1_cachedata_MPORT_addr_pipe_0;
  assign dataArray_5_1_cachedata_MPORT_data = dataArray_5_1[dataArray_5_1_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_5_1_outdata_MPORT_en = dataArray_5_1_outdata_MPORT_en_pipe_0;
  assign dataArray_5_1_outdata_MPORT_addr = dataArray_5_1_outdata_MPORT_addr_pipe_0;
  assign dataArray_5_1_outdata_MPORT_data = dataArray_5_1[dataArray_5_1_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_5_1_toMemData_MPORT_en = dataArray_5_1_toMemData_MPORT_en_pipe_0;
  assign dataArray_5_1_toMemData_MPORT_addr = dataArray_5_1_toMemData_MPORT_addr_pipe_0;
  assign dataArray_5_1_toMemData_MPORT_data = dataArray_5_1[dataArray_5_1_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_5_1_MPORT_data = to_sram_r_bits_data;
  assign dataArray_5_1_MPORT_addr = replace_set;
  assign dataArray_5_1_MPORT_mask = _GEN_1095 & _GEN_1135;
  assign dataArray_5_1_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_5_1_MPORT_1_data = indata[31:0];
  assign dataArray_5_1_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_5_1_MPORT_1_mask = _GEN_1095 & _GEN_1390;
  assign dataArray_5_1_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_5_2_cachedata_MPORT_en = dataArray_5_2_cachedata_MPORT_en_pipe_0;
  assign dataArray_5_2_cachedata_MPORT_addr = dataArray_5_2_cachedata_MPORT_addr_pipe_0;
  assign dataArray_5_2_cachedata_MPORT_data = dataArray_5_2[dataArray_5_2_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_5_2_outdata_MPORT_en = dataArray_5_2_outdata_MPORT_en_pipe_0;
  assign dataArray_5_2_outdata_MPORT_addr = dataArray_5_2_outdata_MPORT_addr_pipe_0;
  assign dataArray_5_2_outdata_MPORT_data = dataArray_5_2[dataArray_5_2_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_5_2_toMemData_MPORT_en = dataArray_5_2_toMemData_MPORT_en_pipe_0;
  assign dataArray_5_2_toMemData_MPORT_addr = dataArray_5_2_toMemData_MPORT_addr_pipe_0;
  assign dataArray_5_2_toMemData_MPORT_data = dataArray_5_2[dataArray_5_2_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_5_2_MPORT_data = to_sram_r_bits_data;
  assign dataArray_5_2_MPORT_addr = replace_set;
  assign dataArray_5_2_MPORT_mask = _GEN_1095 & _GEN_1137;
  assign dataArray_5_2_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_5_2_MPORT_1_data = indata[31:0];
  assign dataArray_5_2_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_5_2_MPORT_1_mask = _GEN_1095 & _GEN_1392;
  assign dataArray_5_2_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_5_3_cachedata_MPORT_en = dataArray_5_3_cachedata_MPORT_en_pipe_0;
  assign dataArray_5_3_cachedata_MPORT_addr = dataArray_5_3_cachedata_MPORT_addr_pipe_0;
  assign dataArray_5_3_cachedata_MPORT_data = dataArray_5_3[dataArray_5_3_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_5_3_outdata_MPORT_en = dataArray_5_3_outdata_MPORT_en_pipe_0;
  assign dataArray_5_3_outdata_MPORT_addr = dataArray_5_3_outdata_MPORT_addr_pipe_0;
  assign dataArray_5_3_outdata_MPORT_data = dataArray_5_3[dataArray_5_3_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_5_3_toMemData_MPORT_en = dataArray_5_3_toMemData_MPORT_en_pipe_0;
  assign dataArray_5_3_toMemData_MPORT_addr = dataArray_5_3_toMemData_MPORT_addr_pipe_0;
  assign dataArray_5_3_toMemData_MPORT_data = dataArray_5_3[dataArray_5_3_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_5_3_MPORT_data = to_sram_r_bits_data;
  assign dataArray_5_3_MPORT_addr = replace_set;
  assign dataArray_5_3_MPORT_mask = _GEN_1095 & _GEN_1139;
  assign dataArray_5_3_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_5_3_MPORT_1_data = indata[31:0];
  assign dataArray_5_3_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_5_3_MPORT_1_mask = _GEN_1095 & _GEN_1394;
  assign dataArray_5_3_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_6_0_cachedata_MPORT_en = dataArray_6_0_cachedata_MPORT_en_pipe_0;
  assign dataArray_6_0_cachedata_MPORT_addr = dataArray_6_0_cachedata_MPORT_addr_pipe_0;
  assign dataArray_6_0_cachedata_MPORT_data = dataArray_6_0[dataArray_6_0_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_6_0_outdata_MPORT_en = dataArray_6_0_outdata_MPORT_en_pipe_0;
  assign dataArray_6_0_outdata_MPORT_addr = dataArray_6_0_outdata_MPORT_addr_pipe_0;
  assign dataArray_6_0_outdata_MPORT_data = dataArray_6_0[dataArray_6_0_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_6_0_toMemData_MPORT_en = dataArray_6_0_toMemData_MPORT_en_pipe_0;
  assign dataArray_6_0_toMemData_MPORT_addr = dataArray_6_0_toMemData_MPORT_addr_pipe_0;
  assign dataArray_6_0_toMemData_MPORT_data = dataArray_6_0[dataArray_6_0_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_6_0_MPORT_data = to_sram_r_bits_data;
  assign dataArray_6_0_MPORT_addr = replace_set;
  assign dataArray_6_0_MPORT_mask = _GEN_1097 & _GEN_1133;
  assign dataArray_6_0_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_6_0_MPORT_1_data = indata[31:0];
  assign dataArray_6_0_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_6_0_MPORT_1_mask = _GEN_1097 & _GEN_1396;
  assign dataArray_6_0_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_6_1_cachedata_MPORT_en = dataArray_6_1_cachedata_MPORT_en_pipe_0;
  assign dataArray_6_1_cachedata_MPORT_addr = dataArray_6_1_cachedata_MPORT_addr_pipe_0;
  assign dataArray_6_1_cachedata_MPORT_data = dataArray_6_1[dataArray_6_1_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_6_1_outdata_MPORT_en = dataArray_6_1_outdata_MPORT_en_pipe_0;
  assign dataArray_6_1_outdata_MPORT_addr = dataArray_6_1_outdata_MPORT_addr_pipe_0;
  assign dataArray_6_1_outdata_MPORT_data = dataArray_6_1[dataArray_6_1_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_6_1_toMemData_MPORT_en = dataArray_6_1_toMemData_MPORT_en_pipe_0;
  assign dataArray_6_1_toMemData_MPORT_addr = dataArray_6_1_toMemData_MPORT_addr_pipe_0;
  assign dataArray_6_1_toMemData_MPORT_data = dataArray_6_1[dataArray_6_1_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_6_1_MPORT_data = to_sram_r_bits_data;
  assign dataArray_6_1_MPORT_addr = replace_set;
  assign dataArray_6_1_MPORT_mask = _GEN_1097 & _GEN_1135;
  assign dataArray_6_1_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_6_1_MPORT_1_data = indata[31:0];
  assign dataArray_6_1_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_6_1_MPORT_1_mask = _GEN_1097 & _GEN_1390;
  assign dataArray_6_1_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_6_2_cachedata_MPORT_en = dataArray_6_2_cachedata_MPORT_en_pipe_0;
  assign dataArray_6_2_cachedata_MPORT_addr = dataArray_6_2_cachedata_MPORT_addr_pipe_0;
  assign dataArray_6_2_cachedata_MPORT_data = dataArray_6_2[dataArray_6_2_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_6_2_outdata_MPORT_en = dataArray_6_2_outdata_MPORT_en_pipe_0;
  assign dataArray_6_2_outdata_MPORT_addr = dataArray_6_2_outdata_MPORT_addr_pipe_0;
  assign dataArray_6_2_outdata_MPORT_data = dataArray_6_2[dataArray_6_2_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_6_2_toMemData_MPORT_en = dataArray_6_2_toMemData_MPORT_en_pipe_0;
  assign dataArray_6_2_toMemData_MPORT_addr = dataArray_6_2_toMemData_MPORT_addr_pipe_0;
  assign dataArray_6_2_toMemData_MPORT_data = dataArray_6_2[dataArray_6_2_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_6_2_MPORT_data = to_sram_r_bits_data;
  assign dataArray_6_2_MPORT_addr = replace_set;
  assign dataArray_6_2_MPORT_mask = _GEN_1097 & _GEN_1137;
  assign dataArray_6_2_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_6_2_MPORT_1_data = indata[31:0];
  assign dataArray_6_2_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_6_2_MPORT_1_mask = _GEN_1097 & _GEN_1392;
  assign dataArray_6_2_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_6_3_cachedata_MPORT_en = dataArray_6_3_cachedata_MPORT_en_pipe_0;
  assign dataArray_6_3_cachedata_MPORT_addr = dataArray_6_3_cachedata_MPORT_addr_pipe_0;
  assign dataArray_6_3_cachedata_MPORT_data = dataArray_6_3[dataArray_6_3_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_6_3_outdata_MPORT_en = dataArray_6_3_outdata_MPORT_en_pipe_0;
  assign dataArray_6_3_outdata_MPORT_addr = dataArray_6_3_outdata_MPORT_addr_pipe_0;
  assign dataArray_6_3_outdata_MPORT_data = dataArray_6_3[dataArray_6_3_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_6_3_toMemData_MPORT_en = dataArray_6_3_toMemData_MPORT_en_pipe_0;
  assign dataArray_6_3_toMemData_MPORT_addr = dataArray_6_3_toMemData_MPORT_addr_pipe_0;
  assign dataArray_6_3_toMemData_MPORT_data = dataArray_6_3[dataArray_6_3_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_6_3_MPORT_data = to_sram_r_bits_data;
  assign dataArray_6_3_MPORT_addr = replace_set;
  assign dataArray_6_3_MPORT_mask = _GEN_1097 & _GEN_1139;
  assign dataArray_6_3_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_6_3_MPORT_1_data = indata[31:0];
  assign dataArray_6_3_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_6_3_MPORT_1_mask = _GEN_1097 & _GEN_1394;
  assign dataArray_6_3_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_7_0_cachedata_MPORT_en = dataArray_7_0_cachedata_MPORT_en_pipe_0;
  assign dataArray_7_0_cachedata_MPORT_addr = dataArray_7_0_cachedata_MPORT_addr_pipe_0;
  assign dataArray_7_0_cachedata_MPORT_data = dataArray_7_0[dataArray_7_0_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_7_0_outdata_MPORT_en = dataArray_7_0_outdata_MPORT_en_pipe_0;
  assign dataArray_7_0_outdata_MPORT_addr = dataArray_7_0_outdata_MPORT_addr_pipe_0;
  assign dataArray_7_0_outdata_MPORT_data = dataArray_7_0[dataArray_7_0_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_7_0_toMemData_MPORT_en = dataArray_7_0_toMemData_MPORT_en_pipe_0;
  assign dataArray_7_0_toMemData_MPORT_addr = dataArray_7_0_toMemData_MPORT_addr_pipe_0;
  assign dataArray_7_0_toMemData_MPORT_data = dataArray_7_0[dataArray_7_0_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_7_0_MPORT_data = to_sram_r_bits_data;
  assign dataArray_7_0_MPORT_addr = replace_set;
  assign dataArray_7_0_MPORT_mask = _GEN_1099 & _GEN_1133;
  assign dataArray_7_0_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_7_0_MPORT_1_data = indata[31:0];
  assign dataArray_7_0_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_7_0_MPORT_1_mask = _GEN_1099 & _GEN_1396;
  assign dataArray_7_0_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_7_1_cachedata_MPORT_en = dataArray_7_1_cachedata_MPORT_en_pipe_0;
  assign dataArray_7_1_cachedata_MPORT_addr = dataArray_7_1_cachedata_MPORT_addr_pipe_0;
  assign dataArray_7_1_cachedata_MPORT_data = dataArray_7_1[dataArray_7_1_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_7_1_outdata_MPORT_en = dataArray_7_1_outdata_MPORT_en_pipe_0;
  assign dataArray_7_1_outdata_MPORT_addr = dataArray_7_1_outdata_MPORT_addr_pipe_0;
  assign dataArray_7_1_outdata_MPORT_data = dataArray_7_1[dataArray_7_1_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_7_1_toMemData_MPORT_en = dataArray_7_1_toMemData_MPORT_en_pipe_0;
  assign dataArray_7_1_toMemData_MPORT_addr = dataArray_7_1_toMemData_MPORT_addr_pipe_0;
  assign dataArray_7_1_toMemData_MPORT_data = dataArray_7_1[dataArray_7_1_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_7_1_MPORT_data = to_sram_r_bits_data;
  assign dataArray_7_1_MPORT_addr = replace_set;
  assign dataArray_7_1_MPORT_mask = _GEN_1099 & _GEN_1135;
  assign dataArray_7_1_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_7_1_MPORT_1_data = indata[31:0];
  assign dataArray_7_1_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_7_1_MPORT_1_mask = _GEN_1099 & _GEN_1390;
  assign dataArray_7_1_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_7_2_cachedata_MPORT_en = dataArray_7_2_cachedata_MPORT_en_pipe_0;
  assign dataArray_7_2_cachedata_MPORT_addr = dataArray_7_2_cachedata_MPORT_addr_pipe_0;
  assign dataArray_7_2_cachedata_MPORT_data = dataArray_7_2[dataArray_7_2_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_7_2_outdata_MPORT_en = dataArray_7_2_outdata_MPORT_en_pipe_0;
  assign dataArray_7_2_outdata_MPORT_addr = dataArray_7_2_outdata_MPORT_addr_pipe_0;
  assign dataArray_7_2_outdata_MPORT_data = dataArray_7_2[dataArray_7_2_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_7_2_toMemData_MPORT_en = dataArray_7_2_toMemData_MPORT_en_pipe_0;
  assign dataArray_7_2_toMemData_MPORT_addr = dataArray_7_2_toMemData_MPORT_addr_pipe_0;
  assign dataArray_7_2_toMemData_MPORT_data = dataArray_7_2[dataArray_7_2_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_7_2_MPORT_data = to_sram_r_bits_data;
  assign dataArray_7_2_MPORT_addr = replace_set;
  assign dataArray_7_2_MPORT_mask = _GEN_1099 & _GEN_1137;
  assign dataArray_7_2_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_7_2_MPORT_1_data = indata[31:0];
  assign dataArray_7_2_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_7_2_MPORT_1_mask = _GEN_1099 & _GEN_1392;
  assign dataArray_7_2_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_7_3_cachedata_MPORT_en = dataArray_7_3_cachedata_MPORT_en_pipe_0;
  assign dataArray_7_3_cachedata_MPORT_addr = dataArray_7_3_cachedata_MPORT_addr_pipe_0;
  assign dataArray_7_3_cachedata_MPORT_data = dataArray_7_3[dataArray_7_3_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_7_3_outdata_MPORT_en = dataArray_7_3_outdata_MPORT_en_pipe_0;
  assign dataArray_7_3_outdata_MPORT_addr = dataArray_7_3_outdata_MPORT_addr_pipe_0;
  assign dataArray_7_3_outdata_MPORT_data = dataArray_7_3[dataArray_7_3_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_7_3_toMemData_MPORT_en = dataArray_7_3_toMemData_MPORT_en_pipe_0;
  assign dataArray_7_3_toMemData_MPORT_addr = dataArray_7_3_toMemData_MPORT_addr_pipe_0;
  assign dataArray_7_3_toMemData_MPORT_data = dataArray_7_3[dataArray_7_3_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_7_3_MPORT_data = to_sram_r_bits_data;
  assign dataArray_7_3_MPORT_addr = replace_set;
  assign dataArray_7_3_MPORT_mask = _GEN_1099 & _GEN_1139;
  assign dataArray_7_3_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_7_3_MPORT_1_data = indata[31:0];
  assign dataArray_7_3_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_7_3_MPORT_1_mask = _GEN_1099 & _GEN_1394;
  assign dataArray_7_3_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_8_0_cachedata_MPORT_en = dataArray_8_0_cachedata_MPORT_en_pipe_0;
  assign dataArray_8_0_cachedata_MPORT_addr = dataArray_8_0_cachedata_MPORT_addr_pipe_0;
  assign dataArray_8_0_cachedata_MPORT_data = dataArray_8_0[dataArray_8_0_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_8_0_outdata_MPORT_en = dataArray_8_0_outdata_MPORT_en_pipe_0;
  assign dataArray_8_0_outdata_MPORT_addr = dataArray_8_0_outdata_MPORT_addr_pipe_0;
  assign dataArray_8_0_outdata_MPORT_data = dataArray_8_0[dataArray_8_0_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_8_0_toMemData_MPORT_en = dataArray_8_0_toMemData_MPORT_en_pipe_0;
  assign dataArray_8_0_toMemData_MPORT_addr = dataArray_8_0_toMemData_MPORT_addr_pipe_0;
  assign dataArray_8_0_toMemData_MPORT_data = dataArray_8_0[dataArray_8_0_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_8_0_MPORT_data = to_sram_r_bits_data;
  assign dataArray_8_0_MPORT_addr = replace_set;
  assign dataArray_8_0_MPORT_mask = _GEN_1101 & _GEN_1133;
  assign dataArray_8_0_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_8_0_MPORT_1_data = indata[31:0];
  assign dataArray_8_0_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_8_0_MPORT_1_mask = _GEN_1101 & _GEN_1396;
  assign dataArray_8_0_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_8_1_cachedata_MPORT_en = dataArray_8_1_cachedata_MPORT_en_pipe_0;
  assign dataArray_8_1_cachedata_MPORT_addr = dataArray_8_1_cachedata_MPORT_addr_pipe_0;
  assign dataArray_8_1_cachedata_MPORT_data = dataArray_8_1[dataArray_8_1_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_8_1_outdata_MPORT_en = dataArray_8_1_outdata_MPORT_en_pipe_0;
  assign dataArray_8_1_outdata_MPORT_addr = dataArray_8_1_outdata_MPORT_addr_pipe_0;
  assign dataArray_8_1_outdata_MPORT_data = dataArray_8_1[dataArray_8_1_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_8_1_toMemData_MPORT_en = dataArray_8_1_toMemData_MPORT_en_pipe_0;
  assign dataArray_8_1_toMemData_MPORT_addr = dataArray_8_1_toMemData_MPORT_addr_pipe_0;
  assign dataArray_8_1_toMemData_MPORT_data = dataArray_8_1[dataArray_8_1_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_8_1_MPORT_data = to_sram_r_bits_data;
  assign dataArray_8_1_MPORT_addr = replace_set;
  assign dataArray_8_1_MPORT_mask = _GEN_1101 & _GEN_1135;
  assign dataArray_8_1_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_8_1_MPORT_1_data = indata[31:0];
  assign dataArray_8_1_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_8_1_MPORT_1_mask = _GEN_1101 & _GEN_1390;
  assign dataArray_8_1_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_8_2_cachedata_MPORT_en = dataArray_8_2_cachedata_MPORT_en_pipe_0;
  assign dataArray_8_2_cachedata_MPORT_addr = dataArray_8_2_cachedata_MPORT_addr_pipe_0;
  assign dataArray_8_2_cachedata_MPORT_data = dataArray_8_2[dataArray_8_2_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_8_2_outdata_MPORT_en = dataArray_8_2_outdata_MPORT_en_pipe_0;
  assign dataArray_8_2_outdata_MPORT_addr = dataArray_8_2_outdata_MPORT_addr_pipe_0;
  assign dataArray_8_2_outdata_MPORT_data = dataArray_8_2[dataArray_8_2_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_8_2_toMemData_MPORT_en = dataArray_8_2_toMemData_MPORT_en_pipe_0;
  assign dataArray_8_2_toMemData_MPORT_addr = dataArray_8_2_toMemData_MPORT_addr_pipe_0;
  assign dataArray_8_2_toMemData_MPORT_data = dataArray_8_2[dataArray_8_2_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_8_2_MPORT_data = to_sram_r_bits_data;
  assign dataArray_8_2_MPORT_addr = replace_set;
  assign dataArray_8_2_MPORT_mask = _GEN_1101 & _GEN_1137;
  assign dataArray_8_2_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_8_2_MPORT_1_data = indata[31:0];
  assign dataArray_8_2_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_8_2_MPORT_1_mask = _GEN_1101 & _GEN_1392;
  assign dataArray_8_2_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_8_3_cachedata_MPORT_en = dataArray_8_3_cachedata_MPORT_en_pipe_0;
  assign dataArray_8_3_cachedata_MPORT_addr = dataArray_8_3_cachedata_MPORT_addr_pipe_0;
  assign dataArray_8_3_cachedata_MPORT_data = dataArray_8_3[dataArray_8_3_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_8_3_outdata_MPORT_en = dataArray_8_3_outdata_MPORT_en_pipe_0;
  assign dataArray_8_3_outdata_MPORT_addr = dataArray_8_3_outdata_MPORT_addr_pipe_0;
  assign dataArray_8_3_outdata_MPORT_data = dataArray_8_3[dataArray_8_3_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_8_3_toMemData_MPORT_en = dataArray_8_3_toMemData_MPORT_en_pipe_0;
  assign dataArray_8_3_toMemData_MPORT_addr = dataArray_8_3_toMemData_MPORT_addr_pipe_0;
  assign dataArray_8_3_toMemData_MPORT_data = dataArray_8_3[dataArray_8_3_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_8_3_MPORT_data = to_sram_r_bits_data;
  assign dataArray_8_3_MPORT_addr = replace_set;
  assign dataArray_8_3_MPORT_mask = _GEN_1101 & _GEN_1139;
  assign dataArray_8_3_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_8_3_MPORT_1_data = indata[31:0];
  assign dataArray_8_3_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_8_3_MPORT_1_mask = _GEN_1101 & _GEN_1394;
  assign dataArray_8_3_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_9_0_cachedata_MPORT_en = dataArray_9_0_cachedata_MPORT_en_pipe_0;
  assign dataArray_9_0_cachedata_MPORT_addr = dataArray_9_0_cachedata_MPORT_addr_pipe_0;
  assign dataArray_9_0_cachedata_MPORT_data = dataArray_9_0[dataArray_9_0_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_9_0_outdata_MPORT_en = dataArray_9_0_outdata_MPORT_en_pipe_0;
  assign dataArray_9_0_outdata_MPORT_addr = dataArray_9_0_outdata_MPORT_addr_pipe_0;
  assign dataArray_9_0_outdata_MPORT_data = dataArray_9_0[dataArray_9_0_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_9_0_toMemData_MPORT_en = dataArray_9_0_toMemData_MPORT_en_pipe_0;
  assign dataArray_9_0_toMemData_MPORT_addr = dataArray_9_0_toMemData_MPORT_addr_pipe_0;
  assign dataArray_9_0_toMemData_MPORT_data = dataArray_9_0[dataArray_9_0_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_9_0_MPORT_data = to_sram_r_bits_data;
  assign dataArray_9_0_MPORT_addr = replace_set;
  assign dataArray_9_0_MPORT_mask = _GEN_1103 & _GEN_1133;
  assign dataArray_9_0_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_9_0_MPORT_1_data = indata[31:0];
  assign dataArray_9_0_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_9_0_MPORT_1_mask = _GEN_1103 & _GEN_1396;
  assign dataArray_9_0_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_9_1_cachedata_MPORT_en = dataArray_9_1_cachedata_MPORT_en_pipe_0;
  assign dataArray_9_1_cachedata_MPORT_addr = dataArray_9_1_cachedata_MPORT_addr_pipe_0;
  assign dataArray_9_1_cachedata_MPORT_data = dataArray_9_1[dataArray_9_1_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_9_1_outdata_MPORT_en = dataArray_9_1_outdata_MPORT_en_pipe_0;
  assign dataArray_9_1_outdata_MPORT_addr = dataArray_9_1_outdata_MPORT_addr_pipe_0;
  assign dataArray_9_1_outdata_MPORT_data = dataArray_9_1[dataArray_9_1_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_9_1_toMemData_MPORT_en = dataArray_9_1_toMemData_MPORT_en_pipe_0;
  assign dataArray_9_1_toMemData_MPORT_addr = dataArray_9_1_toMemData_MPORT_addr_pipe_0;
  assign dataArray_9_1_toMemData_MPORT_data = dataArray_9_1[dataArray_9_1_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_9_1_MPORT_data = to_sram_r_bits_data;
  assign dataArray_9_1_MPORT_addr = replace_set;
  assign dataArray_9_1_MPORT_mask = _GEN_1103 & _GEN_1135;
  assign dataArray_9_1_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_9_1_MPORT_1_data = indata[31:0];
  assign dataArray_9_1_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_9_1_MPORT_1_mask = _GEN_1103 & _GEN_1390;
  assign dataArray_9_1_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_9_2_cachedata_MPORT_en = dataArray_9_2_cachedata_MPORT_en_pipe_0;
  assign dataArray_9_2_cachedata_MPORT_addr = dataArray_9_2_cachedata_MPORT_addr_pipe_0;
  assign dataArray_9_2_cachedata_MPORT_data = dataArray_9_2[dataArray_9_2_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_9_2_outdata_MPORT_en = dataArray_9_2_outdata_MPORT_en_pipe_0;
  assign dataArray_9_2_outdata_MPORT_addr = dataArray_9_2_outdata_MPORT_addr_pipe_0;
  assign dataArray_9_2_outdata_MPORT_data = dataArray_9_2[dataArray_9_2_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_9_2_toMemData_MPORT_en = dataArray_9_2_toMemData_MPORT_en_pipe_0;
  assign dataArray_9_2_toMemData_MPORT_addr = dataArray_9_2_toMemData_MPORT_addr_pipe_0;
  assign dataArray_9_2_toMemData_MPORT_data = dataArray_9_2[dataArray_9_2_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_9_2_MPORT_data = to_sram_r_bits_data;
  assign dataArray_9_2_MPORT_addr = replace_set;
  assign dataArray_9_2_MPORT_mask = _GEN_1103 & _GEN_1137;
  assign dataArray_9_2_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_9_2_MPORT_1_data = indata[31:0];
  assign dataArray_9_2_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_9_2_MPORT_1_mask = _GEN_1103 & _GEN_1392;
  assign dataArray_9_2_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_9_3_cachedata_MPORT_en = dataArray_9_3_cachedata_MPORT_en_pipe_0;
  assign dataArray_9_3_cachedata_MPORT_addr = dataArray_9_3_cachedata_MPORT_addr_pipe_0;
  assign dataArray_9_3_cachedata_MPORT_data = dataArray_9_3[dataArray_9_3_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_9_3_outdata_MPORT_en = dataArray_9_3_outdata_MPORT_en_pipe_0;
  assign dataArray_9_3_outdata_MPORT_addr = dataArray_9_3_outdata_MPORT_addr_pipe_0;
  assign dataArray_9_3_outdata_MPORT_data = dataArray_9_3[dataArray_9_3_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_9_3_toMemData_MPORT_en = dataArray_9_3_toMemData_MPORT_en_pipe_0;
  assign dataArray_9_3_toMemData_MPORT_addr = dataArray_9_3_toMemData_MPORT_addr_pipe_0;
  assign dataArray_9_3_toMemData_MPORT_data = dataArray_9_3[dataArray_9_3_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_9_3_MPORT_data = to_sram_r_bits_data;
  assign dataArray_9_3_MPORT_addr = replace_set;
  assign dataArray_9_3_MPORT_mask = _GEN_1103 & _GEN_1139;
  assign dataArray_9_3_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_9_3_MPORT_1_data = indata[31:0];
  assign dataArray_9_3_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_9_3_MPORT_1_mask = _GEN_1103 & _GEN_1394;
  assign dataArray_9_3_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_10_0_cachedata_MPORT_en = dataArray_10_0_cachedata_MPORT_en_pipe_0;
  assign dataArray_10_0_cachedata_MPORT_addr = dataArray_10_0_cachedata_MPORT_addr_pipe_0;
  assign dataArray_10_0_cachedata_MPORT_data = dataArray_10_0[dataArray_10_0_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_10_0_outdata_MPORT_en = dataArray_10_0_outdata_MPORT_en_pipe_0;
  assign dataArray_10_0_outdata_MPORT_addr = dataArray_10_0_outdata_MPORT_addr_pipe_0;
  assign dataArray_10_0_outdata_MPORT_data = dataArray_10_0[dataArray_10_0_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_10_0_toMemData_MPORT_en = dataArray_10_0_toMemData_MPORT_en_pipe_0;
  assign dataArray_10_0_toMemData_MPORT_addr = dataArray_10_0_toMemData_MPORT_addr_pipe_0;
  assign dataArray_10_0_toMemData_MPORT_data = dataArray_10_0[dataArray_10_0_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_10_0_MPORT_data = to_sram_r_bits_data;
  assign dataArray_10_0_MPORT_addr = replace_set;
  assign dataArray_10_0_MPORT_mask = _GEN_1105 & _GEN_1133;
  assign dataArray_10_0_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_10_0_MPORT_1_data = indata[31:0];
  assign dataArray_10_0_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_10_0_MPORT_1_mask = _GEN_1105 & _GEN_1396;
  assign dataArray_10_0_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_10_1_cachedata_MPORT_en = dataArray_10_1_cachedata_MPORT_en_pipe_0;
  assign dataArray_10_1_cachedata_MPORT_addr = dataArray_10_1_cachedata_MPORT_addr_pipe_0;
  assign dataArray_10_1_cachedata_MPORT_data = dataArray_10_1[dataArray_10_1_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_10_1_outdata_MPORT_en = dataArray_10_1_outdata_MPORT_en_pipe_0;
  assign dataArray_10_1_outdata_MPORT_addr = dataArray_10_1_outdata_MPORT_addr_pipe_0;
  assign dataArray_10_1_outdata_MPORT_data = dataArray_10_1[dataArray_10_1_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_10_1_toMemData_MPORT_en = dataArray_10_1_toMemData_MPORT_en_pipe_0;
  assign dataArray_10_1_toMemData_MPORT_addr = dataArray_10_1_toMemData_MPORT_addr_pipe_0;
  assign dataArray_10_1_toMemData_MPORT_data = dataArray_10_1[dataArray_10_1_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_10_1_MPORT_data = to_sram_r_bits_data;
  assign dataArray_10_1_MPORT_addr = replace_set;
  assign dataArray_10_1_MPORT_mask = _GEN_1105 & _GEN_1135;
  assign dataArray_10_1_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_10_1_MPORT_1_data = indata[31:0];
  assign dataArray_10_1_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_10_1_MPORT_1_mask = _GEN_1105 & _GEN_1390;
  assign dataArray_10_1_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_10_2_cachedata_MPORT_en = dataArray_10_2_cachedata_MPORT_en_pipe_0;
  assign dataArray_10_2_cachedata_MPORT_addr = dataArray_10_2_cachedata_MPORT_addr_pipe_0;
  assign dataArray_10_2_cachedata_MPORT_data = dataArray_10_2[dataArray_10_2_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_10_2_outdata_MPORT_en = dataArray_10_2_outdata_MPORT_en_pipe_0;
  assign dataArray_10_2_outdata_MPORT_addr = dataArray_10_2_outdata_MPORT_addr_pipe_0;
  assign dataArray_10_2_outdata_MPORT_data = dataArray_10_2[dataArray_10_2_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_10_2_toMemData_MPORT_en = dataArray_10_2_toMemData_MPORT_en_pipe_0;
  assign dataArray_10_2_toMemData_MPORT_addr = dataArray_10_2_toMemData_MPORT_addr_pipe_0;
  assign dataArray_10_2_toMemData_MPORT_data = dataArray_10_2[dataArray_10_2_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_10_2_MPORT_data = to_sram_r_bits_data;
  assign dataArray_10_2_MPORT_addr = replace_set;
  assign dataArray_10_2_MPORT_mask = _GEN_1105 & _GEN_1137;
  assign dataArray_10_2_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_10_2_MPORT_1_data = indata[31:0];
  assign dataArray_10_2_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_10_2_MPORT_1_mask = _GEN_1105 & _GEN_1392;
  assign dataArray_10_2_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_10_3_cachedata_MPORT_en = dataArray_10_3_cachedata_MPORT_en_pipe_0;
  assign dataArray_10_3_cachedata_MPORT_addr = dataArray_10_3_cachedata_MPORT_addr_pipe_0;
  assign dataArray_10_3_cachedata_MPORT_data = dataArray_10_3[dataArray_10_3_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_10_3_outdata_MPORT_en = dataArray_10_3_outdata_MPORT_en_pipe_0;
  assign dataArray_10_3_outdata_MPORT_addr = dataArray_10_3_outdata_MPORT_addr_pipe_0;
  assign dataArray_10_3_outdata_MPORT_data = dataArray_10_3[dataArray_10_3_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_10_3_toMemData_MPORT_en = dataArray_10_3_toMemData_MPORT_en_pipe_0;
  assign dataArray_10_3_toMemData_MPORT_addr = dataArray_10_3_toMemData_MPORT_addr_pipe_0;
  assign dataArray_10_3_toMemData_MPORT_data = dataArray_10_3[dataArray_10_3_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_10_3_MPORT_data = to_sram_r_bits_data;
  assign dataArray_10_3_MPORT_addr = replace_set;
  assign dataArray_10_3_MPORT_mask = _GEN_1105 & _GEN_1139;
  assign dataArray_10_3_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_10_3_MPORT_1_data = indata[31:0];
  assign dataArray_10_3_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_10_3_MPORT_1_mask = _GEN_1105 & _GEN_1394;
  assign dataArray_10_3_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_11_0_cachedata_MPORT_en = dataArray_11_0_cachedata_MPORT_en_pipe_0;
  assign dataArray_11_0_cachedata_MPORT_addr = dataArray_11_0_cachedata_MPORT_addr_pipe_0;
  assign dataArray_11_0_cachedata_MPORT_data = dataArray_11_0[dataArray_11_0_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_11_0_outdata_MPORT_en = dataArray_11_0_outdata_MPORT_en_pipe_0;
  assign dataArray_11_0_outdata_MPORT_addr = dataArray_11_0_outdata_MPORT_addr_pipe_0;
  assign dataArray_11_0_outdata_MPORT_data = dataArray_11_0[dataArray_11_0_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_11_0_toMemData_MPORT_en = dataArray_11_0_toMemData_MPORT_en_pipe_0;
  assign dataArray_11_0_toMemData_MPORT_addr = dataArray_11_0_toMemData_MPORT_addr_pipe_0;
  assign dataArray_11_0_toMemData_MPORT_data = dataArray_11_0[dataArray_11_0_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_11_0_MPORT_data = to_sram_r_bits_data;
  assign dataArray_11_0_MPORT_addr = replace_set;
  assign dataArray_11_0_MPORT_mask = _GEN_1107 & _GEN_1133;
  assign dataArray_11_0_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_11_0_MPORT_1_data = indata[31:0];
  assign dataArray_11_0_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_11_0_MPORT_1_mask = _GEN_1107 & _GEN_1396;
  assign dataArray_11_0_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_11_1_cachedata_MPORT_en = dataArray_11_1_cachedata_MPORT_en_pipe_0;
  assign dataArray_11_1_cachedata_MPORT_addr = dataArray_11_1_cachedata_MPORT_addr_pipe_0;
  assign dataArray_11_1_cachedata_MPORT_data = dataArray_11_1[dataArray_11_1_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_11_1_outdata_MPORT_en = dataArray_11_1_outdata_MPORT_en_pipe_0;
  assign dataArray_11_1_outdata_MPORT_addr = dataArray_11_1_outdata_MPORT_addr_pipe_0;
  assign dataArray_11_1_outdata_MPORT_data = dataArray_11_1[dataArray_11_1_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_11_1_toMemData_MPORT_en = dataArray_11_1_toMemData_MPORT_en_pipe_0;
  assign dataArray_11_1_toMemData_MPORT_addr = dataArray_11_1_toMemData_MPORT_addr_pipe_0;
  assign dataArray_11_1_toMemData_MPORT_data = dataArray_11_1[dataArray_11_1_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_11_1_MPORT_data = to_sram_r_bits_data;
  assign dataArray_11_1_MPORT_addr = replace_set;
  assign dataArray_11_1_MPORT_mask = _GEN_1107 & _GEN_1135;
  assign dataArray_11_1_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_11_1_MPORT_1_data = indata[31:0];
  assign dataArray_11_1_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_11_1_MPORT_1_mask = _GEN_1107 & _GEN_1390;
  assign dataArray_11_1_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_11_2_cachedata_MPORT_en = dataArray_11_2_cachedata_MPORT_en_pipe_0;
  assign dataArray_11_2_cachedata_MPORT_addr = dataArray_11_2_cachedata_MPORT_addr_pipe_0;
  assign dataArray_11_2_cachedata_MPORT_data = dataArray_11_2[dataArray_11_2_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_11_2_outdata_MPORT_en = dataArray_11_2_outdata_MPORT_en_pipe_0;
  assign dataArray_11_2_outdata_MPORT_addr = dataArray_11_2_outdata_MPORT_addr_pipe_0;
  assign dataArray_11_2_outdata_MPORT_data = dataArray_11_2[dataArray_11_2_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_11_2_toMemData_MPORT_en = dataArray_11_2_toMemData_MPORT_en_pipe_0;
  assign dataArray_11_2_toMemData_MPORT_addr = dataArray_11_2_toMemData_MPORT_addr_pipe_0;
  assign dataArray_11_2_toMemData_MPORT_data = dataArray_11_2[dataArray_11_2_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_11_2_MPORT_data = to_sram_r_bits_data;
  assign dataArray_11_2_MPORT_addr = replace_set;
  assign dataArray_11_2_MPORT_mask = _GEN_1107 & _GEN_1137;
  assign dataArray_11_2_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_11_2_MPORT_1_data = indata[31:0];
  assign dataArray_11_2_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_11_2_MPORT_1_mask = _GEN_1107 & _GEN_1392;
  assign dataArray_11_2_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_11_3_cachedata_MPORT_en = dataArray_11_3_cachedata_MPORT_en_pipe_0;
  assign dataArray_11_3_cachedata_MPORT_addr = dataArray_11_3_cachedata_MPORT_addr_pipe_0;
  assign dataArray_11_3_cachedata_MPORT_data = dataArray_11_3[dataArray_11_3_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_11_3_outdata_MPORT_en = dataArray_11_3_outdata_MPORT_en_pipe_0;
  assign dataArray_11_3_outdata_MPORT_addr = dataArray_11_3_outdata_MPORT_addr_pipe_0;
  assign dataArray_11_3_outdata_MPORT_data = dataArray_11_3[dataArray_11_3_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_11_3_toMemData_MPORT_en = dataArray_11_3_toMemData_MPORT_en_pipe_0;
  assign dataArray_11_3_toMemData_MPORT_addr = dataArray_11_3_toMemData_MPORT_addr_pipe_0;
  assign dataArray_11_3_toMemData_MPORT_data = dataArray_11_3[dataArray_11_3_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_11_3_MPORT_data = to_sram_r_bits_data;
  assign dataArray_11_3_MPORT_addr = replace_set;
  assign dataArray_11_3_MPORT_mask = _GEN_1107 & _GEN_1139;
  assign dataArray_11_3_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_11_3_MPORT_1_data = indata[31:0];
  assign dataArray_11_3_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_11_3_MPORT_1_mask = _GEN_1107 & _GEN_1394;
  assign dataArray_11_3_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_12_0_cachedata_MPORT_en = dataArray_12_0_cachedata_MPORT_en_pipe_0;
  assign dataArray_12_0_cachedata_MPORT_addr = dataArray_12_0_cachedata_MPORT_addr_pipe_0;
  assign dataArray_12_0_cachedata_MPORT_data = dataArray_12_0[dataArray_12_0_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_12_0_outdata_MPORT_en = dataArray_12_0_outdata_MPORT_en_pipe_0;
  assign dataArray_12_0_outdata_MPORT_addr = dataArray_12_0_outdata_MPORT_addr_pipe_0;
  assign dataArray_12_0_outdata_MPORT_data = dataArray_12_0[dataArray_12_0_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_12_0_toMemData_MPORT_en = dataArray_12_0_toMemData_MPORT_en_pipe_0;
  assign dataArray_12_0_toMemData_MPORT_addr = dataArray_12_0_toMemData_MPORT_addr_pipe_0;
  assign dataArray_12_0_toMemData_MPORT_data = dataArray_12_0[dataArray_12_0_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_12_0_MPORT_data = to_sram_r_bits_data;
  assign dataArray_12_0_MPORT_addr = replace_set;
  assign dataArray_12_0_MPORT_mask = _GEN_1109 & _GEN_1133;
  assign dataArray_12_0_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_12_0_MPORT_1_data = indata[31:0];
  assign dataArray_12_0_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_12_0_MPORT_1_mask = _GEN_1109 & _GEN_1396;
  assign dataArray_12_0_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_12_1_cachedata_MPORT_en = dataArray_12_1_cachedata_MPORT_en_pipe_0;
  assign dataArray_12_1_cachedata_MPORT_addr = dataArray_12_1_cachedata_MPORT_addr_pipe_0;
  assign dataArray_12_1_cachedata_MPORT_data = dataArray_12_1[dataArray_12_1_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_12_1_outdata_MPORT_en = dataArray_12_1_outdata_MPORT_en_pipe_0;
  assign dataArray_12_1_outdata_MPORT_addr = dataArray_12_1_outdata_MPORT_addr_pipe_0;
  assign dataArray_12_1_outdata_MPORT_data = dataArray_12_1[dataArray_12_1_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_12_1_toMemData_MPORT_en = dataArray_12_1_toMemData_MPORT_en_pipe_0;
  assign dataArray_12_1_toMemData_MPORT_addr = dataArray_12_1_toMemData_MPORT_addr_pipe_0;
  assign dataArray_12_1_toMemData_MPORT_data = dataArray_12_1[dataArray_12_1_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_12_1_MPORT_data = to_sram_r_bits_data;
  assign dataArray_12_1_MPORT_addr = replace_set;
  assign dataArray_12_1_MPORT_mask = _GEN_1109 & _GEN_1135;
  assign dataArray_12_1_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_12_1_MPORT_1_data = indata[31:0];
  assign dataArray_12_1_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_12_1_MPORT_1_mask = _GEN_1109 & _GEN_1390;
  assign dataArray_12_1_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_12_2_cachedata_MPORT_en = dataArray_12_2_cachedata_MPORT_en_pipe_0;
  assign dataArray_12_2_cachedata_MPORT_addr = dataArray_12_2_cachedata_MPORT_addr_pipe_0;
  assign dataArray_12_2_cachedata_MPORT_data = dataArray_12_2[dataArray_12_2_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_12_2_outdata_MPORT_en = dataArray_12_2_outdata_MPORT_en_pipe_0;
  assign dataArray_12_2_outdata_MPORT_addr = dataArray_12_2_outdata_MPORT_addr_pipe_0;
  assign dataArray_12_2_outdata_MPORT_data = dataArray_12_2[dataArray_12_2_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_12_2_toMemData_MPORT_en = dataArray_12_2_toMemData_MPORT_en_pipe_0;
  assign dataArray_12_2_toMemData_MPORT_addr = dataArray_12_2_toMemData_MPORT_addr_pipe_0;
  assign dataArray_12_2_toMemData_MPORT_data = dataArray_12_2[dataArray_12_2_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_12_2_MPORT_data = to_sram_r_bits_data;
  assign dataArray_12_2_MPORT_addr = replace_set;
  assign dataArray_12_2_MPORT_mask = _GEN_1109 & _GEN_1137;
  assign dataArray_12_2_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_12_2_MPORT_1_data = indata[31:0];
  assign dataArray_12_2_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_12_2_MPORT_1_mask = _GEN_1109 & _GEN_1392;
  assign dataArray_12_2_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_12_3_cachedata_MPORT_en = dataArray_12_3_cachedata_MPORT_en_pipe_0;
  assign dataArray_12_3_cachedata_MPORT_addr = dataArray_12_3_cachedata_MPORT_addr_pipe_0;
  assign dataArray_12_3_cachedata_MPORT_data = dataArray_12_3[dataArray_12_3_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_12_3_outdata_MPORT_en = dataArray_12_3_outdata_MPORT_en_pipe_0;
  assign dataArray_12_3_outdata_MPORT_addr = dataArray_12_3_outdata_MPORT_addr_pipe_0;
  assign dataArray_12_3_outdata_MPORT_data = dataArray_12_3[dataArray_12_3_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_12_3_toMemData_MPORT_en = dataArray_12_3_toMemData_MPORT_en_pipe_0;
  assign dataArray_12_3_toMemData_MPORT_addr = dataArray_12_3_toMemData_MPORT_addr_pipe_0;
  assign dataArray_12_3_toMemData_MPORT_data = dataArray_12_3[dataArray_12_3_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_12_3_MPORT_data = to_sram_r_bits_data;
  assign dataArray_12_3_MPORT_addr = replace_set;
  assign dataArray_12_3_MPORT_mask = _GEN_1109 & _GEN_1139;
  assign dataArray_12_3_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_12_3_MPORT_1_data = indata[31:0];
  assign dataArray_12_3_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_12_3_MPORT_1_mask = _GEN_1109 & _GEN_1394;
  assign dataArray_12_3_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_13_0_cachedata_MPORT_en = dataArray_13_0_cachedata_MPORT_en_pipe_0;
  assign dataArray_13_0_cachedata_MPORT_addr = dataArray_13_0_cachedata_MPORT_addr_pipe_0;
  assign dataArray_13_0_cachedata_MPORT_data = dataArray_13_0[dataArray_13_0_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_13_0_outdata_MPORT_en = dataArray_13_0_outdata_MPORT_en_pipe_0;
  assign dataArray_13_0_outdata_MPORT_addr = dataArray_13_0_outdata_MPORT_addr_pipe_0;
  assign dataArray_13_0_outdata_MPORT_data = dataArray_13_0[dataArray_13_0_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_13_0_toMemData_MPORT_en = dataArray_13_0_toMemData_MPORT_en_pipe_0;
  assign dataArray_13_0_toMemData_MPORT_addr = dataArray_13_0_toMemData_MPORT_addr_pipe_0;
  assign dataArray_13_0_toMemData_MPORT_data = dataArray_13_0[dataArray_13_0_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_13_0_MPORT_data = to_sram_r_bits_data;
  assign dataArray_13_0_MPORT_addr = replace_set;
  assign dataArray_13_0_MPORT_mask = _GEN_1111 & _GEN_1133;
  assign dataArray_13_0_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_13_0_MPORT_1_data = indata[31:0];
  assign dataArray_13_0_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_13_0_MPORT_1_mask = _GEN_1111 & _GEN_1396;
  assign dataArray_13_0_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_13_1_cachedata_MPORT_en = dataArray_13_1_cachedata_MPORT_en_pipe_0;
  assign dataArray_13_1_cachedata_MPORT_addr = dataArray_13_1_cachedata_MPORT_addr_pipe_0;
  assign dataArray_13_1_cachedata_MPORT_data = dataArray_13_1[dataArray_13_1_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_13_1_outdata_MPORT_en = dataArray_13_1_outdata_MPORT_en_pipe_0;
  assign dataArray_13_1_outdata_MPORT_addr = dataArray_13_1_outdata_MPORT_addr_pipe_0;
  assign dataArray_13_1_outdata_MPORT_data = dataArray_13_1[dataArray_13_1_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_13_1_toMemData_MPORT_en = dataArray_13_1_toMemData_MPORT_en_pipe_0;
  assign dataArray_13_1_toMemData_MPORT_addr = dataArray_13_1_toMemData_MPORT_addr_pipe_0;
  assign dataArray_13_1_toMemData_MPORT_data = dataArray_13_1[dataArray_13_1_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_13_1_MPORT_data = to_sram_r_bits_data;
  assign dataArray_13_1_MPORT_addr = replace_set;
  assign dataArray_13_1_MPORT_mask = _GEN_1111 & _GEN_1135;
  assign dataArray_13_1_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_13_1_MPORT_1_data = indata[31:0];
  assign dataArray_13_1_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_13_1_MPORT_1_mask = _GEN_1111 & _GEN_1390;
  assign dataArray_13_1_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_13_2_cachedata_MPORT_en = dataArray_13_2_cachedata_MPORT_en_pipe_0;
  assign dataArray_13_2_cachedata_MPORT_addr = dataArray_13_2_cachedata_MPORT_addr_pipe_0;
  assign dataArray_13_2_cachedata_MPORT_data = dataArray_13_2[dataArray_13_2_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_13_2_outdata_MPORT_en = dataArray_13_2_outdata_MPORT_en_pipe_0;
  assign dataArray_13_2_outdata_MPORT_addr = dataArray_13_2_outdata_MPORT_addr_pipe_0;
  assign dataArray_13_2_outdata_MPORT_data = dataArray_13_2[dataArray_13_2_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_13_2_toMemData_MPORT_en = dataArray_13_2_toMemData_MPORT_en_pipe_0;
  assign dataArray_13_2_toMemData_MPORT_addr = dataArray_13_2_toMemData_MPORT_addr_pipe_0;
  assign dataArray_13_2_toMemData_MPORT_data = dataArray_13_2[dataArray_13_2_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_13_2_MPORT_data = to_sram_r_bits_data;
  assign dataArray_13_2_MPORT_addr = replace_set;
  assign dataArray_13_2_MPORT_mask = _GEN_1111 & _GEN_1137;
  assign dataArray_13_2_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_13_2_MPORT_1_data = indata[31:0];
  assign dataArray_13_2_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_13_2_MPORT_1_mask = _GEN_1111 & _GEN_1392;
  assign dataArray_13_2_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_13_3_cachedata_MPORT_en = dataArray_13_3_cachedata_MPORT_en_pipe_0;
  assign dataArray_13_3_cachedata_MPORT_addr = dataArray_13_3_cachedata_MPORT_addr_pipe_0;
  assign dataArray_13_3_cachedata_MPORT_data = dataArray_13_3[dataArray_13_3_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_13_3_outdata_MPORT_en = dataArray_13_3_outdata_MPORT_en_pipe_0;
  assign dataArray_13_3_outdata_MPORT_addr = dataArray_13_3_outdata_MPORT_addr_pipe_0;
  assign dataArray_13_3_outdata_MPORT_data = dataArray_13_3[dataArray_13_3_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_13_3_toMemData_MPORT_en = dataArray_13_3_toMemData_MPORT_en_pipe_0;
  assign dataArray_13_3_toMemData_MPORT_addr = dataArray_13_3_toMemData_MPORT_addr_pipe_0;
  assign dataArray_13_3_toMemData_MPORT_data = dataArray_13_3[dataArray_13_3_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_13_3_MPORT_data = to_sram_r_bits_data;
  assign dataArray_13_3_MPORT_addr = replace_set;
  assign dataArray_13_3_MPORT_mask = _GEN_1111 & _GEN_1139;
  assign dataArray_13_3_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_13_3_MPORT_1_data = indata[31:0];
  assign dataArray_13_3_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_13_3_MPORT_1_mask = _GEN_1111 & _GEN_1394;
  assign dataArray_13_3_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_14_0_cachedata_MPORT_en = dataArray_14_0_cachedata_MPORT_en_pipe_0;
  assign dataArray_14_0_cachedata_MPORT_addr = dataArray_14_0_cachedata_MPORT_addr_pipe_0;
  assign dataArray_14_0_cachedata_MPORT_data = dataArray_14_0[dataArray_14_0_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_14_0_outdata_MPORT_en = dataArray_14_0_outdata_MPORT_en_pipe_0;
  assign dataArray_14_0_outdata_MPORT_addr = dataArray_14_0_outdata_MPORT_addr_pipe_0;
  assign dataArray_14_0_outdata_MPORT_data = dataArray_14_0[dataArray_14_0_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_14_0_toMemData_MPORT_en = dataArray_14_0_toMemData_MPORT_en_pipe_0;
  assign dataArray_14_0_toMemData_MPORT_addr = dataArray_14_0_toMemData_MPORT_addr_pipe_0;
  assign dataArray_14_0_toMemData_MPORT_data = dataArray_14_0[dataArray_14_0_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_14_0_MPORT_data = to_sram_r_bits_data;
  assign dataArray_14_0_MPORT_addr = replace_set;
  assign dataArray_14_0_MPORT_mask = _GEN_1113 & _GEN_1133;
  assign dataArray_14_0_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_14_0_MPORT_1_data = indata[31:0];
  assign dataArray_14_0_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_14_0_MPORT_1_mask = _GEN_1113 & _GEN_1396;
  assign dataArray_14_0_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_14_1_cachedata_MPORT_en = dataArray_14_1_cachedata_MPORT_en_pipe_0;
  assign dataArray_14_1_cachedata_MPORT_addr = dataArray_14_1_cachedata_MPORT_addr_pipe_0;
  assign dataArray_14_1_cachedata_MPORT_data = dataArray_14_1[dataArray_14_1_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_14_1_outdata_MPORT_en = dataArray_14_1_outdata_MPORT_en_pipe_0;
  assign dataArray_14_1_outdata_MPORT_addr = dataArray_14_1_outdata_MPORT_addr_pipe_0;
  assign dataArray_14_1_outdata_MPORT_data = dataArray_14_1[dataArray_14_1_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_14_1_toMemData_MPORT_en = dataArray_14_1_toMemData_MPORT_en_pipe_0;
  assign dataArray_14_1_toMemData_MPORT_addr = dataArray_14_1_toMemData_MPORT_addr_pipe_0;
  assign dataArray_14_1_toMemData_MPORT_data = dataArray_14_1[dataArray_14_1_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_14_1_MPORT_data = to_sram_r_bits_data;
  assign dataArray_14_1_MPORT_addr = replace_set;
  assign dataArray_14_1_MPORT_mask = _GEN_1113 & _GEN_1135;
  assign dataArray_14_1_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_14_1_MPORT_1_data = indata[31:0];
  assign dataArray_14_1_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_14_1_MPORT_1_mask = _GEN_1113 & _GEN_1390;
  assign dataArray_14_1_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_14_2_cachedata_MPORT_en = dataArray_14_2_cachedata_MPORT_en_pipe_0;
  assign dataArray_14_2_cachedata_MPORT_addr = dataArray_14_2_cachedata_MPORT_addr_pipe_0;
  assign dataArray_14_2_cachedata_MPORT_data = dataArray_14_2[dataArray_14_2_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_14_2_outdata_MPORT_en = dataArray_14_2_outdata_MPORT_en_pipe_0;
  assign dataArray_14_2_outdata_MPORT_addr = dataArray_14_2_outdata_MPORT_addr_pipe_0;
  assign dataArray_14_2_outdata_MPORT_data = dataArray_14_2[dataArray_14_2_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_14_2_toMemData_MPORT_en = dataArray_14_2_toMemData_MPORT_en_pipe_0;
  assign dataArray_14_2_toMemData_MPORT_addr = dataArray_14_2_toMemData_MPORT_addr_pipe_0;
  assign dataArray_14_2_toMemData_MPORT_data = dataArray_14_2[dataArray_14_2_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_14_2_MPORT_data = to_sram_r_bits_data;
  assign dataArray_14_2_MPORT_addr = replace_set;
  assign dataArray_14_2_MPORT_mask = _GEN_1113 & _GEN_1137;
  assign dataArray_14_2_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_14_2_MPORT_1_data = indata[31:0];
  assign dataArray_14_2_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_14_2_MPORT_1_mask = _GEN_1113 & _GEN_1392;
  assign dataArray_14_2_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_14_3_cachedata_MPORT_en = dataArray_14_3_cachedata_MPORT_en_pipe_0;
  assign dataArray_14_3_cachedata_MPORT_addr = dataArray_14_3_cachedata_MPORT_addr_pipe_0;
  assign dataArray_14_3_cachedata_MPORT_data = dataArray_14_3[dataArray_14_3_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_14_3_outdata_MPORT_en = dataArray_14_3_outdata_MPORT_en_pipe_0;
  assign dataArray_14_3_outdata_MPORT_addr = dataArray_14_3_outdata_MPORT_addr_pipe_0;
  assign dataArray_14_3_outdata_MPORT_data = dataArray_14_3[dataArray_14_3_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_14_3_toMemData_MPORT_en = dataArray_14_3_toMemData_MPORT_en_pipe_0;
  assign dataArray_14_3_toMemData_MPORT_addr = dataArray_14_3_toMemData_MPORT_addr_pipe_0;
  assign dataArray_14_3_toMemData_MPORT_data = dataArray_14_3[dataArray_14_3_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_14_3_MPORT_data = to_sram_r_bits_data;
  assign dataArray_14_3_MPORT_addr = replace_set;
  assign dataArray_14_3_MPORT_mask = _GEN_1113 & _GEN_1139;
  assign dataArray_14_3_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_14_3_MPORT_1_data = indata[31:0];
  assign dataArray_14_3_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_14_3_MPORT_1_mask = _GEN_1113 & _GEN_1394;
  assign dataArray_14_3_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_15_0_cachedata_MPORT_en = dataArray_15_0_cachedata_MPORT_en_pipe_0;
  assign dataArray_15_0_cachedata_MPORT_addr = dataArray_15_0_cachedata_MPORT_addr_pipe_0;
  assign dataArray_15_0_cachedata_MPORT_data = dataArray_15_0[dataArray_15_0_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_15_0_outdata_MPORT_en = dataArray_15_0_outdata_MPORT_en_pipe_0;
  assign dataArray_15_0_outdata_MPORT_addr = dataArray_15_0_outdata_MPORT_addr_pipe_0;
  assign dataArray_15_0_outdata_MPORT_data = dataArray_15_0[dataArray_15_0_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_15_0_toMemData_MPORT_en = dataArray_15_0_toMemData_MPORT_en_pipe_0;
  assign dataArray_15_0_toMemData_MPORT_addr = dataArray_15_0_toMemData_MPORT_addr_pipe_0;
  assign dataArray_15_0_toMemData_MPORT_data = dataArray_15_0[dataArray_15_0_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_15_0_MPORT_data = to_sram_r_bits_data;
  assign dataArray_15_0_MPORT_addr = replace_set;
  assign dataArray_15_0_MPORT_mask = _GEN_1115 & _GEN_1133;
  assign dataArray_15_0_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_15_0_MPORT_1_data = indata[31:0];
  assign dataArray_15_0_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_15_0_MPORT_1_mask = _GEN_1115 & _GEN_1396;
  assign dataArray_15_0_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_15_1_cachedata_MPORT_en = dataArray_15_1_cachedata_MPORT_en_pipe_0;
  assign dataArray_15_1_cachedata_MPORT_addr = dataArray_15_1_cachedata_MPORT_addr_pipe_0;
  assign dataArray_15_1_cachedata_MPORT_data = dataArray_15_1[dataArray_15_1_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_15_1_outdata_MPORT_en = dataArray_15_1_outdata_MPORT_en_pipe_0;
  assign dataArray_15_1_outdata_MPORT_addr = dataArray_15_1_outdata_MPORT_addr_pipe_0;
  assign dataArray_15_1_outdata_MPORT_data = dataArray_15_1[dataArray_15_1_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_15_1_toMemData_MPORT_en = dataArray_15_1_toMemData_MPORT_en_pipe_0;
  assign dataArray_15_1_toMemData_MPORT_addr = dataArray_15_1_toMemData_MPORT_addr_pipe_0;
  assign dataArray_15_1_toMemData_MPORT_data = dataArray_15_1[dataArray_15_1_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_15_1_MPORT_data = to_sram_r_bits_data;
  assign dataArray_15_1_MPORT_addr = replace_set;
  assign dataArray_15_1_MPORT_mask = _GEN_1115 & _GEN_1135;
  assign dataArray_15_1_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_15_1_MPORT_1_data = indata[31:0];
  assign dataArray_15_1_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_15_1_MPORT_1_mask = _GEN_1115 & _GEN_1390;
  assign dataArray_15_1_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_15_2_cachedata_MPORT_en = dataArray_15_2_cachedata_MPORT_en_pipe_0;
  assign dataArray_15_2_cachedata_MPORT_addr = dataArray_15_2_cachedata_MPORT_addr_pipe_0;
  assign dataArray_15_2_cachedata_MPORT_data = dataArray_15_2[dataArray_15_2_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_15_2_outdata_MPORT_en = dataArray_15_2_outdata_MPORT_en_pipe_0;
  assign dataArray_15_2_outdata_MPORT_addr = dataArray_15_2_outdata_MPORT_addr_pipe_0;
  assign dataArray_15_2_outdata_MPORT_data = dataArray_15_2[dataArray_15_2_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_15_2_toMemData_MPORT_en = dataArray_15_2_toMemData_MPORT_en_pipe_0;
  assign dataArray_15_2_toMemData_MPORT_addr = dataArray_15_2_toMemData_MPORT_addr_pipe_0;
  assign dataArray_15_2_toMemData_MPORT_data = dataArray_15_2[dataArray_15_2_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_15_2_MPORT_data = to_sram_r_bits_data;
  assign dataArray_15_2_MPORT_addr = replace_set;
  assign dataArray_15_2_MPORT_mask = _GEN_1115 & _GEN_1137;
  assign dataArray_15_2_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_15_2_MPORT_1_data = indata[31:0];
  assign dataArray_15_2_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_15_2_MPORT_1_mask = _GEN_1115 & _GEN_1392;
  assign dataArray_15_2_MPORT_1_en = state_dcache == 4'h2;
  assign dataArray_15_3_cachedata_MPORT_en = dataArray_15_3_cachedata_MPORT_en_pipe_0;
  assign dataArray_15_3_cachedata_MPORT_addr = dataArray_15_3_cachedata_MPORT_addr_pipe_0;
  assign dataArray_15_3_cachedata_MPORT_data = dataArray_15_3[dataArray_15_3_cachedata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_15_3_outdata_MPORT_en = dataArray_15_3_outdata_MPORT_en_pipe_0;
  assign dataArray_15_3_outdata_MPORT_addr = dataArray_15_3_outdata_MPORT_addr_pipe_0;
  assign dataArray_15_3_outdata_MPORT_data = dataArray_15_3[dataArray_15_3_outdata_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_15_3_toMemData_MPORT_en = dataArray_15_3_toMemData_MPORT_en_pipe_0;
  assign dataArray_15_3_toMemData_MPORT_addr = dataArray_15_3_toMemData_MPORT_addr_pipe_0;
  assign dataArray_15_3_toMemData_MPORT_data = dataArray_15_3[dataArray_15_3_toMemData_MPORT_addr]; // @[dcache.scala 29:33]
  assign dataArray_15_3_MPORT_data = to_sram_r_bits_data;
  assign dataArray_15_3_MPORT_addr = replace_set;
  assign dataArray_15_3_MPORT_mask = _GEN_1115 & _GEN_1139;
  assign dataArray_15_3_MPORT_en = _T_11 & _off_T_4;
  assign dataArray_15_3_MPORT_1_data = indata[31:0];
  assign dataArray_15_3_MPORT_1_addr = _GEN_47 == tag;
  assign dataArray_15_3_MPORT_1_mask = _GEN_1115 & _GEN_1394;
  assign dataArray_15_3_MPORT_1_en = state_dcache == 4'h2;
  assign from_LSU_ready = 4'h0 == state_dcache; // @[Mux.scala 81:61]
  assign to_LSU_valid = _T_3 | _T_2; // @[Mux.scala 81:58]
  assign to_LSU_bits_data = hit ? _GEN_1085 : 32'h0; // @[dcache.scala 145:29]
  assign to_LSU_bits_bresp = 4'h2 == state_dcache; // @[Mux.scala 81:61]
  assign to_sram_ar_valid = 4'h7 == state_dcache; // @[Mux.scala 81:61]
  assign to_sram_ar_bits_addr = _to_sram_ar_bits_addr_T_3[31:0]; // @[dcache.scala 129:27]
  assign to_sram_ar_bits_len = {{6'd0}, _to_sram_ar_bits_len_T_1}; // @[dcache.scala 131:27]
  assign to_sram_r_ready = 4'h8 == state_dcache; // @[Mux.scala 81:61]
  assign to_sram_aw_valid = 4'h4 == state_dcache; // @[Mux.scala 81:61]
  assign to_sram_aw_bits_addr = _to_sram_ar_bits_addr_T_3[31:0]; // @[dcache.scala 135:27]
  assign to_sram_aw_bits_len = {{6'd0}, _to_sram_ar_bits_len_T_1}; // @[dcache.scala 137:27]
  assign to_sram_w_valid = 4'h5 == state_dcache; // @[Mux.scala 81:61]
  assign to_sram_w_bits_data = _GEN_1115 & _GEN_1139 ? dataArray_15_3_toMemData_MPORT_data : _GEN_1020; // @[dcache.scala 140:{27,27}]
  assign to_sram_w_bits_last = _GEN_1854 == 3'h4; // @[dcache.scala 142:34]
  always @(posedge clock) begin
    if (dataArray_0_0_MPORT_en & dataArray_0_0_MPORT_mask) begin
      dataArray_0_0[dataArray_0_0_MPORT_addr] <= dataArray_0_0_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_0_0_MPORT_1_en & dataArray_0_0_MPORT_1_mask) begin
      dataArray_0_0[dataArray_0_0_MPORT_1_addr] <= dataArray_0_0_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_0_0_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_0_0_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_0_0_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_0_0_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_0_0_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_0_0_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_0_1_MPORT_en & dataArray_0_1_MPORT_mask) begin
      dataArray_0_1[dataArray_0_1_MPORT_addr] <= dataArray_0_1_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_0_1_MPORT_1_en & dataArray_0_1_MPORT_1_mask) begin
      dataArray_0_1[dataArray_0_1_MPORT_1_addr] <= dataArray_0_1_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_0_1_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_0_1_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_0_1_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_0_1_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_0_1_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_0_1_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_0_2_MPORT_en & dataArray_0_2_MPORT_mask) begin
      dataArray_0_2[dataArray_0_2_MPORT_addr] <= dataArray_0_2_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_0_2_MPORT_1_en & dataArray_0_2_MPORT_1_mask) begin
      dataArray_0_2[dataArray_0_2_MPORT_1_addr] <= dataArray_0_2_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_0_2_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_0_2_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_0_2_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_0_2_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_0_2_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_0_2_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_0_3_MPORT_en & dataArray_0_3_MPORT_mask) begin
      dataArray_0_3[dataArray_0_3_MPORT_addr] <= dataArray_0_3_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_0_3_MPORT_1_en & dataArray_0_3_MPORT_1_mask) begin
      dataArray_0_3[dataArray_0_3_MPORT_1_addr] <= dataArray_0_3_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_0_3_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_0_3_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_0_3_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_0_3_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_0_3_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_0_3_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_1_0_MPORT_en & dataArray_1_0_MPORT_mask) begin
      dataArray_1_0[dataArray_1_0_MPORT_addr] <= dataArray_1_0_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_1_0_MPORT_1_en & dataArray_1_0_MPORT_1_mask) begin
      dataArray_1_0[dataArray_1_0_MPORT_1_addr] <= dataArray_1_0_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_1_0_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_1_0_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_1_0_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_1_0_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_1_0_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_1_0_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_1_1_MPORT_en & dataArray_1_1_MPORT_mask) begin
      dataArray_1_1[dataArray_1_1_MPORT_addr] <= dataArray_1_1_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_1_1_MPORT_1_en & dataArray_1_1_MPORT_1_mask) begin
      dataArray_1_1[dataArray_1_1_MPORT_1_addr] <= dataArray_1_1_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_1_1_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_1_1_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_1_1_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_1_1_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_1_1_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_1_1_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_1_2_MPORT_en & dataArray_1_2_MPORT_mask) begin
      dataArray_1_2[dataArray_1_2_MPORT_addr] <= dataArray_1_2_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_1_2_MPORT_1_en & dataArray_1_2_MPORT_1_mask) begin
      dataArray_1_2[dataArray_1_2_MPORT_1_addr] <= dataArray_1_2_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_1_2_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_1_2_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_1_2_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_1_2_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_1_2_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_1_2_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_1_3_MPORT_en & dataArray_1_3_MPORT_mask) begin
      dataArray_1_3[dataArray_1_3_MPORT_addr] <= dataArray_1_3_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_1_3_MPORT_1_en & dataArray_1_3_MPORT_1_mask) begin
      dataArray_1_3[dataArray_1_3_MPORT_1_addr] <= dataArray_1_3_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_1_3_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_1_3_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_1_3_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_1_3_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_1_3_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_1_3_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_2_0_MPORT_en & dataArray_2_0_MPORT_mask) begin
      dataArray_2_0[dataArray_2_0_MPORT_addr] <= dataArray_2_0_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_2_0_MPORT_1_en & dataArray_2_0_MPORT_1_mask) begin
      dataArray_2_0[dataArray_2_0_MPORT_1_addr] <= dataArray_2_0_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_2_0_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_2_0_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_2_0_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_2_0_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_2_0_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_2_0_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_2_1_MPORT_en & dataArray_2_1_MPORT_mask) begin
      dataArray_2_1[dataArray_2_1_MPORT_addr] <= dataArray_2_1_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_2_1_MPORT_1_en & dataArray_2_1_MPORT_1_mask) begin
      dataArray_2_1[dataArray_2_1_MPORT_1_addr] <= dataArray_2_1_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_2_1_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_2_1_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_2_1_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_2_1_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_2_1_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_2_1_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_2_2_MPORT_en & dataArray_2_2_MPORT_mask) begin
      dataArray_2_2[dataArray_2_2_MPORT_addr] <= dataArray_2_2_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_2_2_MPORT_1_en & dataArray_2_2_MPORT_1_mask) begin
      dataArray_2_2[dataArray_2_2_MPORT_1_addr] <= dataArray_2_2_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_2_2_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_2_2_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_2_2_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_2_2_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_2_2_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_2_2_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_2_3_MPORT_en & dataArray_2_3_MPORT_mask) begin
      dataArray_2_3[dataArray_2_3_MPORT_addr] <= dataArray_2_3_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_2_3_MPORT_1_en & dataArray_2_3_MPORT_1_mask) begin
      dataArray_2_3[dataArray_2_3_MPORT_1_addr] <= dataArray_2_3_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_2_3_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_2_3_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_2_3_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_2_3_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_2_3_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_2_3_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_3_0_MPORT_en & dataArray_3_0_MPORT_mask) begin
      dataArray_3_0[dataArray_3_0_MPORT_addr] <= dataArray_3_0_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_3_0_MPORT_1_en & dataArray_3_0_MPORT_1_mask) begin
      dataArray_3_0[dataArray_3_0_MPORT_1_addr] <= dataArray_3_0_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_3_0_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_3_0_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_3_0_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_3_0_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_3_0_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_3_0_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_3_1_MPORT_en & dataArray_3_1_MPORT_mask) begin
      dataArray_3_1[dataArray_3_1_MPORT_addr] <= dataArray_3_1_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_3_1_MPORT_1_en & dataArray_3_1_MPORT_1_mask) begin
      dataArray_3_1[dataArray_3_1_MPORT_1_addr] <= dataArray_3_1_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_3_1_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_3_1_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_3_1_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_3_1_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_3_1_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_3_1_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_3_2_MPORT_en & dataArray_3_2_MPORT_mask) begin
      dataArray_3_2[dataArray_3_2_MPORT_addr] <= dataArray_3_2_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_3_2_MPORT_1_en & dataArray_3_2_MPORT_1_mask) begin
      dataArray_3_2[dataArray_3_2_MPORT_1_addr] <= dataArray_3_2_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_3_2_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_3_2_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_3_2_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_3_2_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_3_2_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_3_2_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_3_3_MPORT_en & dataArray_3_3_MPORT_mask) begin
      dataArray_3_3[dataArray_3_3_MPORT_addr] <= dataArray_3_3_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_3_3_MPORT_1_en & dataArray_3_3_MPORT_1_mask) begin
      dataArray_3_3[dataArray_3_3_MPORT_1_addr] <= dataArray_3_3_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_3_3_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_3_3_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_3_3_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_3_3_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_3_3_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_3_3_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_4_0_MPORT_en & dataArray_4_0_MPORT_mask) begin
      dataArray_4_0[dataArray_4_0_MPORT_addr] <= dataArray_4_0_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_4_0_MPORT_1_en & dataArray_4_0_MPORT_1_mask) begin
      dataArray_4_0[dataArray_4_0_MPORT_1_addr] <= dataArray_4_0_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_4_0_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_4_0_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_4_0_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_4_0_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_4_0_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_4_0_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_4_1_MPORT_en & dataArray_4_1_MPORT_mask) begin
      dataArray_4_1[dataArray_4_1_MPORT_addr] <= dataArray_4_1_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_4_1_MPORT_1_en & dataArray_4_1_MPORT_1_mask) begin
      dataArray_4_1[dataArray_4_1_MPORT_1_addr] <= dataArray_4_1_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_4_1_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_4_1_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_4_1_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_4_1_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_4_1_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_4_1_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_4_2_MPORT_en & dataArray_4_2_MPORT_mask) begin
      dataArray_4_2[dataArray_4_2_MPORT_addr] <= dataArray_4_2_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_4_2_MPORT_1_en & dataArray_4_2_MPORT_1_mask) begin
      dataArray_4_2[dataArray_4_2_MPORT_1_addr] <= dataArray_4_2_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_4_2_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_4_2_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_4_2_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_4_2_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_4_2_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_4_2_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_4_3_MPORT_en & dataArray_4_3_MPORT_mask) begin
      dataArray_4_3[dataArray_4_3_MPORT_addr] <= dataArray_4_3_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_4_3_MPORT_1_en & dataArray_4_3_MPORT_1_mask) begin
      dataArray_4_3[dataArray_4_3_MPORT_1_addr] <= dataArray_4_3_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_4_3_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_4_3_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_4_3_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_4_3_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_4_3_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_4_3_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_5_0_MPORT_en & dataArray_5_0_MPORT_mask) begin
      dataArray_5_0[dataArray_5_0_MPORT_addr] <= dataArray_5_0_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_5_0_MPORT_1_en & dataArray_5_0_MPORT_1_mask) begin
      dataArray_5_0[dataArray_5_0_MPORT_1_addr] <= dataArray_5_0_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_5_0_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_5_0_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_5_0_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_5_0_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_5_0_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_5_0_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_5_1_MPORT_en & dataArray_5_1_MPORT_mask) begin
      dataArray_5_1[dataArray_5_1_MPORT_addr] <= dataArray_5_1_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_5_1_MPORT_1_en & dataArray_5_1_MPORT_1_mask) begin
      dataArray_5_1[dataArray_5_1_MPORT_1_addr] <= dataArray_5_1_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_5_1_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_5_1_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_5_1_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_5_1_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_5_1_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_5_1_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_5_2_MPORT_en & dataArray_5_2_MPORT_mask) begin
      dataArray_5_2[dataArray_5_2_MPORT_addr] <= dataArray_5_2_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_5_2_MPORT_1_en & dataArray_5_2_MPORT_1_mask) begin
      dataArray_5_2[dataArray_5_2_MPORT_1_addr] <= dataArray_5_2_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_5_2_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_5_2_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_5_2_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_5_2_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_5_2_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_5_2_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_5_3_MPORT_en & dataArray_5_3_MPORT_mask) begin
      dataArray_5_3[dataArray_5_3_MPORT_addr] <= dataArray_5_3_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_5_3_MPORT_1_en & dataArray_5_3_MPORT_1_mask) begin
      dataArray_5_3[dataArray_5_3_MPORT_1_addr] <= dataArray_5_3_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_5_3_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_5_3_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_5_3_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_5_3_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_5_3_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_5_3_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_6_0_MPORT_en & dataArray_6_0_MPORT_mask) begin
      dataArray_6_0[dataArray_6_0_MPORT_addr] <= dataArray_6_0_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_6_0_MPORT_1_en & dataArray_6_0_MPORT_1_mask) begin
      dataArray_6_0[dataArray_6_0_MPORT_1_addr] <= dataArray_6_0_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_6_0_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_6_0_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_6_0_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_6_0_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_6_0_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_6_0_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_6_1_MPORT_en & dataArray_6_1_MPORT_mask) begin
      dataArray_6_1[dataArray_6_1_MPORT_addr] <= dataArray_6_1_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_6_1_MPORT_1_en & dataArray_6_1_MPORT_1_mask) begin
      dataArray_6_1[dataArray_6_1_MPORT_1_addr] <= dataArray_6_1_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_6_1_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_6_1_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_6_1_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_6_1_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_6_1_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_6_1_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_6_2_MPORT_en & dataArray_6_2_MPORT_mask) begin
      dataArray_6_2[dataArray_6_2_MPORT_addr] <= dataArray_6_2_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_6_2_MPORT_1_en & dataArray_6_2_MPORT_1_mask) begin
      dataArray_6_2[dataArray_6_2_MPORT_1_addr] <= dataArray_6_2_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_6_2_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_6_2_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_6_2_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_6_2_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_6_2_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_6_2_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_6_3_MPORT_en & dataArray_6_3_MPORT_mask) begin
      dataArray_6_3[dataArray_6_3_MPORT_addr] <= dataArray_6_3_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_6_3_MPORT_1_en & dataArray_6_3_MPORT_1_mask) begin
      dataArray_6_3[dataArray_6_3_MPORT_1_addr] <= dataArray_6_3_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_6_3_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_6_3_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_6_3_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_6_3_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_6_3_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_6_3_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_7_0_MPORT_en & dataArray_7_0_MPORT_mask) begin
      dataArray_7_0[dataArray_7_0_MPORT_addr] <= dataArray_7_0_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_7_0_MPORT_1_en & dataArray_7_0_MPORT_1_mask) begin
      dataArray_7_0[dataArray_7_0_MPORT_1_addr] <= dataArray_7_0_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_7_0_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_7_0_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_7_0_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_7_0_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_7_0_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_7_0_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_7_1_MPORT_en & dataArray_7_1_MPORT_mask) begin
      dataArray_7_1[dataArray_7_1_MPORT_addr] <= dataArray_7_1_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_7_1_MPORT_1_en & dataArray_7_1_MPORT_1_mask) begin
      dataArray_7_1[dataArray_7_1_MPORT_1_addr] <= dataArray_7_1_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_7_1_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_7_1_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_7_1_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_7_1_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_7_1_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_7_1_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_7_2_MPORT_en & dataArray_7_2_MPORT_mask) begin
      dataArray_7_2[dataArray_7_2_MPORT_addr] <= dataArray_7_2_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_7_2_MPORT_1_en & dataArray_7_2_MPORT_1_mask) begin
      dataArray_7_2[dataArray_7_2_MPORT_1_addr] <= dataArray_7_2_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_7_2_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_7_2_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_7_2_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_7_2_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_7_2_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_7_2_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_7_3_MPORT_en & dataArray_7_3_MPORT_mask) begin
      dataArray_7_3[dataArray_7_3_MPORT_addr] <= dataArray_7_3_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_7_3_MPORT_1_en & dataArray_7_3_MPORT_1_mask) begin
      dataArray_7_3[dataArray_7_3_MPORT_1_addr] <= dataArray_7_3_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_7_3_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_7_3_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_7_3_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_7_3_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_7_3_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_7_3_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_8_0_MPORT_en & dataArray_8_0_MPORT_mask) begin
      dataArray_8_0[dataArray_8_0_MPORT_addr] <= dataArray_8_0_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_8_0_MPORT_1_en & dataArray_8_0_MPORT_1_mask) begin
      dataArray_8_0[dataArray_8_0_MPORT_1_addr] <= dataArray_8_0_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_8_0_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_8_0_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_8_0_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_8_0_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_8_0_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_8_0_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_8_1_MPORT_en & dataArray_8_1_MPORT_mask) begin
      dataArray_8_1[dataArray_8_1_MPORT_addr] <= dataArray_8_1_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_8_1_MPORT_1_en & dataArray_8_1_MPORT_1_mask) begin
      dataArray_8_1[dataArray_8_1_MPORT_1_addr] <= dataArray_8_1_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_8_1_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_8_1_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_8_1_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_8_1_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_8_1_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_8_1_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_8_2_MPORT_en & dataArray_8_2_MPORT_mask) begin
      dataArray_8_2[dataArray_8_2_MPORT_addr] <= dataArray_8_2_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_8_2_MPORT_1_en & dataArray_8_2_MPORT_1_mask) begin
      dataArray_8_2[dataArray_8_2_MPORT_1_addr] <= dataArray_8_2_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_8_2_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_8_2_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_8_2_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_8_2_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_8_2_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_8_2_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_8_3_MPORT_en & dataArray_8_3_MPORT_mask) begin
      dataArray_8_3[dataArray_8_3_MPORT_addr] <= dataArray_8_3_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_8_3_MPORT_1_en & dataArray_8_3_MPORT_1_mask) begin
      dataArray_8_3[dataArray_8_3_MPORT_1_addr] <= dataArray_8_3_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_8_3_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_8_3_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_8_3_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_8_3_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_8_3_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_8_3_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_9_0_MPORT_en & dataArray_9_0_MPORT_mask) begin
      dataArray_9_0[dataArray_9_0_MPORT_addr] <= dataArray_9_0_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_9_0_MPORT_1_en & dataArray_9_0_MPORT_1_mask) begin
      dataArray_9_0[dataArray_9_0_MPORT_1_addr] <= dataArray_9_0_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_9_0_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_9_0_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_9_0_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_9_0_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_9_0_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_9_0_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_9_1_MPORT_en & dataArray_9_1_MPORT_mask) begin
      dataArray_9_1[dataArray_9_1_MPORT_addr] <= dataArray_9_1_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_9_1_MPORT_1_en & dataArray_9_1_MPORT_1_mask) begin
      dataArray_9_1[dataArray_9_1_MPORT_1_addr] <= dataArray_9_1_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_9_1_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_9_1_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_9_1_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_9_1_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_9_1_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_9_1_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_9_2_MPORT_en & dataArray_9_2_MPORT_mask) begin
      dataArray_9_2[dataArray_9_2_MPORT_addr] <= dataArray_9_2_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_9_2_MPORT_1_en & dataArray_9_2_MPORT_1_mask) begin
      dataArray_9_2[dataArray_9_2_MPORT_1_addr] <= dataArray_9_2_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_9_2_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_9_2_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_9_2_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_9_2_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_9_2_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_9_2_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_9_3_MPORT_en & dataArray_9_3_MPORT_mask) begin
      dataArray_9_3[dataArray_9_3_MPORT_addr] <= dataArray_9_3_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_9_3_MPORT_1_en & dataArray_9_3_MPORT_1_mask) begin
      dataArray_9_3[dataArray_9_3_MPORT_1_addr] <= dataArray_9_3_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_9_3_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_9_3_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_9_3_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_9_3_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_9_3_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_9_3_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_10_0_MPORT_en & dataArray_10_0_MPORT_mask) begin
      dataArray_10_0[dataArray_10_0_MPORT_addr] <= dataArray_10_0_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_10_0_MPORT_1_en & dataArray_10_0_MPORT_1_mask) begin
      dataArray_10_0[dataArray_10_0_MPORT_1_addr] <= dataArray_10_0_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_10_0_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_10_0_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_10_0_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_10_0_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_10_0_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_10_0_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_10_1_MPORT_en & dataArray_10_1_MPORT_mask) begin
      dataArray_10_1[dataArray_10_1_MPORT_addr] <= dataArray_10_1_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_10_1_MPORT_1_en & dataArray_10_1_MPORT_1_mask) begin
      dataArray_10_1[dataArray_10_1_MPORT_1_addr] <= dataArray_10_1_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_10_1_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_10_1_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_10_1_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_10_1_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_10_1_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_10_1_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_10_2_MPORT_en & dataArray_10_2_MPORT_mask) begin
      dataArray_10_2[dataArray_10_2_MPORT_addr] <= dataArray_10_2_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_10_2_MPORT_1_en & dataArray_10_2_MPORT_1_mask) begin
      dataArray_10_2[dataArray_10_2_MPORT_1_addr] <= dataArray_10_2_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_10_2_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_10_2_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_10_2_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_10_2_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_10_2_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_10_2_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_10_3_MPORT_en & dataArray_10_3_MPORT_mask) begin
      dataArray_10_3[dataArray_10_3_MPORT_addr] <= dataArray_10_3_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_10_3_MPORT_1_en & dataArray_10_3_MPORT_1_mask) begin
      dataArray_10_3[dataArray_10_3_MPORT_1_addr] <= dataArray_10_3_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_10_3_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_10_3_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_10_3_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_10_3_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_10_3_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_10_3_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_11_0_MPORT_en & dataArray_11_0_MPORT_mask) begin
      dataArray_11_0[dataArray_11_0_MPORT_addr] <= dataArray_11_0_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_11_0_MPORT_1_en & dataArray_11_0_MPORT_1_mask) begin
      dataArray_11_0[dataArray_11_0_MPORT_1_addr] <= dataArray_11_0_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_11_0_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_11_0_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_11_0_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_11_0_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_11_0_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_11_0_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_11_1_MPORT_en & dataArray_11_1_MPORT_mask) begin
      dataArray_11_1[dataArray_11_1_MPORT_addr] <= dataArray_11_1_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_11_1_MPORT_1_en & dataArray_11_1_MPORT_1_mask) begin
      dataArray_11_1[dataArray_11_1_MPORT_1_addr] <= dataArray_11_1_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_11_1_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_11_1_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_11_1_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_11_1_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_11_1_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_11_1_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_11_2_MPORT_en & dataArray_11_2_MPORT_mask) begin
      dataArray_11_2[dataArray_11_2_MPORT_addr] <= dataArray_11_2_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_11_2_MPORT_1_en & dataArray_11_2_MPORT_1_mask) begin
      dataArray_11_2[dataArray_11_2_MPORT_1_addr] <= dataArray_11_2_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_11_2_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_11_2_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_11_2_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_11_2_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_11_2_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_11_2_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_11_3_MPORT_en & dataArray_11_3_MPORT_mask) begin
      dataArray_11_3[dataArray_11_3_MPORT_addr] <= dataArray_11_3_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_11_3_MPORT_1_en & dataArray_11_3_MPORT_1_mask) begin
      dataArray_11_3[dataArray_11_3_MPORT_1_addr] <= dataArray_11_3_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_11_3_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_11_3_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_11_3_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_11_3_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_11_3_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_11_3_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_12_0_MPORT_en & dataArray_12_0_MPORT_mask) begin
      dataArray_12_0[dataArray_12_0_MPORT_addr] <= dataArray_12_0_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_12_0_MPORT_1_en & dataArray_12_0_MPORT_1_mask) begin
      dataArray_12_0[dataArray_12_0_MPORT_1_addr] <= dataArray_12_0_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_12_0_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_12_0_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_12_0_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_12_0_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_12_0_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_12_0_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_12_1_MPORT_en & dataArray_12_1_MPORT_mask) begin
      dataArray_12_1[dataArray_12_1_MPORT_addr] <= dataArray_12_1_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_12_1_MPORT_1_en & dataArray_12_1_MPORT_1_mask) begin
      dataArray_12_1[dataArray_12_1_MPORT_1_addr] <= dataArray_12_1_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_12_1_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_12_1_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_12_1_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_12_1_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_12_1_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_12_1_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_12_2_MPORT_en & dataArray_12_2_MPORT_mask) begin
      dataArray_12_2[dataArray_12_2_MPORT_addr] <= dataArray_12_2_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_12_2_MPORT_1_en & dataArray_12_2_MPORT_1_mask) begin
      dataArray_12_2[dataArray_12_2_MPORT_1_addr] <= dataArray_12_2_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_12_2_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_12_2_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_12_2_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_12_2_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_12_2_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_12_2_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_12_3_MPORT_en & dataArray_12_3_MPORT_mask) begin
      dataArray_12_3[dataArray_12_3_MPORT_addr] <= dataArray_12_3_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_12_3_MPORT_1_en & dataArray_12_3_MPORT_1_mask) begin
      dataArray_12_3[dataArray_12_3_MPORT_1_addr] <= dataArray_12_3_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_12_3_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_12_3_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_12_3_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_12_3_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_12_3_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_12_3_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_13_0_MPORT_en & dataArray_13_0_MPORT_mask) begin
      dataArray_13_0[dataArray_13_0_MPORT_addr] <= dataArray_13_0_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_13_0_MPORT_1_en & dataArray_13_0_MPORT_1_mask) begin
      dataArray_13_0[dataArray_13_0_MPORT_1_addr] <= dataArray_13_0_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_13_0_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_13_0_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_13_0_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_13_0_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_13_0_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_13_0_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_13_1_MPORT_en & dataArray_13_1_MPORT_mask) begin
      dataArray_13_1[dataArray_13_1_MPORT_addr] <= dataArray_13_1_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_13_1_MPORT_1_en & dataArray_13_1_MPORT_1_mask) begin
      dataArray_13_1[dataArray_13_1_MPORT_1_addr] <= dataArray_13_1_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_13_1_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_13_1_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_13_1_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_13_1_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_13_1_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_13_1_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_13_2_MPORT_en & dataArray_13_2_MPORT_mask) begin
      dataArray_13_2[dataArray_13_2_MPORT_addr] <= dataArray_13_2_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_13_2_MPORT_1_en & dataArray_13_2_MPORT_1_mask) begin
      dataArray_13_2[dataArray_13_2_MPORT_1_addr] <= dataArray_13_2_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_13_2_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_13_2_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_13_2_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_13_2_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_13_2_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_13_2_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_13_3_MPORT_en & dataArray_13_3_MPORT_mask) begin
      dataArray_13_3[dataArray_13_3_MPORT_addr] <= dataArray_13_3_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_13_3_MPORT_1_en & dataArray_13_3_MPORT_1_mask) begin
      dataArray_13_3[dataArray_13_3_MPORT_1_addr] <= dataArray_13_3_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_13_3_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_13_3_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_13_3_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_13_3_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_13_3_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_13_3_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_14_0_MPORT_en & dataArray_14_0_MPORT_mask) begin
      dataArray_14_0[dataArray_14_0_MPORT_addr] <= dataArray_14_0_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_14_0_MPORT_1_en & dataArray_14_0_MPORT_1_mask) begin
      dataArray_14_0[dataArray_14_0_MPORT_1_addr] <= dataArray_14_0_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_14_0_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_14_0_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_14_0_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_14_0_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_14_0_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_14_0_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_14_1_MPORT_en & dataArray_14_1_MPORT_mask) begin
      dataArray_14_1[dataArray_14_1_MPORT_addr] <= dataArray_14_1_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_14_1_MPORT_1_en & dataArray_14_1_MPORT_1_mask) begin
      dataArray_14_1[dataArray_14_1_MPORT_1_addr] <= dataArray_14_1_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_14_1_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_14_1_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_14_1_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_14_1_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_14_1_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_14_1_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_14_2_MPORT_en & dataArray_14_2_MPORT_mask) begin
      dataArray_14_2[dataArray_14_2_MPORT_addr] <= dataArray_14_2_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_14_2_MPORT_1_en & dataArray_14_2_MPORT_1_mask) begin
      dataArray_14_2[dataArray_14_2_MPORT_1_addr] <= dataArray_14_2_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_14_2_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_14_2_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_14_2_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_14_2_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_14_2_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_14_2_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_14_3_MPORT_en & dataArray_14_3_MPORT_mask) begin
      dataArray_14_3[dataArray_14_3_MPORT_addr] <= dataArray_14_3_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_14_3_MPORT_1_en & dataArray_14_3_MPORT_1_mask) begin
      dataArray_14_3[dataArray_14_3_MPORT_1_addr] <= dataArray_14_3_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_14_3_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_14_3_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_14_3_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_14_3_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_14_3_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_14_3_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_15_0_MPORT_en & dataArray_15_0_MPORT_mask) begin
      dataArray_15_0[dataArray_15_0_MPORT_addr] <= dataArray_15_0_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_15_0_MPORT_1_en & dataArray_15_0_MPORT_1_mask) begin
      dataArray_15_0[dataArray_15_0_MPORT_1_addr] <= dataArray_15_0_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_15_0_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_15_0_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_15_0_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_15_0_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_15_0_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_15_0_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_15_1_MPORT_en & dataArray_15_1_MPORT_mask) begin
      dataArray_15_1[dataArray_15_1_MPORT_addr] <= dataArray_15_1_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_15_1_MPORT_1_en & dataArray_15_1_MPORT_1_mask) begin
      dataArray_15_1[dataArray_15_1_MPORT_1_addr] <= dataArray_15_1_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_15_1_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_15_1_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_15_1_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_15_1_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_15_1_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_15_1_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_15_2_MPORT_en & dataArray_15_2_MPORT_mask) begin
      dataArray_15_2[dataArray_15_2_MPORT_addr] <= dataArray_15_2_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_15_2_MPORT_1_en & dataArray_15_2_MPORT_1_mask) begin
      dataArray_15_2[dataArray_15_2_MPORT_1_addr] <= dataArray_15_2_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_15_2_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_15_2_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_15_2_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_15_2_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_15_2_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_15_2_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (dataArray_15_3_MPORT_en & dataArray_15_3_MPORT_mask) begin
      dataArray_15_3[dataArray_15_3_MPORT_addr] <= dataArray_15_3_MPORT_data; // @[dcache.scala 29:33]
    end
    if (dataArray_15_3_MPORT_1_en & dataArray_15_3_MPORT_1_mask) begin
      dataArray_15_3[dataArray_15_3_MPORT_1_addr] <= dataArray_15_3_MPORT_1_data; // @[dcache.scala 29:33]
    end
    dataArray_15_3_cachedata_MPORT_en_pipe_0 <= 1'h0;
    if (1'h0) begin
      dataArray_15_3_cachedata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_15_3_outdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_15_3_outdata_MPORT_addr_pipe_0 <= _GEN_47 == tag;
    end
    dataArray_15_3_toMemData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      dataArray_15_3_toMemData_MPORT_addr_pipe_0 <= replace_set;
    end
    if (reset) begin // @[dcache.scala 19:30]
      replace_set <= 1'h0; // @[dcache.scala 19:30]
    end else if (4'h0 == state_dcache) begin // @[dcache.scala 50:27]
      if (_T_1) begin // @[dcache.scala 52:34]
        if (!(hit)) begin // @[dcache.scala 53:28]
          replace_set <= random_num; // @[dcache.scala 56:34]
        end
      end
    end
    if (reset) begin // @[dcache.scala 26:29]
      random_num <= 1'h0; // @[dcache.scala 26:29]
    end else begin
      random_num <= random_num + 1'h1; // @[dcache.scala 27:20]
    end
    if (reset) begin // @[dcache.scala 30:29]
      tagArray_0_0 <= 24'h0; // @[dcache.scala 30:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        if (_GEN_1086 & _GEN_1116) begin // @[dcache.scala 108:50]
          tagArray_0_0 <= tag; // @[dcache.scala 108:50]
        end
      end
    end
    if (reset) begin // @[dcache.scala 30:29]
      tagArray_0_1 <= 24'h0; // @[dcache.scala 30:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        if (_GEN_1086 & _GEN_1087) begin // @[dcache.scala 108:50]
          tagArray_0_1 <= tag; // @[dcache.scala 108:50]
        end
      end
    end
    if (reset) begin // @[dcache.scala 30:29]
      tagArray_0_2 <= 24'h0; // @[dcache.scala 30:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        if (_GEN_1086 & _GEN_1089) begin // @[dcache.scala 108:50]
          tagArray_0_2 <= tag; // @[dcache.scala 108:50]
        end
      end
    end
    if (reset) begin // @[dcache.scala 30:29]
      tagArray_0_3 <= 24'h0; // @[dcache.scala 30:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        if (_GEN_1086 & _GEN_1091) begin // @[dcache.scala 108:50]
          tagArray_0_3 <= tag; // @[dcache.scala 108:50]
        end
      end
    end
    if (reset) begin // @[dcache.scala 30:29]
      tagArray_0_4 <= 24'h0; // @[dcache.scala 30:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        if (_GEN_1086 & _GEN_1093) begin // @[dcache.scala 108:50]
          tagArray_0_4 <= tag; // @[dcache.scala 108:50]
        end
      end
    end
    if (reset) begin // @[dcache.scala 30:29]
      tagArray_0_5 <= 24'h0; // @[dcache.scala 30:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        if (_GEN_1086 & _GEN_1095) begin // @[dcache.scala 108:50]
          tagArray_0_5 <= tag; // @[dcache.scala 108:50]
        end
      end
    end
    if (reset) begin // @[dcache.scala 30:29]
      tagArray_0_6 <= 24'h0; // @[dcache.scala 30:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        if (_GEN_1086 & _GEN_1097) begin // @[dcache.scala 108:50]
          tagArray_0_6 <= tag; // @[dcache.scala 108:50]
        end
      end
    end
    if (reset) begin // @[dcache.scala 30:29]
      tagArray_0_7 <= 24'h0; // @[dcache.scala 30:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        if (_GEN_1086 & _GEN_1099) begin // @[dcache.scala 108:50]
          tagArray_0_7 <= tag; // @[dcache.scala 108:50]
        end
      end
    end
    if (reset) begin // @[dcache.scala 30:29]
      tagArray_0_8 <= 24'h0; // @[dcache.scala 30:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        if (_GEN_1086 & _GEN_1101) begin // @[dcache.scala 108:50]
          tagArray_0_8 <= tag; // @[dcache.scala 108:50]
        end
      end
    end
    if (reset) begin // @[dcache.scala 30:29]
      tagArray_0_9 <= 24'h0; // @[dcache.scala 30:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        if (_GEN_1086 & _GEN_1103) begin // @[dcache.scala 108:50]
          tagArray_0_9 <= tag; // @[dcache.scala 108:50]
        end
      end
    end
    if (reset) begin // @[dcache.scala 30:29]
      tagArray_0_10 <= 24'h0; // @[dcache.scala 30:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        if (_GEN_1086 & _GEN_1105) begin // @[dcache.scala 108:50]
          tagArray_0_10 <= tag; // @[dcache.scala 108:50]
        end
      end
    end
    if (reset) begin // @[dcache.scala 30:29]
      tagArray_0_11 <= 24'h0; // @[dcache.scala 30:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        if (_GEN_1086 & _GEN_1107) begin // @[dcache.scala 108:50]
          tagArray_0_11 <= tag; // @[dcache.scala 108:50]
        end
      end
    end
    if (reset) begin // @[dcache.scala 30:29]
      tagArray_0_12 <= 24'h0; // @[dcache.scala 30:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        if (_GEN_1086 & _GEN_1109) begin // @[dcache.scala 108:50]
          tagArray_0_12 <= tag; // @[dcache.scala 108:50]
        end
      end
    end
    if (reset) begin // @[dcache.scala 30:29]
      tagArray_0_13 <= 24'h0; // @[dcache.scala 30:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        if (_GEN_1086 & _GEN_1111) begin // @[dcache.scala 108:50]
          tagArray_0_13 <= tag; // @[dcache.scala 108:50]
        end
      end
    end
    if (reset) begin // @[dcache.scala 30:29]
      tagArray_0_14 <= 24'h0; // @[dcache.scala 30:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        if (_GEN_1086 & _GEN_1113) begin // @[dcache.scala 108:50]
          tagArray_0_14 <= tag; // @[dcache.scala 108:50]
        end
      end
    end
    if (reset) begin // @[dcache.scala 30:29]
      tagArray_0_15 <= 24'h0; // @[dcache.scala 30:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        if (_GEN_1086 & _GEN_1115) begin // @[dcache.scala 108:50]
          tagArray_0_15 <= tag; // @[dcache.scala 108:50]
        end
      end
    end
    if (reset) begin // @[dcache.scala 30:29]
      tagArray_1_0 <= 24'h0; // @[dcache.scala 30:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        if (replace_set & _GEN_1116) begin // @[dcache.scala 108:50]
          tagArray_1_0 <= tag; // @[dcache.scala 108:50]
        end
      end
    end
    if (reset) begin // @[dcache.scala 30:29]
      tagArray_1_1 <= 24'h0; // @[dcache.scala 30:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        if (replace_set & _GEN_1087) begin // @[dcache.scala 108:50]
          tagArray_1_1 <= tag; // @[dcache.scala 108:50]
        end
      end
    end
    if (reset) begin // @[dcache.scala 30:29]
      tagArray_1_2 <= 24'h0; // @[dcache.scala 30:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        if (replace_set & _GEN_1089) begin // @[dcache.scala 108:50]
          tagArray_1_2 <= tag; // @[dcache.scala 108:50]
        end
      end
    end
    if (reset) begin // @[dcache.scala 30:29]
      tagArray_1_3 <= 24'h0; // @[dcache.scala 30:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        if (replace_set & _GEN_1091) begin // @[dcache.scala 108:50]
          tagArray_1_3 <= tag; // @[dcache.scala 108:50]
        end
      end
    end
    if (reset) begin // @[dcache.scala 30:29]
      tagArray_1_4 <= 24'h0; // @[dcache.scala 30:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        if (replace_set & _GEN_1093) begin // @[dcache.scala 108:50]
          tagArray_1_4 <= tag; // @[dcache.scala 108:50]
        end
      end
    end
    if (reset) begin // @[dcache.scala 30:29]
      tagArray_1_5 <= 24'h0; // @[dcache.scala 30:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        if (replace_set & _GEN_1095) begin // @[dcache.scala 108:50]
          tagArray_1_5 <= tag; // @[dcache.scala 108:50]
        end
      end
    end
    if (reset) begin // @[dcache.scala 30:29]
      tagArray_1_6 <= 24'h0; // @[dcache.scala 30:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        if (replace_set & _GEN_1097) begin // @[dcache.scala 108:50]
          tagArray_1_6 <= tag; // @[dcache.scala 108:50]
        end
      end
    end
    if (reset) begin // @[dcache.scala 30:29]
      tagArray_1_7 <= 24'h0; // @[dcache.scala 30:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        if (replace_set & _GEN_1099) begin // @[dcache.scala 108:50]
          tagArray_1_7 <= tag; // @[dcache.scala 108:50]
        end
      end
    end
    if (reset) begin // @[dcache.scala 30:29]
      tagArray_1_8 <= 24'h0; // @[dcache.scala 30:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        if (replace_set & _GEN_1101) begin // @[dcache.scala 108:50]
          tagArray_1_8 <= tag; // @[dcache.scala 108:50]
        end
      end
    end
    if (reset) begin // @[dcache.scala 30:29]
      tagArray_1_9 <= 24'h0; // @[dcache.scala 30:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        if (replace_set & _GEN_1103) begin // @[dcache.scala 108:50]
          tagArray_1_9 <= tag; // @[dcache.scala 108:50]
        end
      end
    end
    if (reset) begin // @[dcache.scala 30:29]
      tagArray_1_10 <= 24'h0; // @[dcache.scala 30:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        if (replace_set & _GEN_1105) begin // @[dcache.scala 108:50]
          tagArray_1_10 <= tag; // @[dcache.scala 108:50]
        end
      end
    end
    if (reset) begin // @[dcache.scala 30:29]
      tagArray_1_11 <= 24'h0; // @[dcache.scala 30:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        if (replace_set & _GEN_1107) begin // @[dcache.scala 108:50]
          tagArray_1_11 <= tag; // @[dcache.scala 108:50]
        end
      end
    end
    if (reset) begin // @[dcache.scala 30:29]
      tagArray_1_12 <= 24'h0; // @[dcache.scala 30:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        if (replace_set & _GEN_1109) begin // @[dcache.scala 108:50]
          tagArray_1_12 <= tag; // @[dcache.scala 108:50]
        end
      end
    end
    if (reset) begin // @[dcache.scala 30:29]
      tagArray_1_13 <= 24'h0; // @[dcache.scala 30:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        if (replace_set & _GEN_1111) begin // @[dcache.scala 108:50]
          tagArray_1_13 <= tag; // @[dcache.scala 108:50]
        end
      end
    end
    if (reset) begin // @[dcache.scala 30:29]
      tagArray_1_14 <= 24'h0; // @[dcache.scala 30:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        if (replace_set & _GEN_1113) begin // @[dcache.scala 108:50]
          tagArray_1_14 <= tag; // @[dcache.scala 108:50]
        end
      end
    end
    if (reset) begin // @[dcache.scala 30:29]
      tagArray_1_15 <= 24'h0; // @[dcache.scala 30:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        if (replace_set & _GEN_1115) begin // @[dcache.scala 108:50]
          tagArray_1_15 <= tag; // @[dcache.scala 108:50]
        end
      end
    end
    if (reset) begin // @[dcache.scala 31:29]
      validArray_0_0 <= 1'h0; // @[dcache.scala 31:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        validArray_0_0 <= _GEN_248;
      end
    end
    if (reset) begin // @[dcache.scala 31:29]
      validArray_0_1 <= 1'h0; // @[dcache.scala 31:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        validArray_0_1 <= _GEN_249;
      end
    end
    if (reset) begin // @[dcache.scala 31:29]
      validArray_0_2 <= 1'h0; // @[dcache.scala 31:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        validArray_0_2 <= _GEN_250;
      end
    end
    if (reset) begin // @[dcache.scala 31:29]
      validArray_0_3 <= 1'h0; // @[dcache.scala 31:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        validArray_0_3 <= _GEN_251;
      end
    end
    if (reset) begin // @[dcache.scala 31:29]
      validArray_0_4 <= 1'h0; // @[dcache.scala 31:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        validArray_0_4 <= _GEN_252;
      end
    end
    if (reset) begin // @[dcache.scala 31:29]
      validArray_0_5 <= 1'h0; // @[dcache.scala 31:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        validArray_0_5 <= _GEN_253;
      end
    end
    if (reset) begin // @[dcache.scala 31:29]
      validArray_0_6 <= 1'h0; // @[dcache.scala 31:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        validArray_0_6 <= _GEN_254;
      end
    end
    if (reset) begin // @[dcache.scala 31:29]
      validArray_0_7 <= 1'h0; // @[dcache.scala 31:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        validArray_0_7 <= _GEN_255;
      end
    end
    if (reset) begin // @[dcache.scala 31:29]
      validArray_0_8 <= 1'h0; // @[dcache.scala 31:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        validArray_0_8 <= _GEN_256;
      end
    end
    if (reset) begin // @[dcache.scala 31:29]
      validArray_0_9 <= 1'h0; // @[dcache.scala 31:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        validArray_0_9 <= _GEN_257;
      end
    end
    if (reset) begin // @[dcache.scala 31:29]
      validArray_0_10 <= 1'h0; // @[dcache.scala 31:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        validArray_0_10 <= _GEN_258;
      end
    end
    if (reset) begin // @[dcache.scala 31:29]
      validArray_0_11 <= 1'h0; // @[dcache.scala 31:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        validArray_0_11 <= _GEN_259;
      end
    end
    if (reset) begin // @[dcache.scala 31:29]
      validArray_0_12 <= 1'h0; // @[dcache.scala 31:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        validArray_0_12 <= _GEN_260;
      end
    end
    if (reset) begin // @[dcache.scala 31:29]
      validArray_0_13 <= 1'h0; // @[dcache.scala 31:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        validArray_0_13 <= _GEN_261;
      end
    end
    if (reset) begin // @[dcache.scala 31:29]
      validArray_0_14 <= 1'h0; // @[dcache.scala 31:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        validArray_0_14 <= _GEN_262;
      end
    end
    if (reset) begin // @[dcache.scala 31:29]
      validArray_0_15 <= 1'h0; // @[dcache.scala 31:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        validArray_0_15 <= _GEN_263;
      end
    end
    if (reset) begin // @[dcache.scala 31:29]
      validArray_1_0 <= 1'h0; // @[dcache.scala 31:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        validArray_1_0 <= _GEN_264;
      end
    end
    if (reset) begin // @[dcache.scala 31:29]
      validArray_1_1 <= 1'h0; // @[dcache.scala 31:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        validArray_1_1 <= _GEN_265;
      end
    end
    if (reset) begin // @[dcache.scala 31:29]
      validArray_1_2 <= 1'h0; // @[dcache.scala 31:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        validArray_1_2 <= _GEN_266;
      end
    end
    if (reset) begin // @[dcache.scala 31:29]
      validArray_1_3 <= 1'h0; // @[dcache.scala 31:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        validArray_1_3 <= _GEN_267;
      end
    end
    if (reset) begin // @[dcache.scala 31:29]
      validArray_1_4 <= 1'h0; // @[dcache.scala 31:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        validArray_1_4 <= _GEN_268;
      end
    end
    if (reset) begin // @[dcache.scala 31:29]
      validArray_1_5 <= 1'h0; // @[dcache.scala 31:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        validArray_1_5 <= _GEN_269;
      end
    end
    if (reset) begin // @[dcache.scala 31:29]
      validArray_1_6 <= 1'h0; // @[dcache.scala 31:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        validArray_1_6 <= _GEN_270;
      end
    end
    if (reset) begin // @[dcache.scala 31:29]
      validArray_1_7 <= 1'h0; // @[dcache.scala 31:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        validArray_1_7 <= _GEN_271;
      end
    end
    if (reset) begin // @[dcache.scala 31:29]
      validArray_1_8 <= 1'h0; // @[dcache.scala 31:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        validArray_1_8 <= _GEN_272;
      end
    end
    if (reset) begin // @[dcache.scala 31:29]
      validArray_1_9 <= 1'h0; // @[dcache.scala 31:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        validArray_1_9 <= _GEN_273;
      end
    end
    if (reset) begin // @[dcache.scala 31:29]
      validArray_1_10 <= 1'h0; // @[dcache.scala 31:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        validArray_1_10 <= _GEN_274;
      end
    end
    if (reset) begin // @[dcache.scala 31:29]
      validArray_1_11 <= 1'h0; // @[dcache.scala 31:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        validArray_1_11 <= _GEN_275;
      end
    end
    if (reset) begin // @[dcache.scala 31:29]
      validArray_1_12 <= 1'h0; // @[dcache.scala 31:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        validArray_1_12 <= _GEN_276;
      end
    end
    if (reset) begin // @[dcache.scala 31:29]
      validArray_1_13 <= 1'h0; // @[dcache.scala 31:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        validArray_1_13 <= _GEN_277;
      end
    end
    if (reset) begin // @[dcache.scala 31:29]
      validArray_1_14 <= 1'h0; // @[dcache.scala 31:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        validArray_1_14 <= _GEN_278;
      end
    end
    if (reset) begin // @[dcache.scala 31:29]
      validArray_1_15 <= 1'h0; // @[dcache.scala 31:29]
    end else if (state_dcache == 4'h8 & _off_T_4) begin // @[dcache.scala 104:59]
      if (to_sram_r_bits_last) begin // @[dcache.scala 106:35]
        validArray_1_15 <= _GEN_279;
      end
    end
    if (reset) begin // @[dcache.scala 32:29]
      dirtyArray_0_0 <= 1'h0; // @[dcache.scala 32:29]
    end else if (state_dcache == 4'h2) begin // @[dcache.scala 117:39]
      dirtyArray_0_0 <= _GEN_763;
    end
    if (reset) begin // @[dcache.scala 32:29]
      dirtyArray_0_1 <= 1'h0; // @[dcache.scala 32:29]
    end else if (state_dcache == 4'h2) begin // @[dcache.scala 117:39]
      dirtyArray_0_1 <= _GEN_764;
    end
    if (reset) begin // @[dcache.scala 32:29]
      dirtyArray_0_2 <= 1'h0; // @[dcache.scala 32:29]
    end else if (state_dcache == 4'h2) begin // @[dcache.scala 117:39]
      dirtyArray_0_2 <= _GEN_765;
    end
    if (reset) begin // @[dcache.scala 32:29]
      dirtyArray_0_3 <= 1'h0; // @[dcache.scala 32:29]
    end else if (state_dcache == 4'h2) begin // @[dcache.scala 117:39]
      dirtyArray_0_3 <= _GEN_766;
    end
    if (reset) begin // @[dcache.scala 32:29]
      dirtyArray_0_4 <= 1'h0; // @[dcache.scala 32:29]
    end else if (state_dcache == 4'h2) begin // @[dcache.scala 117:39]
      dirtyArray_0_4 <= _GEN_767;
    end
    if (reset) begin // @[dcache.scala 32:29]
      dirtyArray_0_5 <= 1'h0; // @[dcache.scala 32:29]
    end else if (state_dcache == 4'h2) begin // @[dcache.scala 117:39]
      dirtyArray_0_5 <= _GEN_768;
    end
    if (reset) begin // @[dcache.scala 32:29]
      dirtyArray_0_6 <= 1'h0; // @[dcache.scala 32:29]
    end else if (state_dcache == 4'h2) begin // @[dcache.scala 117:39]
      dirtyArray_0_6 <= _GEN_769;
    end
    if (reset) begin // @[dcache.scala 32:29]
      dirtyArray_0_7 <= 1'h0; // @[dcache.scala 32:29]
    end else if (state_dcache == 4'h2) begin // @[dcache.scala 117:39]
      dirtyArray_0_7 <= _GEN_770;
    end
    if (reset) begin // @[dcache.scala 32:29]
      dirtyArray_0_8 <= 1'h0; // @[dcache.scala 32:29]
    end else if (state_dcache == 4'h2) begin // @[dcache.scala 117:39]
      dirtyArray_0_8 <= _GEN_771;
    end
    if (reset) begin // @[dcache.scala 32:29]
      dirtyArray_0_9 <= 1'h0; // @[dcache.scala 32:29]
    end else if (state_dcache == 4'h2) begin // @[dcache.scala 117:39]
      dirtyArray_0_9 <= _GEN_772;
    end
    if (reset) begin // @[dcache.scala 32:29]
      dirtyArray_0_10 <= 1'h0; // @[dcache.scala 32:29]
    end else if (state_dcache == 4'h2) begin // @[dcache.scala 117:39]
      dirtyArray_0_10 <= _GEN_773;
    end
    if (reset) begin // @[dcache.scala 32:29]
      dirtyArray_0_11 <= 1'h0; // @[dcache.scala 32:29]
    end else if (state_dcache == 4'h2) begin // @[dcache.scala 117:39]
      dirtyArray_0_11 <= _GEN_774;
    end
    if (reset) begin // @[dcache.scala 32:29]
      dirtyArray_0_12 <= 1'h0; // @[dcache.scala 32:29]
    end else if (state_dcache == 4'h2) begin // @[dcache.scala 117:39]
      dirtyArray_0_12 <= _GEN_775;
    end
    if (reset) begin // @[dcache.scala 32:29]
      dirtyArray_0_13 <= 1'h0; // @[dcache.scala 32:29]
    end else if (state_dcache == 4'h2) begin // @[dcache.scala 117:39]
      dirtyArray_0_13 <= _GEN_776;
    end
    if (reset) begin // @[dcache.scala 32:29]
      dirtyArray_0_14 <= 1'h0; // @[dcache.scala 32:29]
    end else if (state_dcache == 4'h2) begin // @[dcache.scala 117:39]
      dirtyArray_0_14 <= _GEN_777;
    end
    if (reset) begin // @[dcache.scala 32:29]
      dirtyArray_0_15 <= 1'h0; // @[dcache.scala 32:29]
    end else if (state_dcache == 4'h2) begin // @[dcache.scala 117:39]
      dirtyArray_0_15 <= _GEN_778;
    end
    if (reset) begin // @[dcache.scala 32:29]
      dirtyArray_1_0 <= 1'h0; // @[dcache.scala 32:29]
    end else if (state_dcache == 4'h2) begin // @[dcache.scala 117:39]
      dirtyArray_1_0 <= _GEN_779;
    end
    if (reset) begin // @[dcache.scala 32:29]
      dirtyArray_1_1 <= 1'h0; // @[dcache.scala 32:29]
    end else if (state_dcache == 4'h2) begin // @[dcache.scala 117:39]
      dirtyArray_1_1 <= _GEN_780;
    end
    if (reset) begin // @[dcache.scala 32:29]
      dirtyArray_1_2 <= 1'h0; // @[dcache.scala 32:29]
    end else if (state_dcache == 4'h2) begin // @[dcache.scala 117:39]
      dirtyArray_1_2 <= _GEN_781;
    end
    if (reset) begin // @[dcache.scala 32:29]
      dirtyArray_1_3 <= 1'h0; // @[dcache.scala 32:29]
    end else if (state_dcache == 4'h2) begin // @[dcache.scala 117:39]
      dirtyArray_1_3 <= _GEN_782;
    end
    if (reset) begin // @[dcache.scala 32:29]
      dirtyArray_1_4 <= 1'h0; // @[dcache.scala 32:29]
    end else if (state_dcache == 4'h2) begin // @[dcache.scala 117:39]
      dirtyArray_1_4 <= _GEN_783;
    end
    if (reset) begin // @[dcache.scala 32:29]
      dirtyArray_1_5 <= 1'h0; // @[dcache.scala 32:29]
    end else if (state_dcache == 4'h2) begin // @[dcache.scala 117:39]
      dirtyArray_1_5 <= _GEN_784;
    end
    if (reset) begin // @[dcache.scala 32:29]
      dirtyArray_1_6 <= 1'h0; // @[dcache.scala 32:29]
    end else if (state_dcache == 4'h2) begin // @[dcache.scala 117:39]
      dirtyArray_1_6 <= _GEN_785;
    end
    if (reset) begin // @[dcache.scala 32:29]
      dirtyArray_1_7 <= 1'h0; // @[dcache.scala 32:29]
    end else if (state_dcache == 4'h2) begin // @[dcache.scala 117:39]
      dirtyArray_1_7 <= _GEN_786;
    end
    if (reset) begin // @[dcache.scala 32:29]
      dirtyArray_1_8 <= 1'h0; // @[dcache.scala 32:29]
    end else if (state_dcache == 4'h2) begin // @[dcache.scala 117:39]
      dirtyArray_1_8 <= _GEN_787;
    end
    if (reset) begin // @[dcache.scala 32:29]
      dirtyArray_1_9 <= 1'h0; // @[dcache.scala 32:29]
    end else if (state_dcache == 4'h2) begin // @[dcache.scala 117:39]
      dirtyArray_1_9 <= _GEN_788;
    end
    if (reset) begin // @[dcache.scala 32:29]
      dirtyArray_1_10 <= 1'h0; // @[dcache.scala 32:29]
    end else if (state_dcache == 4'h2) begin // @[dcache.scala 117:39]
      dirtyArray_1_10 <= _GEN_789;
    end
    if (reset) begin // @[dcache.scala 32:29]
      dirtyArray_1_11 <= 1'h0; // @[dcache.scala 32:29]
    end else if (state_dcache == 4'h2) begin // @[dcache.scala 117:39]
      dirtyArray_1_11 <= _GEN_790;
    end
    if (reset) begin // @[dcache.scala 32:29]
      dirtyArray_1_12 <= 1'h0; // @[dcache.scala 32:29]
    end else if (state_dcache == 4'h2) begin // @[dcache.scala 117:39]
      dirtyArray_1_12 <= _GEN_791;
    end
    if (reset) begin // @[dcache.scala 32:29]
      dirtyArray_1_13 <= 1'h0; // @[dcache.scala 32:29]
    end else if (state_dcache == 4'h2) begin // @[dcache.scala 117:39]
      dirtyArray_1_13 <= _GEN_792;
    end
    if (reset) begin // @[dcache.scala 32:29]
      dirtyArray_1_14 <= 1'h0; // @[dcache.scala 32:29]
    end else if (state_dcache == 4'h2) begin // @[dcache.scala 117:39]
      dirtyArray_1_14 <= _GEN_793;
    end
    if (reset) begin // @[dcache.scala 32:29]
      dirtyArray_1_15 <= 1'h0; // @[dcache.scala 32:29]
    end else if (state_dcache == 4'h2) begin // @[dcache.scala 117:39]
      dirtyArray_1_15 <= _GEN_794;
    end
    if (reset) begin // @[dcache.scala 46:24]
      off <= 2'h0; // @[dcache.scala 46:24]
    end else if (!(4'h0 == state_dcache)) begin // @[dcache.scala 50:27]
      if (!(4'h1 == state_dcache)) begin // @[dcache.scala 50:27]
        if (!(4'h2 == state_dcache)) begin // @[dcache.scala 50:27]
          off <= _GEN_112;
        end
      end
    end
    if (reset) begin // @[dcache.scala 49:31]
      state_dcache <= 4'h0; // @[dcache.scala 49:31]
    end else if (4'h0 == state_dcache) begin // @[dcache.scala 50:27]
      if (_T_1) begin // @[dcache.scala 52:34]
        if (hit) begin // @[dcache.scala 53:28]
          state_dcache <= _state_dcache_T; // @[dcache.scala 54:34]
        end else begin
          state_dcache <= 4'h3; // @[dcache.scala 57:34]
        end
      end else begin
        state_dcache <= 4'h0; // @[dcache.scala 60:30]
      end
    end else if (4'h1 == state_dcache) begin // @[dcache.scala 50:27]
      state_dcache <= 4'h0; // @[dcache.scala 64:26]
    end else if (4'h2 == state_dcache) begin // @[dcache.scala 50:27]
      state_dcache <= 4'h0; // @[dcache.scala 67:26]
    end else begin
      state_dcache <= _GEN_111;
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
  _RAND_7 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_0_1[initvar] = _RAND_7[31:0];
  _RAND_14 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_0_2[initvar] = _RAND_14[31:0];
  _RAND_21 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_0_3[initvar] = _RAND_21[31:0];
  _RAND_28 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_1_0[initvar] = _RAND_28[31:0];
  _RAND_35 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_1_1[initvar] = _RAND_35[31:0];
  _RAND_42 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_1_2[initvar] = _RAND_42[31:0];
  _RAND_49 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_1_3[initvar] = _RAND_49[31:0];
  _RAND_56 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_2_0[initvar] = _RAND_56[31:0];
  _RAND_63 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_2_1[initvar] = _RAND_63[31:0];
  _RAND_70 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_2_2[initvar] = _RAND_70[31:0];
  _RAND_77 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_2_3[initvar] = _RAND_77[31:0];
  _RAND_84 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_3_0[initvar] = _RAND_84[31:0];
  _RAND_91 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_3_1[initvar] = _RAND_91[31:0];
  _RAND_98 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_3_2[initvar] = _RAND_98[31:0];
  _RAND_105 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_3_3[initvar] = _RAND_105[31:0];
  _RAND_112 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_4_0[initvar] = _RAND_112[31:0];
  _RAND_119 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_4_1[initvar] = _RAND_119[31:0];
  _RAND_126 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_4_2[initvar] = _RAND_126[31:0];
  _RAND_133 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_4_3[initvar] = _RAND_133[31:0];
  _RAND_140 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_5_0[initvar] = _RAND_140[31:0];
  _RAND_147 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_5_1[initvar] = _RAND_147[31:0];
  _RAND_154 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_5_2[initvar] = _RAND_154[31:0];
  _RAND_161 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_5_3[initvar] = _RAND_161[31:0];
  _RAND_168 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_6_0[initvar] = _RAND_168[31:0];
  _RAND_175 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_6_1[initvar] = _RAND_175[31:0];
  _RAND_182 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_6_2[initvar] = _RAND_182[31:0];
  _RAND_189 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_6_3[initvar] = _RAND_189[31:0];
  _RAND_196 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_7_0[initvar] = _RAND_196[31:0];
  _RAND_203 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_7_1[initvar] = _RAND_203[31:0];
  _RAND_210 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_7_2[initvar] = _RAND_210[31:0];
  _RAND_217 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_7_3[initvar] = _RAND_217[31:0];
  _RAND_224 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_8_0[initvar] = _RAND_224[31:0];
  _RAND_231 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_8_1[initvar] = _RAND_231[31:0];
  _RAND_238 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_8_2[initvar] = _RAND_238[31:0];
  _RAND_245 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_8_3[initvar] = _RAND_245[31:0];
  _RAND_252 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_9_0[initvar] = _RAND_252[31:0];
  _RAND_259 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_9_1[initvar] = _RAND_259[31:0];
  _RAND_266 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_9_2[initvar] = _RAND_266[31:0];
  _RAND_273 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_9_3[initvar] = _RAND_273[31:0];
  _RAND_280 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_10_0[initvar] = _RAND_280[31:0];
  _RAND_287 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_10_1[initvar] = _RAND_287[31:0];
  _RAND_294 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_10_2[initvar] = _RAND_294[31:0];
  _RAND_301 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_10_3[initvar] = _RAND_301[31:0];
  _RAND_308 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_11_0[initvar] = _RAND_308[31:0];
  _RAND_315 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_11_1[initvar] = _RAND_315[31:0];
  _RAND_322 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_11_2[initvar] = _RAND_322[31:0];
  _RAND_329 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_11_3[initvar] = _RAND_329[31:0];
  _RAND_336 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_12_0[initvar] = _RAND_336[31:0];
  _RAND_343 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_12_1[initvar] = _RAND_343[31:0];
  _RAND_350 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_12_2[initvar] = _RAND_350[31:0];
  _RAND_357 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_12_3[initvar] = _RAND_357[31:0];
  _RAND_364 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_13_0[initvar] = _RAND_364[31:0];
  _RAND_371 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_13_1[initvar] = _RAND_371[31:0];
  _RAND_378 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_13_2[initvar] = _RAND_378[31:0];
  _RAND_385 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_13_3[initvar] = _RAND_385[31:0];
  _RAND_392 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_14_0[initvar] = _RAND_392[31:0];
  _RAND_399 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_14_1[initvar] = _RAND_399[31:0];
  _RAND_406 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_14_2[initvar] = _RAND_406[31:0];
  _RAND_413 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_14_3[initvar] = _RAND_413[31:0];
  _RAND_420 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_15_0[initvar] = _RAND_420[31:0];
  _RAND_427 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_15_1[initvar] = _RAND_427[31:0];
  _RAND_434 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_15_2[initvar] = _RAND_434[31:0];
  _RAND_441 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    dataArray_15_3[initvar] = _RAND_441[31:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  dataArray_0_0_cachedata_MPORT_en_pipe_0 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  dataArray_0_0_cachedata_MPORT_addr_pipe_0 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  dataArray_0_0_outdata_MPORT_en_pipe_0 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  dataArray_0_0_outdata_MPORT_addr_pipe_0 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  dataArray_0_0_toMemData_MPORT_en_pipe_0 = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  dataArray_0_0_toMemData_MPORT_addr_pipe_0 = _RAND_6[0:0];
  _RAND_8 = {1{`RANDOM}};
  dataArray_0_1_cachedata_MPORT_en_pipe_0 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  dataArray_0_1_cachedata_MPORT_addr_pipe_0 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  dataArray_0_1_outdata_MPORT_en_pipe_0 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  dataArray_0_1_outdata_MPORT_addr_pipe_0 = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  dataArray_0_1_toMemData_MPORT_en_pipe_0 = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  dataArray_0_1_toMemData_MPORT_addr_pipe_0 = _RAND_13[0:0];
  _RAND_15 = {1{`RANDOM}};
  dataArray_0_2_cachedata_MPORT_en_pipe_0 = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  dataArray_0_2_cachedata_MPORT_addr_pipe_0 = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  dataArray_0_2_outdata_MPORT_en_pipe_0 = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  dataArray_0_2_outdata_MPORT_addr_pipe_0 = _RAND_18[0:0];
  _RAND_19 = {1{`RANDOM}};
  dataArray_0_2_toMemData_MPORT_en_pipe_0 = _RAND_19[0:0];
  _RAND_20 = {1{`RANDOM}};
  dataArray_0_2_toMemData_MPORT_addr_pipe_0 = _RAND_20[0:0];
  _RAND_22 = {1{`RANDOM}};
  dataArray_0_3_cachedata_MPORT_en_pipe_0 = _RAND_22[0:0];
  _RAND_23 = {1{`RANDOM}};
  dataArray_0_3_cachedata_MPORT_addr_pipe_0 = _RAND_23[0:0];
  _RAND_24 = {1{`RANDOM}};
  dataArray_0_3_outdata_MPORT_en_pipe_0 = _RAND_24[0:0];
  _RAND_25 = {1{`RANDOM}};
  dataArray_0_3_outdata_MPORT_addr_pipe_0 = _RAND_25[0:0];
  _RAND_26 = {1{`RANDOM}};
  dataArray_0_3_toMemData_MPORT_en_pipe_0 = _RAND_26[0:0];
  _RAND_27 = {1{`RANDOM}};
  dataArray_0_3_toMemData_MPORT_addr_pipe_0 = _RAND_27[0:0];
  _RAND_29 = {1{`RANDOM}};
  dataArray_1_0_cachedata_MPORT_en_pipe_0 = _RAND_29[0:0];
  _RAND_30 = {1{`RANDOM}};
  dataArray_1_0_cachedata_MPORT_addr_pipe_0 = _RAND_30[0:0];
  _RAND_31 = {1{`RANDOM}};
  dataArray_1_0_outdata_MPORT_en_pipe_0 = _RAND_31[0:0];
  _RAND_32 = {1{`RANDOM}};
  dataArray_1_0_outdata_MPORT_addr_pipe_0 = _RAND_32[0:0];
  _RAND_33 = {1{`RANDOM}};
  dataArray_1_0_toMemData_MPORT_en_pipe_0 = _RAND_33[0:0];
  _RAND_34 = {1{`RANDOM}};
  dataArray_1_0_toMemData_MPORT_addr_pipe_0 = _RAND_34[0:0];
  _RAND_36 = {1{`RANDOM}};
  dataArray_1_1_cachedata_MPORT_en_pipe_0 = _RAND_36[0:0];
  _RAND_37 = {1{`RANDOM}};
  dataArray_1_1_cachedata_MPORT_addr_pipe_0 = _RAND_37[0:0];
  _RAND_38 = {1{`RANDOM}};
  dataArray_1_1_outdata_MPORT_en_pipe_0 = _RAND_38[0:0];
  _RAND_39 = {1{`RANDOM}};
  dataArray_1_1_outdata_MPORT_addr_pipe_0 = _RAND_39[0:0];
  _RAND_40 = {1{`RANDOM}};
  dataArray_1_1_toMemData_MPORT_en_pipe_0 = _RAND_40[0:0];
  _RAND_41 = {1{`RANDOM}};
  dataArray_1_1_toMemData_MPORT_addr_pipe_0 = _RAND_41[0:0];
  _RAND_43 = {1{`RANDOM}};
  dataArray_1_2_cachedata_MPORT_en_pipe_0 = _RAND_43[0:0];
  _RAND_44 = {1{`RANDOM}};
  dataArray_1_2_cachedata_MPORT_addr_pipe_0 = _RAND_44[0:0];
  _RAND_45 = {1{`RANDOM}};
  dataArray_1_2_outdata_MPORT_en_pipe_0 = _RAND_45[0:0];
  _RAND_46 = {1{`RANDOM}};
  dataArray_1_2_outdata_MPORT_addr_pipe_0 = _RAND_46[0:0];
  _RAND_47 = {1{`RANDOM}};
  dataArray_1_2_toMemData_MPORT_en_pipe_0 = _RAND_47[0:0];
  _RAND_48 = {1{`RANDOM}};
  dataArray_1_2_toMemData_MPORT_addr_pipe_0 = _RAND_48[0:0];
  _RAND_50 = {1{`RANDOM}};
  dataArray_1_3_cachedata_MPORT_en_pipe_0 = _RAND_50[0:0];
  _RAND_51 = {1{`RANDOM}};
  dataArray_1_3_cachedata_MPORT_addr_pipe_0 = _RAND_51[0:0];
  _RAND_52 = {1{`RANDOM}};
  dataArray_1_3_outdata_MPORT_en_pipe_0 = _RAND_52[0:0];
  _RAND_53 = {1{`RANDOM}};
  dataArray_1_3_outdata_MPORT_addr_pipe_0 = _RAND_53[0:0];
  _RAND_54 = {1{`RANDOM}};
  dataArray_1_3_toMemData_MPORT_en_pipe_0 = _RAND_54[0:0];
  _RAND_55 = {1{`RANDOM}};
  dataArray_1_3_toMemData_MPORT_addr_pipe_0 = _RAND_55[0:0];
  _RAND_57 = {1{`RANDOM}};
  dataArray_2_0_cachedata_MPORT_en_pipe_0 = _RAND_57[0:0];
  _RAND_58 = {1{`RANDOM}};
  dataArray_2_0_cachedata_MPORT_addr_pipe_0 = _RAND_58[0:0];
  _RAND_59 = {1{`RANDOM}};
  dataArray_2_0_outdata_MPORT_en_pipe_0 = _RAND_59[0:0];
  _RAND_60 = {1{`RANDOM}};
  dataArray_2_0_outdata_MPORT_addr_pipe_0 = _RAND_60[0:0];
  _RAND_61 = {1{`RANDOM}};
  dataArray_2_0_toMemData_MPORT_en_pipe_0 = _RAND_61[0:0];
  _RAND_62 = {1{`RANDOM}};
  dataArray_2_0_toMemData_MPORT_addr_pipe_0 = _RAND_62[0:0];
  _RAND_64 = {1{`RANDOM}};
  dataArray_2_1_cachedata_MPORT_en_pipe_0 = _RAND_64[0:0];
  _RAND_65 = {1{`RANDOM}};
  dataArray_2_1_cachedata_MPORT_addr_pipe_0 = _RAND_65[0:0];
  _RAND_66 = {1{`RANDOM}};
  dataArray_2_1_outdata_MPORT_en_pipe_0 = _RAND_66[0:0];
  _RAND_67 = {1{`RANDOM}};
  dataArray_2_1_outdata_MPORT_addr_pipe_0 = _RAND_67[0:0];
  _RAND_68 = {1{`RANDOM}};
  dataArray_2_1_toMemData_MPORT_en_pipe_0 = _RAND_68[0:0];
  _RAND_69 = {1{`RANDOM}};
  dataArray_2_1_toMemData_MPORT_addr_pipe_0 = _RAND_69[0:0];
  _RAND_71 = {1{`RANDOM}};
  dataArray_2_2_cachedata_MPORT_en_pipe_0 = _RAND_71[0:0];
  _RAND_72 = {1{`RANDOM}};
  dataArray_2_2_cachedata_MPORT_addr_pipe_0 = _RAND_72[0:0];
  _RAND_73 = {1{`RANDOM}};
  dataArray_2_2_outdata_MPORT_en_pipe_0 = _RAND_73[0:0];
  _RAND_74 = {1{`RANDOM}};
  dataArray_2_2_outdata_MPORT_addr_pipe_0 = _RAND_74[0:0];
  _RAND_75 = {1{`RANDOM}};
  dataArray_2_2_toMemData_MPORT_en_pipe_0 = _RAND_75[0:0];
  _RAND_76 = {1{`RANDOM}};
  dataArray_2_2_toMemData_MPORT_addr_pipe_0 = _RAND_76[0:0];
  _RAND_78 = {1{`RANDOM}};
  dataArray_2_3_cachedata_MPORT_en_pipe_0 = _RAND_78[0:0];
  _RAND_79 = {1{`RANDOM}};
  dataArray_2_3_cachedata_MPORT_addr_pipe_0 = _RAND_79[0:0];
  _RAND_80 = {1{`RANDOM}};
  dataArray_2_3_outdata_MPORT_en_pipe_0 = _RAND_80[0:0];
  _RAND_81 = {1{`RANDOM}};
  dataArray_2_3_outdata_MPORT_addr_pipe_0 = _RAND_81[0:0];
  _RAND_82 = {1{`RANDOM}};
  dataArray_2_3_toMemData_MPORT_en_pipe_0 = _RAND_82[0:0];
  _RAND_83 = {1{`RANDOM}};
  dataArray_2_3_toMemData_MPORT_addr_pipe_0 = _RAND_83[0:0];
  _RAND_85 = {1{`RANDOM}};
  dataArray_3_0_cachedata_MPORT_en_pipe_0 = _RAND_85[0:0];
  _RAND_86 = {1{`RANDOM}};
  dataArray_3_0_cachedata_MPORT_addr_pipe_0 = _RAND_86[0:0];
  _RAND_87 = {1{`RANDOM}};
  dataArray_3_0_outdata_MPORT_en_pipe_0 = _RAND_87[0:0];
  _RAND_88 = {1{`RANDOM}};
  dataArray_3_0_outdata_MPORT_addr_pipe_0 = _RAND_88[0:0];
  _RAND_89 = {1{`RANDOM}};
  dataArray_3_0_toMemData_MPORT_en_pipe_0 = _RAND_89[0:0];
  _RAND_90 = {1{`RANDOM}};
  dataArray_3_0_toMemData_MPORT_addr_pipe_0 = _RAND_90[0:0];
  _RAND_92 = {1{`RANDOM}};
  dataArray_3_1_cachedata_MPORT_en_pipe_0 = _RAND_92[0:0];
  _RAND_93 = {1{`RANDOM}};
  dataArray_3_1_cachedata_MPORT_addr_pipe_0 = _RAND_93[0:0];
  _RAND_94 = {1{`RANDOM}};
  dataArray_3_1_outdata_MPORT_en_pipe_0 = _RAND_94[0:0];
  _RAND_95 = {1{`RANDOM}};
  dataArray_3_1_outdata_MPORT_addr_pipe_0 = _RAND_95[0:0];
  _RAND_96 = {1{`RANDOM}};
  dataArray_3_1_toMemData_MPORT_en_pipe_0 = _RAND_96[0:0];
  _RAND_97 = {1{`RANDOM}};
  dataArray_3_1_toMemData_MPORT_addr_pipe_0 = _RAND_97[0:0];
  _RAND_99 = {1{`RANDOM}};
  dataArray_3_2_cachedata_MPORT_en_pipe_0 = _RAND_99[0:0];
  _RAND_100 = {1{`RANDOM}};
  dataArray_3_2_cachedata_MPORT_addr_pipe_0 = _RAND_100[0:0];
  _RAND_101 = {1{`RANDOM}};
  dataArray_3_2_outdata_MPORT_en_pipe_0 = _RAND_101[0:0];
  _RAND_102 = {1{`RANDOM}};
  dataArray_3_2_outdata_MPORT_addr_pipe_0 = _RAND_102[0:0];
  _RAND_103 = {1{`RANDOM}};
  dataArray_3_2_toMemData_MPORT_en_pipe_0 = _RAND_103[0:0];
  _RAND_104 = {1{`RANDOM}};
  dataArray_3_2_toMemData_MPORT_addr_pipe_0 = _RAND_104[0:0];
  _RAND_106 = {1{`RANDOM}};
  dataArray_3_3_cachedata_MPORT_en_pipe_0 = _RAND_106[0:0];
  _RAND_107 = {1{`RANDOM}};
  dataArray_3_3_cachedata_MPORT_addr_pipe_0 = _RAND_107[0:0];
  _RAND_108 = {1{`RANDOM}};
  dataArray_3_3_outdata_MPORT_en_pipe_0 = _RAND_108[0:0];
  _RAND_109 = {1{`RANDOM}};
  dataArray_3_3_outdata_MPORT_addr_pipe_0 = _RAND_109[0:0];
  _RAND_110 = {1{`RANDOM}};
  dataArray_3_3_toMemData_MPORT_en_pipe_0 = _RAND_110[0:0];
  _RAND_111 = {1{`RANDOM}};
  dataArray_3_3_toMemData_MPORT_addr_pipe_0 = _RAND_111[0:0];
  _RAND_113 = {1{`RANDOM}};
  dataArray_4_0_cachedata_MPORT_en_pipe_0 = _RAND_113[0:0];
  _RAND_114 = {1{`RANDOM}};
  dataArray_4_0_cachedata_MPORT_addr_pipe_0 = _RAND_114[0:0];
  _RAND_115 = {1{`RANDOM}};
  dataArray_4_0_outdata_MPORT_en_pipe_0 = _RAND_115[0:0];
  _RAND_116 = {1{`RANDOM}};
  dataArray_4_0_outdata_MPORT_addr_pipe_0 = _RAND_116[0:0];
  _RAND_117 = {1{`RANDOM}};
  dataArray_4_0_toMemData_MPORT_en_pipe_0 = _RAND_117[0:0];
  _RAND_118 = {1{`RANDOM}};
  dataArray_4_0_toMemData_MPORT_addr_pipe_0 = _RAND_118[0:0];
  _RAND_120 = {1{`RANDOM}};
  dataArray_4_1_cachedata_MPORT_en_pipe_0 = _RAND_120[0:0];
  _RAND_121 = {1{`RANDOM}};
  dataArray_4_1_cachedata_MPORT_addr_pipe_0 = _RAND_121[0:0];
  _RAND_122 = {1{`RANDOM}};
  dataArray_4_1_outdata_MPORT_en_pipe_0 = _RAND_122[0:0];
  _RAND_123 = {1{`RANDOM}};
  dataArray_4_1_outdata_MPORT_addr_pipe_0 = _RAND_123[0:0];
  _RAND_124 = {1{`RANDOM}};
  dataArray_4_1_toMemData_MPORT_en_pipe_0 = _RAND_124[0:0];
  _RAND_125 = {1{`RANDOM}};
  dataArray_4_1_toMemData_MPORT_addr_pipe_0 = _RAND_125[0:0];
  _RAND_127 = {1{`RANDOM}};
  dataArray_4_2_cachedata_MPORT_en_pipe_0 = _RAND_127[0:0];
  _RAND_128 = {1{`RANDOM}};
  dataArray_4_2_cachedata_MPORT_addr_pipe_0 = _RAND_128[0:0];
  _RAND_129 = {1{`RANDOM}};
  dataArray_4_2_outdata_MPORT_en_pipe_0 = _RAND_129[0:0];
  _RAND_130 = {1{`RANDOM}};
  dataArray_4_2_outdata_MPORT_addr_pipe_0 = _RAND_130[0:0];
  _RAND_131 = {1{`RANDOM}};
  dataArray_4_2_toMemData_MPORT_en_pipe_0 = _RAND_131[0:0];
  _RAND_132 = {1{`RANDOM}};
  dataArray_4_2_toMemData_MPORT_addr_pipe_0 = _RAND_132[0:0];
  _RAND_134 = {1{`RANDOM}};
  dataArray_4_3_cachedata_MPORT_en_pipe_0 = _RAND_134[0:0];
  _RAND_135 = {1{`RANDOM}};
  dataArray_4_3_cachedata_MPORT_addr_pipe_0 = _RAND_135[0:0];
  _RAND_136 = {1{`RANDOM}};
  dataArray_4_3_outdata_MPORT_en_pipe_0 = _RAND_136[0:0];
  _RAND_137 = {1{`RANDOM}};
  dataArray_4_3_outdata_MPORT_addr_pipe_0 = _RAND_137[0:0];
  _RAND_138 = {1{`RANDOM}};
  dataArray_4_3_toMemData_MPORT_en_pipe_0 = _RAND_138[0:0];
  _RAND_139 = {1{`RANDOM}};
  dataArray_4_3_toMemData_MPORT_addr_pipe_0 = _RAND_139[0:0];
  _RAND_141 = {1{`RANDOM}};
  dataArray_5_0_cachedata_MPORT_en_pipe_0 = _RAND_141[0:0];
  _RAND_142 = {1{`RANDOM}};
  dataArray_5_0_cachedata_MPORT_addr_pipe_0 = _RAND_142[0:0];
  _RAND_143 = {1{`RANDOM}};
  dataArray_5_0_outdata_MPORT_en_pipe_0 = _RAND_143[0:0];
  _RAND_144 = {1{`RANDOM}};
  dataArray_5_0_outdata_MPORT_addr_pipe_0 = _RAND_144[0:0];
  _RAND_145 = {1{`RANDOM}};
  dataArray_5_0_toMemData_MPORT_en_pipe_0 = _RAND_145[0:0];
  _RAND_146 = {1{`RANDOM}};
  dataArray_5_0_toMemData_MPORT_addr_pipe_0 = _RAND_146[0:0];
  _RAND_148 = {1{`RANDOM}};
  dataArray_5_1_cachedata_MPORT_en_pipe_0 = _RAND_148[0:0];
  _RAND_149 = {1{`RANDOM}};
  dataArray_5_1_cachedata_MPORT_addr_pipe_0 = _RAND_149[0:0];
  _RAND_150 = {1{`RANDOM}};
  dataArray_5_1_outdata_MPORT_en_pipe_0 = _RAND_150[0:0];
  _RAND_151 = {1{`RANDOM}};
  dataArray_5_1_outdata_MPORT_addr_pipe_0 = _RAND_151[0:0];
  _RAND_152 = {1{`RANDOM}};
  dataArray_5_1_toMemData_MPORT_en_pipe_0 = _RAND_152[0:0];
  _RAND_153 = {1{`RANDOM}};
  dataArray_5_1_toMemData_MPORT_addr_pipe_0 = _RAND_153[0:0];
  _RAND_155 = {1{`RANDOM}};
  dataArray_5_2_cachedata_MPORT_en_pipe_0 = _RAND_155[0:0];
  _RAND_156 = {1{`RANDOM}};
  dataArray_5_2_cachedata_MPORT_addr_pipe_0 = _RAND_156[0:0];
  _RAND_157 = {1{`RANDOM}};
  dataArray_5_2_outdata_MPORT_en_pipe_0 = _RAND_157[0:0];
  _RAND_158 = {1{`RANDOM}};
  dataArray_5_2_outdata_MPORT_addr_pipe_0 = _RAND_158[0:0];
  _RAND_159 = {1{`RANDOM}};
  dataArray_5_2_toMemData_MPORT_en_pipe_0 = _RAND_159[0:0];
  _RAND_160 = {1{`RANDOM}};
  dataArray_5_2_toMemData_MPORT_addr_pipe_0 = _RAND_160[0:0];
  _RAND_162 = {1{`RANDOM}};
  dataArray_5_3_cachedata_MPORT_en_pipe_0 = _RAND_162[0:0];
  _RAND_163 = {1{`RANDOM}};
  dataArray_5_3_cachedata_MPORT_addr_pipe_0 = _RAND_163[0:0];
  _RAND_164 = {1{`RANDOM}};
  dataArray_5_3_outdata_MPORT_en_pipe_0 = _RAND_164[0:0];
  _RAND_165 = {1{`RANDOM}};
  dataArray_5_3_outdata_MPORT_addr_pipe_0 = _RAND_165[0:0];
  _RAND_166 = {1{`RANDOM}};
  dataArray_5_3_toMemData_MPORT_en_pipe_0 = _RAND_166[0:0];
  _RAND_167 = {1{`RANDOM}};
  dataArray_5_3_toMemData_MPORT_addr_pipe_0 = _RAND_167[0:0];
  _RAND_169 = {1{`RANDOM}};
  dataArray_6_0_cachedata_MPORT_en_pipe_0 = _RAND_169[0:0];
  _RAND_170 = {1{`RANDOM}};
  dataArray_6_0_cachedata_MPORT_addr_pipe_0 = _RAND_170[0:0];
  _RAND_171 = {1{`RANDOM}};
  dataArray_6_0_outdata_MPORT_en_pipe_0 = _RAND_171[0:0];
  _RAND_172 = {1{`RANDOM}};
  dataArray_6_0_outdata_MPORT_addr_pipe_0 = _RAND_172[0:0];
  _RAND_173 = {1{`RANDOM}};
  dataArray_6_0_toMemData_MPORT_en_pipe_0 = _RAND_173[0:0];
  _RAND_174 = {1{`RANDOM}};
  dataArray_6_0_toMemData_MPORT_addr_pipe_0 = _RAND_174[0:0];
  _RAND_176 = {1{`RANDOM}};
  dataArray_6_1_cachedata_MPORT_en_pipe_0 = _RAND_176[0:0];
  _RAND_177 = {1{`RANDOM}};
  dataArray_6_1_cachedata_MPORT_addr_pipe_0 = _RAND_177[0:0];
  _RAND_178 = {1{`RANDOM}};
  dataArray_6_1_outdata_MPORT_en_pipe_0 = _RAND_178[0:0];
  _RAND_179 = {1{`RANDOM}};
  dataArray_6_1_outdata_MPORT_addr_pipe_0 = _RAND_179[0:0];
  _RAND_180 = {1{`RANDOM}};
  dataArray_6_1_toMemData_MPORT_en_pipe_0 = _RAND_180[0:0];
  _RAND_181 = {1{`RANDOM}};
  dataArray_6_1_toMemData_MPORT_addr_pipe_0 = _RAND_181[0:0];
  _RAND_183 = {1{`RANDOM}};
  dataArray_6_2_cachedata_MPORT_en_pipe_0 = _RAND_183[0:0];
  _RAND_184 = {1{`RANDOM}};
  dataArray_6_2_cachedata_MPORT_addr_pipe_0 = _RAND_184[0:0];
  _RAND_185 = {1{`RANDOM}};
  dataArray_6_2_outdata_MPORT_en_pipe_0 = _RAND_185[0:0];
  _RAND_186 = {1{`RANDOM}};
  dataArray_6_2_outdata_MPORT_addr_pipe_0 = _RAND_186[0:0];
  _RAND_187 = {1{`RANDOM}};
  dataArray_6_2_toMemData_MPORT_en_pipe_0 = _RAND_187[0:0];
  _RAND_188 = {1{`RANDOM}};
  dataArray_6_2_toMemData_MPORT_addr_pipe_0 = _RAND_188[0:0];
  _RAND_190 = {1{`RANDOM}};
  dataArray_6_3_cachedata_MPORT_en_pipe_0 = _RAND_190[0:0];
  _RAND_191 = {1{`RANDOM}};
  dataArray_6_3_cachedata_MPORT_addr_pipe_0 = _RAND_191[0:0];
  _RAND_192 = {1{`RANDOM}};
  dataArray_6_3_outdata_MPORT_en_pipe_0 = _RAND_192[0:0];
  _RAND_193 = {1{`RANDOM}};
  dataArray_6_3_outdata_MPORT_addr_pipe_0 = _RAND_193[0:0];
  _RAND_194 = {1{`RANDOM}};
  dataArray_6_3_toMemData_MPORT_en_pipe_0 = _RAND_194[0:0];
  _RAND_195 = {1{`RANDOM}};
  dataArray_6_3_toMemData_MPORT_addr_pipe_0 = _RAND_195[0:0];
  _RAND_197 = {1{`RANDOM}};
  dataArray_7_0_cachedata_MPORT_en_pipe_0 = _RAND_197[0:0];
  _RAND_198 = {1{`RANDOM}};
  dataArray_7_0_cachedata_MPORT_addr_pipe_0 = _RAND_198[0:0];
  _RAND_199 = {1{`RANDOM}};
  dataArray_7_0_outdata_MPORT_en_pipe_0 = _RAND_199[0:0];
  _RAND_200 = {1{`RANDOM}};
  dataArray_7_0_outdata_MPORT_addr_pipe_0 = _RAND_200[0:0];
  _RAND_201 = {1{`RANDOM}};
  dataArray_7_0_toMemData_MPORT_en_pipe_0 = _RAND_201[0:0];
  _RAND_202 = {1{`RANDOM}};
  dataArray_7_0_toMemData_MPORT_addr_pipe_0 = _RAND_202[0:0];
  _RAND_204 = {1{`RANDOM}};
  dataArray_7_1_cachedata_MPORT_en_pipe_0 = _RAND_204[0:0];
  _RAND_205 = {1{`RANDOM}};
  dataArray_7_1_cachedata_MPORT_addr_pipe_0 = _RAND_205[0:0];
  _RAND_206 = {1{`RANDOM}};
  dataArray_7_1_outdata_MPORT_en_pipe_0 = _RAND_206[0:0];
  _RAND_207 = {1{`RANDOM}};
  dataArray_7_1_outdata_MPORT_addr_pipe_0 = _RAND_207[0:0];
  _RAND_208 = {1{`RANDOM}};
  dataArray_7_1_toMemData_MPORT_en_pipe_0 = _RAND_208[0:0];
  _RAND_209 = {1{`RANDOM}};
  dataArray_7_1_toMemData_MPORT_addr_pipe_0 = _RAND_209[0:0];
  _RAND_211 = {1{`RANDOM}};
  dataArray_7_2_cachedata_MPORT_en_pipe_0 = _RAND_211[0:0];
  _RAND_212 = {1{`RANDOM}};
  dataArray_7_2_cachedata_MPORT_addr_pipe_0 = _RAND_212[0:0];
  _RAND_213 = {1{`RANDOM}};
  dataArray_7_2_outdata_MPORT_en_pipe_0 = _RAND_213[0:0];
  _RAND_214 = {1{`RANDOM}};
  dataArray_7_2_outdata_MPORT_addr_pipe_0 = _RAND_214[0:0];
  _RAND_215 = {1{`RANDOM}};
  dataArray_7_2_toMemData_MPORT_en_pipe_0 = _RAND_215[0:0];
  _RAND_216 = {1{`RANDOM}};
  dataArray_7_2_toMemData_MPORT_addr_pipe_0 = _RAND_216[0:0];
  _RAND_218 = {1{`RANDOM}};
  dataArray_7_3_cachedata_MPORT_en_pipe_0 = _RAND_218[0:0];
  _RAND_219 = {1{`RANDOM}};
  dataArray_7_3_cachedata_MPORT_addr_pipe_0 = _RAND_219[0:0];
  _RAND_220 = {1{`RANDOM}};
  dataArray_7_3_outdata_MPORT_en_pipe_0 = _RAND_220[0:0];
  _RAND_221 = {1{`RANDOM}};
  dataArray_7_3_outdata_MPORT_addr_pipe_0 = _RAND_221[0:0];
  _RAND_222 = {1{`RANDOM}};
  dataArray_7_3_toMemData_MPORT_en_pipe_0 = _RAND_222[0:0];
  _RAND_223 = {1{`RANDOM}};
  dataArray_7_3_toMemData_MPORT_addr_pipe_0 = _RAND_223[0:0];
  _RAND_225 = {1{`RANDOM}};
  dataArray_8_0_cachedata_MPORT_en_pipe_0 = _RAND_225[0:0];
  _RAND_226 = {1{`RANDOM}};
  dataArray_8_0_cachedata_MPORT_addr_pipe_0 = _RAND_226[0:0];
  _RAND_227 = {1{`RANDOM}};
  dataArray_8_0_outdata_MPORT_en_pipe_0 = _RAND_227[0:0];
  _RAND_228 = {1{`RANDOM}};
  dataArray_8_0_outdata_MPORT_addr_pipe_0 = _RAND_228[0:0];
  _RAND_229 = {1{`RANDOM}};
  dataArray_8_0_toMemData_MPORT_en_pipe_0 = _RAND_229[0:0];
  _RAND_230 = {1{`RANDOM}};
  dataArray_8_0_toMemData_MPORT_addr_pipe_0 = _RAND_230[0:0];
  _RAND_232 = {1{`RANDOM}};
  dataArray_8_1_cachedata_MPORT_en_pipe_0 = _RAND_232[0:0];
  _RAND_233 = {1{`RANDOM}};
  dataArray_8_1_cachedata_MPORT_addr_pipe_0 = _RAND_233[0:0];
  _RAND_234 = {1{`RANDOM}};
  dataArray_8_1_outdata_MPORT_en_pipe_0 = _RAND_234[0:0];
  _RAND_235 = {1{`RANDOM}};
  dataArray_8_1_outdata_MPORT_addr_pipe_0 = _RAND_235[0:0];
  _RAND_236 = {1{`RANDOM}};
  dataArray_8_1_toMemData_MPORT_en_pipe_0 = _RAND_236[0:0];
  _RAND_237 = {1{`RANDOM}};
  dataArray_8_1_toMemData_MPORT_addr_pipe_0 = _RAND_237[0:0];
  _RAND_239 = {1{`RANDOM}};
  dataArray_8_2_cachedata_MPORT_en_pipe_0 = _RAND_239[0:0];
  _RAND_240 = {1{`RANDOM}};
  dataArray_8_2_cachedata_MPORT_addr_pipe_0 = _RAND_240[0:0];
  _RAND_241 = {1{`RANDOM}};
  dataArray_8_2_outdata_MPORT_en_pipe_0 = _RAND_241[0:0];
  _RAND_242 = {1{`RANDOM}};
  dataArray_8_2_outdata_MPORT_addr_pipe_0 = _RAND_242[0:0];
  _RAND_243 = {1{`RANDOM}};
  dataArray_8_2_toMemData_MPORT_en_pipe_0 = _RAND_243[0:0];
  _RAND_244 = {1{`RANDOM}};
  dataArray_8_2_toMemData_MPORT_addr_pipe_0 = _RAND_244[0:0];
  _RAND_246 = {1{`RANDOM}};
  dataArray_8_3_cachedata_MPORT_en_pipe_0 = _RAND_246[0:0];
  _RAND_247 = {1{`RANDOM}};
  dataArray_8_3_cachedata_MPORT_addr_pipe_0 = _RAND_247[0:0];
  _RAND_248 = {1{`RANDOM}};
  dataArray_8_3_outdata_MPORT_en_pipe_0 = _RAND_248[0:0];
  _RAND_249 = {1{`RANDOM}};
  dataArray_8_3_outdata_MPORT_addr_pipe_0 = _RAND_249[0:0];
  _RAND_250 = {1{`RANDOM}};
  dataArray_8_3_toMemData_MPORT_en_pipe_0 = _RAND_250[0:0];
  _RAND_251 = {1{`RANDOM}};
  dataArray_8_3_toMemData_MPORT_addr_pipe_0 = _RAND_251[0:0];
  _RAND_253 = {1{`RANDOM}};
  dataArray_9_0_cachedata_MPORT_en_pipe_0 = _RAND_253[0:0];
  _RAND_254 = {1{`RANDOM}};
  dataArray_9_0_cachedata_MPORT_addr_pipe_0 = _RAND_254[0:0];
  _RAND_255 = {1{`RANDOM}};
  dataArray_9_0_outdata_MPORT_en_pipe_0 = _RAND_255[0:0];
  _RAND_256 = {1{`RANDOM}};
  dataArray_9_0_outdata_MPORT_addr_pipe_0 = _RAND_256[0:0];
  _RAND_257 = {1{`RANDOM}};
  dataArray_9_0_toMemData_MPORT_en_pipe_0 = _RAND_257[0:0];
  _RAND_258 = {1{`RANDOM}};
  dataArray_9_0_toMemData_MPORT_addr_pipe_0 = _RAND_258[0:0];
  _RAND_260 = {1{`RANDOM}};
  dataArray_9_1_cachedata_MPORT_en_pipe_0 = _RAND_260[0:0];
  _RAND_261 = {1{`RANDOM}};
  dataArray_9_1_cachedata_MPORT_addr_pipe_0 = _RAND_261[0:0];
  _RAND_262 = {1{`RANDOM}};
  dataArray_9_1_outdata_MPORT_en_pipe_0 = _RAND_262[0:0];
  _RAND_263 = {1{`RANDOM}};
  dataArray_9_1_outdata_MPORT_addr_pipe_0 = _RAND_263[0:0];
  _RAND_264 = {1{`RANDOM}};
  dataArray_9_1_toMemData_MPORT_en_pipe_0 = _RAND_264[0:0];
  _RAND_265 = {1{`RANDOM}};
  dataArray_9_1_toMemData_MPORT_addr_pipe_0 = _RAND_265[0:0];
  _RAND_267 = {1{`RANDOM}};
  dataArray_9_2_cachedata_MPORT_en_pipe_0 = _RAND_267[0:0];
  _RAND_268 = {1{`RANDOM}};
  dataArray_9_2_cachedata_MPORT_addr_pipe_0 = _RAND_268[0:0];
  _RAND_269 = {1{`RANDOM}};
  dataArray_9_2_outdata_MPORT_en_pipe_0 = _RAND_269[0:0];
  _RAND_270 = {1{`RANDOM}};
  dataArray_9_2_outdata_MPORT_addr_pipe_0 = _RAND_270[0:0];
  _RAND_271 = {1{`RANDOM}};
  dataArray_9_2_toMemData_MPORT_en_pipe_0 = _RAND_271[0:0];
  _RAND_272 = {1{`RANDOM}};
  dataArray_9_2_toMemData_MPORT_addr_pipe_0 = _RAND_272[0:0];
  _RAND_274 = {1{`RANDOM}};
  dataArray_9_3_cachedata_MPORT_en_pipe_0 = _RAND_274[0:0];
  _RAND_275 = {1{`RANDOM}};
  dataArray_9_3_cachedata_MPORT_addr_pipe_0 = _RAND_275[0:0];
  _RAND_276 = {1{`RANDOM}};
  dataArray_9_3_outdata_MPORT_en_pipe_0 = _RAND_276[0:0];
  _RAND_277 = {1{`RANDOM}};
  dataArray_9_3_outdata_MPORT_addr_pipe_0 = _RAND_277[0:0];
  _RAND_278 = {1{`RANDOM}};
  dataArray_9_3_toMemData_MPORT_en_pipe_0 = _RAND_278[0:0];
  _RAND_279 = {1{`RANDOM}};
  dataArray_9_3_toMemData_MPORT_addr_pipe_0 = _RAND_279[0:0];
  _RAND_281 = {1{`RANDOM}};
  dataArray_10_0_cachedata_MPORT_en_pipe_0 = _RAND_281[0:0];
  _RAND_282 = {1{`RANDOM}};
  dataArray_10_0_cachedata_MPORT_addr_pipe_0 = _RAND_282[0:0];
  _RAND_283 = {1{`RANDOM}};
  dataArray_10_0_outdata_MPORT_en_pipe_0 = _RAND_283[0:0];
  _RAND_284 = {1{`RANDOM}};
  dataArray_10_0_outdata_MPORT_addr_pipe_0 = _RAND_284[0:0];
  _RAND_285 = {1{`RANDOM}};
  dataArray_10_0_toMemData_MPORT_en_pipe_0 = _RAND_285[0:0];
  _RAND_286 = {1{`RANDOM}};
  dataArray_10_0_toMemData_MPORT_addr_pipe_0 = _RAND_286[0:0];
  _RAND_288 = {1{`RANDOM}};
  dataArray_10_1_cachedata_MPORT_en_pipe_0 = _RAND_288[0:0];
  _RAND_289 = {1{`RANDOM}};
  dataArray_10_1_cachedata_MPORT_addr_pipe_0 = _RAND_289[0:0];
  _RAND_290 = {1{`RANDOM}};
  dataArray_10_1_outdata_MPORT_en_pipe_0 = _RAND_290[0:0];
  _RAND_291 = {1{`RANDOM}};
  dataArray_10_1_outdata_MPORT_addr_pipe_0 = _RAND_291[0:0];
  _RAND_292 = {1{`RANDOM}};
  dataArray_10_1_toMemData_MPORT_en_pipe_0 = _RAND_292[0:0];
  _RAND_293 = {1{`RANDOM}};
  dataArray_10_1_toMemData_MPORT_addr_pipe_0 = _RAND_293[0:0];
  _RAND_295 = {1{`RANDOM}};
  dataArray_10_2_cachedata_MPORT_en_pipe_0 = _RAND_295[0:0];
  _RAND_296 = {1{`RANDOM}};
  dataArray_10_2_cachedata_MPORT_addr_pipe_0 = _RAND_296[0:0];
  _RAND_297 = {1{`RANDOM}};
  dataArray_10_2_outdata_MPORT_en_pipe_0 = _RAND_297[0:0];
  _RAND_298 = {1{`RANDOM}};
  dataArray_10_2_outdata_MPORT_addr_pipe_0 = _RAND_298[0:0];
  _RAND_299 = {1{`RANDOM}};
  dataArray_10_2_toMemData_MPORT_en_pipe_0 = _RAND_299[0:0];
  _RAND_300 = {1{`RANDOM}};
  dataArray_10_2_toMemData_MPORT_addr_pipe_0 = _RAND_300[0:0];
  _RAND_302 = {1{`RANDOM}};
  dataArray_10_3_cachedata_MPORT_en_pipe_0 = _RAND_302[0:0];
  _RAND_303 = {1{`RANDOM}};
  dataArray_10_3_cachedata_MPORT_addr_pipe_0 = _RAND_303[0:0];
  _RAND_304 = {1{`RANDOM}};
  dataArray_10_3_outdata_MPORT_en_pipe_0 = _RAND_304[0:0];
  _RAND_305 = {1{`RANDOM}};
  dataArray_10_3_outdata_MPORT_addr_pipe_0 = _RAND_305[0:0];
  _RAND_306 = {1{`RANDOM}};
  dataArray_10_3_toMemData_MPORT_en_pipe_0 = _RAND_306[0:0];
  _RAND_307 = {1{`RANDOM}};
  dataArray_10_3_toMemData_MPORT_addr_pipe_0 = _RAND_307[0:0];
  _RAND_309 = {1{`RANDOM}};
  dataArray_11_0_cachedata_MPORT_en_pipe_0 = _RAND_309[0:0];
  _RAND_310 = {1{`RANDOM}};
  dataArray_11_0_cachedata_MPORT_addr_pipe_0 = _RAND_310[0:0];
  _RAND_311 = {1{`RANDOM}};
  dataArray_11_0_outdata_MPORT_en_pipe_0 = _RAND_311[0:0];
  _RAND_312 = {1{`RANDOM}};
  dataArray_11_0_outdata_MPORT_addr_pipe_0 = _RAND_312[0:0];
  _RAND_313 = {1{`RANDOM}};
  dataArray_11_0_toMemData_MPORT_en_pipe_0 = _RAND_313[0:0];
  _RAND_314 = {1{`RANDOM}};
  dataArray_11_0_toMemData_MPORT_addr_pipe_0 = _RAND_314[0:0];
  _RAND_316 = {1{`RANDOM}};
  dataArray_11_1_cachedata_MPORT_en_pipe_0 = _RAND_316[0:0];
  _RAND_317 = {1{`RANDOM}};
  dataArray_11_1_cachedata_MPORT_addr_pipe_0 = _RAND_317[0:0];
  _RAND_318 = {1{`RANDOM}};
  dataArray_11_1_outdata_MPORT_en_pipe_0 = _RAND_318[0:0];
  _RAND_319 = {1{`RANDOM}};
  dataArray_11_1_outdata_MPORT_addr_pipe_0 = _RAND_319[0:0];
  _RAND_320 = {1{`RANDOM}};
  dataArray_11_1_toMemData_MPORT_en_pipe_0 = _RAND_320[0:0];
  _RAND_321 = {1{`RANDOM}};
  dataArray_11_1_toMemData_MPORT_addr_pipe_0 = _RAND_321[0:0];
  _RAND_323 = {1{`RANDOM}};
  dataArray_11_2_cachedata_MPORT_en_pipe_0 = _RAND_323[0:0];
  _RAND_324 = {1{`RANDOM}};
  dataArray_11_2_cachedata_MPORT_addr_pipe_0 = _RAND_324[0:0];
  _RAND_325 = {1{`RANDOM}};
  dataArray_11_2_outdata_MPORT_en_pipe_0 = _RAND_325[0:0];
  _RAND_326 = {1{`RANDOM}};
  dataArray_11_2_outdata_MPORT_addr_pipe_0 = _RAND_326[0:0];
  _RAND_327 = {1{`RANDOM}};
  dataArray_11_2_toMemData_MPORT_en_pipe_0 = _RAND_327[0:0];
  _RAND_328 = {1{`RANDOM}};
  dataArray_11_2_toMemData_MPORT_addr_pipe_0 = _RAND_328[0:0];
  _RAND_330 = {1{`RANDOM}};
  dataArray_11_3_cachedata_MPORT_en_pipe_0 = _RAND_330[0:0];
  _RAND_331 = {1{`RANDOM}};
  dataArray_11_3_cachedata_MPORT_addr_pipe_0 = _RAND_331[0:0];
  _RAND_332 = {1{`RANDOM}};
  dataArray_11_3_outdata_MPORT_en_pipe_0 = _RAND_332[0:0];
  _RAND_333 = {1{`RANDOM}};
  dataArray_11_3_outdata_MPORT_addr_pipe_0 = _RAND_333[0:0];
  _RAND_334 = {1{`RANDOM}};
  dataArray_11_3_toMemData_MPORT_en_pipe_0 = _RAND_334[0:0];
  _RAND_335 = {1{`RANDOM}};
  dataArray_11_3_toMemData_MPORT_addr_pipe_0 = _RAND_335[0:0];
  _RAND_337 = {1{`RANDOM}};
  dataArray_12_0_cachedata_MPORT_en_pipe_0 = _RAND_337[0:0];
  _RAND_338 = {1{`RANDOM}};
  dataArray_12_0_cachedata_MPORT_addr_pipe_0 = _RAND_338[0:0];
  _RAND_339 = {1{`RANDOM}};
  dataArray_12_0_outdata_MPORT_en_pipe_0 = _RAND_339[0:0];
  _RAND_340 = {1{`RANDOM}};
  dataArray_12_0_outdata_MPORT_addr_pipe_0 = _RAND_340[0:0];
  _RAND_341 = {1{`RANDOM}};
  dataArray_12_0_toMemData_MPORT_en_pipe_0 = _RAND_341[0:0];
  _RAND_342 = {1{`RANDOM}};
  dataArray_12_0_toMemData_MPORT_addr_pipe_0 = _RAND_342[0:0];
  _RAND_344 = {1{`RANDOM}};
  dataArray_12_1_cachedata_MPORT_en_pipe_0 = _RAND_344[0:0];
  _RAND_345 = {1{`RANDOM}};
  dataArray_12_1_cachedata_MPORT_addr_pipe_0 = _RAND_345[0:0];
  _RAND_346 = {1{`RANDOM}};
  dataArray_12_1_outdata_MPORT_en_pipe_0 = _RAND_346[0:0];
  _RAND_347 = {1{`RANDOM}};
  dataArray_12_1_outdata_MPORT_addr_pipe_0 = _RAND_347[0:0];
  _RAND_348 = {1{`RANDOM}};
  dataArray_12_1_toMemData_MPORT_en_pipe_0 = _RAND_348[0:0];
  _RAND_349 = {1{`RANDOM}};
  dataArray_12_1_toMemData_MPORT_addr_pipe_0 = _RAND_349[0:0];
  _RAND_351 = {1{`RANDOM}};
  dataArray_12_2_cachedata_MPORT_en_pipe_0 = _RAND_351[0:0];
  _RAND_352 = {1{`RANDOM}};
  dataArray_12_2_cachedata_MPORT_addr_pipe_0 = _RAND_352[0:0];
  _RAND_353 = {1{`RANDOM}};
  dataArray_12_2_outdata_MPORT_en_pipe_0 = _RAND_353[0:0];
  _RAND_354 = {1{`RANDOM}};
  dataArray_12_2_outdata_MPORT_addr_pipe_0 = _RAND_354[0:0];
  _RAND_355 = {1{`RANDOM}};
  dataArray_12_2_toMemData_MPORT_en_pipe_0 = _RAND_355[0:0];
  _RAND_356 = {1{`RANDOM}};
  dataArray_12_2_toMemData_MPORT_addr_pipe_0 = _RAND_356[0:0];
  _RAND_358 = {1{`RANDOM}};
  dataArray_12_3_cachedata_MPORT_en_pipe_0 = _RAND_358[0:0];
  _RAND_359 = {1{`RANDOM}};
  dataArray_12_3_cachedata_MPORT_addr_pipe_0 = _RAND_359[0:0];
  _RAND_360 = {1{`RANDOM}};
  dataArray_12_3_outdata_MPORT_en_pipe_0 = _RAND_360[0:0];
  _RAND_361 = {1{`RANDOM}};
  dataArray_12_3_outdata_MPORT_addr_pipe_0 = _RAND_361[0:0];
  _RAND_362 = {1{`RANDOM}};
  dataArray_12_3_toMemData_MPORT_en_pipe_0 = _RAND_362[0:0];
  _RAND_363 = {1{`RANDOM}};
  dataArray_12_3_toMemData_MPORT_addr_pipe_0 = _RAND_363[0:0];
  _RAND_365 = {1{`RANDOM}};
  dataArray_13_0_cachedata_MPORT_en_pipe_0 = _RAND_365[0:0];
  _RAND_366 = {1{`RANDOM}};
  dataArray_13_0_cachedata_MPORT_addr_pipe_0 = _RAND_366[0:0];
  _RAND_367 = {1{`RANDOM}};
  dataArray_13_0_outdata_MPORT_en_pipe_0 = _RAND_367[0:0];
  _RAND_368 = {1{`RANDOM}};
  dataArray_13_0_outdata_MPORT_addr_pipe_0 = _RAND_368[0:0];
  _RAND_369 = {1{`RANDOM}};
  dataArray_13_0_toMemData_MPORT_en_pipe_0 = _RAND_369[0:0];
  _RAND_370 = {1{`RANDOM}};
  dataArray_13_0_toMemData_MPORT_addr_pipe_0 = _RAND_370[0:0];
  _RAND_372 = {1{`RANDOM}};
  dataArray_13_1_cachedata_MPORT_en_pipe_0 = _RAND_372[0:0];
  _RAND_373 = {1{`RANDOM}};
  dataArray_13_1_cachedata_MPORT_addr_pipe_0 = _RAND_373[0:0];
  _RAND_374 = {1{`RANDOM}};
  dataArray_13_1_outdata_MPORT_en_pipe_0 = _RAND_374[0:0];
  _RAND_375 = {1{`RANDOM}};
  dataArray_13_1_outdata_MPORT_addr_pipe_0 = _RAND_375[0:0];
  _RAND_376 = {1{`RANDOM}};
  dataArray_13_1_toMemData_MPORT_en_pipe_0 = _RAND_376[0:0];
  _RAND_377 = {1{`RANDOM}};
  dataArray_13_1_toMemData_MPORT_addr_pipe_0 = _RAND_377[0:0];
  _RAND_379 = {1{`RANDOM}};
  dataArray_13_2_cachedata_MPORT_en_pipe_0 = _RAND_379[0:0];
  _RAND_380 = {1{`RANDOM}};
  dataArray_13_2_cachedata_MPORT_addr_pipe_0 = _RAND_380[0:0];
  _RAND_381 = {1{`RANDOM}};
  dataArray_13_2_outdata_MPORT_en_pipe_0 = _RAND_381[0:0];
  _RAND_382 = {1{`RANDOM}};
  dataArray_13_2_outdata_MPORT_addr_pipe_0 = _RAND_382[0:0];
  _RAND_383 = {1{`RANDOM}};
  dataArray_13_2_toMemData_MPORT_en_pipe_0 = _RAND_383[0:0];
  _RAND_384 = {1{`RANDOM}};
  dataArray_13_2_toMemData_MPORT_addr_pipe_0 = _RAND_384[0:0];
  _RAND_386 = {1{`RANDOM}};
  dataArray_13_3_cachedata_MPORT_en_pipe_0 = _RAND_386[0:0];
  _RAND_387 = {1{`RANDOM}};
  dataArray_13_3_cachedata_MPORT_addr_pipe_0 = _RAND_387[0:0];
  _RAND_388 = {1{`RANDOM}};
  dataArray_13_3_outdata_MPORT_en_pipe_0 = _RAND_388[0:0];
  _RAND_389 = {1{`RANDOM}};
  dataArray_13_3_outdata_MPORT_addr_pipe_0 = _RAND_389[0:0];
  _RAND_390 = {1{`RANDOM}};
  dataArray_13_3_toMemData_MPORT_en_pipe_0 = _RAND_390[0:0];
  _RAND_391 = {1{`RANDOM}};
  dataArray_13_3_toMemData_MPORT_addr_pipe_0 = _RAND_391[0:0];
  _RAND_393 = {1{`RANDOM}};
  dataArray_14_0_cachedata_MPORT_en_pipe_0 = _RAND_393[0:0];
  _RAND_394 = {1{`RANDOM}};
  dataArray_14_0_cachedata_MPORT_addr_pipe_0 = _RAND_394[0:0];
  _RAND_395 = {1{`RANDOM}};
  dataArray_14_0_outdata_MPORT_en_pipe_0 = _RAND_395[0:0];
  _RAND_396 = {1{`RANDOM}};
  dataArray_14_0_outdata_MPORT_addr_pipe_0 = _RAND_396[0:0];
  _RAND_397 = {1{`RANDOM}};
  dataArray_14_0_toMemData_MPORT_en_pipe_0 = _RAND_397[0:0];
  _RAND_398 = {1{`RANDOM}};
  dataArray_14_0_toMemData_MPORT_addr_pipe_0 = _RAND_398[0:0];
  _RAND_400 = {1{`RANDOM}};
  dataArray_14_1_cachedata_MPORT_en_pipe_0 = _RAND_400[0:0];
  _RAND_401 = {1{`RANDOM}};
  dataArray_14_1_cachedata_MPORT_addr_pipe_0 = _RAND_401[0:0];
  _RAND_402 = {1{`RANDOM}};
  dataArray_14_1_outdata_MPORT_en_pipe_0 = _RAND_402[0:0];
  _RAND_403 = {1{`RANDOM}};
  dataArray_14_1_outdata_MPORT_addr_pipe_0 = _RAND_403[0:0];
  _RAND_404 = {1{`RANDOM}};
  dataArray_14_1_toMemData_MPORT_en_pipe_0 = _RAND_404[0:0];
  _RAND_405 = {1{`RANDOM}};
  dataArray_14_1_toMemData_MPORT_addr_pipe_0 = _RAND_405[0:0];
  _RAND_407 = {1{`RANDOM}};
  dataArray_14_2_cachedata_MPORT_en_pipe_0 = _RAND_407[0:0];
  _RAND_408 = {1{`RANDOM}};
  dataArray_14_2_cachedata_MPORT_addr_pipe_0 = _RAND_408[0:0];
  _RAND_409 = {1{`RANDOM}};
  dataArray_14_2_outdata_MPORT_en_pipe_0 = _RAND_409[0:0];
  _RAND_410 = {1{`RANDOM}};
  dataArray_14_2_outdata_MPORT_addr_pipe_0 = _RAND_410[0:0];
  _RAND_411 = {1{`RANDOM}};
  dataArray_14_2_toMemData_MPORT_en_pipe_0 = _RAND_411[0:0];
  _RAND_412 = {1{`RANDOM}};
  dataArray_14_2_toMemData_MPORT_addr_pipe_0 = _RAND_412[0:0];
  _RAND_414 = {1{`RANDOM}};
  dataArray_14_3_cachedata_MPORT_en_pipe_0 = _RAND_414[0:0];
  _RAND_415 = {1{`RANDOM}};
  dataArray_14_3_cachedata_MPORT_addr_pipe_0 = _RAND_415[0:0];
  _RAND_416 = {1{`RANDOM}};
  dataArray_14_3_outdata_MPORT_en_pipe_0 = _RAND_416[0:0];
  _RAND_417 = {1{`RANDOM}};
  dataArray_14_3_outdata_MPORT_addr_pipe_0 = _RAND_417[0:0];
  _RAND_418 = {1{`RANDOM}};
  dataArray_14_3_toMemData_MPORT_en_pipe_0 = _RAND_418[0:0];
  _RAND_419 = {1{`RANDOM}};
  dataArray_14_3_toMemData_MPORT_addr_pipe_0 = _RAND_419[0:0];
  _RAND_421 = {1{`RANDOM}};
  dataArray_15_0_cachedata_MPORT_en_pipe_0 = _RAND_421[0:0];
  _RAND_422 = {1{`RANDOM}};
  dataArray_15_0_cachedata_MPORT_addr_pipe_0 = _RAND_422[0:0];
  _RAND_423 = {1{`RANDOM}};
  dataArray_15_0_outdata_MPORT_en_pipe_0 = _RAND_423[0:0];
  _RAND_424 = {1{`RANDOM}};
  dataArray_15_0_outdata_MPORT_addr_pipe_0 = _RAND_424[0:0];
  _RAND_425 = {1{`RANDOM}};
  dataArray_15_0_toMemData_MPORT_en_pipe_0 = _RAND_425[0:0];
  _RAND_426 = {1{`RANDOM}};
  dataArray_15_0_toMemData_MPORT_addr_pipe_0 = _RAND_426[0:0];
  _RAND_428 = {1{`RANDOM}};
  dataArray_15_1_cachedata_MPORT_en_pipe_0 = _RAND_428[0:0];
  _RAND_429 = {1{`RANDOM}};
  dataArray_15_1_cachedata_MPORT_addr_pipe_0 = _RAND_429[0:0];
  _RAND_430 = {1{`RANDOM}};
  dataArray_15_1_outdata_MPORT_en_pipe_0 = _RAND_430[0:0];
  _RAND_431 = {1{`RANDOM}};
  dataArray_15_1_outdata_MPORT_addr_pipe_0 = _RAND_431[0:0];
  _RAND_432 = {1{`RANDOM}};
  dataArray_15_1_toMemData_MPORT_en_pipe_0 = _RAND_432[0:0];
  _RAND_433 = {1{`RANDOM}};
  dataArray_15_1_toMemData_MPORT_addr_pipe_0 = _RAND_433[0:0];
  _RAND_435 = {1{`RANDOM}};
  dataArray_15_2_cachedata_MPORT_en_pipe_0 = _RAND_435[0:0];
  _RAND_436 = {1{`RANDOM}};
  dataArray_15_2_cachedata_MPORT_addr_pipe_0 = _RAND_436[0:0];
  _RAND_437 = {1{`RANDOM}};
  dataArray_15_2_outdata_MPORT_en_pipe_0 = _RAND_437[0:0];
  _RAND_438 = {1{`RANDOM}};
  dataArray_15_2_outdata_MPORT_addr_pipe_0 = _RAND_438[0:0];
  _RAND_439 = {1{`RANDOM}};
  dataArray_15_2_toMemData_MPORT_en_pipe_0 = _RAND_439[0:0];
  _RAND_440 = {1{`RANDOM}};
  dataArray_15_2_toMemData_MPORT_addr_pipe_0 = _RAND_440[0:0];
  _RAND_442 = {1{`RANDOM}};
  dataArray_15_3_cachedata_MPORT_en_pipe_0 = _RAND_442[0:0];
  _RAND_443 = {1{`RANDOM}};
  dataArray_15_3_cachedata_MPORT_addr_pipe_0 = _RAND_443[0:0];
  _RAND_444 = {1{`RANDOM}};
  dataArray_15_3_outdata_MPORT_en_pipe_0 = _RAND_444[0:0];
  _RAND_445 = {1{`RANDOM}};
  dataArray_15_3_outdata_MPORT_addr_pipe_0 = _RAND_445[0:0];
  _RAND_446 = {1{`RANDOM}};
  dataArray_15_3_toMemData_MPORT_en_pipe_0 = _RAND_446[0:0];
  _RAND_447 = {1{`RANDOM}};
  dataArray_15_3_toMemData_MPORT_addr_pipe_0 = _RAND_447[0:0];
  _RAND_448 = {1{`RANDOM}};
  replace_set = _RAND_448[0:0];
  _RAND_449 = {1{`RANDOM}};
  random_num = _RAND_449[0:0];
  _RAND_450 = {1{`RANDOM}};
  tagArray_0_0 = _RAND_450[23:0];
  _RAND_451 = {1{`RANDOM}};
  tagArray_0_1 = _RAND_451[23:0];
  _RAND_452 = {1{`RANDOM}};
  tagArray_0_2 = _RAND_452[23:0];
  _RAND_453 = {1{`RANDOM}};
  tagArray_0_3 = _RAND_453[23:0];
  _RAND_454 = {1{`RANDOM}};
  tagArray_0_4 = _RAND_454[23:0];
  _RAND_455 = {1{`RANDOM}};
  tagArray_0_5 = _RAND_455[23:0];
  _RAND_456 = {1{`RANDOM}};
  tagArray_0_6 = _RAND_456[23:0];
  _RAND_457 = {1{`RANDOM}};
  tagArray_0_7 = _RAND_457[23:0];
  _RAND_458 = {1{`RANDOM}};
  tagArray_0_8 = _RAND_458[23:0];
  _RAND_459 = {1{`RANDOM}};
  tagArray_0_9 = _RAND_459[23:0];
  _RAND_460 = {1{`RANDOM}};
  tagArray_0_10 = _RAND_460[23:0];
  _RAND_461 = {1{`RANDOM}};
  tagArray_0_11 = _RAND_461[23:0];
  _RAND_462 = {1{`RANDOM}};
  tagArray_0_12 = _RAND_462[23:0];
  _RAND_463 = {1{`RANDOM}};
  tagArray_0_13 = _RAND_463[23:0];
  _RAND_464 = {1{`RANDOM}};
  tagArray_0_14 = _RAND_464[23:0];
  _RAND_465 = {1{`RANDOM}};
  tagArray_0_15 = _RAND_465[23:0];
  _RAND_466 = {1{`RANDOM}};
  tagArray_1_0 = _RAND_466[23:0];
  _RAND_467 = {1{`RANDOM}};
  tagArray_1_1 = _RAND_467[23:0];
  _RAND_468 = {1{`RANDOM}};
  tagArray_1_2 = _RAND_468[23:0];
  _RAND_469 = {1{`RANDOM}};
  tagArray_1_3 = _RAND_469[23:0];
  _RAND_470 = {1{`RANDOM}};
  tagArray_1_4 = _RAND_470[23:0];
  _RAND_471 = {1{`RANDOM}};
  tagArray_1_5 = _RAND_471[23:0];
  _RAND_472 = {1{`RANDOM}};
  tagArray_1_6 = _RAND_472[23:0];
  _RAND_473 = {1{`RANDOM}};
  tagArray_1_7 = _RAND_473[23:0];
  _RAND_474 = {1{`RANDOM}};
  tagArray_1_8 = _RAND_474[23:0];
  _RAND_475 = {1{`RANDOM}};
  tagArray_1_9 = _RAND_475[23:0];
  _RAND_476 = {1{`RANDOM}};
  tagArray_1_10 = _RAND_476[23:0];
  _RAND_477 = {1{`RANDOM}};
  tagArray_1_11 = _RAND_477[23:0];
  _RAND_478 = {1{`RANDOM}};
  tagArray_1_12 = _RAND_478[23:0];
  _RAND_479 = {1{`RANDOM}};
  tagArray_1_13 = _RAND_479[23:0];
  _RAND_480 = {1{`RANDOM}};
  tagArray_1_14 = _RAND_480[23:0];
  _RAND_481 = {1{`RANDOM}};
  tagArray_1_15 = _RAND_481[23:0];
  _RAND_482 = {1{`RANDOM}};
  validArray_0_0 = _RAND_482[0:0];
  _RAND_483 = {1{`RANDOM}};
  validArray_0_1 = _RAND_483[0:0];
  _RAND_484 = {1{`RANDOM}};
  validArray_0_2 = _RAND_484[0:0];
  _RAND_485 = {1{`RANDOM}};
  validArray_0_3 = _RAND_485[0:0];
  _RAND_486 = {1{`RANDOM}};
  validArray_0_4 = _RAND_486[0:0];
  _RAND_487 = {1{`RANDOM}};
  validArray_0_5 = _RAND_487[0:0];
  _RAND_488 = {1{`RANDOM}};
  validArray_0_6 = _RAND_488[0:0];
  _RAND_489 = {1{`RANDOM}};
  validArray_0_7 = _RAND_489[0:0];
  _RAND_490 = {1{`RANDOM}};
  validArray_0_8 = _RAND_490[0:0];
  _RAND_491 = {1{`RANDOM}};
  validArray_0_9 = _RAND_491[0:0];
  _RAND_492 = {1{`RANDOM}};
  validArray_0_10 = _RAND_492[0:0];
  _RAND_493 = {1{`RANDOM}};
  validArray_0_11 = _RAND_493[0:0];
  _RAND_494 = {1{`RANDOM}};
  validArray_0_12 = _RAND_494[0:0];
  _RAND_495 = {1{`RANDOM}};
  validArray_0_13 = _RAND_495[0:0];
  _RAND_496 = {1{`RANDOM}};
  validArray_0_14 = _RAND_496[0:0];
  _RAND_497 = {1{`RANDOM}};
  validArray_0_15 = _RAND_497[0:0];
  _RAND_498 = {1{`RANDOM}};
  validArray_1_0 = _RAND_498[0:0];
  _RAND_499 = {1{`RANDOM}};
  validArray_1_1 = _RAND_499[0:0];
  _RAND_500 = {1{`RANDOM}};
  validArray_1_2 = _RAND_500[0:0];
  _RAND_501 = {1{`RANDOM}};
  validArray_1_3 = _RAND_501[0:0];
  _RAND_502 = {1{`RANDOM}};
  validArray_1_4 = _RAND_502[0:0];
  _RAND_503 = {1{`RANDOM}};
  validArray_1_5 = _RAND_503[0:0];
  _RAND_504 = {1{`RANDOM}};
  validArray_1_6 = _RAND_504[0:0];
  _RAND_505 = {1{`RANDOM}};
  validArray_1_7 = _RAND_505[0:0];
  _RAND_506 = {1{`RANDOM}};
  validArray_1_8 = _RAND_506[0:0];
  _RAND_507 = {1{`RANDOM}};
  validArray_1_9 = _RAND_507[0:0];
  _RAND_508 = {1{`RANDOM}};
  validArray_1_10 = _RAND_508[0:0];
  _RAND_509 = {1{`RANDOM}};
  validArray_1_11 = _RAND_509[0:0];
  _RAND_510 = {1{`RANDOM}};
  validArray_1_12 = _RAND_510[0:0];
  _RAND_511 = {1{`RANDOM}};
  validArray_1_13 = _RAND_511[0:0];
  _RAND_512 = {1{`RANDOM}};
  validArray_1_14 = _RAND_512[0:0];
  _RAND_513 = {1{`RANDOM}};
  validArray_1_15 = _RAND_513[0:0];
  _RAND_514 = {1{`RANDOM}};
  dirtyArray_0_0 = _RAND_514[0:0];
  _RAND_515 = {1{`RANDOM}};
  dirtyArray_0_1 = _RAND_515[0:0];
  _RAND_516 = {1{`RANDOM}};
  dirtyArray_0_2 = _RAND_516[0:0];
  _RAND_517 = {1{`RANDOM}};
  dirtyArray_0_3 = _RAND_517[0:0];
  _RAND_518 = {1{`RANDOM}};
  dirtyArray_0_4 = _RAND_518[0:0];
  _RAND_519 = {1{`RANDOM}};
  dirtyArray_0_5 = _RAND_519[0:0];
  _RAND_520 = {1{`RANDOM}};
  dirtyArray_0_6 = _RAND_520[0:0];
  _RAND_521 = {1{`RANDOM}};
  dirtyArray_0_7 = _RAND_521[0:0];
  _RAND_522 = {1{`RANDOM}};
  dirtyArray_0_8 = _RAND_522[0:0];
  _RAND_523 = {1{`RANDOM}};
  dirtyArray_0_9 = _RAND_523[0:0];
  _RAND_524 = {1{`RANDOM}};
  dirtyArray_0_10 = _RAND_524[0:0];
  _RAND_525 = {1{`RANDOM}};
  dirtyArray_0_11 = _RAND_525[0:0];
  _RAND_526 = {1{`RANDOM}};
  dirtyArray_0_12 = _RAND_526[0:0];
  _RAND_527 = {1{`RANDOM}};
  dirtyArray_0_13 = _RAND_527[0:0];
  _RAND_528 = {1{`RANDOM}};
  dirtyArray_0_14 = _RAND_528[0:0];
  _RAND_529 = {1{`RANDOM}};
  dirtyArray_0_15 = _RAND_529[0:0];
  _RAND_530 = {1{`RANDOM}};
  dirtyArray_1_0 = _RAND_530[0:0];
  _RAND_531 = {1{`RANDOM}};
  dirtyArray_1_1 = _RAND_531[0:0];
  _RAND_532 = {1{`RANDOM}};
  dirtyArray_1_2 = _RAND_532[0:0];
  _RAND_533 = {1{`RANDOM}};
  dirtyArray_1_3 = _RAND_533[0:0];
  _RAND_534 = {1{`RANDOM}};
  dirtyArray_1_4 = _RAND_534[0:0];
  _RAND_535 = {1{`RANDOM}};
  dirtyArray_1_5 = _RAND_535[0:0];
  _RAND_536 = {1{`RANDOM}};
  dirtyArray_1_6 = _RAND_536[0:0];
  _RAND_537 = {1{`RANDOM}};
  dirtyArray_1_7 = _RAND_537[0:0];
  _RAND_538 = {1{`RANDOM}};
  dirtyArray_1_8 = _RAND_538[0:0];
  _RAND_539 = {1{`RANDOM}};
  dirtyArray_1_9 = _RAND_539[0:0];
  _RAND_540 = {1{`RANDOM}};
  dirtyArray_1_10 = _RAND_540[0:0];
  _RAND_541 = {1{`RANDOM}};
  dirtyArray_1_11 = _RAND_541[0:0];
  _RAND_542 = {1{`RANDOM}};
  dirtyArray_1_12 = _RAND_542[0:0];
  _RAND_543 = {1{`RANDOM}};
  dirtyArray_1_13 = _RAND_543[0:0];
  _RAND_544 = {1{`RANDOM}};
  dirtyArray_1_14 = _RAND_544[0:0];
  _RAND_545 = {1{`RANDOM}};
  dirtyArray_1_15 = _RAND_545[0:0];
  _RAND_546 = {1{`RANDOM}};
  off = _RAND_546[1:0];
  _RAND_547 = {1{`RANDOM}};
  state_dcache = _RAND_547[3:0];
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
  input  [7:0]  axi_aw_bits_len,
  output        axi_w_ready,
  input         axi_w_valid,
  input  [31:0] axi_w_bits_data
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
  assign RamBB_i1_clock = clock; // @[sram_Axi.scala 156:25]
  assign RamBB_i1_addr = reg_addr; // @[sram_Axi.scala 157:25]
  assign RamBB_i1_mem_wen = _T_10 | _T_9; // @[Mux.scala 81:58]
  assign RamBB_i1_valid = _T_10 | (_T_9 | (_T_6 | _T_5)); // @[Mux.scala 81:58]
  assign RamBB_i1_wdata = axi_w_bits_data; // @[sram_Axi.scala 168:25]
  assign RamBB_i1_wmask = 4'hf; // @[sram_Axi.scala 169:25]
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
        reg_AxLen <= axi_aw_bits_len; // @[sram_Axi.scala 110:28]
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
        reg_burst <= 2'h1; // @[sram_Axi.scala 112:28]
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
  wire  EXU_i_lsu_to_cache_ready; // @[core.scala 36:27]
  wire  EXU_i_lsu_to_cache_valid; // @[core.scala 36:27]
  wire [31:0] EXU_i_lsu_to_cache_bits_addr; // @[core.scala 36:27]
  wire [31:0] EXU_i_lsu_to_cache_bits_wdata; // @[core.scala 36:27]
  wire  EXU_i_lsu_to_cache_bits_is_write; // @[core.scala 36:27]
  wire [31:0] EXU_i_lsu_to_cache_bits_wmask; // @[core.scala 36:27]
  wire  EXU_i_lsu_from_cache_valid; // @[core.scala 36:27]
  wire [31:0] EXU_i_lsu_from_cache_bits_data; // @[core.scala 36:27]
  wire  EXU_i_lsu_from_cache_bits_bresp; // @[core.scala 36:27]
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
  wire  IFU_i_clock; // @[core.scala 40:27]
  wire  IFU_i_reset; // @[core.scala 40:27]
  wire  IFU_i_to_IDU_valid; // @[core.scala 40:27]
  wire [31:0] IFU_i_to_IDU_bits_inst; // @[core.scala 40:27]
  wire [31:0] IFU_i_to_IDU_bits_pc; // @[core.scala 40:27]
  wire  IFU_i_from_EXU_bits_bru_ctrl_br; // @[core.scala 40:27]
  wire [31:0] IFU_i_from_EXU_bits_bru_addr; // @[core.scala 40:27]
  wire  IFU_i_from_EXU_bits_csr_ctrl_br; // @[core.scala 40:27]
  wire [31:0] IFU_i_from_EXU_bits_csr_addr; // @[core.scala 40:27]
  wire  IFU_i_from_WBU_ready; // @[core.scala 40:27]
  wire  IFU_i_from_WBU_valid; // @[core.scala 40:27]
  wire  IFU_i_axi_ar_ready; // @[core.scala 40:27]
  wire  IFU_i_axi_ar_valid; // @[core.scala 40:27]
  wire [31:0] IFU_i_axi_ar_bits_addr; // @[core.scala 40:27]
  wire  IFU_i_axi_r_ready; // @[core.scala 40:27]
  wire  IFU_i_axi_r_valid; // @[core.scala 40:27]
  wire [31:0] IFU_i_axi_r_bits_data; // @[core.scala 40:27]
  wire  sram_i_clock; // @[core.scala 41:27]
  wire  sram_i_reset; // @[core.scala 41:27]
  wire  sram_i_axi_ar_ready; // @[core.scala 41:27]
  wire  sram_i_axi_ar_valid; // @[core.scala 41:27]
  wire [31:0] sram_i_axi_ar_bits_addr; // @[core.scala 41:27]
  wire  sram_i_axi_r_ready; // @[core.scala 41:27]
  wire  sram_i_axi_r_valid; // @[core.scala 41:27]
  wire [31:0] sram_i_axi_r_bits_data; // @[core.scala 41:27]
  wire  dcache_clock; // @[core.scala 62:27]
  wire  dcache_reset; // @[core.scala 62:27]
  wire  dcache_from_LSU_ready; // @[core.scala 62:27]
  wire  dcache_from_LSU_valid; // @[core.scala 62:27]
  wire [31:0] dcache_from_LSU_bits_addr; // @[core.scala 62:27]
  wire [31:0] dcache_from_LSU_bits_wdata; // @[core.scala 62:27]
  wire  dcache_from_LSU_bits_is_write; // @[core.scala 62:27]
  wire [31:0] dcache_from_LSU_bits_wmask; // @[core.scala 62:27]
  wire  dcache_to_LSU_valid; // @[core.scala 62:27]
  wire [31:0] dcache_to_LSU_bits_data; // @[core.scala 62:27]
  wire  dcache_to_LSU_bits_bresp; // @[core.scala 62:27]
  wire  dcache_to_sram_ar_ready; // @[core.scala 62:27]
  wire  dcache_to_sram_ar_valid; // @[core.scala 62:27]
  wire [31:0] dcache_to_sram_ar_bits_addr; // @[core.scala 62:27]
  wire [7:0] dcache_to_sram_ar_bits_len; // @[core.scala 62:27]
  wire  dcache_to_sram_r_ready; // @[core.scala 62:27]
  wire  dcache_to_sram_r_valid; // @[core.scala 62:27]
  wire [31:0] dcache_to_sram_r_bits_data; // @[core.scala 62:27]
  wire  dcache_to_sram_r_bits_last; // @[core.scala 62:27]
  wire  dcache_to_sram_aw_ready; // @[core.scala 62:27]
  wire  dcache_to_sram_aw_valid; // @[core.scala 62:27]
  wire [31:0] dcache_to_sram_aw_bits_addr; // @[core.scala 62:27]
  wire [7:0] dcache_to_sram_aw_bits_len; // @[core.scala 62:27]
  wire  dcache_to_sram_w_ready; // @[core.scala 62:27]
  wire  dcache_to_sram_w_valid; // @[core.scala 62:27]
  wire [31:0] dcache_to_sram_w_bits_data; // @[core.scala 62:27]
  wire  dcache_to_sram_w_bits_last; // @[core.scala 62:27]
  wire  sram_i2_clock; // @[core.scala 63:27]
  wire  sram_i2_reset; // @[core.scala 63:27]
  wire  sram_i2_axi_ar_ready; // @[core.scala 63:27]
  wire  sram_i2_axi_ar_valid; // @[core.scala 63:27]
  wire [31:0] sram_i2_axi_ar_bits_addr; // @[core.scala 63:27]
  wire [7:0] sram_i2_axi_ar_bits_len; // @[core.scala 63:27]
  wire  sram_i2_axi_r_ready; // @[core.scala 63:27]
  wire  sram_i2_axi_r_valid; // @[core.scala 63:27]
  wire [31:0] sram_i2_axi_r_bits_data; // @[core.scala 63:27]
  wire  sram_i2_axi_r_bits_last; // @[core.scala 63:27]
  wire  sram_i2_axi_aw_ready; // @[core.scala 63:27]
  wire  sram_i2_axi_aw_valid; // @[core.scala 63:27]
  wire [31:0] sram_i2_axi_aw_bits_addr; // @[core.scala 63:27]
  wire [7:0] sram_i2_axi_aw_bits_len; // @[core.scala 63:27]
  wire  sram_i2_axi_w_ready; // @[core.scala 63:27]
  wire  sram_i2_axi_w_valid; // @[core.scala 63:27]
  wire [31:0] sram_i2_axi_w_bits_data; // @[core.scala 63:27]
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
    .lsu_to_cache_ready(EXU_i_lsu_to_cache_ready),
    .lsu_to_cache_valid(EXU_i_lsu_to_cache_valid),
    .lsu_to_cache_bits_addr(EXU_i_lsu_to_cache_bits_addr),
    .lsu_to_cache_bits_wdata(EXU_i_lsu_to_cache_bits_wdata),
    .lsu_to_cache_bits_is_write(EXU_i_lsu_to_cache_bits_is_write),
    .lsu_to_cache_bits_wmask(EXU_i_lsu_to_cache_bits_wmask),
    .lsu_from_cache_valid(EXU_i_lsu_from_cache_valid),
    .lsu_from_cache_bits_data(EXU_i_lsu_from_cache_bits_data),
    .lsu_from_cache_bits_bresp(EXU_i_lsu_from_cache_bits_bresp)
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
  IFU IFU_i ( // @[core.scala 40:27]
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
    .axi_ar_ready(IFU_i_axi_ar_ready),
    .axi_ar_valid(IFU_i_axi_ar_valid),
    .axi_ar_bits_addr(IFU_i_axi_ar_bits_addr),
    .axi_r_ready(IFU_i_axi_r_ready),
    .axi_r_valid(IFU_i_axi_r_valid),
    .axi_r_bits_data(IFU_i_axi_r_bits_data)
  );
  SRAM sram_i ( // @[core.scala 41:27]
    .clock(sram_i_clock),
    .reset(sram_i_reset),
    .axi_ar_ready(sram_i_axi_ar_ready),
    .axi_ar_valid(sram_i_axi_ar_valid),
    .axi_ar_bits_addr(sram_i_axi_ar_bits_addr),
    .axi_r_ready(sram_i_axi_r_ready),
    .axi_r_valid(sram_i_axi_r_valid),
    .axi_r_bits_data(sram_i_axi_r_bits_data)
  );
  D_Cache dcache ( // @[core.scala 62:27]
    .clock(dcache_clock),
    .reset(dcache_reset),
    .from_LSU_ready(dcache_from_LSU_ready),
    .from_LSU_valid(dcache_from_LSU_valid),
    .from_LSU_bits_addr(dcache_from_LSU_bits_addr),
    .from_LSU_bits_wdata(dcache_from_LSU_bits_wdata),
    .from_LSU_bits_is_write(dcache_from_LSU_bits_is_write),
    .from_LSU_bits_wmask(dcache_from_LSU_bits_wmask),
    .to_LSU_valid(dcache_to_LSU_valid),
    .to_LSU_bits_data(dcache_to_LSU_bits_data),
    .to_LSU_bits_bresp(dcache_to_LSU_bits_bresp),
    .to_sram_ar_ready(dcache_to_sram_ar_ready),
    .to_sram_ar_valid(dcache_to_sram_ar_valid),
    .to_sram_ar_bits_addr(dcache_to_sram_ar_bits_addr),
    .to_sram_ar_bits_len(dcache_to_sram_ar_bits_len),
    .to_sram_r_ready(dcache_to_sram_r_ready),
    .to_sram_r_valid(dcache_to_sram_r_valid),
    .to_sram_r_bits_data(dcache_to_sram_r_bits_data),
    .to_sram_r_bits_last(dcache_to_sram_r_bits_last),
    .to_sram_aw_ready(dcache_to_sram_aw_ready),
    .to_sram_aw_valid(dcache_to_sram_aw_valid),
    .to_sram_aw_bits_addr(dcache_to_sram_aw_bits_addr),
    .to_sram_aw_bits_len(dcache_to_sram_aw_bits_len),
    .to_sram_w_ready(dcache_to_sram_w_ready),
    .to_sram_w_valid(dcache_to_sram_w_valid),
    .to_sram_w_bits_data(dcache_to_sram_w_bits_data),
    .to_sram_w_bits_last(dcache_to_sram_w_bits_last)
  );
  sram_axi_rw sram_i2 ( // @[core.scala 63:27]
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
    .axi_aw_bits_len(sram_i2_axi_aw_bits_len),
    .axi_w_ready(sram_i2_axi_w_ready),
    .axi_w_valid(sram_i2_axi_w_valid),
    .axi_w_bits_data(sram_i2_axi_w_bits_data)
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
  assign EXU_i_lsu_to_cache_ready = dcache_from_LSU_ready; // @[Connect.scala 17:22]
  assign EXU_i_lsu_from_cache_valid = dcache_to_LSU_valid; // @[Connect.scala 16:22]
  assign EXU_i_lsu_from_cache_bits_data = dcache_to_LSU_bits_data; // @[Connect.scala 15:22]
  assign EXU_i_lsu_from_cache_bits_bresp = dcache_to_LSU_bits_bresp; // @[Connect.scala 15:22]
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
  assign IFU_i_axi_ar_ready = sram_i_axi_ar_ready; // @[Connect.scala 17:22]
  assign IFU_i_axi_r_valid = sram_i_axi_r_valid; // @[Connect.scala 16:22]
  assign IFU_i_axi_r_bits_data = sram_i_axi_r_bits_data; // @[Connect.scala 15:22]
  assign sram_i_clock = clock;
  assign sram_i_reset = reset;
  assign sram_i_axi_ar_valid = IFU_i_axi_ar_valid; // @[Connect.scala 16:22]
  assign sram_i_axi_ar_bits_addr = IFU_i_axi_ar_bits_addr; // @[Connect.scala 15:22]
  assign sram_i_axi_r_ready = IFU_i_axi_r_ready; // @[Connect.scala 17:22]
  assign dcache_clock = clock;
  assign dcache_reset = reset;
  assign dcache_from_LSU_valid = EXU_i_lsu_to_cache_valid; // @[Connect.scala 16:22]
  assign dcache_from_LSU_bits_addr = EXU_i_lsu_to_cache_bits_addr; // @[Connect.scala 15:22]
  assign dcache_from_LSU_bits_wdata = EXU_i_lsu_to_cache_bits_wdata; // @[Connect.scala 15:22]
  assign dcache_from_LSU_bits_is_write = EXU_i_lsu_to_cache_bits_is_write; // @[Connect.scala 15:22]
  assign dcache_from_LSU_bits_wmask = EXU_i_lsu_to_cache_bits_wmask; // @[Connect.scala 15:22]
  assign dcache_to_sram_ar_ready = sram_i2_axi_ar_ready; // @[Connect.scala 17:22]
  assign dcache_to_sram_r_valid = sram_i2_axi_r_valid; // @[Connect.scala 16:22]
  assign dcache_to_sram_r_bits_data = sram_i2_axi_r_bits_data; // @[Connect.scala 15:22]
  assign dcache_to_sram_r_bits_last = sram_i2_axi_r_bits_last; // @[Connect.scala 15:22]
  assign dcache_to_sram_aw_ready = sram_i2_axi_aw_ready; // @[Connect.scala 17:22]
  assign dcache_to_sram_w_ready = sram_i2_axi_w_ready; // @[Connect.scala 17:22]
  assign sram_i2_clock = clock;
  assign sram_i2_reset = reset;
  assign sram_i2_axi_ar_valid = dcache_to_sram_ar_valid; // @[Connect.scala 16:22]
  assign sram_i2_axi_ar_bits_addr = dcache_to_sram_ar_bits_addr; // @[Connect.scala 15:22]
  assign sram_i2_axi_ar_bits_len = dcache_to_sram_ar_bits_len; // @[Connect.scala 15:22]
  assign sram_i2_axi_r_ready = dcache_to_sram_r_ready; // @[Connect.scala 17:22]
  assign sram_i2_axi_aw_valid = dcache_to_sram_aw_valid; // @[Connect.scala 16:22]
  assign sram_i2_axi_aw_bits_addr = dcache_to_sram_aw_bits_addr; // @[Connect.scala 15:22]
  assign sram_i2_axi_aw_bits_len = dcache_to_sram_aw_bits_len; // @[Connect.scala 15:22]
  assign sram_i2_axi_w_valid = dcache_to_sram_w_valid; // @[Connect.scala 16:22]
  assign sram_i2_axi_w_bits_data = dcache_to_sram_w_bits_data; // @[Connect.scala 15:22]
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
