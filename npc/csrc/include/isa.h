#ifndef __ISA_H__
#define __ISA_H__

#include <macro.h>
#include "common.h"

typedef struct {
  word_t gpr[32];
  // uint64_t *gpr;
  /* paddinig */
  // uint64_t padding[31];
  vaddr_t pc;
  /* 0:mtvec, 1:mepc, 2:mstatus, 3:mcause */
  // word_t csr[4];
} riscv64_CPU_state;

#define cpu_mtvec_id    0
#define cpu_mepc_id     1
#define cpu_mcause_id   2
typedef struct {
  word_t gpr[32];
  vaddr_t pc;
  /* 0:mtvec, 1:mepc, 2:mstatus, 3:mcause */
  word_t csr[3];

  word_t mstatus;
} riscv32_CPU_state;


// typedef riscv64_CPU_state CPU_state;
typedef riscv32_CPU_state CPU_state;


#endif