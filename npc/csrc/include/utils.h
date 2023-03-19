
#ifndef __UTILS_H__
#define __UTILS_H__

#include <macro.h>

typedef struct {
  // uint64_t gpr[32];
  uint64_t *gpr;
  uint64_t padding[31];
  vaddr_t pc;
} riscv64_CPU_state;

typedef riscv64_CPU_state CPU_state;


void init_difftest(char *ref_so_file, long img_size, int port);
void difftest_step();
#endif