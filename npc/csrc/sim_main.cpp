#include "verilated.h"
#include "verilated_vcd_c.h"
#include "../obj_dir/Vtop.h"
#include <iostream>
/* DPI-C function */
#include "svdpi.h"
#include "Vtop__Dpi.h"

#include "include/utils.h"

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
  top->clk = 1;
  step_and_dump_wave();
  top->clk = 0;
  step_and_dump_wave();
}

#define ebreak  0b00000000000100000000000001110011
uint32_t mem[10] = {0b00000000000100000000000010010011,
                    0b00000000000100001000000100010011,
                    ebreak,
                    0b00000000000100010000000110010011
                    };

#define inst_id (top->pc - 0x80000000)/4

int terminal = 0;
void exit_code(){
  terminal = 1;
}

int main(int argc, char *argv[]) {
  printf(ANSI_FMT("argc is : %d\n", ANSI_FG_RED), argc);
  for(int i = 0; i < argc; i++){
    printf(ANSI_FMT("argv %d is: %s\n", ANSI_FG_GREEN), i, argv[i]);
  }

  sim_init();

  top->rst = 1;
  single_cycle();
  single_cycle();
  top->rst = 0;

  for(int i = 0; i < 10; i++){
    top->inst = mem[inst_id];
    /* two cycle one instruction */
    single_cycle();
    // single_cycle();
    if(terminal)
      break;
  }


  sim_exit();
}
