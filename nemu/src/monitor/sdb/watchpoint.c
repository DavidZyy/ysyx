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

#include "sdb.h"

#define NR_WP 32

typedef struct watchpoint {
  int NO;
  struct watchpoint *next;
  uint64_t last_val;
  char args[32];
  /* TODO: Add more members if necessary */
} WP;

static WP wp_pool[NR_WP] = {};
static WP *head = NULL, *free_ = NULL;

void init_wp_pool() {
  int i;
  for (i = 0; i < NR_WP; i ++) {
    wp_pool[i].NO = i;
    wp_pool[i].next = (i == NR_WP - 1 ? NULL : &wp_pool[i + 1]);
  }

  head = NULL;
  free_ = wp_pool;
}

/* TODO: Implement the functionality of watchpoint */

WP* new_wp() {
  assert(free_);
  WP* new = free_;
  free_ = free_->next;// remove new from free list

  new->next = head; // add new to used list
  head = new;
  return new;
}

void free_up(WP *wp) {
  if(wp != head) {
    WP* p = head;
    while(p->next != wp) p = p->next;
    p->next = wp->next;
  } else {
    head = wp->next;
  }

  wp->next = free_;
  free_ = wp;
}

void watch(char *args) {
  bool success;
  WP *new = new_wp();
  new->last_val = expr(args, &success);
  memcpy(new->args, args, strlen(args));
}

bool if_wp_chg() {
  WP *p;
  for (p = head; p; p = p->next) {
    bool success;
    uint64_t new_val = expr(p->args, &success);
    // printf("watch point changed!\n");
    if (new_val != p->last_val) {
      // printf("watch point changed!\n");
      printf("Hit watch point: NO.%d, old value: %lx, new value %lx, expression: %s\n",
            p->NO, p->last_val, new_val, p->args);
      p->last_val = new_val;
      return true;
    }
  }
  return false;
}

void del_wp(int n) {
  WP *p;
  for (p = head; p; p = p->next) {
    if(p->NO == n) {
      free_up(p);
      break;
    }
  }
}

void print_wp_info() {
  WP *p;
  for (p = head; p; p = p->next) {
    printf("NO.%d, args:%s, val:%ld\n", p->NO, p->args, p->last_val);
  }
}

