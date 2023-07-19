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

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <assert.h>
#include <string.h>

// this should be enough
static char buf[65536] = {};
static char code_buf[65536 + 128] = {}; // a little larger than `buf`
static char *code_format =
"#include <stdio.h>\n"
"int main() { "
"  unsigned result = %s; "
"  printf(\"%%u\", result); "
"  return 0; "
"}";

int buf_id;

int choose(int n) {
  return rand() % n;
}

void put_str_in_buf(char *str) {
  sprintf(buf+buf_id, "%s", str);
  buf_id += strlen(str);
  assert(buf_id < sizeof(buf));
}

void put_char_in_buf(char ch) {
  sprintf(buf+buf_id, "%c", ch);
  buf_id++;
  assert(buf_id < sizeof(buf));
}

void gen(char ch) {
  put_char_in_buf(ch);
}

void gen_num() {
  int num = choose(100);
  char str[10];
  sprintf(str, "%d", num);
  put_str_in_buf(str);
}

int num_operators = 4;
void gen_rand_op() {
  int operator_index = rand() % num_operators;
  char operator;
  switch (operator_index) {
    case 0: operator = '+'; break;
    case 1: operator = '-'; break;
    case 2: operator = '*'; break;
    case 3: operator = '/'; break;
    default: operator = '+';
  }
  put_char_in_buf(operator);
}

static void gen_rand_expr() {
  // buf[0] = '\0';
  // sprintf(buf, "%s", "1");
  switch (choose(3)) {
    case 0: gen_num(); break;
    case 1: gen('('); gen_rand_expr(); gen(')'); break;
    default: gen_rand_expr(); gen_rand_op(); gen_rand_expr(); break;
  }
}

int main(int argc, char *argv[]) {
  int a = 0;
  int seed = time(0);
  srand(seed);
  int loop = 10;
  if (argc > 1) {
    sscanf(argv[1], "%d", &loop);
  }
  int i;
  for (i = 0; i < loop; i ++) {
    // reset
    memset(buf, 0, sizeof(buf));
    buf_id  = 0;

    gen_rand_expr();

    sprintf(code_buf, code_format, buf);

    FILE *fp = fopen("/tmp/.code.c", "w");
    assert(fp != NULL);
    fputs(code_buf, fp);
    fclose(fp);

    // int ret = system("gcc /tmp/.code.c -o /tmp/.expr");
    int ret = system("gcc /tmp/.code.c -o /tmp/.expr > /tmp/.compile_output 2>&1");
    if (ret != 0) continue;

    fp = popen("/tmp/.expr", "r");
    assert(fp != NULL);

    int result;
    a = fscanf(fp, "%d", &result);

    pclose(fp);

    // remove divided by zero
    // if (result != UINT32_MAX)
      printf("%u %s\n", result, buf);
  }
  return a;
}
