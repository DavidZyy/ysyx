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
#define mcause_id   0x342
#define mstatus_id  0x300

#define cpu_mtvec_id    0
#define cpu_mepc_id     1
#define cpu_mcause_id   2

#define csr_cnt 3

/* zyy: why without flag registers? like NZCV? */
typedef struct {
  word_t gpr[32];
  vaddr_t pc;
  /* 0:mtvec, 1:mepc, 2:mcause */
  word_t csr[3];

  union MStatus {
    struct {
        uint32_t uie : 1;   // User mode interrupt enable
        uint32_t sie : 1;   // Supervisor mode interrupt enable
        uint32_t wpri1 : 1; // Reserved (write-preserved) bit 1
        uint32_t mie : 1;   // Machine mode interrupt enable
        uint32_t upie : 1;  // User mode previous interrupt enable
        uint32_t spie : 1;  // Supervisor mode previous interrupt enable
        uint32_t wpri2 : 1; // Reserved (write-preserved) bit 2
        uint32_t mpie : 1;  // Machine mode previous interrupt enable
        uint32_t spp : 1;   // Supervisor Previous Privilege mode
        uint32_t wpri3 : 2; // Reserved (write-preserved) bits 3-4
        uint32_t mpp : 2;   // Machine Previous Privilege mode
        uint32_t fs : 2;    // Machine mode FPU state
        uint32_t xs : 2;    // Machine mode extension state
        uint32_t mprv : 1;  // Modify privilege level when accessing CSRs, the set and clear see chatgpt
        uint32_t sum : 1;   // Supervisor User Memory Access (S/U)
        uint32_t mxr : 1;   // Execute-only memory in user mode (X)
        uint32_t tvm : 1;   // Trap Virtual Memory (TVM)
        uint32_t tw : 1;    // Timeout Wait
        uint32_t tsr : 1;   // Trap SRET
        uint32_t wpri4 : 8; // Reserved (write-preserved) bits 5-12
        uint32_t sd : 1;    //
    } fields;
    uint32_t raw; // Access the raw 32-bit representation
  } mstatus;
  // union Mstatus mstatus;
} riscv32_CPU_state;

// decode
typedef struct {
  union {
    uint32_t val;
  } inst;
} riscv32_ISADecodeInfo;

#define isa_mmu_check(vaddr, len, type) (MMU_DIRECT)

#endif
