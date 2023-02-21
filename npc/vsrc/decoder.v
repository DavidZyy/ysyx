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
  output inst_not_ipl
);

  /* opcode */
  wire op_imm = `OpIs(`OP_IMM);
  wire op_system = `OpIs(`SYSTEM);
  
  /* funct3 */
  wire funct3_000 = `FUNCT3_Is(3'b000);

  /* funct7, if it has more cases, use script to generate the codes below */


  /* funct12, use for system instructions? */
  wire funct12_000000000001 = `FUNCT12_Is(12'b000000000001);


  /* instructions ref: volume I: RISC-V Unprivileged ISA V20191213 */

  /* 2.4 integer computational instructions */
    /* integer register-immediate instructions */
  wire addi     = op_imm & funct3_000;
    /* integer register-register instructions */

  /* 2.5 control transfer instructions */
    /* unconditial jumps */

    /* conditianal branches */

  /* 2.6 load and store */

  /* 2.8 environment call and breakpoints */
  wire ebreak   = op_system & funct3_000 & funct12_000000000001;
  

  /* instruction type, to be the key to choose immediate */
  wire I_type = op_imm;


  /* immediate */
  wire [`ImmWidth-1:0] I_imm = `immI(inst);


  assign is_ebreak = ebreak;

  assign imm = ({`ImmWidth{I_type}} & I_imm);

  // assign dec_info
  assign alu_add = addi;

  /* a instruction needs immediate has no rs2 */
  assign need_imm = op_imm | ebreak;

  assign rd = `RD(inst);
  assign rs1 = `RS1(inst);
  assign rs2 = `RS2(inst);

  /* this signal seems silly, but it is useful, 
    according to the principle "implement first, and than 
    perfect it", we just use it. */
  assign inst_not_ipl = ~(addi | ebreak);
endmodule
