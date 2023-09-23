#include <am.h>
#include "include/npc.h"

static uint64_t boot_time = 0;
 
#include <stdio.h>
static uint64_t read_time() __attribute__((noinline));
/* access can only get old data! so get error!! */
/* the clock frequency in nemu */
/* return the us */
static uint64_t read_time() {
  /* hi should put before before lo, or the rtc_io_handler will not be 
    called, because it has "if (!is_write && offset == 4) {",  */
  uint32_t hi = *(volatile uint32_t *)(RTC_ADDR + 4);
  // printf("read hi: %x\n", hi);
  uint32_t lo = *(volatile uint32_t *)(RTC_ADDR + 0);
  printf("read lo: %x\n", hi);
  uint64_t time = ((uint64_t)hi << 32) | lo;
  return time;
}

void __am_timer_init() {
  boot_time = read_time();
}

void __am_timer_uptime(AM_TIMER_UPTIME_T *uptime) {
  uptime->us = read_time() - boot_time;
}

void __am_timer_rtc(AM_TIMER_RTC_T *rtc) {
  rtc->second = 0;
  rtc->minute = 0;
  rtc->hour   = 0;
  rtc->day    = 0;
  rtc->month  = 0;
  rtc->year   = 1900;
}
