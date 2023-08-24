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
#ifdef CONFIG_MTRACE
  // word_t raddr = (addr & !align_mask);
  word_t raddr = (addr >> 2) << 2;
  word_t rdata = paddr_read(raddr, sizeof(word_t));
  IFDEF(CONFIG_MTRACE, log_write("pc:" FMT_WORD", inst:" FMT_WORD"\n", cpu.pc, vaddr_ifetch(cpu.pc, 4)));
  // IFDEF(CONFIG_MTRACE, log_write("pc:" FMT_WORD"\n", cpu.pc));
  IFDEF(CONFIG_MTRACE, log_write("raddr:" FMT_WORD", rdata:" FMT_WORD"\n\n", raddr, rdata));
#endif
  return paddr_read(addr, len);
}

word_t get_wmask(word_t addr, word_t len) {
#ifdef CONFIG_ISA64
  panic(not implemented!);
#endif
  word_t sb_wmask, sh_wmask = 0, sw_wmask, wmask, addr_low_2;
  addr_low_2 = addr & 0b11;
  if(addr_low_2 == 0) {
    sb_wmask = 0x000000ff;
    sh_wmask = 0x0000ffff;
  } else if(addr_low_2 == 1) {
    sb_wmask = 0x0000ff00;
  } else if(addr_low_2 == 2) {
    sb_wmask = 0x00ff0000;
    sh_wmask = 0xffff0000;
  } else if(addr_low_2 == 3) {
    sb_wmask = 0xff000000;
  } else {
    sb_wmask = 0;
    sh_wmask = 0;
  }

  sw_wmask = 0xffffffff;

  if(len == 1) wmask = sb_wmask;
  else if(len == 2) wmask = sh_wmask;
  else if(len == 4) wmask = sw_wmask;
  else wmask = 0;

  return wmask;
}

void vaddr_write(vaddr_t addr, int len, word_t data) {
#ifdef CONFIG_MTRACE
  word_t addr_low_2 = addr & 0b11;
  // word_t waddr = (addr & !align_mask);
  word_t waddr = (addr >> 2) << 2;
  word_t rdata = paddr_read(waddr, sizeof(word_t));
  // word_t rdata = 0;
  word_t wmask = get_wmask(addr, len);
  word_t wdata = ((data << 8*addr_low_2) & wmask) | (rdata & ~wmask);

  IFDEF(CONFIG_MTRACE, log_write("pc:" FMT_WORD", inst:" FMT_WORD"\n", cpu.pc, vaddr_ifetch(cpu.pc, 4)));
  // IFDEF(CONFIG_MTRACE, log_write("pc:" FMT_WORD"\n", cpu.pc));
  IFDEF(CONFIG_MTRACE, log_write("waddr:" FMT_WORD", wdata:" FMT_WORD"\n\n", waddr, wdata));
#endif
  paddr_write(addr, len, data);
}
