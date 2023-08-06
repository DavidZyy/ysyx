#ifndef __FTRACE_H__
#define __FTRACE_H__

#include <common.h>

typedef struct {
  char func_name[20];
  vaddr_t func_addr_begin;
  unsigned long long func_size;
} ftrace_struct;

#define RET 0x00008067
/* current inst pc is s->snpc-4 */
#define FUNC_TRACE {IFDEF(CONFIG_FTRACE, ftrace(s->snpc-4, s->dnpc, 0));}
#define FUNC_TRACE_RET {IFDEF(CONFIG_FTRACE, ftrace(s->snpc-4, s->dnpc, 1));}

char *addr_to_func(vaddr_t addr);
int is_a_call(vaddr_t addr);
void ftrace(vaddr_t old_addr, vaddr_t new_addr, int is_ret);
#endif