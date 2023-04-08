
/* using for define a vector for 0 to Width-1 */
`define Vec(Width) Width-1:0

`define InstWidth   32
// `define PcRst 64'h80000000
`define PcRst 64'h80000014


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
  // `define AluopWidth  32
  `define AluopWidth  48

//   `define AluopAdd      0
//   `define AluopSub      1
//   `define AluopLt       2 // less than, signed, use for slti
//   `define AluopLtu      3 // less than, unsigned, use for sltiu
//   `define AluopAnd      4
//   `define AluopOr       5
//   `define AluopXor      6
//   `define AluopSll      7 // shift left logically
//   `define AluopSrl      8 // shift right logically
//   `define AluopSra      9 // shift right arithmetically
//   `define AluopOutImm   10 // output immediate (operator2) directly
//   `define AluopEq       11
//   `define AluopNe       12
//   `define AluopGe       13
//   `define AluopGeu      14
//   `define AluopAddw     15
//   `define AluopSllw     16
//   `define AluopSrlw     17
//   `define AluopSraw     18
//   `define AluopSubw     19
//   `define AluopMul      20
//   `define AluopMulh     21
//   `define AluopMulhsu   22
//   `define AluopMulhu    23
//   `define AluopMulw     24
//   `define AluopDiv      25
//   `define AluopDivu     26
//   `define AluopRem      27
//   `define AluopRemu     28
//   `define AluopDivw     29
//   `define AluopDivuw    30
//   `define AluopRemw     31
//   `define Aluopremuw    32
// 
//   /* AluAdd equals to 1<<`AluopAdd, and so on */
//   `define AluAdd        `AluopWidth'h000000000001
//   `define AluSub        `AluopWidth'h000000000002
//   `define AluLt         `AluopWidth'h000000000004
//   `define AluLtu        `AluopWidth'h000000000008
//   `define AluAnd        `AluopWidth'h000000000010
//   `define AluOr         `AluopWidth'h000000000020
//   `define AluXor        `AluopWidth'h000000000040
//   `define AluSll        `AluopWidth'h000000000080
//   `define AluSrl        `AluopWidth'h000000000100
//   `define AluSra        `AluopWidth'h000000000200
//   `define AluOutImm     `AluopWidth'h000000000400
//   `define AluEq         `AluopWidth'h000000000800
//   `define AluNe         `AluopWidth'h000000001000
//   `define AluGe         `AluopWidth'h000000002000
//   `define AluGeu        `AluopWidth'h000000004000
//   `define AluAddw       `AluopWidth'h000000008000
//   `define AluSllw       `AluopWidth'h000000010000
//   `define AluSrlw       `AluopWidth'h000000020000
//   `define AluSraw       `AluopWidth'h000000040000
//   `define AluSubw       `AluopWidth'h000000080000
//   `define AluMul        `AluopWidth'h000000100000
//   `define AluMulh       `AluopWidth'h000000200000
//   `define AluMulhsu     `AluopWidth'h000000400000
//   `define AluMulhu      `AluopWidth'h000000800000
//   `define AluMulw       `AluopWidth'h000001000000   
//   `define Aludiv        `AluopWidth'h000002000000
//   `define Aludivu       `AluopWidth'h000004000000
//   `define Alurem        `AluopWidth'h000008000000
//   `define Aluremu       `AluopWidth'h000010000000
//   `define Aludivw       `AluopWidth'h000020000000
//   `define Aludivuw      `AluopWidth'h000040000000
//   `define Aluremw       `AluopWidth'h000080000000
//   `define Aluremuw      `AluopWidth'h000100000000

  `define AluopAdd      0
  `define AluopSub      `AluopAdd    +  1
  `define AluopLt       `AluopSub    +  1  // less than, signed, use for slti
  `define AluopLtu      `AluopLt     +  1  // less than, unsigned, use for sltiu
  `define AluopAnd      `AluopLtu    +  1
  `define AluopOr       `AluopAnd    +  1
  `define AluopXor      `AluopOr     +  1
  `define AluopSll      `AluopXor    +  1  // shift left logically
  `define AluopSrl      `AluopSll    +  1  // shift right logically
  `define AluopSra      `AluopSrl    +  1  // shift right arithmetically
  `define AluopOutImm   `AluopSra    +  1  // output immediate (operator2) directly
  `define AluopEq       `AluopOutImm +  1 
  `define AluopNe       `AluopEq     +  1 
  `define AluopGe       `AluopNe     +  1 
  `define AluopGeu      `AluopGe     +  1 
  `define AluopAddw     `AluopGeu    +  1 
  `define AluopSllw     `AluopAddw   +  1 
  `define AluopSrlw     `AluopSllw   +  1 
  `define AluopSraw     `AluopSrlw   +  1 
  `define AluopSubw     `AluopSraw   +  1 
  `define AluopMul      `AluopSubw   +  1 
  `define AluopMulh     `AluopMul    +  1 
  `define AluopMulhsu   `AluopMulh   +  1 
  `define AluopMulhu    `AluopMulhsu +  1 
  `define AluopMulw     `AluopMulhu  +  1 
  `define AluopDiv      `AluopMulw   +  1 
  `define AluopDivu     `AluopDiv    +  1 
  `define AluopRem      `AluopDivu   +  1 
  `define AluopRemu     `AluopRem    +  1 
  `define AluopDivw     `AluopRemu   +  1 
  `define AluopDivuw    `AluopDivw   +  1 
  `define AluopRemw     `AluopDivuw  +  1 
  `define AluopRemuw    `AluopRemw   +  1 

  /* AluAdd equals to 1<<`AluopAdd, and so on */
  `define AluAdd        `AluopWidth'h000000000001
  `define AluSub        ( `AluAdd     << 1)
  `define AluLt         ( `AluSub     << 1)
  `define AluLtu        ( `AluLt      << 1)
  `define AluAnd        ( `AluLtu     << 1)
  `define AluOr         ( `AluAnd     << 1)
  `define AluXor        ( `AluOr      << 1)
  `define AluSll        ( `AluXor     << 1)
  `define AluSrl        ( `AluSll     << 1)
  `define AluSra        ( `AluSrl     << 1)
  `define AluOutImm     ( `AluSra     << 1)
  `define AluEq         ( `AluOutImm  << 1)
  `define AluNe         ( `AluEq      << 1)
  `define AluGe         ( `AluNe      << 1)
  `define AluGeu        ( `AluGe      << 1)
  `define AluAddw       ( `AluGeu     << 1)
  `define AluSllw       ( `AluAddw    << 1)
  `define AluSrlw       ( `AluSllw    << 1)
  `define AluSraw       ( `AluSrlw    << 1)
  `define AluSubw       ( `AluSraw    << 1)
  `define AluMul        ( `AluSubw    << 1)
  `define AluMulh       ( `AluMul     << 1)
  `define AluMulhsu     ( `AluMulh    << 1)
  `define AluMulhu      ( `AluMulhsu  << 1)
  `define AluMulw       ( `AluMulhu   << 1)
  `define Aludiv        ( `AluMulw    << 1)
  `define Aludivu       ( `Aludiv     << 1)
  `define Alurem        ( `Aludivu    << 1)
  `define Aluremu       ( `Alurem     << 1)
  `define Aludivw       ( `Aluremu    << 1)
  `define Aludivuw      ( `Aludivw    << 1)
  `define Aluremw       ( `Aludivuw   << 1)
  `define Aluremuw      ( `Aluremw    << 1) 

  `define ShtWdt  6 // shift fileds width, for slli, srli, srai ...
  `define ShtWdtW 5 // for slliw, srliw, sraiw ...

  `define WordWidth 32

  /* for lb, lh, lw, ld, sb instructions ... */
  `define WdtTypeCnt  4 // 8, 16, 32, 64, there are four width types

  `define Wdtop8  0
  `define Wdtop16 1
  `define Wdtop32 2
  `define Wdtop64 3

  `define Wdt8    `WdtTypeCnt'h1
  `define Wdt16   `WdtTypeCnt'h2
  `define Wdt32   `WdtTypeCnt'h4    
  `define Wdt64   `WdtTypeCnt'h8
