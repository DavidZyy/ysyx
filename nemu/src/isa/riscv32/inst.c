/***************************************************************************************
* Copyright (c) 2014-2022 Zihao Yu, Nanjing University
*
* NEMU is licensed under Mulan PSL v2.
* You can use this software according to the terms and conditions of the Mulan PSL v2.
* You may obtain a copy of Mulan PSL v2 at:
*          http://license.coscl.org.cn/MulanPSL2
*
* THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND,
* EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT,
* MERCHANTABILITY OR FIT FOR A PARTICULAR PURPOSE.
*
* See the Mulan PSL v2 for more details.
***************************************************************************************/

#include "local-include/reg.h"
#include <cpu/cpu.h>
#include <cpu/ifetch.h>
#include <cpu/decode.h>
#include <ftrace.h>

#define R(i) gpr(i)
#define Mr vaddr_read
#define Mw vaddr_write

enum {
  TYPE_I, TYPE_U, TYPE_S, TYPE_J, TYPE_R, TYPE_B,
  TYPE_N, // none
};

#define src1R() do { *src1 = R(rs1); } while (0)
#define src2R() do { *src2 = R(rs2); } while (0)
#define immI() do { *imm = SEXT(BITS(i, 31, 20), 12); } while(0)
#define immU() do { *imm = SEXT(BITS(i, 31, 12), 20) << 12; } while(0)
#define immS() do { *imm = (SEXT(BITS(i, 31, 25), 7) << 5) | BITS(i, 11, 7); } while(0)
#define immJ() do { *imm = (SEXT(BITS(i, 31, 31), 1) << 20) | (BITS(i, 19, 12) << 12) | (BITS(i, 20, 20) << 11) | (BITS(i, 30, 21) << 1); } while(0)
#define immB() do { *imm = (SEXT(BITS(i, 31, 31), 1) << 12) | (BITS(i, 7, 7) << 11) | (BITS(i, 30, 25) << 5) | (BITS(i, 11, 8) << 1); } while(0)

static void decode_operand(Decode *s, int *dest, word_t *src1, word_t *src2, word_t *imm, int type) {
  uint32_t i = s->isa.inst.val;
  int rd  = BITS(i, 11, 7);
  int rs1 = BITS(i, 19, 15);
  int rs2 = BITS(i, 24, 20);
  *dest = rd;
  switch (type) {
    case TYPE_I: src1R();          immI(); break;
    case TYPE_U:                   immU(); break;
    case TYPE_S: src1R(); src2R(); immS(); break;
    case TYPE_J:                   immJ(); break;
    case TYPE_R: src1R(); src2R();       ; break;
    case TYPE_B: src1R(); src2R(); immB(); break;
  }
}

void csrrw(word_t csr_id, int rd, word_t src1);
void csrrs(word_t csr_id, int rd, word_t src1);
void ecall(Decode *s);
void mret(Decode *s);

static int decode_exec(Decode *s) {
  int dest = 0;
  word_t src1 = 0, src2 = 0, imm = 0;
  s->dnpc = s->snpc;

#define INSTPAT_INST(s) ((s)->isa.inst.val)
#define INSTPAT_MATCH(s, name, type, ... /* execute body */ ) { \
  decode_operand(s, &dest, &src1, &src2, &imm, concat(TYPE_, type)); \
  __VA_ARGS__ ; \
}

  INSTPAT_START();

