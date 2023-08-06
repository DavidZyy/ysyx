#include <ftrace.h>
#include <common.h>

int nest_num;
extern ftrace_struct func_info[64];
extern int func_id;

char *addr_to_func(vaddr_t addr) {
  for(int i = 0; i < func_id; i++) {
    if(func_info[i].func_addr_begin <= addr &&  addr < func_info[i].func_addr_begin+func_info[i].func_size) {
      return func_info[i].func_name;
    }
  }
  return NULL;
}

/**
 * if addr is the beginning of a function, than it is a call.
 */
int is_a_call(vaddr_t addr) {
  for(int i = 0; i < func_id; i++) {
    if(addr == func_info[i].func_addr_begin){
      return 1;
    }
  }
  return 0;
}

/* from the beginning of a function is a call */
void ftrace(vaddr_t old_addr, vaddr_t new_addr, int is_ret) {
  int is_call = is_a_call(new_addr);
  if(is_ret) nest_num--;

  if(is_call || is_ret) {
    char *old_func = addr_to_func(old_addr);
    char *new_func = addr_to_func(new_addr);
    log_write("0x%"XX, old_addr);
    for(int i = 0; i < nest_num; i++) {
      log_write("  ");
    }
    if(!is_ret){
      nest_num++;
      log_write("call [%s@0x%"XX"]\n", new_func, new_addr);
    } else {
      log_write("ret [%s]\n", old_func);
    }
  }
}