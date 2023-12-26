#include "verilated.h"
#include "verilated_vcd_c.h"
#include "../obj_dir/Vtop.h"

/* DPI-C function */
#include "svdpi.h"
// #include "Vtop__Dpi.h"
#include "verilated_dpi.h"

// my header
#include "utils.h"
#include "macro.h"
#include "mem.h"
#include "isa.h"
#include "debug.h"
#include "vga.h"

// c library
// #include <iostream>
#include <stdio.h>
#include <string.h>
#include <elf.h>

void init_log(const char *log_file);

VerilatedContext* contextp = NULL;
VerilatedVcdC* tfp = NULL;
Vtop* top;

CPU_state cpu;
uint64_t g_cycle = 0;
uint64_t g_nr_guest_inst = 0;

/**
 * close vcd will much faster!
 */
void step_and_dump_wave(){
  top->eval();
  contextp->timeInc(1);
  tfp->dump(contextp->time());
}

void sim_init(){
  contextp = new VerilatedContext;
  tfp = new VerilatedVcdC;
  // top = new Vtop;
  top = new Vtop{contextp};
  contextp->traceEverOn(true);
  top->trace(tfp, 0);
  tfp->open("dump.vcd");
}

void sim_exit(){
  step_and_dump_wave();
  tfp->close();
}

void single_cycle() {
  g_cycle++;
  top->clock = 0;
  step_and_dump_wave();
  top->clock = 1;
  step_and_dump_wave();
}

/* ebreak means success! */
int terminal = 0;
extern "C" void exit_code(){
  terminal = 1;
  printf(ANSI_FMT("program exit at " FMT_WORD "\n", ANSI_FG_RED), top->io_out_wbu_pc);
}

void print_clkdiv(long long clkdiv){
  printf("read rtc in cpu: %llx\n", clkdiv);
}

void print_serial(long long ch){
  printf("%c", (char)ch);
}

/**
 * At the first two clock cycles, the pc is 0, the
 * instructions at 0 is illegal, so the 
 * signal is emited. To prevent this case happens,
 * I add the condition "top->pc > 0".
 */
extern "C" void not_impl_exception(){
  if(top->io_out_wbu_pc){
  terminal = 1;
  printf(ANSI_FMT("instructions has not been immplemented!\n", ANSI_FG_RED));
  printf("pc:" FMT_WORD", inst:" FMT_WORD"\n", top->io_out_wbu_pc, top->io_out_ifu_inst);
  // printf(ANSI_FMT("pc: %p  %08x\n", ANSI_FG_RED), 
    // (void *)top->pc_IF, *((uint32_t *)(&pmem[top->pc_IF - 0x80000000])));
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

word_t *cpu_gpr = NULL;
extern "C" void set_gpr_ptr(const svOpenArrayHandle r) {
  cpu_gpr = (word_t *)(((VerilatedDpiOpenVar*)r)->datap());
}


/* get npc's register state */
void get_cpu() {
  assert(cpu_gpr);
  // get gpr
  for(int i = 0; i < 32; i++){
    cpu.gpr[i] = cpu_gpr[i];
  }

  // get csr
  cpu.csr[cpu_mcause_id] = top->io_out_difftest_mcause;
  cpu.csr[cpu_mepc_id] = top->io_out_difftest_mepc;
  cpu.csr[cpu_mtvec_id] = top->io_out_difftest_mtvec;
  cpu.mstatus = top->io_out_difftest_mstatus;

  // get pc
  cpu.pc = top->io_out_nextExecPC;
}

// execute on inst, until WB stage
void npc_exec_once() {
  g_nr_guest_inst++;
  int n=1000;
  while(!top->io_out_wb && n){
    single_cycle();
    n--;
  }
  single_cycle();
    get_cpu();
}

void nemu_exec_once() {
  difftest_step();
}

void init_isa() {
  cpu.pc = RESET_VECTOR;
}

uint8_t* guest_to_host(paddr_t paddr);
// similar to monitor
void init_monitor(int argc, char *argv[]) {
  init_log(argv[3]);
  init_isa();
  long img_size = load_img(argv[1]);
  // long img_size = load_init_img();
  init_difftest(argv[2], img_size, 0);
}

void init_device() {
  init_vga();
}

int status = 0;

void vga_update_screen();
extern uint8_t pmem[CONFIG_MSIZE];


// void print_section_header() {
//   printf("  Type: %u ", section_header->sh_type);
//   printf("  Address: 0x%lx ", section_header->sh_addr);
//   printf("  Offset: 0x%lx ", section_header->sh_offset);
//   printf("  Size: 0x%lx ", section_header->sh_size);
//   printf("  EntSize: 0x%lx ", section_header->sh_entsize);
//   printf("  Flags: 0x%lx ", section_header->sh_flags);
//   printf("  Link: %u ", section_header->sh_link);
//   printf("  Info: %u ", section_header->sh_info);
//   printf("  Align: 0x%lx ", section_header->sh_addralign);
// }

word_t text_max;
#define Elf_Ehdr MUXDEF(CONFIG_ISA64, Elf64_Ehdr, Elf32_Ehdr)
#define Elf_Phdr MUXDEF(CONFIG_ISA64, Elf64_Phdr, Elf32_Phdr)
#define Elf_Shdr MUXDEF(CONFIG_ISA64, Elf64_Shdr, Elf32_Shdr)
#define Elf_Sym  MUXDEF(CONFIG_ISA64, Elf64_Sym,  Elf32_Sym)
Elf_Shdr section_header;
void get_text_addr_range(const char *elf_file) {
  assert(elf_file);
  FILE *file = fopen(elf_file, "rb");
  assert(file);

  Elf_Ehdr elf_header;
  assert(fread(&elf_header, sizeof(Elf_Ehdr), 1, file) == 1);

  // locate to .text section
  fseek(file, elf_header.e_shoff + sizeof(Elf_Shdr), SEEK_SET);
  // read it
  assert(fread(&section_header, sizeof(Elf_Shdr), 1, file) == 1);
  text_max = section_header.sh_addr + section_header.sh_size;
  printf("text_max: 0x%x\n", text_max);
}

static void statistic() {
  Log("host cpu cycle spent = %lu" , g_cycle);
  Log("total guest instructions = %lu",  g_nr_guest_inst);
  if (g_cycle > 0) Log("ipc = %lf ", (double)g_nr_guest_inst / (double)g_cycle);
  else Log("Finish running in less than 1 cycle and can not calculate the ipc");
}

void dump_gpr();
int main(int argc, char *argv[]) {
  get_text_addr_range(argv[4]);
  // print_arg(argc, argv);
  init_monitor(argc, argv);
  // init_device();
  Log("wave has closed to make it sim faster");

  sim_init();

  top->reset = 1;
  single_cycle();
  top->reset = 0;

  uint64_t i;
  uint64_t times = -1;
  // uint64_t times = 1000;

  int begin = 1;

  for (i = 0; i < times; i++) {

    // printf("%-3s: " FMT_WORD"\n" ,"before exec pc", cpu.pc);
    npc_exec_once();
    // printf("%-3s: " FMT_WORD"\n" ,"after exec pc", cpu.pc);
    // dump_gpr();
    // printf("\n\n");
    // vga_update_screen();
    nemu_exec_once();
    // log_write("pc:" FMT_WORD", inst:" FMT_WORD"\n", top->io_out_wbu_pc, top->io_out_ifu_inst);
    
    if(terminal)
      break;
  }
  statistic();

  sim_exit();
  return status;
}
