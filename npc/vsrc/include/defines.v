
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
  `define SEXT(imm, len)  {{(`ImmWidth - len){imm[len-1]}}, {imm}}
  /* zero extension */
  `define ZEXT(imm, len)  {{(`ImmWidth - len){1'b0}}, {imm}}

  `define immI(inst) {{(`ImmWidth-11){inst[31]}}, inst[30:20] }
  `define immU(inst) {{(`ImmWidth-32){inst[31]}}, inst[31:12], {12{1'b0}}}
  `define immJ(inst) {{(`ImmWidth-20){inst[31]}}, inst[19:12], inst[20], inst[30:21], {1{1'b0}}}
  `define immS(inst) {{(`ImmWidth-11){inst[31]}}, inst[30:25], inst[11:7]}
  `define immR(inst) `ImmWidth'b0
  `define immB(inst) {{(`ImmWidth-12){inst[31]}}, inst[7], inst[30:25], inst[11:8], {1{1'b0}}}


/* decode instruction related */
  `define RD(inst)        inst[11:7]
  `define RS1(inst)       inst[19:15]
  `define RS2(inst)       inst[24:20]
  `define OPCODE(inst)    inst[6:0]
  `define FUNCT3(inst)    inst[14:12]
  `define FUNCT7(inst)    inst[31:25]
  `define FUNCT12(inst)   inst[31:20]

  `define FUNCT3_Is(imm)  (`FUNCT3(inst) == imm);
  `define FUNCT7_Is(imm)  (`FUNCT7(inst) == imm);
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

  `define AluopAdd      0
  `define AluopSub      1
  `define AluopLt       2 // less than, signed, use for slti
  `define AluopLtu      3 // less than, unsigned, use for sltiu
  `define AluopAnd      4
  `define AluopOr       5
  `define AluopXor      6
  `define AluopSll      7 // shift left logically
  `define AluopSrl      8 // shift right logically
  `define AluopSra      9 // shift right arithmetically
  `define AluopOutImm   10 // output immediate (operator2) directly
  `define AluopEq       11
  `define AluopNe       12
  `define AluopGe       13
  `define AluopGeu      14
  `define AluopAddw     15
  `define AluopSllw     16
  `define AluopSrlw     17
  `define AluopSraw     18
  `define AluopSubw     19

  /* AluAdd equals to 1<<`AluopAdd, and so on */
  `define AluAdd        `AluopWidth'h00000001
  `define AluSub        `AluopWidth'h00000002
  `define AluLt         `AluopWidth'h00000004
  `define AluLtu        `AluopWidth'h00000008
  `define AluAnd        `AluopWidth'h00000010
  `define AluOr         `AluopWidth'h00000020
  `define AluXor        `AluopWidth'h00000040
  `define AluSll        `AluopWidth'h00000080
  `define AluSrl        `AluopWidth'h00000100
  `define AluSra        `AluopWidth'h00000200
  `define AluOutImm     `AluopWidth'h00000400
  `define AluEq         `AluopWidth'h00000800
  `define AluNe         `AluopWidth'h00001000
  `define AluGe         `AluopWidth'h00002000
  `define AluGeu        `AluopWidth'h00004000
  `define AluAddw       `AluopWidth'h00008000
  `define AluSllw       `AluopWidth'h00010000
  `define AluSrlw       `AluopWidth'h00020000
  `define AluSubw       `AluopWidth'h00080000

  `define ShtWdt  6 // shift fileds width, for slli, srli, srai ...
  `define ShtWdtW 5 // for slliw, srliw, sraiw ...
