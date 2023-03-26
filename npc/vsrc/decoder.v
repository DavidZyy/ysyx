/*
  Input an instruction, to tell which instrction it is,
  and ouput its relative components.
  Which signals shoulld decoder to produce to pass to 
  executor?
  Add a new instructions is not convenient, I plan to write a 
  script to generate verilog codes automaticallly when add new
  instruction
*/
`include "./include/defines.v"


module decoder (
  input [`Vec(`InstWidth)] inst,

  output [`Vec(`RegIdWidth)] rd,
  output [`Vec(`RegIdWidth)] rs1,
  output [`Vec(`RegIdWidth)] rs2,
  output [`Vec(`ImmWidth)] imm,
  output need_imm,
  /* verilator lint_off UNDRIVEN */
  output [`Vec(`AluopWidth)] alu_op,
  output is_ebreak,
  output is_auipc,
  output inst_not_ipl,
  output is_jal,
  output is_jalr,
  output reg_wen,
  output mem_wen,
  output [7:0] wmask,
  output is_load,
  output is_branch,
  // output mem_ren
  output [`Vec(`WdtTypeCnt)] wdt_op,
  output is_unsigned
);

/* decode infos */
  /* opcode */
  wire op_imm     = `OpIs(`OP_IMM);
  wire op_system  = `OpIs(`SYSTEM);
  wire op_auipc   = `OpIs(`AUIPC);
  wire op_jal     = `OpIs(`JAL);
  wire op_store   = `OpIs(`STORE);
  wire op_jalr    = `OpIs(`JALR);
  wire op_load    = `OpIs(`LOAD);
  wire op_op      = `OpIs(`OP);
  wire op_lui     = `OpIs(`LUI);
  wire op_branch  = `OpIs(`BRANCH);
  wire op_imm_32  = `OpIs(`OP_IMM_32);
  wire op_32      = `OpIs(`OP_32);

  /* funct3 */
  wire funct3_000 = `FUNCT3_Is(3'b000);
  wire funct3_001 = `FUNCT3_Is(3'b001);
  wire funct3_010 = `FUNCT3_Is(3'b010);
  wire funct3_011 = `FUNCT3_Is(3'b011);
  wire funct3_100 = `FUNCT3_Is(3'b100);
  wire funct3_101 = `FUNCT3_Is(3'b101);
  wire funct3_110 = `FUNCT3_Is(3'b110);
  wire funct3_111 = `FUNCT3_Is(3'b111);

  /* funct7, if it has more cases, use script to generate the codes below */
  wire funct7_0000000 = `FUNCT7_Is(7'b0000000);
  wire funct7_0100000 = `FUNCT7_Is(7'b0100000);

  /* funct12, use for system instructions? */
  wire funct12_000000000001 = `FUNCT12_Is(12'b000000000001);

  /* for shift instructions */
  wire inst_31_26_000000  = (inst[31:26] == 6'b000000);
  wire inst_31_26_010000  = (inst[31:26] == 6'b010000);

/* Instructions */
  /* reference: volume I: RISC-V Unprivileged ISA V20191213 */

/* RV32I */
  /* 2.4 integer computational instructions */
    /* integer register-immediate instructions */
  wire addi     = op_imm & funct3_000;
  wire slti     = op_imm & funct3_010;
  wire sltiu    = op_imm & funct3_011;
  wire andi     = op_imm & funct3_111;
  wire ori      = op_imm & funct3_110;
  wire xori     = op_imm & funct3_100;
  wire slli     = op_imm & funct3_001 & inst_31_26_000000;
  wire srli     = op_imm & funct3_101 & inst_31_26_000000;
  wire srai     = op_imm & funct3_101 & inst_31_26_010000;
  wire lui      = op_lui;
  wire auipc    = op_auipc;

    /* integer register-register instructions */
  wire add        = op_op & funct3_000 & funct7_0000000;
  wire slt        = op_op & funct3_010 & funct7_0000000;
  wire sltu       = op_op & funct3_011 & funct7_0000000;
  wire and_inst   = op_op & funct3_111 & funct7_0000000;
  wire or_inst    = op_op & funct3_110 & funct7_0000000;
  wire xor_inst   = op_op & funct3_100 & funct7_0000000;
  wire sll        = op_op & funct3_001 & funct7_0000000;
  wire srl        = op_op & funct3_101 & funct7_0000000;
  wire sub        = op_op & funct3_000 & funct7_0100000;
  wire sra        = op_op & funct3_101 & funct7_0100000;

  /* 2.5 control transfer instructions */
    /* unconditial jumps */
  wire jal  = op_jal;
  wire jalr = op_jalr;

    /* conditianal branches */
  wire beq  = op_branch & funct3_000;
  wire bne  = op_branch & funct3_001;
  wire blt  = op_branch & funct3_100;
  wire bltu = op_branch & funct3_110;
  wire bge  = op_branch & funct3_101;
  wire bgeu = op_branch & funct3_111;

  /* 2.6 load and store */
  wire sd = op_store &  funct3_011;

  wire ld   = op_load & funct3_011;
  wire lw   = op_load & funct3_010;
  wire lwu  = op_load & funct3_110;
  wire lh   = op_load & funct3_001;
  wire lhu  = op_load & funct3_101;
  wire lb   = op_load & funct3_000;
  wire lbu  = op_load & funct3_100;

  /* 2.8 environment call and breakpoints */
  wire ebreak = op_system & funct3_000 & funct12_000000000001;
  
/* RV64I */
  /* integer register-immediate instructions */
  wire addiw = op_imm_32 & funct3_000;
  wire slliw = op_imm_32 & funct3_001 & funct7_0000000;
  wire srliw = op_imm_32 & funct3_101 & funct7_0000000;
  wire sraiw = op_imm_32 & funct3_101 & funct7_0100000;

  /* integer register-register instructions */
  wire sllw = op_32 & & funct3_001 & funct7_0000000;
  wire srlw = op_32 & & funct3_101 & funct7_0000000;
  wire sraw = op_32 & & funct3_101 & funct7_0100000;


/* Immediate */
  /* instruction type, to be the key to choose immediate */
  wire I_type = op_imm | op_imm_32 | op_load | jalr;
  wire U_type = lui | auipc;
  wire J_type = jal;
  wire S_type = op_store;
  wire R_type = op_op;
  wire B_type = op_branch;


  wire [`Vec(`ImmWidth)] I_imm = `immI(inst);
  wire [`Vec(`ImmWidth)] U_imm = `immU(inst);
  wire [`Vec(`ImmWidth)] J_imm = `immJ(inst);
  wire [`Vec(`ImmWidth)] S_imm = `immS(inst);
  wire [`Vec(`ImmWidth)] R_imm = `immR(inst);
  wire [`Vec(`ImmWidth)] B_imm = `immB(inst);


  assign imm =  ({`ImmWidth{I_type}} & I_imm) |
                ({`ImmWidth{U_type}} & U_imm) |
                ({`ImmWidth{J_type}} & J_imm) |
                ({`ImmWidth{S_type}} & S_imm) |
                ({`ImmWidth{B_type}} & B_imm) |
                ({`ImmWidth{R_type}} & R_imm);

/* Registers */
  assign rd  = `RD(inst);
  assign rs1 = `RS1(inst);
  assign rs2 = `RS2(inst);


/* Control Signals */
  /* alu signals */
  assign alu_op[`AluopAdd]      = addi  | auipc | sd | jal | jalr | ld | add;
  assign alu_op[`AluopSub]      = sub;
  assign alu_op[`AluopLt]       = slti  | slt   | blt;
  assign alu_op[`AluopLtu]      = sltiu | sltu  | bltu;
  assign alu_op[`AluopAnd]      = andi  | and_inst;
  assign alu_op[`AluopOr]       = ori   | or_inst;
  assign alu_op[`AluopXor]      = xori  | xor_inst;
  assign alu_op[`AluopSll]      = slli  | sll;
  assign alu_op[`AluopSrl]      = srli  | srl;
  assign alu_op[`AluopSra]      = srai  | sra;
  assign alu_op[`AluopOutImm]   = lui;
  assign alu_op[`AluopEq]       = beq;
  assign alu_op[`AluopNe]       = bne;
  assign alu_op[`AluopGe]       = bge;
  assign alu_op[`AluopGeu]      = bgeu;
  assign alu_op[`AluopAddw]     = addiw;
  assign alu_op[`AluopSllw]     = slliw | sllw;
  assign alu_op[`AluopSrlw]     = srliw | srlw;
  assign alu_op[`AluopSraw]     = sraiw | sraw;


  /* a instruction needs immediate has no rs2 */
  assign need_imm = op_imm | op_imm_32 | lui | auipc | sd | jal | jalr | ld;


  /* special instruction signals */
  assign is_ebreak  = ebreak;
  assign is_auipc   = auipc;
  assign is_jal     = jal;
  assign is_jalr    = jalr;
  assign is_load    = ld;
  assign is_branch  = op_branch;

  /* write enable */
  assign reg_wen = op_imm | op_imm_32 | lui | auipc | op_op | op_32 |  jal | jalr | ld;
  assign mem_wen = sd;

  assign wmask = sd ?  8'hff : 0;

  assign wdt_op[Wdtop8]  = lb | lbu;
  assign wdt_op[Wdtop16] = lh | lhu;
  assign wdt_op[Wdtop32] = lw | lwu;
  assign wdt_op[Wdtop64] = ld;

  assign is_unsigned = lbu | lhu | lwu;

  /* exception signals */
  /* this signal seems silly, but it is useful, 
    according to the principle "implement first, and than 
    perfect it", we just use it. */
  assign inst_not_ipl = ~(addi | ebreak | auipc | jal | sd | jalr 
  | ld | add | sub | slti | sltiu | andi | beq | bne | addiw);

endmodule
