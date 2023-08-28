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

#include <isa.h>
#include "local-include/reg.h"
#include <common.h>

const char *regs[] = {
  "$0", "ra", "sp", "gp", "tp", "t0", "t1", "t2",
  "s0", "s1", "a0", "a1", "a2", "a3", "a4", "a5",
  "a6", "a7", "s2", "s3", "s4", "s5", "s6", "s7",
  "s8", "s9", "s10", "s11", "t3", "t4", "t5", "t6"
};

const char *csrs[] = {
  "mtvec",
  "mepc",
  "mcause"
};


void isa_reg_display(CPU_state *ref) {
  printf("nemu(dut)     spike(ref)\n");
  for (int i = 0; i < 32; i++) {
    if(ref->gpr[i] != gpr(i)) {
      // printf("%-3s: %016"XX"  ", regs[i], gpr(i));  // Use width and alignment specifiers in the format string
      // printf("%-3s: %016"XX"  ", regs[i], ref->gpr[i]);
      printf("%-3s: %"XX"  ", regs[i], gpr(i));  // Use width and alignment specifiers in the format string
      printf("%-3s: %"XX"  ", regs[i], ref->gpr[i]);
      printf("\n");
    }
  }

  for (int i = 0; i < csr_cnt; i++) {
    if(ref->csr[i] != cpu.csr[i]) {
      printf("%-7s: %016"XX"  ", csrs[i], cpu.csr[i]);  // Use width and alignment specifiers in the format string
      printf("%-7s: %016"XX"  ", csrs[i], ref->csr[i]);
      printf("\n");
    }
  }

  if(ref->mstatus.raw != cpu.mstatus.raw) {
    printf("%-7s: %016"XX"  ", "mstatus", cpu.mstatus.raw);  // Use width and alignment specifiers in the format string
    printf("%-7s: %016"XX"  ", "mstatus", ref->mstatus.raw);
    printf("\n");
  }

  if (ref->pc != cpu.pc) {
      printf("%-3s: %016"XX"  ", "pc", cpu.pc);  // Use width and alignment specifiers in the format string
      printf("%-3s: %016"XX"  ", "pc", ref->pc);
      printf("\n");
  }
}

word_t isa_reg_str2val(const char *s, bool *success) {
  for (int i = 0; i < 32; i ++) {
    if(!strcmp(regs[i], s+1) || !strcmp(s, "$0"))
      return gpr(i);
  }
  assert(0);
  return 0;
}
