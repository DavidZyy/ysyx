
#define PG_ALIGN __attribute((aligned(4096)))

#define inst_id (top->next_pc - 0x80000000)
#define CONFIG_MSIZE 0x8000000

// instructions
/* note the byte order, the machine is little endia */
// #define ebreak   0b01110011, 0b00000000, 0b00010000, 0b00000000
#define ebreak   0x00100073