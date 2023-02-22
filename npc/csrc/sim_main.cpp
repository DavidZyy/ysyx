#include "verilated.h"
#include "verilated_vcd_c.h"
#include "../obj_dir/Vtop.h"
#include <iostream>

/* DPI-C function */
#include "svdpi.h"
#include "Vtop__Dpi.h"

#include "utils.h"
#include "macro.h"
#include <stdio.h>
#include <string.h>

VerilatedContext* contextp = NULL;
VerilatedVcdC* tfp = NULL;

static Vtop* top;

void step_and_dump_wave(){
  top->eval();
  contextp->timeInc(1);
  tfp->dump(contextp->time());
}
void sim_init(){
  contextp = new VerilatedContext;
  tfp = new VerilatedVcdC;
  top = new Vtop;
  contextp->traceEverOn(true);
  top->trace(tfp, 0);
  tfp->open("dump.vcd");
}

void sim_exit(){
  step_and_dump_wave();
  tfp->close();
}

void single_cycle() {
  top->clk = 0;
  step_and_dump_wave();
  top->clk = 1;
  step_and_dump_wave();
}

static uint8_t pmem[CONFIG_MSIZE] PG_ALIGN = {};

int terminal = 0;
void exit_code(){
  terminal = 1;
}

/**
 * At the first two clock cycles, the pc is 0, the
 * instructions at 0 is illegal, so the 
 * signal is emited. To prevent this case happens,
 * I add the condition "top->pc > 0".
 */
void not_ipl_exception(){
  if(top->current_pc){
  terminal = 1;
  printf(ANSI_FMT("instructions has not been immplemented!\n", ANSI_FG_RED));
  printf(ANSI_FMT("pc: %p  %08x\n", ANSI_FG_RED), 
    (void *)top->current_pc, *((uint32_t *)(&pmem[top->current_pc - 0x80000000])));
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

static long load_img(const char *img_file) {
  memset(pmem, 1, sizeof(pmem));
  assert(img_file != NULL);

  FILE *fp = fopen(img_file, "rb");

  assert(fp != NULL);

  fseek(fp, 0, SEEK_END);
  long size = ftell(fp);

  fseek(fp, 0, SEEK_SET);
  int ret = fread(pmem, size, 1, fp);
  assert(ret == 1);

  fclose(fp);
  return size;
}

/**
 * The single cycle time series design refers:
 * https://nju-projectn.github.io/dlco-lecture-note/exp/11.html#id9
 */
int main(int argc, char *argv[]) {
  // print_arg(argc, argv);
  load_img(argv[1]);

  sim_init();

  top->rst = 1;
  single_cycle();
  top->rst = 0;

  for(int i = 0; i < 100; i++){
    top->inst = *((uint32_t *)(&pmem[inst_id]));
    /* two cycle one instruction */
    single_cycle();
    // single_cycle();
    if(terminal)
      break;
  }


  sim_exit();
}
