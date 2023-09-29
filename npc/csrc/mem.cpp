#include <stdint.h>
#include <assert.h>

#include "utils.h"
#include "isa.h"
#include "mem.h"
#include "conf.h"
#include "debug.h"
#include "npc.h"
#include "vga.h"

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


static inline bool in_vmem(paddr_t addr) {
  return (addr >= FB_ADDR) && (addr < FB_ADDR+SCREEN_SZ);
}

static void out_of_bound(paddr_t addr) {
  panic("npc: address = " FMT_PADDR " is out of bound of pmem [" FMT_PADDR ", " FMT_PADDR "] at pc = " FMT_WORD,
      addr, PMEM_LEFT, PMEM_RIGHT, top->io_out_pc);
}

extern int npc_read_device;
extern int npc_write_device;

uint64_t us;
extern uint32_t vmem[SCREEN_W * SCREEN_H];
extern uint32_t vgactl_port_base[2];
#include<sys/time.h>
extern "C" void pmem_read(sword_t raddr, sword_t *rdata) {
  Assert(!(raddr & align_mask), "%s addr: " FMT_WORD" not align to 4 byte!, at pc: " FMT_WORD " instruction is: " FMT_WORD, __func__, raddr, top->io_out_pc, top->io_out_inst);

  if (raddr == 0 && top->io_out_pc == 0) {
    // not ready for inst fetch
    return;
  } else if (raddr == RTC_ADDR+4) {
    struct timeval now;
    gettimeofday(&now, NULL);
    us = now.tv_sec * 1000000 + now.tv_usec;
    *rdata = (uint32_t)(us>>32);
    npc_read_device = 1;
  } else if (raddr == RTC_ADDR) {
    *rdata = (uint32_t)us;
    npc_read_device = 1;
  } else if (raddr == SERIAL_PORT) {

  } else if (raddr == VGACTL_ADDR) {
    *rdata = vgactl_port_base[0];
    npc_read_device = 1;
  } else if (raddr == VGACTL_ADDR+4) {

  } else if (in_vmem(raddr)) {

  } else {
    // memory
    if(!in_pmem(raddr)) out_of_bound(raddr);
    void*raddr_temp = guest_to_host(raddr);
    *rdata = *(word_t *)raddr_temp;
  }
    npc_read_device = 0;
}

extern "C" void pmem_write(sword_t waddr, sword_t wdata) {
  Assert(!(waddr & align_mask), "%s addr: " FMT_WORD" not align to 4 byte!, at pc: " FMT_WORD " instruction is: " FMT_WORD, __func__, waddr, top->io_out_pc, top->io_out_inst);

  if (waddr == SERIAL_PORT) {
    // printf("%d: %c", waddr, (char)wdata);
    printf("%c", (char)wdata);
    npc_write_device = 1;
  } else if(in_vmem(waddr)) {
    // log_write("addr: %x, data: %x\n", waddr, wdata);
    // uint8_t *vmem_addr = waddr - FB_ADDR + (uint8_t *)vmem + 1600 * 100;
    uint8_t *vmem_addr = waddr - FB_ADDR + (uint8_t *)vmem;
    *(uint32_t *)vmem_addr = wdata;
    npc_write_device = 1;
  } else if (waddr == VGACTL_ADDR+4) {
    vgactl_port_base[1] = wdata;
    npc_write_device = 1;
  } else {
    if(!in_pmem(waddr)) out_of_bound(waddr);
    uint8_t *waddr_temp = guest_to_host(waddr);
    *(uint32_t *)waddr_temp = wdata;
  }
}

extern "C" void vaddr_ifetch(sword_t raddr, sword_t *rdata) {
  pmem_read(raddr, rdata);
}

extern "C" void vaddr_read(sword_t raddr, sword_t *rdata) {
  // printf("%x\n", *(uint32_t *)guest_to_host(0x8000dfe0));
  pmem_read(raddr, rdata);
  // store also call read
  // if(top->io_out_is_load) {
    IFDEF(CONFIG_MTRACE, log_write("pc:" FMT_WORD", inst:" FMT_WORD"\n", top->io_out_pc, top->io_out_inst));
    IFDEF(CONFIG_MTRACE, log_write("raddr:" FMT_WORD", rdata:" FMT_WORD"\n\n", raddr, *rdata));
  // }
}

extern "C" void vaddr_write(sword_t waddr, sword_t wdata) {
  pmem_write(waddr, wdata);
  IFDEF(CONFIG_MTRACE, log_write("pc:" FMT_WORD", inst:" FMT_WORD"\n", top->io_out_pc, top->io_out_inst));
  IFDEF(CONFIG_MTRACE, log_write("waddr:" FMT_WORD", wdata:" FMT_WORD"\n\n", waddr, wdata));
}

long load_img(const char *img_file) {
  // !!!!!!!!!!!!!!!!!!! memset 1 ???? what shit?
  memset(pmem, 0, sizeof(pmem));
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
