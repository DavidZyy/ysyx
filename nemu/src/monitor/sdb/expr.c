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
  TK_DECIMAL, TK_HEX, TK_REG, TK_MINUS, TK_DEREF
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
  {"0x[0-9A-Fa-f]+", TK_HEX},
  {"[0-9]+", TK_DECIMAL},   // decimal integers
  {"\\$[0-9A-Za-z]+", TK_REG}
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
            tokens[nr_token].str[substr_len] = '\0';
            nr_token++; break;
          case TK_HEX:
            tokens[nr_token].type = TK_HEX;
            memcpy(tokens[nr_token].str, substr_start, substr_len);
            tokens[nr_token].str[substr_len] = '\0';
            nr_token++; break;
          case TK_REG:
            tokens[nr_token].type = TK_REG;
            memcpy(tokens[nr_token].str, substr_start, substr_len);
            tokens[nr_token].str[substr_len] = '\0';
            nr_token++; break;
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

int prio(int type){
  switch (type) {
    case '+':
    case '-': return 0;
    case '*':
    case '/': return 1;
    case TK_EQ: return 2;
    default : assert(0);
  }
}

bool is_operator(Token tok) {
  if( tok.type == '+' ||
      tok.type == '-' ||
      tok.type == '/' ||
      tok.type == '*' ||
      tok.type == TK_EQ)
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
  // assert(op >= 0);
  // if not find, return -1
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
    printf("parentheses not correct!\n");
    assert(0);
  }
}

word_t eval(int p, int q) {
  if(p > q) {
    // assert(0);
    return 0;
  } else if (p == q) {
    // operands
    if(tokens[p].type == TK_DECIMAL) {
      return atoi(tokens[p].str);
    } else if(tokens[p].type == TK_HEX) {
      char *endptr;
      long decimal = strtol(tokens[p].str, &endptr, 16);
      if(*endptr  !=  '\0') assert(0);
      return decimal;
    } else if(tokens[p].type == TK_REG) {
      bool success;
      return isa_reg_str2val(tokens[p].str, &success);
    } else {
      assert(0);
    }
  } else if (check_parentheses(p, q)) {
    // parentheses
    return eval(p+1, q-1);
  } else {
    // operators
    int op = getop(p, q);
    int val1 = eval(p, op-1);
    int val2;
    if(tokens[op+1].type == TK_MINUS) {
      val2 = -eval(op+2, q);
    } else {
      val2 = eval(op+1, q);
    }

    if(op == -1) {
      return val2;
    } else {
      switch (tokens[op].type) {
        case '+': return val1 + val2;
        case '-': return val1 - val2;
        case '*': return val1 * val2;
        case '/': return val1 / val2;
        case TK_EQ: return val1 == val2;
        default : assert(0);
      }
    }
  }
}

word_t expr(char *e, bool *success) {
  if (!make_token(e)) {
    *success = false;
    return 0;
  }

  /* TODO: Insert codes to evaluate the expression. */
  // to support minus calculation
  int i;

  for (i = 0; i < nr_token; i++) {
    if(tokens[i].type == '-' && (i == 0 || is_operator(tokens[i-1])))
      tokens[i].type = TK_MINUS;
  }

  for (i = 0; i < nr_token; i ++) {
    if(tokens[i].type == '*' && (i == 0 || is_operator(tokens[i-1])))
      tokens[i].type = TK_DEREF;
  }

  return eval(0, nr_token-1);
}