/* RV32I*/
/* 2.4 Integer Computational Instructions */
  /* Integer Register-Immediate Instructions */
  INSTPAT("??????? ????? ????? 000 ????? 00100 11", addi   , I, R(dest) = src1 + imm); /* the src1 = R(rs1), see decode_operand */
  INSTPAT("??????? ????? ????? 010 ????? 00100 11", slti   , I, R(dest) = ((sword_t)src1 < (sword_t)imm));
  INSTPAT("??????? ????? ????? 011 ????? 00100 11", sltiu  , I, R(dest) = (src1 < imm));
  INSTPAT("??????? ????? ????? 111 ????? 00100 11", andi   , I, R(dest) = src1 & imm);
  INSTPAT("??????? ????? ????? 110 ????? 00100 11", ori    , I, R(dest) = src1 | imm);
  INSTPAT("??????? ????? ????? 100 ????? 00100 11", xori   , I, R(dest) = src1 ^ imm);
  INSTPAT("0000000 ????? ????? 001 ????? 00100 11", slli   , I, R(dest) = src1 << RV32_shamt(imm));
  INSTPAT("0000000 ????? ????? 101 ????? 00100 11", srli   , I, R(dest) = src1 >> RV32_shamt(imm));
  INSTPAT("0100000 ????? ????? 101 ????? 00100 11", srai   , I, R(dest) = (sword_t)src1 >> RV32_shamt(imm));
  INSTPAT("??????? ????? ????? ??? ????? 01101 11", lui    , U, R(dest) = imm);
  INSTPAT("??????? ????? ????? ??? ????? 00101 11", auipc  , U, R(dest) = s->pc + imm);

  /* Integer Register-Register Operations */
  INSTPAT("0000000 ????? ????? 000 ????? 01100 11", add    , R, R(dest) = src1 + src2);
  INSTPAT("0000000 ????? ????? 010 ????? 01100 11", slt    , R, R(dest) = (sword_t)src1 < (sword_t)src2);
  INSTPAT("0000000 ????? ????? 011 ????? 01100 11", sltu   , R, R(dest) = src1 < src2);
  INSTPAT("0000000 ????? ????? 111 ????? 01100 11", and    , R, R(dest) = src1 & src2);
  INSTPAT("0000000 ????? ????? 110 ????? 01100 11", or     , R, R(dest) = src1 | src2);
  INSTPAT("0000000 ????? ????? 100 ????? 01100 11", xor    , R, R(dest) = src1 ^ src2);
  INSTPAT("0000000 ????? ????? 001 ????? 01100 11", sll    , R, R(dest) = src1 << src2);
  INSTPAT("0000000 ????? ????? 101 ????? 01100 11", srl    , R, R(dest) = src1 >> src2);
  INSTPAT("0100000 ????? ????? 000 ????? 01100 11", sub    , R, R(dest) = src1 - src2);
  INSTPAT("0100000 ????? ????? 101 ????? 01100 11", sra    , R, R(dest) = (sword_t)src1 >> src2);

/* 2.5 Control Transfer Instructions */
  /* Unconditional Jumps */
  
  INSTPAT("??????? ????? ????? ??? ????? 11011 11", jal    , J, R(dest) = s->pc + 4; s->dnpc = s->pc + imm; FUNC_TRACE);
  INSTPAT("??????? ????? ????? 000 ????? 11001 11", jalr   , I, 
  R(dest) = s->pc + 4; s->dnpc = src1 + imm; s->dnpc = s->dnpc & ~1; if(s->isa.inst.val == RET) {FUNC_TRACE_RET} else {FUNC_TRACE});

  /* Conditional Branches, B-type */
  INSTPAT("??????? ????? ????? 000 ????? 11000 11", beq    , B, if(src1 == src2) {s->dnpc = s->pc + imm; FUNC_TRACE} ); /* it does not matter add or not add (sword_t) before imm? */
  INSTPAT("??????? ????? ????? 001 ????? 11000 11", bne    , B, if(src1 != src2) {s->dnpc = s->pc + imm; FUNC_TRACE} );
  INSTPAT("??????? ????? ????? 100 ????? 11000 11", blt    , B, if((sword_t)src1 < (sword_t)src2) {s->dnpc = s->pc + imm; FUNC_TRACE});
  INSTPAT("??????? ????? ????? 101 ????? 11000 11", bge    , B, if((sword_t)src1 >= (sword_t)src2) {s->dnpc = s->pc + imm; FUNC_TRACE});
  INSTPAT("??????? ????? ????? 110 ????? 11000 11", bltu   , B, if(src1 < src2) {s->dnpc = s->pc + imm; FUNC_TRACE});
  INSTPAT("??????? ????? ????? 111 ????? 11000 11", bgeu   , B, if((word_t)src1 >= (word_t)src2) {s->dnpc = s->pc + imm; FUNC_TRACE});

/* 2.6 Load and Store Instructions */
  INSTPAT("??????? ????? ????? 000 ????? 00000 11", lb     , I, R(dest) = SEXT(BITS(Mr(src1 + imm, 1), 8, 0), 8));
  INSTPAT("??????? ????? ????? 100 ????? 00000 11", lbu    , I, R(dest) = Mr(src1 + imm, 1));
  INSTPAT("??????? ????? ????? 001 ????? 00000 11", lh     , I, R(dest) = SEXT(BITS(Mr(src1 + imm, 2), 16, 0), 16));
  INSTPAT("??????? ????? ????? 101 ????? 00000 11", lhu    , I, R(dest) = Mr(src1 + imm, 2));
  INSTPAT("??????? ????? ????? 010 ????? 00000 11", lw     , I, R(dest) = Mr(src1 + imm, 4));

  INSTPAT("??????? ????? ????? 000 ????? 01000 11", sb     , S, Mw(src1 + imm, 1, src2));
  INSTPAT("??????? ????? ????? 001 ????? 01000 11", sh     , S, Mw(src1 + imm, 2, src2));
  INSTPAT("??????? ????? ????? 010 ????? 01000 11", sw     , S, Mw(src1 + imm, 4, src2));

