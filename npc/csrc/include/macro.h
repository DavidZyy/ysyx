
#ifndef __MACRO_H__
#define __MACRO_H__

#define PG_ALIGN __attribute((aligned(4096)))

#define inst_id (top->next_pc - 0x80000000)
#define CONFIG_MSIZE 0x8000000
#define CONFIG_MBASE 0x80000000
#define CONFIG_PC_RESET_OFFSET 0x0
#define PMEM_LEFT  ((paddr_t)CONFIG_MBASE)
#define PMEM_RIGHT ((paddr_t)CONFIG_MBASE + CONFIG_MSIZE - 1)
#define RESET_VECTOR (PMEM_LEFT + CONFIG_PC_RESET_OFFSET)

// types
#define paddr_t uint64_t
#define vaddr_t uint64_t
// instructions
/* note the byte order, the machine is little endia */
// #define ebreak   0b01110011, 0b00000000, 0b00010000, 0b00000000
#define ebreak   0x00100073

#endif
