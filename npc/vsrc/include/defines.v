
/* using for define a vector for 0 to Width-1 */
`define Vec(Width) Width-1:0

`define InstWidth   32
`define PcRst 64'h80000000


  `define AddrWidth       64

/* register related macro */
  `define RegIdWidth      5 /* the width of a number to discribe a register's index */
  `define RegCnt          2**`RegIdWidth /* register counts */
  `define RegWidth        64 /* width of register */


/* immediate ralated macro */
  `define ImmWidth        64 /* width of immediate */
  /* sign extension to ImmWidth, len is the length of the current input imm */
  `define SEXT(imm, len)  {(`ImmWidth - len){imm[len-1]}, imm}
  /* zero extension */
  `define ZEXT(imm, len)  {(`ImmWidth - len){1'b0}, imm}

  `define immI(inst) {{(`ImmWidth-11){inst[31]}}, inst[30:20] }
  `define immU(inst) {{(`ImmWidth-32){inst[31]}}, inst[31:12], {12{1'b0}}}
  `define immJ(inst) {{(`ImmWidth-20){inst[31]}}, inst[19:12], inst[20], inst[30:21], {1{1'b0}}}
  `define immS(inst) {{(`ImmWidth-11){inst[31]}}, inst[30:25], inst[11:7]}
  `define immR(inst) `ImmWidth'b0


/* decode instruction related */
  `define RD(inst)        inst[11:7]
  `define RS1(inst)       inst[19:15]
  `define RS2(inst)       inst[24:20]
  `define OPCODE(inst)    inst[6:0]
  `define FUNCT3(inst)    inst[14:12]
  `define FUNCT7(inst)    inst[31:25]
  `define FUNCT12(inst)   inst[31:20]

  `define FUNCT3_Is(imm) (`FUNCT3(inst) == imm);
  `define FUNCT7_Is(imm) (`FUNCT7(inst) == imm);
  `define FUNCT12_Is(imm) (`FUNCT12(inst) == imm);


  /* inst[6:0], opcode, we must make our codes have a 
    great expansibility, as it may add more opcode fields later. */
  `define OP_IMM      7'b0010011
  `define LUI         7'b0110111
  `define AUIPC       7'b0010111
  `define OP          7'b0110011
  `define JAL         7'b1101111
  `define JALR        7'b1100111
  `define BRANCH      7'b1100011
  `define LOAD        7'b0000011
  `define STORE       7'b0100011
  `define MISC_MEM    7'b0001111
  `define SYSTEM      7'b1110011

  `define OP_IMM_32   7'b0011011
  `define OP_32       7'b0111011
  /* define more here ... */


  /* the format of `define IsOp(opcode)  (`OPCODE(inst) == `opcode) 
    is worse than below. The abbreviation means if the opcode is ... */
  `define OpIs(opcode)  (`OPCODE(inst) == opcode)


  /* alu_op decode information */
  `define AluopWidth  32

  `define AluopAdd 0
  `define AluopSub 1


  /* AluAdd equals to 1<<`AluopAdd, and so on */
  `define AluAdd `AluopWidth'h00000000
  `define AluSub `AluopWidth'h00000001