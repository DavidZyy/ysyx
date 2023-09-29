#include <dlfcn.h>
#include <stdint.h>
#include <assert.h>
#include <stdio.h>

#include "macro.h"
#include "utils.h"
#include "isa.h"
#include "common.h"

// #define NULL nullptr
enum { DIFFTEST_TO_DUT, DIFFTEST_TO_REF };

extern uint8_t pmem[CONFIG_MSIZE];
// extern riscv64_CPU_state cpu;
extern CPU_state cpu;
extern int terminal;

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

bool check_status_reg() {
  return true;
}

bool isa_difftest_checkregs(CPU_state *ref_r, vaddr_t pc) {
  for(int i = 0; i < 32; i++){
    if(ref_r->gpr[i] != cpu.gpr[i])
      goto error;
  }
  if(ref_r->pc != cpu.pc)
    goto error;

  if(!check_status_reg())
    goto error;

  return true;

error:
  *(&pc) = ref_r->pc;
  return false;
}

const char *regs[] = {
  "$0", "ra", "sp", "gp", "tp", "t0", "t1", "t2",
  "s0", "s1", "a0", "a1", "a2", "a3", "a4", "a5",
  "a6", "a7", "s2", "s3", "s4", "s5", "s6", "s7",
  "s8", "s9", "s10", "s11", "t3", "t4", "t5", "t6"
};

// 一个输出RTL中通用寄存器的值的示例
void dump_gpr() {
  int i;
  for (i = 0; i < 32; i++) {
    printf("%-3s: " FMT_WORD "  ", regs[i], cpu.gpr[i]);  // Use width and alignment specifiers in the format string
    // if(cpu.gpr[i])
      // printf("gpr[%d] = 0x%lx\n", i, cpu.gpr[i]);
    printf("\n");
  }
}

void isa_reg_display(CPU_state *ref){
  // for(int i = 0; i < 32; i++){
  //   if(ref->gpr[i] != cpu.gpr[i]) {
  //     printf("nemu: gpr[%d] = " FMT_WORD, i, ref->gpr[i]);
  //     printf("\t");
  //     printf("npc: gpr[%d] = " FMT_WORD"\n", i, cpu.gpr[i]);
  //   }
  // }
  printf("npc(dut)     nemu(ref)\n");
  for (int i = 0; i < 32; i++) {
    if(ref->gpr[i] != cpu.gpr[i]) {
      printf("%-3s: " FMT_WORD "  ", regs[i], cpu.gpr[i]);  // Use width and alignment specifiers in the format string
      printf("%-3s: " FMT_WORD "  ", regs[i], ref->gpr[i]);
      printf("\n");
    }
  }

  printf("%-3s: " FMT_WORD ,"pc", cpu.pc);
  printf("\t");
  printf("%-3s: " FMT_WORD"\n", "pc", ref->pc);
}

extern int status;
static void checkregs(CPU_state *ref, vaddr_t pc){
  if (!isa_difftest_checkregs(ref, pc)) {
    printf(ANSI_FMT("Regs Error:\n", ANSI_FG_RED));
    // while(1);
    isa_reg_display(ref);
    terminal = 1;
    status = 1;
  }
}

static void checkmem(){

}

int npc_read_device = 0;
int npc_write_device = 0;

void difftest_step() {
  CPU_state ref_f;
  int pc = 0;

  if (npc_read_device) {
    // not exec, copy regs and memory to ref
    ref_difftest_regcpy(&cpu, DIFFTEST_TO_REF);
    ref_difftest_memcpy(RESET_VECTOR, guest_to_host(RESET_VECTOR), sizeof(pmem), DIFFTEST_TO_REF);
    // reset
    npc_read_device = 0;
  } else if(npc_write_device) {
    // do noting
    ref_difftest_regcpy(&cpu, DIFFTEST_TO_REF);
    ref_difftest_memcpy(RESET_VECTOR, guest_to_host(RESET_VECTOR), sizeof(pmem), DIFFTEST_TO_REF);
    // reset
    npc_write_device = 0;
  } else {
    ref_difftest_exec(1);
    ref_difftest_regcpy(&ref_f, DIFFTEST_TO_DUT);
    checkregs(&ref_f, pc);
  }

  /* if the instructions is store, check the memory 
    around the destination address */
  // if(is_store())
  // checkmem();
}
