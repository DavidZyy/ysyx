#include <nvboard.h>
#include <Vtop.h>
#include <unistd.h>

#include "mem.h"

static TOP_NAME dut;

void nvboard_bind_all_pins(Vtop* top);

static void single_cycle() {
  dut.clk = 0; dut.eval();
  dut.clk = 1; dut.eval();
}

static void reset(int n) {
  dut.rst = 1;
  while (n -- > 0) single_cycle();
  dut.rst = 0;
}

int main(int argc, char *argv[]) {
  // load_img(argv[1]);
  load_init_img();

  nvboard_bind_all_pins(&dut);
  nvboard_init();

  reset(10);

  while(1) {
    nvboard_update();
    /* to have time see the display on seg */
    sleep(100);
    single_cycle();
  }
}

