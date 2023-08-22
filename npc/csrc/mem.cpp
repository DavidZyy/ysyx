#include <stdint.h>
#include <assert.h>

#include "utils.h"
#include "isa.h"
#include "mem.h"
#include "conf.h"
#include "debug.h"

#include "verilated.h"
#include "verilated_vcd_c.h"
#include "../obj_dir/Vtop.h"

/* DPI-C function */
#include "svdpi.h"
// #include "Vtop__Dpi.h"
#include "verilated_dpi.h"

extern Vtop* top;
uint8_t pmem[CONFIG_MSIZE] PG_ALIGN = {};

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

static void out_of_bound(paddr_t addr) {
  panic("address = " FMT_PADDR " is out of bound of pmem [" FMT_PADDR ", " FMT_PADDR "] at pc = " FMT_WORD,
      addr, PMEM_LEFT, PMEM_RIGHT, top->io_out_pc);
}

extern "C" void pmem_read(sword_t raddr, sword_t *rdata) {
  Assert(!(raddr & 0x3u), "pmem_read raddr: " FMT_WORD"not align to 4 byte!", raddr);
  if(raddr == 0 && top->io_out_pc == 0) return;
  if(!in_pmem(raddr)) out_of_bound(raddr);
  void*raddr_temp = guest_to_host(raddr);
  *rdata = *(word_t *)raddr_temp;
  IFDEF(CONFIG_MTRACE, log_write("raddr:" FMT_WORD", rdata:" FMT_WORD"\n", raddr, *rdata));
}

extern "C" void pmem_write(long long waddr, long long wdata) {
  // printf(ANSI_FMT("waddr: %llx\n\n", ANSI_FG_GREEN), waddr);
  assert(in_pmem(waddr));

  // assert(!(waddr & 0x7));
  // printf("waddr: %lx\n", waddr);
  // printf("wdata: %lx\n", wdata);
  // printf("wmask: %lx\n", wmask);
  // 总是往地址为`waddr & ~0x7ull`的8字节按写掩码`wmask`写入`wdata`
  // `wmask`中每比特表示`wdata`中1个字节的掩码,
  // 如`wmask = 0x3`代表只写入最低2个字节, 内存中的其它字节保持不变
  uint8_t *waddr_temp = guest_to_host(waddr);
  *(uint32_t *)waddr_temp = wdata;
  // switch (wmask) {
  //   case 0x1:   *(uint8_t  *)waddr_temp = wdata;break;
  //   case 0x3:   *(uint16_t *)waddr_temp = wdata;break;
  //   case 0xf:   *(uint32_t *)waddr_temp = wdata;break;
  //   // case 0xff:  *(uint64_t *)waddr_temp = wdata;break;
  //   default:  *(uint64_t *)waddr_temp = wdata;break;
  //   // default: printf("pmem_write!\n"); exit(0); break;
  //   // default: printf("pmem_write!\n"); break;
  // }
}

long load_img(const char *img_file) {
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
