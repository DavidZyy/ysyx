#include <am.h>
#include <riscv/riscv.h>
#include <klib.h>

static Context* (*user_handler)(Event, Context*) = NULL;

// new added
const char *regs[] = {
  "$0", "ra", "sp", "gp", "tp", "t0", "t1", "t2",
  "s0", "s1", "a0", "a1", "a2", "a3", "a4", "a5",
  "a6", "a7", "s2", "s3", "s4", "s5", "s6", "s7",
  "s8", "s9", "s10", "s11", "t3", "t4", "t5", "t6"
};

const char *csrs[] = {
  "mtvec",
  "mepc",
  "mstatus",
  "mcause"
};

void print_context(Context *c) {
  for(int i = 0; i < 32; i++) {
    printf("%-3s: %016lx  \n", regs[i], c->gpr[i]);
  }
  printf("%-7s: %016lx  \n", csrs[3], c->mcause);
  printf("%-7s: %016lx  \n", csrs[2], c->mstatus);
  printf("%-7s: %016lx  \n", csrs[1], c->mepc);
}
// new added

Context* __am_irq_handle(Context *c) {
  // add mepc 4
  // c->mepc += 4;
  print_context(c);
  if (user_handler) {
    Event ev = {0};
    switch (c->mcause) {
      case 0xb: ev.event = EVENT_YIELD; break;
      default: ev.event = EVENT_ERROR; break;
    }

    c = user_handler(ev, c);
    assert(c != NULL);
  }

  return c;
}

extern void __am_asm_trap(void);

bool cte_init(Context*(*handler)(Event, Context*)) {
  // initialize exception entry
  asm volatile("csrw mtvec, %0" : : "r"(__am_asm_trap));

  // register event handler
  user_handler = handler;

  return true;
}

Context *kcontext(Area kstack, void (*entry)(void *), void *arg) {
  return NULL;
}

void yield() {
  asm volatile("li a7, -1; ecall");
}

bool ienabled() {
  return false;
}

void iset(bool enable) {
}
