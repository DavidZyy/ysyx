#include "verilated.h"
#include "verilated_vcd_c.h"
#include "../obj_dir/Vtop.h"

/* DPI-C function */
#include "svdpi.h"
#include "Vtop__Dpi.h"
#include "verilated_dpi.h"

// my header
#include "utils.h"
#include "macro.h"
#include "mem.h"

// c library
// #include <iostream>
#include <stdio.h>
#include <string.h>

VerilatedContext* contextp = NULL;
VerilatedVcdC* tfp = NULL;
static Vtop* top;

CPU_state cpu;
// uint8_t pmem[CONFIG_MSIZE] PG_ALIGN = {};

void step_and_dump_wave(){
  top->eval();
  contextp->timeInc(1);
  tfp->dump(contextp->time());
  // contextp->timeInc(1);
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

void single_cycle(int rst) {
  top->clk = 0;
  if(rst) top->rst = 1;
  step_and_dump_wave();
  if(rst) top->rst = 0;
  top->clk = 1;
  step_and_dump_wave();
}


/* ebreak means success! */
int terminal = 0;
void exit_code(){
  terminal = 1;
  printf(ANSI_FMT("program exit at %p\n", ANSI_FG_RED), 
        (void *)top->pc_WB);
        // (void *)top->pc_IF);
}

/**
 * At the first two clock cycles, the pc is 0, the
 * instructions at 0 is illegal, so the 
 * signal is emited. To prevent this case happens,
 * I add the condition "top->pc > 0".
 */
void not_ipl_exception(){
  if(top->pc_IF){
  terminal = 1;
  printf(ANSI_FMT("instructions has not been immplemented!\n", ANSI_FG_RED));
  printf(ANSI_FMT("pc: %p  %08x\n", ANSI_FG_RED), 
    (void *)top->pc_IF, *((uint32_t *)(&pmem[top->pc_IF - 0x80000000])));
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

uint64_t *cpu_gpr = NULL;
extern "C" void set_gpr_ptr(const svOpenArrayHandle r) {
  cpu_gpr = (uint64_t *)(((VerilatedDpiOpenVar*)r)->datap());
  // cpu.gpr = (uint64_t *)(((VerilatedDpiOpenVar*)r)->datap());
}

// 一个输出RTL中通用寄存器的值的示例
void dump_gpr() {
  int i;
  for (i = 0; i < 32; i++) {
    if(cpu.gpr[i])
      printf("gpr[%d] = 0x%lx\n", i, cpu.gpr[i]);
  }
  printf("\n");
}

void get_cpu() {
  assert(cpu_gpr);
  for(int i = 0; i < 32; i++){
    cpu.gpr[i] = cpu_gpr[i];
  }
  // cpu.pc = top->pc_IF;
  cpu.pc = top->pc_WB;
}

void npc_exec_once() {
    single_cycle(0); 
    get_cpu();
}

void nemu_exec_once() {
  difftest_step();
}

// 当nemu的pc和npc的pc_IF为xxxx时，说明这个地址的指令还没有执行。
/** * The single cycle time series design refers: * https://nju-projectn.github.io/dlco-lecture-note/exp/11.html#id9 */
int main(int argc, char *argv[]) {
  // get_cpu();
  cpu.pc = RESET_VECTOR;
  // print_arg(argc, argv);
  long size = load_img(argv[1]);
  // long size = load_init_img();
  init_difftest(argv[2], size, 0);

  sim_init();

  top->rst = 1;
  single_cycle(0);
  single_cycle(0);
  top->rst = 0;

  uint64_t i;
  uint64_t times = -1;

  // int nemu_not_run = 1;
  int begin = 1;

  for(i = 0; i < times; i++){

    /* if control branch failed */
    if(begin){
      begin = 0;
      npc_exec_once(); // execute jmp / branch
      npc_exec_once(); // execute nop
      npc_exec_once(); // execute nop
      npc_exec_once(); // execute nop
      npc_exec_once(); // execute nop
    }
    else {
      npc_exec_once();
    }

    nemu_exec_once(); // execute jmp / branch

    // if( i > 1) difftest_step();
    /* run nop inst */
    // if(top->flush){
      // single_cycle(0);
      // difftest_step();
      // single_cycle(0);
    // }
    // while (top->flush)
    // if(top->flush_EX)
    if(top->flush_WB)
      begin = 1;
    
    
    // dump_gpr();
    if(terminal)
      break;
  }

  sim_exit();
}
