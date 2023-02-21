
#define PG_ALIGN __attribute((aligned(4096)))

#define inst_id (top->pc - 0x80000000)/4

// instructions
#define ebreak  0b00000000000100000000000001110011