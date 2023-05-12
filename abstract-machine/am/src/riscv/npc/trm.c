#include <am.h>
#include <klib-macros.h>
#include <npc.h>

extern char _heap_start;
int main(const char *args);

extern char _pmem_start;
#define PMEM_SIZE (128 * 1024 * 1024)
#define PMEM_END  ((uintptr_t)&_pmem_start + PMEM_SIZE)

Area heap = RANGE(&_heap_start, PMEM_END);
#ifndef MAINARGS
#define MAINARGS ""
#endif
static const char mainargs[] = MAINARGS;

void putch(char ch) {
  outb((0xa0000000 + 0x00003f8), ch);
}

// // use inline assembly codes
// void __attribute__((noreturn)) halt(int code) {
// // void halt(int code) {
//   // while (1);
//   __asm__ volatile ("ebreak");
// }

// use inline assembly codes
void halt(int code) {
  __asm__ volatile ("ebreak");
  /* if have no this, we will get noreturn error */
  while(1);
}


void _trm_init() {
  int ret = main(mainargs);
  halt(ret);
}
