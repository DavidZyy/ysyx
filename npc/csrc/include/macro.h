
#define PG_ALIGN __attribute((aligned(4096)))

#define inst_id (top->pc - 0x80000000)
#define CONFIG_MSIZE 0x8000000

// instructions
#define ebreak  0b00000000, 0b00010000, 0b00000000, 0b01110011