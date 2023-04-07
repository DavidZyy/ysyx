// #include <stdint.h>
// #include <utils.h>

// uint8_t* guest_to_host(paddr_t paddr);
// paddr_t host_to_guest(uint8_t *haddr);
// void pmem_read(long long raddr, long long *rdata);
// void pmem_write(long long waddr, long long wdata, char wmask);

extern uint8_t pmem[CONFIG_MSIZE];
int load_init_img();
long load_img(const char *img_file);