/* 2.8 Environment Call and Breakpoints */
  INSTPAT("0000000 00001 00000 000 00000 11100 11", ebreak , N, NEMUTRAP(s->pc, R(10))); // R(10) is $a0
  INSTPAT("0000000 00000 00000 000 00000 11100 11", ecall  , N, ecall(s));


/* 7.1 Multiplication Operations */
  INSTPAT("0000001 ????? ????? 000 ????? 01100 11", mul    , R, R(dest) = src1 * src2);
  // not right!!
  INSTPAT("0000001 ????? ????? 001 ????? 01100 11", mulh   , R, R(dest) = ((sword_t)src1>>16 * (sword_t)src2)>>16);//seems not right, shoule be 64
  INSTPAT("0000001 ????? ????? 010 ????? 01100 11", mulhsu , R, R(dest) = ((sword_t)src1>>16 * (word_t)src2)>>16);
  INSTPAT("0000001 ????? ????? 011 ????? 01100 11", mulhu  , R, R(dest) = ((word_t)src1>>16 * (word_t)src2)>>16);

/* 7.2 Division Operations */
  INSTPAT("0000001 ????? ????? 100 ????? 01100 11", div    , R, R(dest) = ((sword_t)src1 / (sword_t)src2));
  INSTPAT("0000001 ????? ????? 101 ????? 01100 11", divu   , R, R(dest) = ((word_t)src1 / (word_t)src2));

  INSTPAT("0000001 ????? ????? 110 ????? 01100 11", rem    , R, R(dest) = ((sword_t)src1 % (sword_t)src2));
  INSTPAT("0000001 ????? ????? 111 ????? 01100 11", remu   , R, R(dest) = ((word_t)src1 % (word_t)src2));

  /* RV-Zicsr */
  INSTPAT("??????? ????? ????? 001 ????? 11100 11", csrrw  , I, csrrw(imm, dest, src1));
  INSTPAT("??????? ????? ????? 010 ????? 11100 11", csrrs  , I, csrrs(imm, dest, src1));

  INSTPAT("0011000 00010 00000 000 00000 11100 11", mret   , I, mret(s));
/* Invalid Instructions, not risc-v inst. */
  INSTPAT("??????? ????? ????? ??? ????? ????? ??", inv    , N, INV(s->pc));
  INSTPAT_END();

  R(0) = 0; // reset $zero to 0

  return 0;
}

void mret(Decode *s) {
  s->dnpc = cpu.csr[cpu_mepc_id];
  cpu.csr[cpu_mstatus_id] = (word_t)0xa00000080;
}

void csrrw(word_t csr_id, int rd, word_t src1) {
  if (csr_id == mtvec_id) {
    R(rd) = cpu.csr[cpu_mtvec_id];
    cpu.csr[cpu_mtvec_id] = src1;
  } else if (csr_id == mepc_id) {
    R(rd) = cpu.csr[cpu_mepc_id];
    cpu.csr[cpu_mepc_id] = src1;
  } else if (csr_id == mstatus_id) {
    R(rd) = cpu.csr[cpu_mstatus_id];
    cpu.csr[cpu_mstatus_id] = src1;
  } else if (csr_id == mcause_id) {
    R(rd) = cpu.csr[cpu_mcause_id];
    cpu.csr[cpu_mcause_id] = src1;
  } else {
    panic("here!!");
  }
}

void ecall(Decode *s) {
  IFDEF(CONFIG_ETRACE, log_write("etrace: ecall in ecall function in inst.c\n"));
  cpu.csr[cpu_mstatus_id] = (word_t)0xa00001800;
  cpu.csr[cpu_mepc_id]    = cpu.pc; // see ref
  cpu.csr[cpu_mcause_id]  = 0xb; // environment call from M-mode
  s->dnpc = cpu.csr[cpu_mtvec_id];
}

void csrrs(word_t csr_id, int rd, word_t src1) {
  if (csr_id == mtvec_id) {
    R(rd) = cpu.csr[cpu_mtvec_id];
    /* no set */
  } else if (csr_id == mepc_id) {
    R(rd) = cpu.csr[cpu_mepc_id];
  } else if (csr_id == mstatus_id) {
    R(rd) = cpu.csr[cpu_mstatus_id];
  } else if (csr_id == mcause_id ) {
    R(rd) = cpu.csr[cpu_mcause_id];
  } else {
    panic("here!!");
  }
}

int isa_exec_once(Decode *s) {
  s->isa.inst.val = inst_fetch(&s->snpc, 4);
  return decode_exec(s);
}
