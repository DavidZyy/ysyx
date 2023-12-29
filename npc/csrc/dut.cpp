#include <dlfcn.h>
#include <stdint.h>
#include <assert.h>
#include <stdio.h>

#include "macro.h"
#include "utils.h"
#include "isa.h"
#include "common.h"

#include "../obj_dir/Vtop.h"
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
  // ref_difftest_memcpy(RESET_VECTOR, guest_to_host(RESET_VECTOR), sizeof(pmem), DIFFTEST_TO_REF); // should copy all pmem, not just img_size here, or 0xdeadbeef not copy to nemu
  ref_difftest_memcpy(RESET_VECTOR, guest_to_host(RESET_VECTOR), img_size, DIFFTEST_TO_REF); // should copy all pmem, not just img_size here, or 0xdeadbeef not copy to nemu, if just copy img_size make it faster, mem should be initialized to 0.
  // printf(ANSI_FMT("dut cpu pc is: %p\n", ANSI_FG_GREEN), &cpu.pc);
  // printf(ANSI_FMT("cpu addr is: %p\n", ANSI_FG_GREEN), &cpu);
  ref_difftest_regcpy(&cpu, DIFFTEST_TO_REF);
}

extern Vtop* top;
bool check_status_reg(CPU_state *ref_r) {
  if(top->io_out_difftest_mcause != ref_r->csr[cpu_mcause_id])
    return false;
  if(top->io_out_difftest_mepc != ref_r->csr[cpu_mepc_id])
    return false;
  // if(top->io_out_difftest_mstatus != ref_r->mstatus)
  //   return false;
  if(top->io_out_difftest_mtvec != ref_r->csr[cpu_mtvec_id])
    return false;
  return true;
}

bool isa_difftest_checkregs(CPU_state *ref_r, vaddr_t pc) {
  for(int i = 0; i < 32; i++){
    if(ref_r->gpr[i] != cpu.gpr[i])
      goto error;
  }
  if(ref_r->pc != cpu.pc)
    goto error;

  if(!check_status_reg(ref_r))
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
    if(cpu.gpr[i]) {
      printf("%-3s: " FMT_WORD "\n", regs[i], cpu.gpr[i]);  // Use width and alignment specifiers in the format string
    }
  }
}

void isa_reg_display(CPU_state *ref_r){
  printf("npc(dut)     nemu(ref)\n");
  for (int i = 0; i < 32; i++) {
    if(ref_r->gpr[i] != cpu.gpr[i]) {
      printf("%-3s: " FMT_WORD "  ", regs[i], cpu.gpr[i]);  // Use width and alignment specifiers in the format string
      printf("%-3s: " FMT_WORD "  ", regs[i], ref_r->gpr[i]);
      printf("\n");
    }
  }

  if(top->io_out_difftest_mcause != ref_r->csr[cpu_mcause_id]) {
      printf("%-3s: " FMT_WORD "  ", "mcause", top->io_out_difftest_mcause);
      printf("%-3s: " FMT_WORD "  ", "mcause", ref_r->csr[cpu_mcause_id]);
      printf("\n");
  }
  if(top->io_out_difftest_mepc != ref_r->csr[cpu_mepc_id]) {
      printf("%-3s: " FMT_WORD "  ", "mepc", top->io_out_difftest_mepc);
      printf("%-3s: " FMT_WORD "  ", "mepc", ref_r->csr[cpu_mepc_id]);
      printf("\n");
  }
  if(top->io_out_difftest_mstatus != ref_r->mstatus) {
      printf("%-3s: " FMT_WORD "  ", "mstatus", top->io_out_difftest_mstatus);
      printf("%-3s: " FMT_WORD "  ", "mstatus", ref_r->mstatus);
      printf("\n");
  }
  if(top->io_out_difftest_mtvec != ref_r->csr[cpu_mtvec_id]) {
      printf("%-3s: " FMT_WORD "  ", "mtvec", top->io_out_difftest_mtvec);
      printf("%-3s: " FMT_WORD "  ", "mtvec", ref_r->csr[cpu_mtvec_id]);
      printf("\n");
  }

  printf("%-3s: " FMT_WORD ,"pc", cpu.pc);
  printf("\t");
  printf("%-3s: " FMT_WORD"\n", "pc", ref_r->pc);
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

uint8_t ref_mem[CONFIG_MSIZE];

static void checkmem(uint8_t *ref_mem) {
  for(int i=0; i<sizeof(ref_mem)/sizeof(uint32_t); i++) {
    if(*(uint32_t *)(pmem + i) != *(uint32_t *)(ref_mem + i)) {
      printf(ANSI_FMT("mem Error:\n", ANSI_FG_RED));
      printf("npc(dut)     nemu(ref)\n");
      printf("addr:" FMT_WORD"\n", RESET_VECTOR+4*i);
      printf(FMT_WORD "  " FMT_WORD"\n", *(uint32_t *)(pmem + i), *(uint32_t *)(ref_mem + i));
      terminal = 1;
      status = 1;
      break;
    }
  }
}

int npc_access_device = 0;

void difftest_step() {
  CPU_state ref_f;
  int pc = 0;

  if (npc_access_device ) {
    // not exec, copy regs to ref, load nead to copy pc and the changed reg, and store need to copy pc!
    // do not need to copy mem, it will cause cache coherence problem in cache system.
    ref_difftest_regcpy(&cpu, DIFFTEST_TO_REF);
    // reset
    npc_access_device = 0;
  } else {
    if(npc_access_device == 2) npc_access_device--; // wait for access dev in exu wb in wbu.
    ref_difftest_exec(1);
    // check regs
    ref_difftest_regcpy(&ref_f, DIFFTEST_TO_DUT);
    checkregs(&ref_f, pc);
    // check mems
    // ref_difftest_memcpy(RESET_VECTOR, ref_mem, sizeof(ref_mem), DIFFTEST_TO_DUT);
    // checkmem(ref_mem);
  }

  /* if the instructions is store, check the memory 
    around the destination address */
  // if(is_store())
  // checkmem();
}
