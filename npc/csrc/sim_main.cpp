/**
 * the main function used in simulation.
*/

// #include "Vtop.h"
// #include <verilated.h>
// #include "verilated_vcd_c.h"
// #include <stdio.h>
// #include <stdlib.h>
// #include <assert.h>

// void nvboard_bind_all_pins(Vtop* top);

// int main(int argc, char** argv) {
//     Verilated::mkdir("logs");

//     VerilatedContext* contextp = new VerilatedContext;
//     contextp->commandArgs(argc, argv);
//     Vtop* top = new Vtop{contextp};

//     VerilatedVcdC* tfp = new VerilatedVcdC;
//     contextp->traceEverOn(true);
//     top->trace(tfp, 0);
//     tfp->open("logs/wave.vcd");


//     while (!contextp->gotFinish()) { 
//         int a = rand() & 1;
//         int b = rand() & 1;
//         top->a = a;
//         top->b = b;
//         top->eval(); 
//         printf("a = %d, b = %d, f = %d\n", a, b, top->f);
//         // top->opentrace("trace.vcd");
//         tfp->dump(contextp->time());
//         contextp->timeInc(1);

//         assert(top->f == (a ^ b));
//     }

//     tfp->close();

//     delete top;
//     delete contextp;
//     delete tfp;
//     return 0;
// }
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

int main() {
  sim_init();

  top->s=0; top->a=0; top->b=0;  step_and_dump_wave();   // 将s，a和b均初始化为“0”
                      top->b=1;  step_and_dump_wave();   // 将b改为“1”，s和a的值不变，继续保持“0”，
            top->a=1; top->b=0;  step_and_dump_wave();   // 将a，b分别改为“1”和“0”，s的值不变，
                      top->b=1;  step_and_dump_wave();   // 将b改为“1”，s和a的值不变，维持10个时间单位
  top->s=1; top->a=0; top->b=0;  step_and_dump_wave();   // 将s，a，b分别变为“1,0,0”，维持10个时间单位
                      top->b=1;  step_and_dump_wave();
            top->a=1; top->b=0;  step_and_dump_wave();
                      top->b=1;  step_and_dump_wave();
  sim_exit();
}







