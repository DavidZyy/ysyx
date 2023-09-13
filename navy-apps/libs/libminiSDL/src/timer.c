#include <NDL.h>
#include <sdl-timer.h>
#include <stdio.h>

SDL_TimerID SDL_AddTimer(uint32_t interval, SDL_NewTimerCallback callback, void *param) {
  return NULL;
}

int SDL_RemoveTimer(SDL_TimerID id) {
  return 1;
}

 #include <sys/time.h>
/* Get the number of milliseconds since SDL library initialization. */
uint32_t SDL_GetTicks() {
  // return NDL_GetTicks();
  // return 1;
  struct timeval current_time;
  gettimeofday(&current_time, NULL);
  // printf("tv_sec: %d, tv_usec: %d\n", current_time.tv_sec, current_time.tv_usec);
  return current_time.tv_sec * 1000 + current_time.tv_usec / 1000;
}

void SDL_Delay(uint32_t ms) {
  // uint32_t a = SDL_GetTicks();
  // uint32_t b = SDL_GetTicks();
  // while(b <= a + 1) {
  //   b = SDL_GetTicks();
  // }
  return;
}
