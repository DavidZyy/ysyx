#include "verilated.h"
#include "verilated_vcd_c.h"
#include "../obj_dir/Vtop.h"

/* DPI-C function */
#include "svdpi.h"
// #include "Vtop__Dpi.h"
#include "verilated_dpi.h"

// my header
#include "utils.h"
#include "macro.h"
#include "mem.h"
#include "isa.h"
#include "debug.h"
#include "vga.h"

// c library
// #include <iostream>
#include <stdio.h>
#include <string.h>

void init_log(const char *log_file);

VerilatedContext* contextp = NULL;
VerilatedVcdC* tfp = NULL;
Vtop* top;

CPU_state cpu;
// uint8_t pmem[CONFIG_MSIZE] PG_ALIGN = {};

/**
 * close vcd will much faster!
 */
void step_and_dump_wave(){
  top->eval();
  contextp->timeInc(1);
  tfp->dump(contextp->time());
}

void sim_init(){
  contextp = new VerilatedContext;
  tfp = new VerilatedVcdC;
  // top = new Vtop;
  top = new Vtop{contextp};
  contextp->traceEverOn(true);
  top->trace(tfp, 0);
  tfp->open("dump.vcd");
}

void sim_exit(){
  step_and_dump_wave();
  tfp->close();
}

void single_cycle() {
  top->clock = 0;
  step_and_dump_wave();
  top->clock = 1;
  step_and_dump_wave();
}

/* ebreak means success! */
int terminal = 0;
extern "C" void exit_code(){
  terminal = 1;
  printf(ANSI_FMT("program exit at %p\n", ANSI_FG_RED), 
        (void *)top->io_out_pc);
}

void print_clkdiv(long long clkdiv){
  printf("read rtc in cpu: %llx\n", clkdiv);
}

void print_serial(long long ch){
  printf("%c", ch);
}

/**
 * At the first two clock cycles, the pc is 0, the
 * instructions at 0 is illegal, so the 
 * signal is emited. To prevent this case happens,
 * I add the condition "top->pc > 0".
 */
extern "C" void not_impl_exception(){
  if(top->io_out_pc){
  terminal = 1;
  printf(ANSI_FMT("instructions has not been immplemented!\n", ANSI_FG_RED));
  printf("pc:" FMT_WORD", inst:" FMT_WORD"\n", top->io_out_pc, top->io_out_inst);
  // printf(ANSI_FMT("pc: %p  %08x\n", ANSI_FG_RED), 
    // (void *)top->pc_IF, *((uint32_t *)(&pmem[top->pc_IF - 0x80000000])));
    // (void *)top->pc, top->inst);
  // printf(ANSI_FMT(""))
  }
}

/**
 * argv[1] is the path of the program to be executed.
 */
void print_arg(int argc, char *argv[]){
  printf(ANSI_FMT("argc is : %d\n", ANSI_FG_RED), argc);
  for(int i = 0; i < argc; i++){
    printf(ANSI_FMT("argv %d is: %s\n", ANSI_FG_GREEN), i, argv[i]);
  }
}

word_t *cpu_gpr = NULL;
extern "C" void set_gpr_ptr(const svOpenArrayHandle r) {
  cpu_gpr = (word_t *)(((VerilatedDpiOpenVar*)r)->datap());
}


/* get npc's register state */
void get_cpu() {
  assert(cpu_gpr);
  // get gpr
  for(int i = 0; i < 32; i++){
    cpu.gpr[i] = cpu_gpr[i];
  }

  // get csr
  cpu.csr[cpu_mcause_id] = top->io_out_difftest_mcause;
  cpu.csr[cpu_mepc_id] = top->io_out_difftest_mepc;
  cpu.csr[cpu_mtvec_id] = top->io_out_difftest_mtvec;
  cpu.mstatus = top->io_out_difftest_mstatus;

  // get pc
  cpu.pc = top->io_out_pc;
}

// execute on inst, until WB stage
void npc_exec_once() {
    single_cycle();
    single_cycle();
    get_cpu();
}

void nemu_exec_once() {
  difftest_step();
}

void init_isa() {
  cpu.pc = RESET_VECTOR;
}

uint8_t* guest_to_host(paddr_t paddr);
// similar to monitor
void init_monitor(int argc, char *argv[]) {
  init_log(argv[3]);
  init_isa();
  long img_size = load_img(argv[1]);
  // long img_size = load_init_img();
  init_difftest(argv[2], img_size, 0);
}

void init_device() {
  init_vga();
}

int status = 0;

void vga_update_screen();
extern uint8_t pmem[CONFIG_MSIZE];

void dump_gpr();
int main(int argc, char *argv[]) {
  init_monitor(argc, argv);
  // init_device();
  Log("wave has closed to make it sim faster");

  sim_init();

  top->reset = 1;
  single_cycle();
  top->reset = 0;

  uint64_t i;
  uint64_t times = -1;
  // uint64_t times = 1000000;
  // uint64_t times = 1;

  int begin = 1;

  for (i = 0; i < times; i++) {

    // printf("%-3s: " FMT_WORD"\n" ,"before exec pc", cpu.pc);
    npc_exec_once();
    // printf("%-3s: " FMT_WORD"\n" ,"after exec pc", cpu.pc);
    // dump_gpr();
    // printf("\n\n");
    // vga_update_screen();
    // nemu_exec_once();
    // log_write("pc:" FMT_WORD", inst:" FMT_WORD"\n", top->io_out_pc, top->io_out_inst);
    
    if(terminal)
      break;
  }

  sim_exit();
  return status;
}
