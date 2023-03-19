#include <dlfcn.h>
#include <stdint.h>
#include <assert.h>
#include <stdio.h>

#include "macro.h"
#include "utils.h"

// #define NULL nullptr
enum { DIFFTEST_TO_DUT, DIFFTEST_TO_REF };

extern uint8_t pmem[CONFIG_MSIZE];
extern riscv64_CPU_state cpu;

extern uint8_t* guest_to_host(paddr_t paddr);

void (*ref_difftest_memcpy)(paddr_t addr, void *buf, size_t n, bool direction) = NULL;
void (*ref_difftest_regcpy)(void *dut, bool direction) = NULL;
void (*ref_difftest_exec)(uint64_t n) = NULL;

void init_difftest(char *ref_so_file, long img_size, int port) {
  assert(ref_so_file != NULL);

  void *handle;
  handle = dlopen(ref_so_file, RTLD_LAZY);
  assert(handle);

  void *ref_difftest_memcpy_temp = dlsym(handle, "difftest_memcpy");
  ref_difftest_memcpy = (void (*)(paddr_t , void *, size_t , bool))ref_difftest_memcpy_temp;
  assert(ref_difftest_memcpy);

  ref_difftest_regcpy = (void (*)(void *, bool ))dlsym(handle, "difftest_regcpy");
  assert(ref_difftest_regcpy);

  ref_difftest_exec = (void (*)(uint64_t))dlsym(handle, "difftest_exec");
  assert(ref_difftest_exec);

  // ref_difftest_raise_intr = dlsym(handle, "difftest_raise_intr");
  // assert(ref_difftest_raise_intr);

  void (*ref_difftest_init)(int) = (void (*)(int))dlsym(handle, "difftest_init");
  assert(ref_difftest_init);

  // Log("Differential testing: %s", ANSI_FMT("ON", ANSI_FG_GREEN));
  // Log("The result of every instruction will be compared with %s. "
  //     "This will help you a lot for debugging, but also significantly reduce the performance. "
  //     "If it is not necessary, you can turn it off in menuconfig.", ref_so_file);

  ref_difftest_init(port);
  ref_difftest_memcpy(RESET_VECTOR, guest_to_host(RESET_VECTOR), img_size, DIFFTEST_TO_REF);
  // printf(ANSI_FMT("dut cpu pc is: %p\n", ANSI_FG_GREEN), &cpu.pc);
  // printf(ANSI_FMT("cpu addr is: %p\n", ANSI_FG_GREEN), &cpu);
  ref_difftest_regcpy(&cpu, DIFFTEST_TO_REF);
}

bool isa_difftest_checkregs(CPU_state *ref_r, vaddr_t pc) {
  for(int i = 0; i < 32; i++){
    if(ref_r->gpr[i] != cpu.gpr[i])
      goto error;
  }
  if(ref_r->pc != cpu.pc)
    goto error;

  return true;

error:
  *(&pc) = ref_r->pc;
  return false;
}

static void checkregs(CPU_state *ref, vaddr_t pc){
  if (!isa_difftest_checkregs(ref, pc)) {
    printf(ANSI_FMT("Regs error!", ANSI_FG_RED));
    // while(1);
  }
}

void difftest_step(){
  CPU_state ref_f;
  int pc = 0;

  ref_difftest_exec(1);
  ref_difftest_regcpy(&ref_f, DIFFTEST_TO_DUT);
  checkregs(&ref_f, pc);
}
