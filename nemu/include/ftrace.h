#ifndef __FTRACE_H__
#define __FTRACE_H__

typedef struct {
  char func_name[20];
  unsigned long long func_addr_begin;
  unsigned long long func_size;
} ftrace_struct;

#endif