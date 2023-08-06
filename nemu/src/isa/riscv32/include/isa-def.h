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

#ifndef __ISA_RISCV32_H__
#define __ISA_RISCV32_H__

#include <common.h>

#define mtvec_id    0x305
#define mepc_id     0x341
#define mstatus_id  0x300
#define mcause_id   0x342

#define cpu_mtvec_id    0
#define cpu_mepc_id     1
#define cpu_mstatus_id  2
#define cpu_mcause_id   3

#define csr_cnt 4
/* zyy: why without flag registers? like NZCV? */
typedef struct {
  word_t gpr[32];
  vaddr_t pc;
  /* 0:mtvec, 1:mepc, 2:mstatus, 3:mcause */
  word_t csr[4];
} riscv32_CPU_state;

// decode
typedef struct {
  union {
    uint32_t val;
  } inst;
} riscv32_ISADecodeInfo;

#define isa_mmu_check(vaddr, len, type) (MMU_DIRECT)

#endif
