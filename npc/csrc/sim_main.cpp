#include "verilated.h"
#include "verilated_vcd_c.h"
#include "../obj_dir/Vtop.h"

/* DPI-C function */
#include "svdpi.h"
#include "Vtop__Dpi.h"
#include "verilated_dpi.h"

// my header
#include "utils.h"
#include "macro.h"

// c library
// #include <iostream>
#include <stdio.h>
#include <string.h>
#include <assert.h>

VerilatedContext* contextp = NULL;
VerilatedVcdC* tfp = NULL;
static Vtop* top;

CPU_state cpu;
uint8_t pmem[CONFIG_MSIZE] PG_ALIGN = {};

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

void single_cycle(int rst) {
  top->clk = 1;
  if(rst) top->rst = 1;
  step_and_dump_wave();
  if(rst) top->rst = 0;
  top->clk = 0;
  step_and_dump_wave();
}


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

int load_init_img(){
  *(uint32_t*)(&pmem[0]) = 0x00009117;
  *(uint32_t*)(&pmem[4]) = 0x00009117;
  *(uint32_t*)(&pmem[8]) = 0x00009117;
  *(uint32_t*)(&pmem[12]) = ebreak;
  *(uint32_t*)(&pmem[16]) = 0x00000000;
  // *(uint32_t*)(&pmem[12]) = 0x00008117;
  // *(uint32_t*)(&pmem[16]) = ebreak;
  return 16;
}

/* my understanding: paddr is the program in the guest's address, paddr - CONFIG_MBASE 
is the offset from the beginning of the program, pmem is the beginning of the program in
the host. */
uint8_t* guest_to_host(paddr_t paddr) { return pmem + paddr - CONFIG_MBASE; }
/* haddr is the address in host nemu, - pmem is the offset from the beginning, + CONFIG_MBASE(the
beginning of the programm in guest) get the address in the guest. */
paddr_t host_to_guest(uint8_t *haddr) { return haddr - pmem + CONFIG_MBASE; }


static inline bool in_pmem(paddr_t addr) {
  return (addr >= CONFIG_MBASE) && (addr - CONFIG_MBASE < CONFIG_MSIZE);
}

void pmem_read(long long raddr, long long *rdata) {
  if(top->rst){
    *rdata = 0;
    return;
  }
  printf(ANSI_FMT("current_pc: %p\n", ANSI_FG_RED), (void *)top->current_pc);
  printf(ANSI_FMT("next_pc: %p\n", ANSI_FG_RED), (void *)top->next_pc);
  printf(ANSI_FMT("raddr: %lld\n", ANSI_FG_RED), raddr);
  // if(top->next_pc && top->current_pc)
    assert(in_pmem(raddr));
  // 总是读取地址为`raddr & ~0x7ull`的8字节返回给`rdata`
  raddr = raddr & ~0x7; // align to 8

  uint8_t *raddr_temp = guest_to_host(raddr);
  *rdata = *(uint64_t *)raddr_temp;
  printf(ANSI_FMT("next_pcddddddddd: %p\n", ANSI_FG_RED), (void *)top->next_pc);
}

void pmem_write(long long waddr, long long wdata, char wmask) {
  assert(in_pmem(waddr));

  assert(!(waddr & 0x7));
  printf("waddr: %lx\n", waddr);
  printf("wdata: %lx\n", wdata);
  printf("wmask: %lx\n", wmask);
  // 总是往地址为`waddr & ~0x7ull`的8字节按写掩码`wmask`写入`wdata`
  // `wmask`中每比特表示`wdata`中1个字节的掩码,
  // 如`wmask = 0x3`代表只写入最低2个字节, 内存中的其它字节保持不变
  uint8_t *waddr_temp = guest_to_host(waddr);
  switch (wmask) {
    case 0x1:   *(uint8_t  *)waddr_temp = wdata;break;
    case 0x3:   *(uint16_t *)waddr_temp = wdata;break;
    case 0xf:   *(uint32_t *)waddr_temp = wdata;break;
    // case 0xff:  *(uint64_t *)waddr_temp = wdata;break;
    default:  *(uint64_t *)waddr_temp = wdata;break;
    // default: printf("pmem_write!\n"); exit(0); break;
    // default: printf("pmem_write!\n"); break;
  }
}


uint64_t *cpu_gpr = NULL;
extern "C" void set_gpr_ptr(const svOpenArrayHandle r) {
  cpu_gpr = (uint64_t *)(((VerilatedDpiOpenVar*)r)->datap());
  // cpu.gpr = (uint64_t *)(((VerilatedDpiOpenVar*)r)->datap());
}

// 一个输出RTL中通用寄存器的值的示例
void dump_gpr() {
  int i;
  for (i = 0; i < 32; i++) {
    if(cpu.gpr[i])
      printf("gpr[%d] = 0x%lx\n", i, cpu.gpr[i]);
  }
  printf("\n");
}

void get_cpu() {
  assert(cpu_gpr);
  for(int i = 0; i < 32; i++){
    cpu.gpr[i] = cpu_gpr[i];
  }
  cpu.pc = top->current_pc;
}
// 当nemu的pc和npc的current_pc为xxxx时，说明这个地址的指令还没有执行。
/**
 * The single cycle time series design refers:
 * https://nju-projectn.github.io/dlco-lecture-note/exp/11.html#id9
 */
int main(int argc, char *argv[]) {
  // get_cpu();
  cpu.pc = RESET_VECTOR;
  // print_arg(argc, argv);
  // long size = load_img(argv[1]);
  long size = load_init_img();
  init_difftest(argv[2], size, 0);

  sim_init();

  top->rst = 1;
  single_cycle(0);
  top->rst = 0;

  for(int i = 0; i < 100; i++){
    single_cycle(0);
    get_cpu();
    if(i)
      difftest_step();
    // dump_gpr();
    if(terminal)
      break;
  }

  sim_exit();
}
