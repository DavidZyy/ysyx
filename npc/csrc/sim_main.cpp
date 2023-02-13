#include "verilated.h"
#include "verilated_vcd_c.h"
#include "../obj_dir/Vtop.h"
#include <iostream>

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

uint32_t mem[10] = {0b00000000000100000000000010010011,
                    0b00000000000100001000000100010011
                    };

#define inst_id (top->pc - 0x80000000)/4

int main() {
  sim_init();

  top->rst = 1;
  single_cycle();
  single_cycle();
  top->rst = 0;

  for(int i = 0; i < 10; i++){
    top->inst = mem[inst_id];
    single_cycle();
  }

  sim_exit();
}
