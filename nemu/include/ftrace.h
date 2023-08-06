#ifndef __FTRACE_H__
#define __FTRACE_H__

#include <common.h>

typedef struct {
  char func_name[20];
  vaddr_t func_addr_begin;
  unsigned long long func_size;
} ftrace_struct;

#endif