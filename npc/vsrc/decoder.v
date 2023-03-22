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

  // output inst_type,
  output [`Vec(`RegIdWidth)] rd,
  output [`Vec(`RegIdWidth)] rs1,
  output [`Vec(`RegIdWidth)] rs2,
  output [`Vec(`ImmWidth)] imm,
  output need_imm,
  output alu_add,
  output is_ebreak,
  output is_auipc,
  output inst_not_ipl,
  output is_jal,
  output is_jalr,
  output reg_wen,
  output mem_wen,
  output [7:0] wmask,
  output is_load
);

/* decode infos */
  /* opcode */
  wire op_imm = `OpIs(`OP_IMM);
  wire op_system = `OpIs(`SYSTEM);
  wire op_auipc = `OpIs(`AUIPC);
  wire op_jal = `OpIs(`JAL);
  wire op_store = `OpIs(`STORE);
  wire op_jalr = `OpIs(`JALR);
  wire op_load  = `OpIs(`LOAD);
  wire op_op  = `OpIs(`OP)
  
  /* funct3 */
  wire funct3_000 = `FUNCT3_Is(3'b000);
  // wire funct3_001 = `FUNCT3_Is(3'b001);
  // wire funct3_010 = `FUNCT3_Is(3'b010);
  wire funct3_011 = `FUNCT3_Is(3'b011);

  /* funct7, if it has more cases, use script to generate the codes below */
  wire funct7_0000000 = `FUNCT7_Is(7'b0000000);


  /* funct12, use for system instructions? */
  wire funct12_000000000001 = `FUNCT12_Is(12'b000000000001);


/* instructions */
  /* inst is zero */
  wire nop = (inst == 32'h0);

  /* reference: volume I: RISC-V Unprivileged ISA V20191213 */

  /* 2.4 integer computational instructions */
    /* integer register-immediate instructions */
  wire addi     = op_imm & funct3_000;
  wire auipc    = op_auipc;
    /* integer register-register instructions */
  wire add  = op_op & funct3_000 & funct7_0000000;

  /* 2.5 control transfer instructions */
    /* unconditial jumps */
  wire jal = op_jal;
  wire jalr = op_jalr;

    /* conditianal branches */

  /* 2.6 load and store */
  wire sd = op_store &  funct3_011;
  wire ld = op_load & funct3_011;

  /* 2.8 environment call and breakpoints */
  wire ebreak = op_system & funct3_000 & funct12_000000000001;
  

/* immediate */
  /* instruction type, to be the key to choose immediate */
  wire I_type = op_imm | op_load | jalr;
  wire U_type = auipc;
  wire J_type = jal;
  wire S_type = op_store;
  wire R_type = op_op;


  wire [`Vec(`ImmWidth)] I_imm = `immI(inst);
  wire [`Vec(`ImmWidth)] U_imm = `immU(inst);
  wire [`Vec(`ImmWidth)] J_imm = `immJ(inst);
  wire [`Vec(`ImmWidth)] S_imm = `immS(inst);
  wire [`Vec(`ImmWidth)] R_imm = `immR(inst);


  assign imm =  ({`ImmWidth{I_type}} & I_imm) |
                ({`ImmWidth{U_type}} & U_imm) |
                ({`ImmWidth{J_type}} & J_imm) |
                ({`ImmWidth{S_type}} & S_imm) |
                ({`ImmWidth{R_type}} & R_imm);

/* registers */
  assign rd = `RD(inst);
  assign rs1 = `RS1(inst);
  assign rs2 = `RS2(inst);


/* control signals */
  /* alu signals */
  assign alu_add = addi | auipc | sd | jalr | ld | add;

  // assign alu_op

  /* a instruction needs immediate has no rs2 */
  assign need_imm = op_imm | auipc | sd | jalr | ld;


  /* special instruction signals */
  assign is_ebreak = ebreak;
  assign is_auipc = auipc;
  assign is_jal = jal;
  assign is_jalr = jalr;
  assign is_load  = ld;

  /* write enable */
  // assign reg_wen = ~(sd);
  assign reg_wen = addi | auipc | jal | jalr | ld | add;
  // assign reg_wen = 0;
  assign mem_wen = sd;
  // assign mem_wen = 1'b0;

  // assign wmask = sd ? (wmask | 8'hff) : wmask;
  assign wmask = sd ?  8'hff : 0;


  /* exception signals */
  /* this signal seems silly, but it is useful, 
    according to the principle "implement first, and than 
    perfect it", we just use it. */
  assign inst_not_ipl = ~(addi | ebreak | auipc | jal | sd | nop | jalr 
  | ld | add);

endmodule
