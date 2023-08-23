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
#include <memory/paddr.h>

word_t vaddr_ifetch(vaddr_t addr, int len) {
  return paddr_read(addr, len);
}

extern CPU_state cpu;

// void mtrace_dis
word_t vaddr_read(vaddr_t addr, int len) {
  word_t rdata = paddr_read(addr, len);
  IFDEF(CONFIG_MTRACE, log_write("pc:" FMT_WORD", inst:" FMT_WORD"\n", cpu.pc, vaddr_ifetch(cpu.pc, 4)));
  // IFDEF(CONFIG_MTRACE, log_write("pc:" FMT_WORD"\n", cpu.pc));
  IFDEF(CONFIG_MTRACE, log_write("raddr:" FMT_WORD", rdata:" FMT_WORD"\n\n", addr, rdata));
  return rdata;
}

void vaddr_write(vaddr_t addr, int len, word_t data) {
  IFDEF(CONFIG_MTRACE, log_write("pc:" FMT_WORD", inst:" FMT_WORD"\n", cpu.pc, vaddr_ifetch(cpu.pc, 4)));
  // IFDEF(CONFIG_MTRACE, log_write("pc:" FMT_WORD"\n", cpu.pc));
  IFDEF(CONFIG_MTRACE, log_write("waddr:" FMT_WORD", wdata:" FMT_WORD"\n\n", addr, data));
  paddr_write(addr, len, data);
}
