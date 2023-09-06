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

/* access can only get old data! so get error!! */
/* the clock frequency in nemu */
/* return the us */
static uint64_t read_time() {
  uint32_t lo = *(volatile uint32_t *)(RTC_ADDR + 0);
  uint32_t hi = *(volatile uint32_t *)(RTC_ADDR + 4);
  uint64_t time = ((uint64_t)hi << 32) | lo;
  return time;
}

#include<stdio.h>
void __am_timer_init() {
  boot_time = read_time();
  printf("am init boot time: %ld\n", boot_time);
}

// /* return the us */
void __am_timer_uptime(AM_TIMER_UPTIME_T *uptime) {
  uptime->us = read_time() - boot_time;
  printf("am uptime us is: %ld\n", uptime->us);
}

void __am_timer_rtc(AM_TIMER_RTC_T *rtc) {
  rtc->second = 0;
  rtc->minute = 0;
  rtc->hour   = 0;
  rtc->day    = 0;
  rtc->month  = 0;
  rtc->year   = 1900;
}
