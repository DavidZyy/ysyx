#include <am.h>
#include <riscv/riscv.h>
#include <klib.h>

static Context* (*user_handler)(Event, Context*) = NULL;

Context* __am_irq_handle(Context *c) {
  c->mepc += 4;
  if (user_handler) {
    Event ev = {0};
    switch (c->mcause) {
      case 0xb: 
        if(c->GPR1 == -1) {
          ev.event = EVENT_YIELD;
        } else {
          ev.event = EVENT_SYSCALL;
        }
        break;
      default: ev.event = EVENT_ERROR; break;
    }

    // c' value is been changed here! passing in c is not the return c.
    c = user_handler(ev, c);
    // chage sp here
    // assert(c != NULL);
  }

  // c is changed
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

// end is the bottem of stack, and decrese the size of Context
// is the top of stack, stack increase from high address to low address
Context *kcontext(Area kstack, void (*entry)(void *), void *arg) {
  // return NULL;
  Context *stack_top = kstack.end - sizeof(Context);
  stack_top->mepc = (uintptr_t)entry;
  printf("mepc addr:%p\n", &(stack_top->mepc));
  return stack_top;
}

void yield() {
#ifdef __riscv_e
  asm volatile("li a5, -1; ecall");
#else
  asm volatile("li a7, -1; ecall");
#endif
}

bool ienabled() {
  return false;
}

void iset(bool enable) {
}
