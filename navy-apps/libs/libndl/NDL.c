#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include <assert.h>
#include <sys/time.h>
#include <stdio.h>
#include <fcntl.h>

static int evtdev = -1;
static int fbdev = -1;
static int screen_w = 0, screen_h = 0;
static int canvas_w = 0, canvas_h = 0;

/* return seconds, not use us */
uint32_t NDL_GetTicks() {
  struct timeval current_time;
  gettimeofday(&current_time, NULL);
  return current_time.tv_sec * 1000;
}

int NDL_PollEvent(char *buf, int len) {
  int fd = open("/dev/events", 2);
  int return_val = 0;

  if(read(fd, buf, len))
    return_val = 1;

  close(fd);
  return return_val;
}

/* should only be called in SDL_SetVideoMode */
void NDL_OpenCanvas(int *w, int *h) {
  if (getenv("NWM_APP")) {
    int fbctl = 4;
    fbdev = 5;
    screen_w = *w; screen_h = *h;
    printf("screen_w %d, screen_h %d", screen_w, screen_h);
    char buf[64];
    int len = sprintf(buf, "%d %d", screen_w, screen_h);
    // let NWM resize the window and create the frame buffer
    write(fbctl, buf, len);
    while (1) {
      // 3 = evtdev
      int nread = read(3, buf, sizeof(buf) - 1);
      if (nread <= 0) continue;
      buf[nread] = '\0';
      if (strcmp(buf, "mmap ok") == 0) break;
    }
    close(fbctl);
  } else {
    int fd = open("/proc/dispinfo", 2);
    char buf[64];
    if (read(fd, buf, sizeof(buf)-1)) {
      sscanf(buf, "WIDTH: %d\nHEIGHT: %d\n", &screen_w, &screen_h);

      /* full screen */
      if(*w==0 && *h==0) {
        *w = screen_w;
        *h = screen_h;
      }
      canvas_w = *w;
      canvas_h = *h;

      close(fd);
    }
  }
}

void check_in_vmem(uint32_t addr) {
  if(addr > sizeof(int)*screen_h*screen_w) {
    printf("screen_h is %d, screen_w is %d, total mem is %d, addr is %d, out of vmem!\n",
      screen_h, screen_w, sizeof(int)*screen_h*screen_w, addr);
    while(1);
  }
}

/* only used in SDL_UpdateRect */
void NDL_DrawRect(uint32_t *pixels, int x, int y, int w, int h) {
  // printf("x: %d, y: %d, w: %d, h: %d\n", x, y, w, h);
  int fd = open("/dev/fb", O_RDWR);
  x += (screen_w - canvas_w) / 2;
  y += (screen_h - canvas_h) / 2;
  assert(x >= 0);
  assert(y >= 0);

  /* write line by line */
  for(int i=0; i<h; i++) {
    /* 需要往整个screen上面填像素，所以这里乘screen_w */
    uint32_t addr = sizeof(int) * ((y+i)*screen_w + x);
    check_in_vmem(addr);
    lseek(fd, addr, SEEK_SET);
    write(fd, pixels+i*w, w*sizeof(int));
  }

  close(fd);
}

void NDL_OpenAudio(int freq, int channels, int samples) {
}

void NDL_CloseAudio() {
}

int NDL_PlayAudio(void *buf, int len) {
  return 0;
}

int NDL_QueryAudio() {
  return 0;
}

int NDL_Init(uint32_t flags) {
  if (getenv("NWM_APP")) {
    evtdev = 3;
  }
  return 0;
}

void NDL_Quit() {
}
