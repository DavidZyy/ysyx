/***************************************************************************************
* Copyright (c) 2014-2022 Zihao Yu, Nanjing University
*
* NEMU is licensed under Mulan PSL v2.
* You can use this software according to the terms and conditions of the Mulan PSL v2.
* You may obtain a copy of Mulan PSL v2 at:
*          http://license.coscl.org.cn/MulanPSL2
*
* THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND,
* EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT,
* MERCHANTABILITY OR FIT FOR A PARTICULAR PURPOSE.
*
* See the Mulan PSL v2 for more details.
***************************************************************************************/

#include <common.h>

void init_monitor(int, char *[]);
void am_init_monitor();
void engine_start();
int is_exit_status_bad();

word_t expr(char *e, bool *success);
void test_gen_expr() {
  FILE *file;
  char line[256];
  file = fopen("/home/zhuyangyang/project/ysyx-workbench/nemu/tools/gen-expr/input", "r");
  assert(file);

  while (fgets(line, sizeof(line), file)) {
    // printf("%s", line);
    char *result_str = strtok(line, " ");
    int result  = atoi(result_str);
    char *expr_str  = result_str  + strlen(result_str) + 1;
    printf("result: %d\n", result);
    printf("expr_str: %s", expr_str);
    bool success;
    assert(result == expr(expr_str, &success));
  }
  fclose(file);
  return;
}

int main(int argc, char *argv[]) {
  /* Initialize the monitor. */
#ifdef CONFIG_TARGET_AM
  am_init_monitor();
#else
  init_monitor(argc, argv);
#endif

  // test_gen_expr();

  /* Start engine. */
  engine_start();

  return is_exit_status_bad();
}
