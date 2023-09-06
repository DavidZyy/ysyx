#include <am.h>
#include <nemu.h>

// void __am_timer_init() {
// }
// 
// void __am_timer_uptime(AM_TIMER_UPTIME_T *uptime) {
//   uptime->us = 0;
// }
// 
// void __am_timer_rtc(AM_TIMER_RTC_T *rtc) {
//   rtc->second = 0;
//   rtc->minute = 0;
//   rtc->hour   = 0;
//   rtc->day    = 0;
//   rtc->month  = 0;
//   rtc->year   = 1900;
// }

static uint64_t boot_time = 0;

#include<stdio.h>
/* access can only get old data! so get error!! */
/* the clock frequency in nemu */
/* return the us */
static uint64_t read_time() {
  uint32_t lo = *(volatile uint32_t *)(RTC_ADDR + 0);
  printf("lo: %d\n", lo);
  uint32_t hi = *(volatile uint32_t *)(RTC_ADDR + 4);
  printf("hi: %d\n", hi);
  uint64_t time = ((uint64_t)hi << 32) | lo;
  return time;
}

void __am_timer_init() {
  printf("\nbefore read_time __am_timer_init: %ld\n", boot_time);
  boot_time = read_time();
  printf("after __am_timer_init: %ld\n\n", boot_time);
}

// /* return the us */
void __am_timer_uptime(AM_TIMER_UPTIME_T *uptime) {
  printf("\nbefore read_time __am_timer_uptime: %ld\n", uptime->us);
  uptime->us = read_time() - boot_time;
  printf("after __am_timer_uptime: %ld\n\n", uptime->us);
}

void __am_timer_rtc(AM_TIMER_RTC_T *rtc) {
  rtc->second = 0;
  rtc->minute = 0;
  rtc->hour   = 0;
  rtc->day    = 0;
  rtc->month  = 0;
  rtc->year   = 1900;
}
