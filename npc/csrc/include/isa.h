#ifndef __ISA_H__
#define __ISA_H__

#include <macro.h>

// types
// #define paddr_t uint64_t
// #define vaddr_t uint64_t
// #define word_t  uint64_t

#define paddr_t uint32_t
#define vaddr_t uint32_t
#define word_t  uint32_t
#define sword_t int32_t

typedef struct {
  word_t gpr[32];
  // uint64_t *gpr;
  /* paddinig */
  // uint64_t padding[31];
  vaddr_t pc;
} riscv64_CPU_state;

typedef struct {
  word_t gpr[32];
  vaddr_t pc;
  /* 0:mtvec, 1:mepc, 2:mstatus, 3:mcause */
  word_t csr[4];
} riscv32_CPU_state;


// typedef riscv64_CPU_state CPU_state;
typedef riscv32_CPU_state CPU_state;


#endif