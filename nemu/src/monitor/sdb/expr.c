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

#include <isa.h>

/* We use the POSIX regex functions to process regular expressions.
 * Type 'man regex' for more information about POSIX regex functions.
 */
#include <regex.h>

#include <string.h>

enum {
  TK_NOTYPE = 256, TK_EQ,

  /* TODO: Add more token types */
  TK_DECIMAL,
};

static struct rule {
  const char *regex;
  int token_type;
} rules[] = {

  /* TODO: Add more rules.
   * Pay attention to the precedence level of different rules.
   */

  {" +", TK_NOTYPE},        // spaces
  {"\\+", '+'},             // plus
  {"==", TK_EQ},            // equal
  {"-", '-'},              // minus
  {"\\*", '*'},            // multiplication
  {"/", '/'},              // division
  {"\\(", '('},            // left parentheses
  {"\\)", ')'},            // right parentheses
  {"[0-9]+", TK_DECIMAL},  // decimal integers
};

#define NR_REGEX ARRLEN(rules)

static regex_t re[NR_REGEX] = {};

/* Rules are used for many times.
 * Therefore we compile them only once before any usage.
 */
void init_regex() {
  int i;
  char error_msg[128];
  int ret;

  for (i = 0; i < NR_REGEX; i ++) {
    ret = regcomp(&re[i], rules[i].regex, REG_EXTENDED);
    if (ret != 0) {
      regerror(ret, &re[i], error_msg, 128);
      panic("regex compilation failed: %s\n%s", error_msg, rules[i].regex);
    }
  }
}

typedef struct token {
  int type;
  char str[32];
} Token;

static Token tokens[32] __attribute__((used)) = {};
static int nr_token __attribute__((used))  = 0;

static bool make_token(char *e) {
  int position = 0;
  int i;
  regmatch_t pmatch;

  nr_token = 0;

  while (e[position] != '\0') {
    /* Try all rules one by one. */
    for (i = 0; i < NR_REGEX; i ++) {
      if (regexec(&re[i], e + position, 1, &pmatch, 0) == 0 && pmatch.rm_so == 0) {
        char *substr_start = e + position;
        int substr_len = pmatch.rm_eo;

        Log("match rules[%d] = \"%s\" at position %d with len %d: %.*s",
            i, rules[i].regex, position, substr_len, substr_len, substr_start);

        position += substr_len;

        /* TODO: Now a new token is recognized with rules[i]. Add codes
         * to record the token in the array `tokens'. For certain types
         * of tokens, some extra actions should be performed.
         */

        switch (rules[i].token_type) {
          case '+': tokens[nr_token++].type = '+'; break;
          case '-': tokens[nr_token++].type = '-'; break;
          case '*': tokens[nr_token++].type = '*'; break;
          case '/': tokens[nr_token++].type = '/'; break;
          case '(': tokens[nr_token++].type = '('; break;
          case ')': tokens[nr_token++].type = ')'; break;
          // case TK_NOTYPE: tokens[nr_token].type = TK_NOTYPE; break;
          case TK_NOTYPE: break;
          case TK_EQ: tokens[nr_token++].type = TK_EQ; break;
          case TK_DECIMAL:
            tokens[nr_token].type = TK_DECIMAL;
            memcpy(tokens[nr_token].str, substr_start, substr_len);
            nr_token++;
            break;
          default: TODO();
        }
        // nr_token++;

        break;
      }
    }

    if (i == NR_REGEX) {
      printf("no match at position %d\n%s\n%*.s^\n", position, e, position, "");
      return false;
    }
  }

  return true;
}


int prio(char ch){
  switch (ch) {
    case '+':
    case '-': return 0;
    case '*':
    case '/': return 1;
    default : assert(0);
  }
}

bool is_operator(Token tok) {
  if(tok.type == '+' ||
      tok.type == '-' ||
      tok.type == '/' ||
      tok.type == '*')
      return true;

  return false;
}

int getop(int p, int q) {
  int op = -1;
  for(int i = p; i <= q; i++) {
    if(tokens[i].type == '(') {
      while(tokens[i].type != ')') i++;
    } else if(is_operator(tokens[i])) {
      if(op == -1 || prio(tokens[op].type) >= prio(tokens[i].type))
        op = i;
    }
  }
  assert(op >= 0);
  return op;
}

// typedef struct paren {
//   int idx;
//   int type;
// } paren_t;

// left parentheses stack
int stack[32];

/**
 * (1+2)*(3-1), the first "(" matches with the last ")".
 */
bool check_parentheses(int p, int q) {
  // if(tokens[p].type == '(' && tokens[q].type == ')')
  //   return true;
  // return false;
  int parentheses_correct = 0;
  int match_p_q = 0;

  int stack_id = 0;
  for(int i = p; i <= q; i++) {
    assert(stack_id < 32);
    if(tokens[i].type == '(') {
      stack[stack_id++] = i;
    } else if (tokens[i].type == ')') {
      // match
      stack_id--;
      if((i == q) && (stack[stack_id] == p))
        match_p_q = 1;
    }
  }

  if(stack_id == 0)
    parentheses_correct = 1;

  if(parentheses_correct) {
    if(match_p_q) {
      return true;
    } else {
      return  false;
    }
  } else {
    assert(0);
  }
}

word_t eval(int p, int q) {
  if(p > q) {
    assert(0);
  } else if (p == q) {
    return atoi(tokens[p].str);
  } else if (check_parentheses(p, q)) {
    return eval(p+1, q-1);
  } else {
    int op = getop(p, q);
    int val1 = eval(p, op-1);
    int val2 = eval(op+1, q);

    switch (tokens[op].type) {
      case '+': return val1 + val2;
      case '-': return val1 - val2;
      case '*': return val1 * val2;
      case '/': return val1 / val2;
      default : assert(0);
    }
  }
}

word_t expr(char *e, bool *success) {
  if (!make_token(e)) {
    *success = false;
    return 0;
  }

  /* TODO: Insert codes to evaluate the expression. */
  // TODO();

  // return 0;
  return eval(0, nr_token-1);
}
