/**
 * @file dpi_c.cpp
 * @author Yangyang Zhu (1929772352@qq.com)
 * @version 0.1
 * @date 2023-04-07
 * 
 * @copyright Copyright (c) 2023
 * other dpi-c functions except memory related functions.
 */
/* DPI-C function */
#include "svdpi.h"
#include "Vtop__Dpi.h"
#include "verilated_dpi.h"

/* ebreak means success! */
int terminal = 0;
void exit_code(){
  terminal = 1;
  printf(ANSI_FMT("program exit at %p\n", ANSI_FG_RED), 
        (void *)top->current_pc);
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

uint64_t *cpu_gpr = NULL;
extern "C" void set_gpr_ptr(const svOpenArrayHandle r) {
  cpu_gpr = (uint64_t *)(((VerilatedDpiOpenVar*)r)->datap());
  // cpu.gpr = (uint64_t *)(((VerilatedDpiOpenVar*)r)->datap());
}
