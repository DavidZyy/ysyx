#include "verilated.h"
#include "verilated_vcd_c.h"
#include "../obj_dir/Vtop.h"
#include <iostream>

/* DPI-C function */
#include "svdpi.h"
#include "Vtop__Dpi.h"

#include "utils.h"
#include "macro.h"
#include <stdio.h>
#include <string.h>

VerilatedContext* contextp = NULL;
VerilatedVcdC* tfp = NULL;

static Vtop* top;

static uint8_t pmem[CONFIG_MSIZE] PG_ALIGN = {};
void step_and_dump_wave(){
  top->eval();
  contextp->timeInc(1);
  tfp->dump(contextp->time());
  // contextp->timeInc(1);
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
  top->clk = 0;
  // printf(ANSI_FMT("program exit at %p\n", ANSI_FG_RED), 
        // (void *)top->next_pc);

  // if(top->next_pc)
    // top->inst = *((uint32_t *)(&pmem[inst_id]));
  step_and_dump_wave();
  top->clk = 1;
  step_and_dump_wave();
}


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

/**
 * argv[1] is the path of the program to be executed.
 */
void print_arg(int argc, char *argv[]){
  printf(ANSI_FMT("argc is : %d\n", ANSI_FG_RED), argc);
  for(int i = 0; i < argc; i++){
    printf(ANSI_FMT("argv %d is: %s\n", ANSI_FG_GREEN), i, argv[i]);
  }
}

static long load_img(const char *img_file) {
  memset(pmem, 1, sizeof(pmem));
  assert(img_file != NULL);

  FILE *fp = fopen(img_file, "rb");

  assert(fp != NULL);

  fseek(fp, 0, SEEK_END);
  long size = ftell(fp);

  fseek(fp, 0, SEEK_SET);
  int ret = fread(pmem, size, 1, fp);
  assert(ret == 1);

  fclose(fp);
  return size;
}

void load_init_img(){
  *(uint32_t*)(&pmem[0]) = 0x00009117;
  *(uint32_t*)(&pmem[4]) = 0x00009117;
  *(uint32_t*)(&pmem[8]) = 0x00009117;
  *(uint32_t*)(&pmem[12]) = ebreak;
  *(uint32_t*)(&pmem[16]) = 0x00000000;
  // *(uint32_t*)(&pmem[12]) = 0x00008117;
  // *(uint32_t*)(&pmem[16]) = ebreak;
}

#define paddr_t uint64_t
/* my understanding: paddr is the program in the guest's address, paddr - CONFIG_MBASE 
is the offset from the beginning of the program, pmem is the beginning of the program in
the host. */
uint8_t* guest_to_host(paddr_t paddr) { return pmem + paddr - CONFIG_MBASE; }
/* haddr is the address in host nemu, - pmem is the offset from the beginning, + CONFIG_MBASE(the
beginning of the programm in guest) get the address in the guest. */
paddr_t host_to_guest(uint8_t *haddr) { return haddr - pmem + CONFIG_MBASE; }


void pmem_read(long long raddr, long long *rdata) {
  // 总是读取地址为`raddr & ~0x7ull`的8字节返回给`rdata`
  raddr = raddr & ~0x7; // align to 8

  uint8_t *raddr_temp = guest_to_host(raddr);
  *rdata = *(uint64_t *)raddr_temp;
}

extern "C" void pmem_write(long long waddr, long long wdata, char wmask) {
  // 总是往地址为`waddr & ~0x7ull`的8字节按写掩码`wmask`写入`wdata`
  // `wmask`中每比特表示`wdata`中1个字节的掩码,
  // 如`wmask = 0x3`代表只写入最低2个字节, 内存中的其它字节保持不变
}

/**
 * The single cycle time series design refers:
 * https://nju-projectn.github.io/dlco-lecture-note/exp/11.html#id9
 */
int main(int argc, char *argv[]) {
  // print_arg(argc, argv);
  load_img(argv[1]);
  // load_init_img();

  sim_init();

  top->rst = 1;
  single_cycle();
  top->rst = 0;

  for(int i = 0; i < 100; i++){
    // top->inst = *((uint32_t *)(&pmem[inst_id]));
    /* two cycle one instruction */
    single_cycle();
    // single_cycle();
    if(terminal)
      break;
  }


  sim_exit();
  // int time = 100;
  // top = new Vtop;
  // verilated::traceEverOn(true);
}

// unsigned long main_time = 0;
// 
// void cpu_init() {
//   //cpu_gpr[32] = CONFIG_MBASE;
//   top -> clk = 0;
//   top -> rst = 1;
//   top -> eval();
//   tfp->dump(main_time);
//   main_time ++;
//   top -> clk = 1;
//   top -> rst = 1;
//   top -> eval();
//   tfp->dump(main_time);
//   main_time ++;
//   top -> rst = 0;
// }
// 
// void exec_once(VerilatedVcdC* tfp) {
//   top->clk = 0;
//   //printf("======clk shoule be 0 now %d\n",top->clk);
//   // top->mem_inst = pmem_read(top->mem_addr);
//   // printf("excute addr:0x%08lx inst:0x%08x\n",top->mem_addr,top->mem_inst);
//   top->inst = *((uint32_t *)(&pmem[inst_id]));
//   // top->inst = pmem_read();
//   top->eval();
//   tfp->dump(main_time);
//   main_time ++;
// 
//   top->clk = 1;
//   //printf("======clk should be 1 now %d\n",top->clk); 
//   top->eval(); 
// 	tfp->dump(main_time);
//   main_time ++;
// }
// 
// 
// void cpu_exec(uint64_t n) {
//   for(int i; i < n; i++){
//       exec_once(tfp);
//       // #ifdef CONFIG_DIFFTEST
//         // difftest_exec_once();
//       // #endif
//       if(terminal)
//         break;
//   }
// }
// 
// 
// //============ Main ============
// int main(int argc, char** argv, char** env) {
//   load_init_img();
//   contextp = new VerilatedContext;
//   contextp->commandArgs(argc, argv);
//   top = new Vtop{contextp};
//   //VCD波形设置  start
//   Verilated::traceEverOn(true);
//   tfp = new VerilatedVcdC;
//   top->trace(tfp, 0);
//   // tfp->open("wave.vcd");
//   tfp->open("dump1.vcd");
//   //VCD波形设置  end
//   //initial data
//   // pmem_init();
//   cpu_init();
//   cpu_exec(100);
// //   #ifdef CONFIG_DIFFTEST
// //     init_difftest();
// //   #endif
// //  
// //   sdb_mainloop();
//   tfp->close();
//   return 0;
// }
