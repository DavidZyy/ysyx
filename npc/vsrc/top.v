/* verilator lint_off DECLFILENAME */
/* verilator lint_off UNUSEDSIGNAL */
/* verilator lint_off UNDRIVEN */
/* verilator lint_off UNOPTFLAT */
/* verilator lint_off WIDTHEXPAND */
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
  reg [31:0] reg_PC; // @[IFU.scala 37:26]
  wire [31:0] _next_PC_T_1 = reg_PC + 32'h4; // @[IFU.scala 46:27]
  wire  _reg_PC_T = from_WBU_ready & from_WBU_valid; // @[Decoupled.scala 51:35]
  reg [1:0] state; // @[IFU.scala 79:24]
  wire [1:0] _state_T = axi_ar_ready ? 2'h1 : 2'h0; // @[IFU.scala 81:28]
  assign to_IDU_valid = 2'h2 == state; // @[Mux.scala 81:61]
  assign to_IDU_bits_inst = to_IDU_valid ? axi_r_bits_data : 32'h13; // @[IFU.scala 56:31]
  assign to_IDU_bits_pc = reg_PC; // @[IFU.scala 64:25]
  assign from_WBU_ready = 2'h2 == state; // @[Mux.scala 81:61]
  assign axi_ar_valid = 2'h0 == state; // @[Mux.scala 81:61]
  assign axi_ar_bits_addr = reg_PC; // @[IFU.scala 53:22]
  assign axi_r_ready = 2'h1 == state; // @[Mux.scala 81:61]
  always @(posedge clock) begin
    if (reset) begin // @[IFU.scala 37:26]
      reg_PC <= 32'h80000000; // @[IFU.scala 37:26]
    end else if (_reg_PC_T) begin // @[IFU.scala 51:18]
      if (from_EXU_bits_bru_ctrl_br) begin // @[IFU.scala 41:38]
        reg_PC <= from_EXU_bits_bru_addr; // @[IFU.scala 42:17]
      end else if (from_EXU_bits_csr_ctrl_br) begin // @[IFU.scala 43:45]
        reg_PC <= from_EXU_bits_csr_addr; // @[IFU.scala 44:17]
      end else begin
        reg_PC <= _next_PC_T_1; // @[IFU.scala 46:17]
      end
    end
    if (reset) begin // @[IFU.scala 79:24]
      state <= 2'h0; // @[IFU.scala 79:24]
    end else if (2'h2 == state) begin // @[Mux.scala 81:58]
      if (from_WBU_valid) begin // @[IFU.scala 83:28]
        state <= 2'h0;
      end else begin
        state <= 2'h2;
      end
    end else if (2'h1 == state) begin // @[Mux.scala 81:58]
      if (axi_r_valid) begin // @[IFU.scala 82:28]
        state <= 2'h2;
      end else begin
        state <= 2'h1;
      end
    end else if (2'h0 == state) begin // @[Mux.scala 81:58]
      state <= _state_T;
    end else begin
      state <= 2'h0;
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
  state = _RAND_1[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
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
  output        to_EXU_valid,
  output [31:0] to_EXU_bits_imm,
  output [31:0] to_EXU_bits_pc,
  output [31:0] to_EXU_bits_rdata1,
  output [31:0] to_EXU_bits_rdata2,
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
  assign to_EXU_bits_rdata1 = RegFile_i_io_out_rdata1; // @[ISU.scala 35:26]
  assign to_EXU_bits_rdata2 = RegFile_i_io_out_rdata2; // @[ISU.scala 36:26]
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
  assign RegFile_i_io_in_rd = from_IDU_bits_rd; // @[ISU.scala 23:29]
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
module Lsu(
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
  output        axi_aw_valid,
  output        axi_w_valid,
  output [31:0] axi_w_bits_data,
  output [3:0]  axi_w_bits_strb,
  output        axi_b_ready,
  input         axi_b_valid,
  output        axi_ar_valid,
  output [31:0] axi_ar_bits_addr,
  output        axi_r_ready,
  input         axi_r_valid,
  input  [31:0] axi_r_bits_data
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire  RamBB_i1_clock; // @[lsu.scala 100:26]
  wire [31:0] RamBB_i1_addr; // @[lsu.scala 100:26]
  wire  RamBB_i1_mem_wen; // @[lsu.scala 100:26]
  wire  RamBB_i1_valid; // @[lsu.scala 100:26]
  wire [31:0] RamBB_i1_wdata; // @[lsu.scala 100:26]
  wire [3:0] RamBB_i1_wmask; // @[lsu.scala 100:26]
  wire [31:0] RamBB_i1_rdata; // @[lsu.scala 100:26]
  reg [2:0] state; // @[lsu.scala 47:24]
  wire  _state_T = axi_r_ready & axi_r_valid; // @[Decoupled.scala 51:35]
  wire [2:0] _state_T_1 = _state_T ? 3'h5 : 3'h2; // @[lsu.scala 65:25]
  wire  _state_T_2 = axi_b_ready & axi_b_valid; // @[Decoupled.scala 51:35]
  wire [2:0] _state_T_3 = _state_T_2 ? 3'h5 : 3'h4; // @[lsu.scala 72:25]
  wire [2:0] _GEN_2 = 3'h5 == state ? 3'h0 : state; // @[lsu.scala 49:20 75:19 47:24]
  wire [2:0] _GEN_3 = 3'h4 == state ? _state_T_3 : _GEN_2; // @[lsu.scala 49:20 72:19]
  wire [2:0] _GEN_4 = 3'h3 == state ? 3'h4 : _GEN_3; // @[lsu.scala 49:20 69:19]
  wire [1:0] addr_low_2 = io_in_addr[1:0]; // @[lsu.scala 96:31]
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
  wire [31:0] _io_out_rdata_T_3 = 4'h1 == io_in_op ? lb_rdata : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _io_out_rdata_T_5 = 4'h4 == io_in_op ? lbu_rdata : _io_out_rdata_T_3; // @[Mux.scala 81:58]
  wire [31:0] _io_out_rdata_T_7 = 4'h2 == io_in_op ? lh_rdata : _io_out_rdata_T_5; // @[Mux.scala 81:58]
  wire [31:0] _io_out_rdata_T_9 = 4'h5 == io_in_op ? lhu_rdata : _io_out_rdata_T_7; // @[Mux.scala 81:58]
  wire [1:0] _sb_wmask_T_1 = 2'h1 == addr_low_2 ? 2'h2 : 2'h1; // @[Mux.scala 81:58]
  wire [2:0] _sb_wmask_T_3 = 2'h2 == addr_low_2 ? 3'h4 : {{1'd0}, _sb_wmask_T_1}; // @[Mux.scala 81:58]
  wire [3:0] sb_wmask = 2'h3 == addr_low_2 ? 4'h8 : {{1'd0}, _sb_wmask_T_3}; // @[Mux.scala 81:58]
  wire [1:0] _sh_wmask_T_1 = 2'h0 == addr_low_2 ? 2'h3 : 2'h0; // @[Mux.scala 81:58]
  wire [3:0] sh_wmask = 2'h2 == addr_low_2 ? 4'hc : {{2'd0}, _sh_wmask_T_1}; // @[Mux.scala 81:58]
  wire [3:0] _wmask_T_1 = 4'h6 == io_in_op ? sb_wmask : 4'h0; // @[Mux.scala 81:58]
  wire [3:0] _wmask_T_3 = 4'h7 == io_in_op ? sh_wmask : _wmask_T_1; // @[Mux.scala 81:58]
  RamBB RamBB_i1 ( // @[lsu.scala 100:26]
    .clock(RamBB_i1_clock),
    .addr(RamBB_i1_addr),
    .mem_wen(RamBB_i1_mem_wen),
    .valid(RamBB_i1_valid),
    .wdata(RamBB_i1_wdata),
    .wmask(RamBB_i1_wmask),
    .rdata(RamBB_i1_rdata)
  );
  assign io_out_rdata = 4'h3 == io_in_op ? axi_r_bits_data : _io_out_rdata_T_9; // @[Mux.scala 81:58]
  assign io_out_end = 3'h5 == state; // @[Mux.scala 81:61]
  assign io_out_idle = 3'h0 == state; // @[Mux.scala 81:61]
  assign axi_aw_valid = 3'h3 == state; // @[Mux.scala 81:61]
  assign axi_w_valid = 3'h3 == state; // @[Mux.scala 81:61]
  assign axi_w_bits_data = io_in_wdata; // @[lsu.scala 91:22]
  assign axi_w_bits_strb = 4'h8 == io_in_op ? 4'hf : _wmask_T_3; // @[Mux.scala 81:58]
  assign axi_b_ready = 3'h4 == state; // @[Mux.scala 81:61]
  assign axi_ar_valid = 3'h1 == state; // @[Mux.scala 81:61]
  assign axi_ar_bits_addr = io_in_addr; // @[lsu.scala 89:22]
  assign axi_r_ready = 3'h2 == state; // @[Mux.scala 81:61]
  assign RamBB_i1_clock = clock; // @[lsu.scala 102:25]
  assign RamBB_i1_addr = io_in_addr; // @[lsu.scala 103:25]
  assign RamBB_i1_mem_wen = io_in_mem_wen; // @[lsu.scala 104:25]
  assign RamBB_i1_valid = io_in_valid; // @[lsu.scala 105:25]
  assign RamBB_i1_wdata = io_in_wdata; // @[lsu.scala 178:25]
  assign RamBB_i1_wmask = 4'h8 == io_in_op ? 4'hf : _wmask_T_3; // @[Mux.scala 81:58]
  always @(posedge clock) begin
    if (reset) begin // @[lsu.scala 47:24]
      state <= 3'h0; // @[lsu.scala 47:24]
    end else if (3'h0 == state) begin // @[lsu.scala 49:20]
      if (io_in_valid) begin // @[lsu.scala 51:32]
        if (io_in_mem_wen) begin // @[lsu.scala 52:38]
          state <= 3'h3; // @[lsu.scala 53:27]
        end else begin
          state <= 3'h1; // @[lsu.scala 55:27]
        end
      end else begin
        state <= 3'h0; // @[lsu.scala 58:23]
      end
    end else if (3'h1 == state) begin // @[lsu.scala 49:20]
      state <= 3'h2; // @[lsu.scala 62:19]
    end else if (3'h2 == state) begin // @[lsu.scala 49:20]
      state <= _state_T_1; // @[lsu.scala 65:19]
    end else begin
      state <= _GEN_4;
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
  state = _RAND_0[2:0];
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
module SRAM_lsu(
  input         clock,
  input         reset,
  output        axi_aw_ready,
  input         axi_aw_valid,
  output        axi_w_ready,
  input         axi_w_valid,
  input  [31:0] axi_w_bits_data,
  input  [3:0]  axi_w_bits_strb,
  input         axi_b_ready,
  output        axi_b_valid,
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
  wire  RamBB_i1_clock; // @[sram.scala 139:26]
  wire [31:0] RamBB_i1_addr; // @[sram.scala 139:26]
  wire  RamBB_i1_mem_wen; // @[sram.scala 139:26]
  wire  RamBB_i1_valid; // @[sram.scala 139:26]
  wire [31:0] RamBB_i1_wdata; // @[sram.scala 139:26]
  wire [3:0] RamBB_i1_wmask; // @[sram.scala 139:26]
  wire [31:0] RamBB_i1_rdata; // @[sram.scala 139:26]
  reg [2:0] state; // @[sram.scala 98:24]
  wire  _axi_ar_ready_T = 3'h0 == state; // @[Mux.scala 81:61]
  wire  _axi_r_valid_T = 3'h2 == state; // @[Mux.scala 81:61]
  wire  _axi_b_valid_T = 3'h4 == state; // @[Mux.scala 81:61]
  reg  delay; // @[sram.scala 108:24]
  wire  _T_1 = axi_ar_ready & axi_ar_valid; // @[Decoupled.scala 51:35]
  wire  _T_2 = axi_aw_ready & axi_aw_valid; // @[Decoupled.scala 51:35]
  wire  _T_3 = axi_w_ready & axi_w_valid; // @[Decoupled.scala 51:35]
  wire  _state_T = ~delay; // @[sram.scala 124:32]
  wire  _delay_T_1 = delay - 1'h1; // @[sram.scala 125:28]
  wire  _state_T_2 = axi_r_ready & axi_r_valid; // @[Decoupled.scala 51:35]
  wire [2:0] _state_T_3 = _state_T_2 ? 3'h0 : 3'h2; // @[sram.scala 128:25]
  wire [2:0] _state_T_5 = _state_T ? 3'h4 : 3'h3; // @[sram.scala 131:25]
  wire  _state_T_6 = axi_b_ready & axi_b_valid; // @[Decoupled.scala 51:35]
  wire [2:0] _state_T_7 = _state_T_6 ? 3'h0 : 3'h4; // @[sram.scala 135:25]
  wire [2:0] _GEN_2 = _axi_b_valid_T ? _state_T_7 : state; // @[sram.scala 110:20 135:19 98:24]
  wire [2:0] _GEN_3 = 3'h3 == state ? _state_T_5 : _GEN_2; // @[sram.scala 110:20 131:19]
  wire  _GEN_4 = 3'h3 == state ? _delay_T_1 : delay; // @[sram.scala 110:20 132:19 108:24]
  RamBB RamBB_i1 ( // @[sram.scala 139:26]
    .clock(RamBB_i1_clock),
    .addr(RamBB_i1_addr),
    .mem_wen(RamBB_i1_mem_wen),
    .valid(RamBB_i1_valid),
    .wdata(RamBB_i1_wdata),
    .wmask(RamBB_i1_wmask),
    .rdata(RamBB_i1_rdata)
  );
  assign axi_aw_ready = 3'h0 == state; // @[Mux.scala 81:61]
  assign axi_w_ready = 3'h0 == state; // @[Mux.scala 81:61]
  assign axi_b_valid = 3'h4 == state; // @[Mux.scala 81:61]
  assign axi_ar_ready = 3'h0 == state; // @[Mux.scala 81:61]
  assign axi_r_valid = 3'h2 == state; // @[Mux.scala 81:61]
  assign axi_r_bits_data = RamBB_i1_rdata; // @[sram.scala 155:21]
  assign RamBB_i1_clock = clock; // @[sram.scala 141:25]
  assign RamBB_i1_addr = axi_ar_bits_addr; // @[sram.scala 142:25]
  assign RamBB_i1_mem_wen = 3'h4 == state; // @[Mux.scala 81:61]
  assign RamBB_i1_valid = 3'h4 == state | 3'h2 == state; // @[Mux.scala 81:58]
  assign RamBB_i1_wdata = axi_w_bits_data; // @[sram.scala 152:25]
  assign RamBB_i1_wmask = axi_w_bits_strb; // @[sram.scala 153:25]
  always @(posedge clock) begin
    if (reset) begin // @[sram.scala 98:24]
      state <= 3'h0; // @[sram.scala 98:24]
    end else if (_axi_ar_ready_T) begin // @[sram.scala 110:20]
      if (_T_1) begin // @[sram.scala 113:32]
        state <= 3'h1; // @[sram.scala 114:23]
      end else if (_T_2 & _T_3) begin // @[sram.scala 116:51]
        state <= 3'h3; // @[sram.scala 117:23]
      end else begin
        state <= 3'h0; // @[sram.scala 120:23]
      end
    end else if (3'h1 == state) begin // @[sram.scala 110:20]
      if (~delay) begin // @[sram.scala 124:25]
        state <= 3'h2;
      end else begin
        state <= 3'h1;
      end
    end else if (_axi_r_valid_T) begin // @[sram.scala 110:20]
      state <= _state_T_3; // @[sram.scala 128:19]
    end else begin
      state <= _GEN_3;
    end
    if (reset) begin // @[sram.scala 108:24]
      delay <= 1'h0; // @[sram.scala 108:24]
    end else if (_axi_ar_ready_T) begin // @[sram.scala 110:20]
      delay <= 1'h0; // @[sram.scala 112:19]
    end else if (3'h1 == state) begin // @[sram.scala 110:20]
      delay <= delay - 1'h1; // @[sram.scala 125:19]
    end else if (!(_axi_r_valid_T)) begin // @[sram.scala 110:20]
      delay <= _GEN_4;
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
  state = _RAND_0[2:0];
  _RAND_1 = {1{`RANDOM}};
  delay = _RAND_1[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
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
  output [2:0]  to_WBU_bits_fu_op,
  output        to_IFU_bits_bru_ctrl_br,
  output [31:0] to_IFU_bits_bru_addr,
  output        to_IFU_bits_csr_ctrl_br,
  output [31:0] to_IFU_bits_csr_addr,
  output [31:0] difftest_mcause,
  output [31:0] difftest_mepc,
  output [31:0] difftest_mstatus,
  output [31:0] difftest_mtvec
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire [31:0] Alu_i_io_in_src1; // @[EXU.scala 18:37]
  wire [31:0] Alu_i_io_in_src2; // @[EXU.scala 18:37]
  wire [3:0] Alu_i_io_in_op; // @[EXU.scala 18:37]
  wire [31:0] Alu_i_io_out_result; // @[EXU.scala 18:37]
  wire [31:0] Mdu_i_io_in_src1; // @[EXU.scala 19:37]
  wire [31:0] Mdu_i_io_in_src2; // @[EXU.scala 19:37]
  wire [3:0] Mdu_i_io_in_op; // @[EXU.scala 19:37]
  wire [31:0] Mdu_i_io_out_result; // @[EXU.scala 19:37]
  wire [31:0] Bru_i_io_in_src1; // @[EXU.scala 20:37]
  wire [31:0] Bru_i_io_in_src2; // @[EXU.scala 20:37]
  wire [3:0] Bru_i_io_in_op; // @[EXU.scala 20:37]
  wire  Bru_i_io_out_ctrl_br; // @[EXU.scala 20:37]
  wire  Lsu_i_clock; // @[EXU.scala 21:37]
  wire  Lsu_i_reset; // @[EXU.scala 21:37]
  wire  Lsu_i_io_in_valid; // @[EXU.scala 21:37]
  wire  Lsu_i_io_in_mem_wen; // @[EXU.scala 21:37]
  wire [31:0] Lsu_i_io_in_addr; // @[EXU.scala 21:37]
  wire [31:0] Lsu_i_io_in_wdata; // @[EXU.scala 21:37]
  wire [3:0] Lsu_i_io_in_op; // @[EXU.scala 21:37]
  wire [31:0] Lsu_i_io_out_rdata; // @[EXU.scala 21:37]
  wire  Lsu_i_io_out_end; // @[EXU.scala 21:37]
  wire  Lsu_i_io_out_idle; // @[EXU.scala 21:37]
  wire  Lsu_i_axi_aw_valid; // @[EXU.scala 21:37]
  wire  Lsu_i_axi_w_valid; // @[EXU.scala 21:37]
  wire [31:0] Lsu_i_axi_w_bits_data; // @[EXU.scala 21:37]
  wire [3:0] Lsu_i_axi_w_bits_strb; // @[EXU.scala 21:37]
  wire  Lsu_i_axi_b_ready; // @[EXU.scala 21:37]
  wire  Lsu_i_axi_b_valid; // @[EXU.scala 21:37]
  wire  Lsu_i_axi_ar_valid; // @[EXU.scala 21:37]
  wire [31:0] Lsu_i_axi_ar_bits_addr; // @[EXU.scala 21:37]
  wire  Lsu_i_axi_r_ready; // @[EXU.scala 21:37]
  wire  Lsu_i_axi_r_valid; // @[EXU.scala 21:37]
  wire [31:0] Lsu_i_axi_r_bits_data; // @[EXU.scala 21:37]
  wire  Csr_i_clock; // @[EXU.scala 22:37]
  wire  Csr_i_reset; // @[EXU.scala 22:37]
  wire [2:0] Csr_i_io_in_op; // @[EXU.scala 22:37]
  wire [31:0] Csr_i_io_in_cur_pc; // @[EXU.scala 22:37]
  wire [31:0] Csr_i_io_in_csr_id; // @[EXU.scala 22:37]
  wire [31:0] Csr_i_io_in_wdata; // @[EXU.scala 22:37]
  wire  Csr_i_io_out_csr_br; // @[EXU.scala 22:37]
  wire [31:0] Csr_i_io_out_csr_addr; // @[EXU.scala 22:37]
  wire [31:0] Csr_i_io_out_r_csr; // @[EXU.scala 22:37]
  wire [31:0] Csr_i_io_out_difftest_mcause; // @[EXU.scala 22:37]
  wire [31:0] Csr_i_io_out_difftest_mepc; // @[EXU.scala 22:37]
  wire [31:0] Csr_i_io_out_difftest_mstatus; // @[EXU.scala 22:37]
  wire [31:0] Csr_i_io_out_difftest_mtvec; // @[EXU.scala 22:37]
  wire  ebreak_moudle_i_is_ebreak; // @[EXU.scala 23:37]
  wire  not_impl_moudle_i_not_impl; // @[EXU.scala 24:37]
  wire  sram_i_clock; // @[EXU.scala 112:24]
  wire  sram_i_reset; // @[EXU.scala 112:24]
  wire  sram_i_axi_aw_ready; // @[EXU.scala 112:24]
  wire  sram_i_axi_aw_valid; // @[EXU.scala 112:24]
  wire  sram_i_axi_w_ready; // @[EXU.scala 112:24]
  wire  sram_i_axi_w_valid; // @[EXU.scala 112:24]
  wire [31:0] sram_i_axi_w_bits_data; // @[EXU.scala 112:24]
  wire [3:0] sram_i_axi_w_bits_strb; // @[EXU.scala 112:24]
  wire  sram_i_axi_b_ready; // @[EXU.scala 112:24]
  wire  sram_i_axi_b_valid; // @[EXU.scala 112:24]
  wire  sram_i_axi_ar_ready; // @[EXU.scala 112:24]
  wire  sram_i_axi_ar_valid; // @[EXU.scala 112:24]
  wire [31:0] sram_i_axi_ar_bits_addr; // @[EXU.scala 112:24]
  wire  sram_i_axi_r_ready; // @[EXU.scala 112:24]
  wire  sram_i_axi_r_valid; // @[EXU.scala 112:24]
  wire [31:0] sram_i_axi_r_bits_data; // @[EXU.scala 112:24]
  reg [1:0] state; // @[EXU.scala 33:24]
  wire  _state_T = from_ISU_ready & from_ISU_valid; // @[Decoupled.scala 51:35]
  wire [1:0] _state_T_2 = Lsu_i_io_out_idle ? 2'h2 : 2'h1; // @[EXU.scala 41:29]
  wire [1:0] _state_T_3 = Lsu_i_io_out_end ? 2'h3 : 2'h2; // @[EXU.scala 47:25]
  wire [1:0] _GEN_1 = 2'h3 == state ? 2'h0 : state; // @[EXU.scala 34:20 50:19 33:24]
  wire [31:0] _Alu_i_io_in_src1_T_1 = 2'h2 == from_ISU_bits_ctrl_sig_src1_op ? from_ISU_bits_rdata1 : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _Alu_i_io_in_src2_T_1 = 2'h2 == from_ISU_bits_ctrl_sig_src2_op ? from_ISU_bits_rdata2 : 32'h0; // @[Mux.scala 81:58]
  Alu Alu_i ( // @[EXU.scala 18:37]
    .io_in_src1(Alu_i_io_in_src1),
    .io_in_src2(Alu_i_io_in_src2),
    .io_in_op(Alu_i_io_in_op),
    .io_out_result(Alu_i_io_out_result)
  );
  Mdu Mdu_i ( // @[EXU.scala 19:37]
    .io_in_src1(Mdu_i_io_in_src1),
    .io_in_src2(Mdu_i_io_in_src2),
    .io_in_op(Mdu_i_io_in_op),
    .io_out_result(Mdu_i_io_out_result)
  );
  Bru Bru_i ( // @[EXU.scala 20:37]
    .io_in_src1(Bru_i_io_in_src1),
    .io_in_src2(Bru_i_io_in_src2),
    .io_in_op(Bru_i_io_in_op),
    .io_out_ctrl_br(Bru_i_io_out_ctrl_br)
  );
  Lsu Lsu_i ( // @[EXU.scala 21:37]
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
    .axi_aw_valid(Lsu_i_axi_aw_valid),
    .axi_w_valid(Lsu_i_axi_w_valid),
    .axi_w_bits_data(Lsu_i_axi_w_bits_data),
    .axi_w_bits_strb(Lsu_i_axi_w_bits_strb),
    .axi_b_ready(Lsu_i_axi_b_ready),
    .axi_b_valid(Lsu_i_axi_b_valid),
    .axi_ar_valid(Lsu_i_axi_ar_valid),
    .axi_ar_bits_addr(Lsu_i_axi_ar_bits_addr),
    .axi_r_ready(Lsu_i_axi_r_ready),
    .axi_r_valid(Lsu_i_axi_r_valid),
    .axi_r_bits_data(Lsu_i_axi_r_bits_data)
  );
  Csr Csr_i ( // @[EXU.scala 22:37]
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
  ebreak_moudle ebreak_moudle_i ( // @[EXU.scala 23:37]
    .is_ebreak(ebreak_moudle_i_is_ebreak)
  );
  not_impl_moudle not_impl_moudle_i ( // @[EXU.scala 24:37]
    .not_impl(not_impl_moudle_i_not_impl)
  );
  SRAM_lsu sram_i ( // @[EXU.scala 112:24]
    .clock(sram_i_clock),
    .reset(sram_i_reset),
    .axi_aw_ready(sram_i_axi_aw_ready),
    .axi_aw_valid(sram_i_axi_aw_valid),
    .axi_w_ready(sram_i_axi_w_ready),
    .axi_w_valid(sram_i_axi_w_valid),
    .axi_w_bits_data(sram_i_axi_w_bits_data),
    .axi_w_bits_strb(sram_i_axi_w_bits_strb),
    .axi_b_ready(sram_i_axi_b_ready),
    .axi_b_valid(sram_i_axi_b_valid),
    .axi_ar_ready(sram_i_axi_ar_ready),
    .axi_ar_valid(sram_i_axi_ar_valid),
    .axi_ar_bits_addr(sram_i_axi_ar_bits_addr),
    .axi_r_ready(sram_i_axi_r_ready),
    .axi_r_valid(sram_i_axi_r_valid),
    .axi_r_bits_data(sram_i_axi_r_bits_data)
  );
  assign from_ISU_ready = 2'h0 == state; // @[Mux.scala 81:61]
  assign to_WBU_valid = 2'h3 == state; // @[Mux.scala 81:61]
  assign to_WBU_bits_alu_result = Alu_i_io_out_result; // @[EXU.scala 97:28]
  assign to_WBU_bits_mdu_result = Mdu_i_io_out_result; // @[EXU.scala 98:28]
  assign to_WBU_bits_lsu_rdata = Lsu_i_io_out_rdata; // @[EXU.scala 99:28]
  assign to_WBU_bits_csr_rdata = Csr_i_io_out_r_csr; // @[EXU.scala 100:28]
  assign to_WBU_bits_pc = from_ISU_bits_pc; // @[EXU.scala 101:28]
  assign to_WBU_bits_reg_wen = from_ISU_bits_ctrl_sig_reg_wen; // @[EXU.scala 102:28]
  assign to_WBU_bits_fu_op = from_ISU_bits_ctrl_sig_fu_op; // @[EXU.scala 103:28]
  assign to_IFU_bits_bru_ctrl_br = Bru_i_io_out_ctrl_br; // @[EXU.scala 105:33]
  assign to_IFU_bits_bru_addr = Alu_i_io_out_result; // @[EXU.scala 106:33]
  assign to_IFU_bits_csr_ctrl_br = Csr_i_io_out_csr_br; // @[EXU.scala 107:33]
  assign to_IFU_bits_csr_addr = Csr_i_io_out_csr_addr; // @[EXU.scala 108:33]
  assign difftest_mcause = Csr_i_io_out_difftest_mcause; // @[EXU.scala 110:14]
  assign difftest_mepc = Csr_i_io_out_difftest_mepc; // @[EXU.scala 110:14]
  assign difftest_mstatus = Csr_i_io_out_difftest_mstatus; // @[EXU.scala 110:14]
  assign difftest_mtvec = Csr_i_io_out_difftest_mtvec; // @[EXU.scala 110:14]
  assign Alu_i_io_in_src1 = 2'h1 == from_ISU_bits_ctrl_sig_src1_op ? from_ISU_bits_pc : _Alu_i_io_in_src1_T_1; // @[Mux.scala 81:58]
  assign Alu_i_io_in_src2 = 2'h3 == from_ISU_bits_ctrl_sig_src2_op ? from_ISU_bits_imm : _Alu_i_io_in_src2_T_1; // @[Mux.scala 81:58]
  assign Alu_i_io_in_op = from_ISU_bits_ctrl_sig_alu_op; // @[EXU.scala 58:20]
  assign Mdu_i_io_in_src1 = from_ISU_bits_rdata1; // @[EXU.scala 70:24]
  assign Mdu_i_io_in_src2 = from_ISU_bits_rdata2; // @[EXU.scala 71:24]
  assign Mdu_i_io_in_op = from_ISU_bits_ctrl_sig_mdu_op; // @[EXU.scala 69:24]
  assign Bru_i_io_in_src1 = from_ISU_bits_rdata1; // @[EXU.scala 83:24]
  assign Bru_i_io_in_src2 = from_ISU_bits_rdata2; // @[EXU.scala 84:24]
  assign Bru_i_io_in_op = from_ISU_bits_ctrl_sig_bru_op; // @[EXU.scala 82:24]
  assign Lsu_i_clock = clock;
  assign Lsu_i_reset = reset;
  assign Lsu_i_io_in_valid = 2'h2 == state; // @[Mux.scala 81:61]
  assign Lsu_i_io_in_mem_wen = from_ISU_bits_ctrl_sig_mem_wen; // @[EXU.scala 76:25]
  assign Lsu_i_io_in_addr = Alu_i_io_out_result; // @[EXU.scala 74:25]
  assign Lsu_i_io_in_wdata = from_ISU_bits_rdata2; // @[EXU.scala 75:25]
  assign Lsu_i_io_in_op = from_ISU_bits_ctrl_sig_lsu_op; // @[EXU.scala 77:25]
  assign Lsu_i_axi_b_valid = sram_i_axi_b_valid; // @[Connect.scala 12:22]
  assign Lsu_i_axi_r_valid = sram_i_axi_r_valid; // @[Connect.scala 12:22]
  assign Lsu_i_axi_r_bits_data = sram_i_axi_r_bits_data; // @[Connect.scala 11:22]
  assign Csr_i_clock = clock;
  assign Csr_i_reset = reset;
  assign Csr_i_io_in_op = from_ISU_bits_ctrl_sig_csr_op; // @[EXU.scala 87:25]
  assign Csr_i_io_in_cur_pc = from_ISU_bits_pc; // @[EXU.scala 88:25]
  assign Csr_i_io_in_csr_id = from_ISU_bits_imm; // @[EXU.scala 89:25]
  assign Csr_i_io_in_wdata = from_ISU_bits_rdata1; // @[EXU.scala 90:25]
  assign ebreak_moudle_i_is_ebreak = from_ISU_bits_ctrl_sig_is_ebreak; // @[EXU.scala 93:32]
  assign not_impl_moudle_i_not_impl = from_ISU_bits_ctrl_sig_not_impl; // @[EXU.scala 95:32]
  assign sram_i_clock = clock;
  assign sram_i_reset = reset;
  assign sram_i_axi_aw_valid = Lsu_i_axi_aw_valid; // @[Connect.scala 12:22]
  assign sram_i_axi_w_valid = Lsu_i_axi_w_valid; // @[Connect.scala 12:22]
  assign sram_i_axi_w_bits_data = Lsu_i_axi_w_bits_data; // @[Connect.scala 11:22]
  assign sram_i_axi_w_bits_strb = Lsu_i_axi_w_bits_strb; // @[Connect.scala 11:22]
  assign sram_i_axi_b_ready = Lsu_i_axi_b_ready; // @[Connect.scala 13:22]
  assign sram_i_axi_ar_valid = Lsu_i_axi_ar_valid; // @[Connect.scala 12:22]
  assign sram_i_axi_ar_bits_addr = Lsu_i_axi_ar_bits_addr; // @[Connect.scala 11:22]
  assign sram_i_axi_r_ready = Lsu_i_axi_r_ready; // @[Connect.scala 13:22]
  always @(posedge clock) begin
    if (reset) begin // @[EXU.scala 33:24]
      state <= 2'h0; // @[EXU.scala 33:24]
    end else if (2'h0 == state) begin // @[EXU.scala 34:20]
      if (_state_T) begin // @[EXU.scala 36:25]
        state <= 2'h1;
      end else begin
        state <= 2'h0;
      end
    end else if (2'h1 == state) begin // @[EXU.scala 34:20]
      if (from_ISU_bits_ctrl_sig_fu_op == 3'h4) begin // @[EXU.scala 40:69]
        state <= _state_T_2; // @[EXU.scala 41:23]
      end else begin
        state <= 2'h3; // @[EXU.scala 43:23]
      end
    end else if (2'h2 == state) begin // @[EXU.scala 34:20]
      state <= _state_T_3; // @[EXU.scala 47:19]
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
  input  [2:0]  from_EXU_bits_fu_op,
  output        to_ISU_bits_reg_wen,
  output [31:0] to_ISU_bits_wdata,
  output        to_IFU_valid
);
  wire  _to_ISU_bits_reg_wen_T = from_EXU_ready & from_EXU_valid; // @[Decoupled.scala 51:35]
  wire [31:0] _to_ISU_bits_wdata_T_1 = from_EXU_bits_pc + 32'h4; // @[WBU.scala 24:47]
  wire [31:0] _to_ISU_bits_wdata_T_3 = 3'h1 == from_EXU_bits_fu_op ? from_EXU_bits_alu_result : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _to_ISU_bits_wdata_T_5 = 3'h4 == from_EXU_bits_fu_op ? from_EXU_bits_lsu_rdata : _to_ISU_bits_wdata_T_3; // @[Mux.scala 81:58]
  wire [31:0] _to_ISU_bits_wdata_T_7 = 3'h3 == from_EXU_bits_fu_op ? _to_ISU_bits_wdata_T_1 : _to_ISU_bits_wdata_T_5; // @[Mux.scala 81:58]
  wire [31:0] _to_ISU_bits_wdata_T_9 = 3'h5 == from_EXU_bits_fu_op ? from_EXU_bits_csr_rdata : _to_ISU_bits_wdata_T_7; // @[Mux.scala 81:58]
  assign from_EXU_ready = 1'h1; // @[WBU.scala 14:20]
  assign to_ISU_bits_reg_wen = _to_ISU_bits_reg_wen_T & from_EXU_bits_reg_wen; // @[WBU.scala 19:31]
  assign to_ISU_bits_wdata = 3'h2 == from_EXU_bits_fu_op ? from_EXU_bits_mdu_result : _to_ISU_bits_wdata_T_9; // @[Mux.scala 81:58]
  assign to_IFU_valid = from_EXU_valid; // @[WBU.scala 16:20]
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
  wire [31:0] RomBB_i1_addr; // @[sram.scala 88:26]
  wire [31:0] RomBB_i1_inst; // @[sram.scala 88:26]
  reg [1:0] state; // @[sram.scala 45:24]
  wire  _axi_ar_ready_T = 2'h0 == state; // @[Mux.scala 81:61]
  wire  _axi_r_valid_T = 2'h2 == state; // @[Mux.scala 81:61]
  reg  delay; // @[sram.scala 55:24]
  wire [1:0] _GEN_3 = axi_r_ready ? 2'h0 : 2'h2; // @[sram.scala 78:32 79:25 83:25]
  RomBB RomBB_i1 ( // @[sram.scala 88:26]
    .addr(RomBB_i1_addr),
    .inst(RomBB_i1_inst)
  );
  assign axi_ar_ready = 2'h0 == state; // @[Mux.scala 81:61]
  assign axi_r_valid = 2'h2 == state; // @[Mux.scala 81:61]
  assign axi_r_bits_data = RomBB_i1_inst; // @[sram.scala 91:21]
  assign RomBB_i1_addr = axi_ar_bits_addr; // @[sram.scala 90:22]
  always @(posedge clock) begin
    if (reset) begin // @[sram.scala 45:24]
      state <= 2'h0; // @[sram.scala 45:24]
    end else if (_axi_ar_ready_T) begin // @[sram.scala 58:20]
      if (axi_ar_valid) begin // @[sram.scala 61:33]
        state <= 2'h1; // @[sram.scala 62:25]
      end else begin
        state <= 2'h0; // @[sram.scala 67:25]
      end
    end else if (2'h1 == state) begin // @[sram.scala 58:20]
      if (~delay) begin // @[sram.scala 71:34]
        state <= 2'h2; // @[sram.scala 72:23]
      end
    end else if (_axi_r_valid_T) begin // @[sram.scala 58:20]
      state <= _GEN_3;
    end
    if (reset) begin // @[sram.scala 55:24]
      delay <= 1'h0; // @[sram.scala 55:24]
    end else if (_axi_ar_ready_T) begin // @[sram.scala 58:20]
      delay <= 1'h0; // @[sram.scala 60:21]
    end else if (2'h1 == state) begin // @[sram.scala 58:20]
      if (!(~delay)) begin // @[sram.scala 71:34]
        delay <= delay - 1'h1; // @[sram.scala 74:23]
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
  state = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  delay = _RAND_1[0:0];
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
`endif // RANDOMIZE_REG_INIT
  wire  IFU_i_clock; // @[core.scala 27:27]
  wire  IFU_i_reset; // @[core.scala 27:27]
  wire  IFU_i_to_IDU_valid; // @[core.scala 27:27]
  wire [31:0] IFU_i_to_IDU_bits_inst; // @[core.scala 27:27]
  wire [31:0] IFU_i_to_IDU_bits_pc; // @[core.scala 27:27]
  wire  IFU_i_from_EXU_bits_bru_ctrl_br; // @[core.scala 27:27]
  wire [31:0] IFU_i_from_EXU_bits_bru_addr; // @[core.scala 27:27]
  wire  IFU_i_from_EXU_bits_csr_ctrl_br; // @[core.scala 27:27]
  wire [31:0] IFU_i_from_EXU_bits_csr_addr; // @[core.scala 27:27]
  wire  IFU_i_from_WBU_ready; // @[core.scala 27:27]
  wire  IFU_i_from_WBU_valid; // @[core.scala 27:27]
  wire  IFU_i_axi_ar_ready; // @[core.scala 27:27]
  wire  IFU_i_axi_ar_valid; // @[core.scala 27:27]
  wire [31:0] IFU_i_axi_ar_bits_addr; // @[core.scala 27:27]
  wire  IFU_i_axi_r_ready; // @[core.scala 27:27]
  wire  IFU_i_axi_r_valid; // @[core.scala 27:27]
  wire [31:0] IFU_i_axi_r_bits_data; // @[core.scala 27:27]
  wire  IDU_i_from_IFU_valid; // @[core.scala 28:27]
  wire [31:0] IDU_i_from_IFU_bits_inst; // @[core.scala 28:27]
  wire [31:0] IDU_i_from_IFU_bits_pc; // @[core.scala 28:27]
  wire  IDU_i_to_ISU_valid; // @[core.scala 28:27]
  wire [31:0] IDU_i_to_ISU_bits_imm; // @[core.scala 28:27]
  wire [31:0] IDU_i_to_ISU_bits_pc; // @[core.scala 28:27]
  wire [4:0] IDU_i_to_ISU_bits_rs1; // @[core.scala 28:27]
  wire [4:0] IDU_i_to_ISU_bits_rs2; // @[core.scala 28:27]
  wire [4:0] IDU_i_to_ISU_bits_rd; // @[core.scala 28:27]
  wire  IDU_i_to_ISU_bits_ctrl_sig_reg_wen; // @[core.scala 28:27]
  wire [2:0] IDU_i_to_ISU_bits_ctrl_sig_fu_op; // @[core.scala 28:27]
  wire  IDU_i_to_ISU_bits_ctrl_sig_mem_wen; // @[core.scala 28:27]
  wire  IDU_i_to_ISU_bits_ctrl_sig_is_ebreak; // @[core.scala 28:27]
  wire  IDU_i_to_ISU_bits_ctrl_sig_not_impl; // @[core.scala 28:27]
  wire [1:0] IDU_i_to_ISU_bits_ctrl_sig_src1_op; // @[core.scala 28:27]
  wire [1:0] IDU_i_to_ISU_bits_ctrl_sig_src2_op; // @[core.scala 28:27]
  wire [3:0] IDU_i_to_ISU_bits_ctrl_sig_alu_op; // @[core.scala 28:27]
  wire [3:0] IDU_i_to_ISU_bits_ctrl_sig_lsu_op; // @[core.scala 28:27]
  wire [3:0] IDU_i_to_ISU_bits_ctrl_sig_bru_op; // @[core.scala 28:27]
  wire [2:0] IDU_i_to_ISU_bits_ctrl_sig_csr_op; // @[core.scala 28:27]
  wire [3:0] IDU_i_to_ISU_bits_ctrl_sig_mdu_op; // @[core.scala 28:27]
  wire  ISU_i_clock; // @[core.scala 29:27]
  wire  ISU_i_reset; // @[core.scala 29:27]
  wire  ISU_i_from_IDU_valid; // @[core.scala 29:27]
  wire [31:0] ISU_i_from_IDU_bits_imm; // @[core.scala 29:27]
  wire [31:0] ISU_i_from_IDU_bits_pc; // @[core.scala 29:27]
  wire [4:0] ISU_i_from_IDU_bits_rs1; // @[core.scala 29:27]
  wire [4:0] ISU_i_from_IDU_bits_rs2; // @[core.scala 29:27]
  wire [4:0] ISU_i_from_IDU_bits_rd; // @[core.scala 29:27]
  wire  ISU_i_from_IDU_bits_ctrl_sig_reg_wen; // @[core.scala 29:27]
  wire [2:0] ISU_i_from_IDU_bits_ctrl_sig_fu_op; // @[core.scala 29:27]
  wire  ISU_i_from_IDU_bits_ctrl_sig_mem_wen; // @[core.scala 29:27]
  wire  ISU_i_from_IDU_bits_ctrl_sig_is_ebreak; // @[core.scala 29:27]
  wire  ISU_i_from_IDU_bits_ctrl_sig_not_impl; // @[core.scala 29:27]
  wire [1:0] ISU_i_from_IDU_bits_ctrl_sig_src1_op; // @[core.scala 29:27]
  wire [1:0] ISU_i_from_IDU_bits_ctrl_sig_src2_op; // @[core.scala 29:27]
  wire [3:0] ISU_i_from_IDU_bits_ctrl_sig_alu_op; // @[core.scala 29:27]
  wire [3:0] ISU_i_from_IDU_bits_ctrl_sig_lsu_op; // @[core.scala 29:27]
  wire [3:0] ISU_i_from_IDU_bits_ctrl_sig_bru_op; // @[core.scala 29:27]
  wire [2:0] ISU_i_from_IDU_bits_ctrl_sig_csr_op; // @[core.scala 29:27]
  wire [3:0] ISU_i_from_IDU_bits_ctrl_sig_mdu_op; // @[core.scala 29:27]
  wire  ISU_i_from_WBU_bits_reg_wen; // @[core.scala 29:27]
  wire [31:0] ISU_i_from_WBU_bits_wdata; // @[core.scala 29:27]
  wire  ISU_i_to_EXU_valid; // @[core.scala 29:27]
  wire [31:0] ISU_i_to_EXU_bits_imm; // @[core.scala 29:27]
  wire [31:0] ISU_i_to_EXU_bits_pc; // @[core.scala 29:27]
  wire [31:0] ISU_i_to_EXU_bits_rdata1; // @[core.scala 29:27]
  wire [31:0] ISU_i_to_EXU_bits_rdata2; // @[core.scala 29:27]
  wire  ISU_i_to_EXU_bits_ctrl_sig_reg_wen; // @[core.scala 29:27]
  wire [2:0] ISU_i_to_EXU_bits_ctrl_sig_fu_op; // @[core.scala 29:27]
  wire  ISU_i_to_EXU_bits_ctrl_sig_mem_wen; // @[core.scala 29:27]
  wire  ISU_i_to_EXU_bits_ctrl_sig_is_ebreak; // @[core.scala 29:27]
  wire  ISU_i_to_EXU_bits_ctrl_sig_not_impl; // @[core.scala 29:27]
  wire [1:0] ISU_i_to_EXU_bits_ctrl_sig_src1_op; // @[core.scala 29:27]
  wire [1:0] ISU_i_to_EXU_bits_ctrl_sig_src2_op; // @[core.scala 29:27]
  wire [3:0] ISU_i_to_EXU_bits_ctrl_sig_alu_op; // @[core.scala 29:27]
  wire [3:0] ISU_i_to_EXU_bits_ctrl_sig_lsu_op; // @[core.scala 29:27]
  wire [3:0] ISU_i_to_EXU_bits_ctrl_sig_bru_op; // @[core.scala 29:27]
  wire [2:0] ISU_i_to_EXU_bits_ctrl_sig_csr_op; // @[core.scala 29:27]
  wire [3:0] ISU_i_to_EXU_bits_ctrl_sig_mdu_op; // @[core.scala 29:27]
  wire  EXU_i_clock; // @[core.scala 30:27]
  wire  EXU_i_reset; // @[core.scala 30:27]
  wire  EXU_i_from_ISU_ready; // @[core.scala 30:27]
  wire  EXU_i_from_ISU_valid; // @[core.scala 30:27]
  wire [31:0] EXU_i_from_ISU_bits_imm; // @[core.scala 30:27]
  wire [31:0] EXU_i_from_ISU_bits_pc; // @[core.scala 30:27]
  wire [31:0] EXU_i_from_ISU_bits_rdata1; // @[core.scala 30:27]
  wire [31:0] EXU_i_from_ISU_bits_rdata2; // @[core.scala 30:27]
  wire  EXU_i_from_ISU_bits_ctrl_sig_reg_wen; // @[core.scala 30:27]
  wire [2:0] EXU_i_from_ISU_bits_ctrl_sig_fu_op; // @[core.scala 30:27]
  wire  EXU_i_from_ISU_bits_ctrl_sig_mem_wen; // @[core.scala 30:27]
  wire  EXU_i_from_ISU_bits_ctrl_sig_is_ebreak; // @[core.scala 30:27]
  wire  EXU_i_from_ISU_bits_ctrl_sig_not_impl; // @[core.scala 30:27]
  wire [1:0] EXU_i_from_ISU_bits_ctrl_sig_src1_op; // @[core.scala 30:27]
  wire [1:0] EXU_i_from_ISU_bits_ctrl_sig_src2_op; // @[core.scala 30:27]
  wire [3:0] EXU_i_from_ISU_bits_ctrl_sig_alu_op; // @[core.scala 30:27]
  wire [3:0] EXU_i_from_ISU_bits_ctrl_sig_lsu_op; // @[core.scala 30:27]
  wire [3:0] EXU_i_from_ISU_bits_ctrl_sig_bru_op; // @[core.scala 30:27]
  wire [2:0] EXU_i_from_ISU_bits_ctrl_sig_csr_op; // @[core.scala 30:27]
  wire [3:0] EXU_i_from_ISU_bits_ctrl_sig_mdu_op; // @[core.scala 30:27]
  wire  EXU_i_to_WBU_valid; // @[core.scala 30:27]
  wire [31:0] EXU_i_to_WBU_bits_alu_result; // @[core.scala 30:27]
  wire [31:0] EXU_i_to_WBU_bits_mdu_result; // @[core.scala 30:27]
  wire [31:0] EXU_i_to_WBU_bits_lsu_rdata; // @[core.scala 30:27]
  wire [31:0] EXU_i_to_WBU_bits_csr_rdata; // @[core.scala 30:27]
  wire [31:0] EXU_i_to_WBU_bits_pc; // @[core.scala 30:27]
  wire  EXU_i_to_WBU_bits_reg_wen; // @[core.scala 30:27]
  wire [2:0] EXU_i_to_WBU_bits_fu_op; // @[core.scala 30:27]
  wire  EXU_i_to_IFU_bits_bru_ctrl_br; // @[core.scala 30:27]
  wire [31:0] EXU_i_to_IFU_bits_bru_addr; // @[core.scala 30:27]
  wire  EXU_i_to_IFU_bits_csr_ctrl_br; // @[core.scala 30:27]
  wire [31:0] EXU_i_to_IFU_bits_csr_addr; // @[core.scala 30:27]
  wire [31:0] EXU_i_difftest_mcause; // @[core.scala 30:27]
  wire [31:0] EXU_i_difftest_mepc; // @[core.scala 30:27]
  wire [31:0] EXU_i_difftest_mstatus; // @[core.scala 30:27]
  wire [31:0] EXU_i_difftest_mtvec; // @[core.scala 30:27]
  wire  WBU_i_from_EXU_ready; // @[core.scala 31:27]
  wire  WBU_i_from_EXU_valid; // @[core.scala 31:27]
  wire [31:0] WBU_i_from_EXU_bits_alu_result; // @[core.scala 31:27]
  wire [31:0] WBU_i_from_EXU_bits_mdu_result; // @[core.scala 31:27]
  wire [31:0] WBU_i_from_EXU_bits_lsu_rdata; // @[core.scala 31:27]
  wire [31:0] WBU_i_from_EXU_bits_csr_rdata; // @[core.scala 31:27]
  wire [31:0] WBU_i_from_EXU_bits_pc; // @[core.scala 31:27]
  wire  WBU_i_from_EXU_bits_reg_wen; // @[core.scala 31:27]
  wire [2:0] WBU_i_from_EXU_bits_fu_op; // @[core.scala 31:27]
  wire  WBU_i_to_ISU_bits_reg_wen; // @[core.scala 31:27]
  wire [31:0] WBU_i_to_ISU_bits_wdata; // @[core.scala 31:27]
  wire  WBU_i_to_IFU_valid; // @[core.scala 31:27]
  wire  sram_i_clock; // @[core.scala 33:27]
  wire  sram_i_reset; // @[core.scala 33:27]
  wire  sram_i_axi_ar_ready; // @[core.scala 33:27]
  wire  sram_i_axi_ar_valid; // @[core.scala 33:27]
  wire [31:0] sram_i_axi_ar_bits_addr; // @[core.scala 33:27]
  wire  sram_i_axi_r_ready; // @[core.scala 33:27]
  wire  sram_i_axi_r_valid; // @[core.scala 33:27]
  wire [31:0] sram_i_axi_r_bits_data; // @[core.scala 33:27]
  wire  _EXU_i_from_ISU_bits_T = ISU_i_to_EXU_valid & EXU_i_from_ISU_ready; // @[Connect.scala 22:58]
  reg [31:0] EXU_i_from_ISU_bits_r_imm; // @[Reg.scala 19:16]
  reg [31:0] EXU_i_from_ISU_bits_r_pc; // @[Reg.scala 19:16]
  reg [31:0] EXU_i_from_ISU_bits_r_rdata1; // @[Reg.scala 19:16]
  reg [31:0] EXU_i_from_ISU_bits_r_rdata2; // @[Reg.scala 19:16]
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
  IFU IFU_i ( // @[core.scala 27:27]
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
  IDU IDU_i ( // @[core.scala 28:27]
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
  ISU ISU_i ( // @[core.scala 29:27]
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
    .to_EXU_valid(ISU_i_to_EXU_valid),
    .to_EXU_bits_imm(ISU_i_to_EXU_bits_imm),
    .to_EXU_bits_pc(ISU_i_to_EXU_bits_pc),
    .to_EXU_bits_rdata1(ISU_i_to_EXU_bits_rdata1),
    .to_EXU_bits_rdata2(ISU_i_to_EXU_bits_rdata2),
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
  EXU EXU_i ( // @[core.scala 30:27]
    .clock(EXU_i_clock),
    .reset(EXU_i_reset),
    .from_ISU_ready(EXU_i_from_ISU_ready),
    .from_ISU_valid(EXU_i_from_ISU_valid),
    .from_ISU_bits_imm(EXU_i_from_ISU_bits_imm),
    .from_ISU_bits_pc(EXU_i_from_ISU_bits_pc),
    .from_ISU_bits_rdata1(EXU_i_from_ISU_bits_rdata1),
    .from_ISU_bits_rdata2(EXU_i_from_ISU_bits_rdata2),
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
    .to_WBU_bits_fu_op(EXU_i_to_WBU_bits_fu_op),
    .to_IFU_bits_bru_ctrl_br(EXU_i_to_IFU_bits_bru_ctrl_br),
    .to_IFU_bits_bru_addr(EXU_i_to_IFU_bits_bru_addr),
    .to_IFU_bits_csr_ctrl_br(EXU_i_to_IFU_bits_csr_ctrl_br),
    .to_IFU_bits_csr_addr(EXU_i_to_IFU_bits_csr_addr),
    .difftest_mcause(EXU_i_difftest_mcause),
    .difftest_mepc(EXU_i_difftest_mepc),
    .difftest_mstatus(EXU_i_difftest_mstatus),
    .difftest_mtvec(EXU_i_difftest_mtvec)
  );
  WBU WBU_i ( // @[core.scala 31:27]
    .from_EXU_ready(WBU_i_from_EXU_ready),
    .from_EXU_valid(WBU_i_from_EXU_valid),
    .from_EXU_bits_alu_result(WBU_i_from_EXU_bits_alu_result),
    .from_EXU_bits_mdu_result(WBU_i_from_EXU_bits_mdu_result),
    .from_EXU_bits_lsu_rdata(WBU_i_from_EXU_bits_lsu_rdata),
    .from_EXU_bits_csr_rdata(WBU_i_from_EXU_bits_csr_rdata),
    .from_EXU_bits_pc(WBU_i_from_EXU_bits_pc),
    .from_EXU_bits_reg_wen(WBU_i_from_EXU_bits_reg_wen),
    .from_EXU_bits_fu_op(WBU_i_from_EXU_bits_fu_op),
    .to_ISU_bits_reg_wen(WBU_i_to_ISU_bits_reg_wen),
    .to_ISU_bits_wdata(WBU_i_to_ISU_bits_wdata),
    .to_IFU_valid(WBU_i_to_IFU_valid)
  );
  SRAM sram_i ( // @[core.scala 33:27]
    .clock(sram_i_clock),
    .reset(sram_i_reset),
    .axi_ar_ready(sram_i_axi_ar_ready),
    .axi_ar_valid(sram_i_axi_ar_valid),
    .axi_ar_bits_addr(sram_i_axi_ar_bits_addr),
    .axi_r_ready(sram_i_axi_r_ready),
    .axi_r_valid(sram_i_axi_r_valid),
    .axi_r_bits_data(sram_i_axi_r_bits_data)
  );
  assign io_out_inst = IFU_i_to_IDU_bits_inst; // @[core.scala 46:20]
  assign io_out_pc = IFU_i_to_IDU_bits_pc; // @[core.scala 47:20]
  assign io_out_difftest_mcause = EXU_i_difftest_mcause; // @[core.scala 50:21]
  assign io_out_difftest_mepc = EXU_i_difftest_mepc; // @[core.scala 50:21]
  assign io_out_difftest_mstatus = EXU_i_difftest_mstatus; // @[core.scala 50:21]
  assign io_out_difftest_mtvec = EXU_i_difftest_mtvec; // @[core.scala 50:21]
  assign io_out_wb = WBU_i_to_IFU_valid; // @[core.scala 48:20]
  assign IFU_i_clock = clock;
  assign IFU_i_reset = reset;
  assign IFU_i_from_EXU_bits_bru_ctrl_br = EXU_i_to_IFU_bits_bru_ctrl_br; // @[Connect.scala 11:22]
  assign IFU_i_from_EXU_bits_bru_addr = EXU_i_to_IFU_bits_bru_addr; // @[Connect.scala 11:22]
  assign IFU_i_from_EXU_bits_csr_ctrl_br = EXU_i_to_IFU_bits_csr_ctrl_br; // @[Connect.scala 11:22]
  assign IFU_i_from_EXU_bits_csr_addr = EXU_i_to_IFU_bits_csr_addr; // @[Connect.scala 11:22]
  assign IFU_i_from_WBU_valid = WBU_i_to_IFU_valid; // @[Connect.scala 12:22]
  assign IFU_i_axi_ar_ready = sram_i_axi_ar_ready; // @[Connect.scala 13:22]
  assign IFU_i_axi_r_valid = sram_i_axi_r_valid; // @[Connect.scala 12:22]
  assign IFU_i_axi_r_bits_data = sram_i_axi_r_bits_data; // @[Connect.scala 11:22]
  assign IDU_i_from_IFU_valid = IFU_i_to_IDU_valid; // @[Connect.scala 12:22]
  assign IDU_i_from_IFU_bits_inst = IFU_i_to_IDU_bits_inst; // @[Connect.scala 11:22]
  assign IDU_i_from_IFU_bits_pc = IFU_i_to_IDU_bits_pc; // @[Connect.scala 11:22]
  assign ISU_i_clock = clock;
  assign ISU_i_reset = reset;
  assign ISU_i_from_IDU_valid = IDU_i_to_ISU_valid; // @[Connect.scala 12:22]
  assign ISU_i_from_IDU_bits_imm = IDU_i_to_ISU_bits_imm; // @[Connect.scala 11:22]
  assign ISU_i_from_IDU_bits_pc = IDU_i_to_ISU_bits_pc; // @[Connect.scala 11:22]
  assign ISU_i_from_IDU_bits_rs1 = IDU_i_to_ISU_bits_rs1; // @[Connect.scala 11:22]
  assign ISU_i_from_IDU_bits_rs2 = IDU_i_to_ISU_bits_rs2; // @[Connect.scala 11:22]
  assign ISU_i_from_IDU_bits_rd = IDU_i_to_ISU_bits_rd; // @[Connect.scala 11:22]
  assign ISU_i_from_IDU_bits_ctrl_sig_reg_wen = IDU_i_to_ISU_bits_ctrl_sig_reg_wen; // @[Connect.scala 11:22]
  assign ISU_i_from_IDU_bits_ctrl_sig_fu_op = IDU_i_to_ISU_bits_ctrl_sig_fu_op; // @[Connect.scala 11:22]
  assign ISU_i_from_IDU_bits_ctrl_sig_mem_wen = IDU_i_to_ISU_bits_ctrl_sig_mem_wen; // @[Connect.scala 11:22]
  assign ISU_i_from_IDU_bits_ctrl_sig_is_ebreak = IDU_i_to_ISU_bits_ctrl_sig_is_ebreak; // @[Connect.scala 11:22]
  assign ISU_i_from_IDU_bits_ctrl_sig_not_impl = IDU_i_to_ISU_bits_ctrl_sig_not_impl; // @[Connect.scala 11:22]
  assign ISU_i_from_IDU_bits_ctrl_sig_src1_op = IDU_i_to_ISU_bits_ctrl_sig_src1_op; // @[Connect.scala 11:22]
  assign ISU_i_from_IDU_bits_ctrl_sig_src2_op = IDU_i_to_ISU_bits_ctrl_sig_src2_op; // @[Connect.scala 11:22]
  assign ISU_i_from_IDU_bits_ctrl_sig_alu_op = IDU_i_to_ISU_bits_ctrl_sig_alu_op; // @[Connect.scala 11:22]
  assign ISU_i_from_IDU_bits_ctrl_sig_lsu_op = IDU_i_to_ISU_bits_ctrl_sig_lsu_op; // @[Connect.scala 11:22]
  assign ISU_i_from_IDU_bits_ctrl_sig_bru_op = IDU_i_to_ISU_bits_ctrl_sig_bru_op; // @[Connect.scala 11:22]
  assign ISU_i_from_IDU_bits_ctrl_sig_csr_op = IDU_i_to_ISU_bits_ctrl_sig_csr_op; // @[Connect.scala 11:22]
  assign ISU_i_from_IDU_bits_ctrl_sig_mdu_op = IDU_i_to_ISU_bits_ctrl_sig_mdu_op; // @[Connect.scala 11:22]
  assign ISU_i_from_WBU_bits_reg_wen = WBU_i_to_ISU_bits_reg_wen; // @[Connect.scala 11:22]
  assign ISU_i_from_WBU_bits_wdata = WBU_i_to_ISU_bits_wdata; // @[Connect.scala 11:22]
  assign EXU_i_clock = clock;
  assign EXU_i_reset = reset;
  assign EXU_i_from_ISU_valid = ISU_i_to_EXU_valid; // @[Connect.scala 23:22]
  assign EXU_i_from_ISU_bits_imm = EXU_i_from_ISU_bits_r_imm; // @[Connect.scala 22:22]
  assign EXU_i_from_ISU_bits_pc = EXU_i_from_ISU_bits_r_pc; // @[Connect.scala 22:22]
  assign EXU_i_from_ISU_bits_rdata1 = EXU_i_from_ISU_bits_r_rdata1; // @[Connect.scala 22:22]
  assign EXU_i_from_ISU_bits_rdata2 = EXU_i_from_ISU_bits_r_rdata2; // @[Connect.scala 22:22]
  assign EXU_i_from_ISU_bits_ctrl_sig_reg_wen = EXU_i_from_ISU_bits_r_ctrl_sig_reg_wen; // @[Connect.scala 22:22]
  assign EXU_i_from_ISU_bits_ctrl_sig_fu_op = EXU_i_from_ISU_bits_r_ctrl_sig_fu_op; // @[Connect.scala 22:22]
  assign EXU_i_from_ISU_bits_ctrl_sig_mem_wen = EXU_i_from_ISU_bits_r_ctrl_sig_mem_wen; // @[Connect.scala 22:22]
  assign EXU_i_from_ISU_bits_ctrl_sig_is_ebreak = EXU_i_from_ISU_bits_r_ctrl_sig_is_ebreak; // @[Connect.scala 22:22]
  assign EXU_i_from_ISU_bits_ctrl_sig_not_impl = EXU_i_from_ISU_bits_r_ctrl_sig_not_impl; // @[Connect.scala 22:22]
  assign EXU_i_from_ISU_bits_ctrl_sig_src1_op = EXU_i_from_ISU_bits_r_ctrl_sig_src1_op; // @[Connect.scala 22:22]
  assign EXU_i_from_ISU_bits_ctrl_sig_src2_op = EXU_i_from_ISU_bits_r_ctrl_sig_src2_op; // @[Connect.scala 22:22]
  assign EXU_i_from_ISU_bits_ctrl_sig_alu_op = EXU_i_from_ISU_bits_r_ctrl_sig_alu_op; // @[Connect.scala 22:22]
  assign EXU_i_from_ISU_bits_ctrl_sig_lsu_op = EXU_i_from_ISU_bits_r_ctrl_sig_lsu_op; // @[Connect.scala 22:22]
  assign EXU_i_from_ISU_bits_ctrl_sig_bru_op = EXU_i_from_ISU_bits_r_ctrl_sig_bru_op; // @[Connect.scala 22:22]
  assign EXU_i_from_ISU_bits_ctrl_sig_csr_op = EXU_i_from_ISU_bits_r_ctrl_sig_csr_op; // @[Connect.scala 22:22]
  assign EXU_i_from_ISU_bits_ctrl_sig_mdu_op = EXU_i_from_ISU_bits_r_ctrl_sig_mdu_op; // @[Connect.scala 22:22]
  assign WBU_i_from_EXU_valid = EXU_i_to_WBU_valid; // @[Connect.scala 12:22]
  assign WBU_i_from_EXU_bits_alu_result = EXU_i_to_WBU_bits_alu_result; // @[Connect.scala 11:22]
  assign WBU_i_from_EXU_bits_mdu_result = EXU_i_to_WBU_bits_mdu_result; // @[Connect.scala 11:22]
  assign WBU_i_from_EXU_bits_lsu_rdata = EXU_i_to_WBU_bits_lsu_rdata; // @[Connect.scala 11:22]
  assign WBU_i_from_EXU_bits_csr_rdata = EXU_i_to_WBU_bits_csr_rdata; // @[Connect.scala 11:22]
  assign WBU_i_from_EXU_bits_pc = EXU_i_to_WBU_bits_pc; // @[Connect.scala 11:22]
  assign WBU_i_from_EXU_bits_reg_wen = EXU_i_to_WBU_bits_reg_wen; // @[Connect.scala 11:22]
  assign WBU_i_from_EXU_bits_fu_op = EXU_i_to_WBU_bits_fu_op; // @[Connect.scala 11:22]
  assign sram_i_clock = clock;
  assign sram_i_reset = reset;
  assign sram_i_axi_ar_valid = IFU_i_axi_ar_valid; // @[Connect.scala 12:22]
  assign sram_i_axi_ar_bits_addr = IFU_i_axi_ar_bits_addr; // @[Connect.scala 11:22]
  assign sram_i_axi_r_ready = IFU_i_axi_r_ready; // @[Connect.scala 13:22]
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
  EXU_i_from_ISU_bits_r_ctrl_sig_reg_wen = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  EXU_i_from_ISU_bits_r_ctrl_sig_fu_op = _RAND_5[2:0];
  _RAND_6 = {1{`RANDOM}};
  EXU_i_from_ISU_bits_r_ctrl_sig_mem_wen = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  EXU_i_from_ISU_bits_r_ctrl_sig_is_ebreak = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  EXU_i_from_ISU_bits_r_ctrl_sig_not_impl = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  EXU_i_from_ISU_bits_r_ctrl_sig_src1_op = _RAND_9[1:0];
  _RAND_10 = {1{`RANDOM}};
  EXU_i_from_ISU_bits_r_ctrl_sig_src2_op = _RAND_10[1:0];
  _RAND_11 = {1{`RANDOM}};
  EXU_i_from_ISU_bits_r_ctrl_sig_alu_op = _RAND_11[3:0];
  _RAND_12 = {1{`RANDOM}};
  EXU_i_from_ISU_bits_r_ctrl_sig_lsu_op = _RAND_12[3:0];
  _RAND_13 = {1{`RANDOM}};
  EXU_i_from_ISU_bits_r_ctrl_sig_bru_op = _RAND_13[3:0];
  _RAND_14 = {1{`RANDOM}};
  EXU_i_from_ISU_bits_r_ctrl_sig_csr_op = _RAND_14[2:0];
  _RAND_15 = {1{`RANDOM}};
  EXU_i_from_ISU_bits_r_ctrl_sig_mdu_op = _RAND_15[3:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
