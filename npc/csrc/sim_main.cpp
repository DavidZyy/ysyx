/**
 * the main function used in simulation.
*/

#include "Vtop.h"
#include <verilated.h>
#include "verilated_vcd_c.h"
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

void nvboard_bind_all_pins(Vtop* top);

int main(int argc, char** argv) {
    Verilated::mkdir("logs");

    VerilatedContext* contextp = new VerilatedContext;
    contextp->commandArgs(argc, argv);
    Vtop* top = new Vtop{contextp};

    VerilatedVcdC* tfp = new VerilatedVcdC;
    contextp->traceEverOn(true);
    top->trace(tfp, 0);
    tfp->open("logs/wave.vcd");


    while (!contextp->gotFinish()) { 
        int a = rand() & 1;
        int b = rand() & 1;
        top->a = a;
        top->b = b;
        top->eval(); 
        printf("a = %d, b = %d, f = %d\n", a, b, top->f);
        // top->opentrace("trace.vcd");
        tfp->dump(contextp->time());
        contextp->timeInc(1);

        assert(top->f == (a ^ b));
    }

    tfp->close();

    delete top;
    delete contextp;
    delete tfp;
    return 0;
}