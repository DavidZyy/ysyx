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

// instructions
/* note the byte order, the machine is little endia */
// #define ebreak   0b01110011, 0b00000000, 0b00010000, 0b00000000
#define ebreak   0x00100073

#define concat_temp(x, y) x ## y
#define concat(x, y) concat_temp(x, y)

#define CHOOSE2nd(a, b, ...) b
#define MUX_WITH_COMMA(contain_comma, a, b) CHOOSE2nd(contain_comma a, b)
#define MUX_MACRO_PROPERTY(p, macro, a, b) MUX_WITH_COMMA(concat(p, macro), a, b)

#define __P_DEF_0  X,
#define __P_DEF_1  X,

#define MUXDEF(macro, X, Y)  MUX_MACRO_PROPERTY(__P_DEF_, macro, X, Y)

// simplification for conditional compilation
#define __IGNORE(...)
#define __KEEP(...) __VA_ARGS__
// 如果定义了 macro， 选择__KEEP，否则就选择 __IGNORE
// keep the code if a boolean macro is defined
#define IFDEF(macro, ...) MUXDEF(macro, __KEEP, __IGNORE)(__VA_ARGS__)

#endif
