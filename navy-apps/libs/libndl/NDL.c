#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include <sys/time.h>
#include <stdio.h>

static int evtdev = -1;
static int fbdev = -1;
static int screen_w = 0, screen_h = 0;
static int canvas_w = 0, canvas_h = 0;

/* return seconds, not use us */
uint32_t NDL_GetTicks() {
  struct timeval current_time;
  gettimeofday(&current_time, NULL);
  return current_time.tv_sec;
}

int NDL_PollEvent(char *buf, int len) {
  int fd = open("/dev/events", 0);
  int return_val = 0;

  if(read(fd, buf, len))
    return_val = 1;

  close(fd);
  return return_val;
}

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
    int fd = open("/proc/dispinfo", 0);
    char buf[64];
    if (read(fd, buf, sizeof(buf)-1)) {
      sscanf(buf, "WIDTH: %d\nHEIGHT: %d\n", &screen_w, &screen_h);
      // printf("%d %d %d, %d\n", screen_w, screen_h, *w, *h);
      if(*w && *h) {
        canvas_w = *w;
        canvas_h = *h;
      } else {
        canvas_w = screen_w;
        canvas_h = screen_h;
        /* forget below */
        *w = screen_w;
        *h = screen_h;
      }
    }
  }
}

#include<stdio.h>
char out_file3[] = "./test3.txt";
char out_file4[] = "./test4.txt";
char out_file5[] = "./test5.txt";
void write_slide_pixels_to_file_in_SDL_UpdateRect(FILE *fp, void *pixels, int w, int h) {
  // fprintf(fp, "\n%s\n", fname);
  fprintf(fp, "width: %d, height: %d\n", w, h);
  for(int i=0; i<h; i++){
    for(int j=0; j<w; j++){
      fprintf(fp, "%d:%d ", (((uint32_t *)(pixels))+(i*w)+j), *(((uint32_t *)(pixels))+(i*w)+j));
    }
    fprintf(fp, "\n");
  }
  fprintf(fp, "\n");
}

/**
 * If 'x', 'y', 'w' and 'h' are all 0, SDL_UpdateRect will update the entire screen.
 */
void NDL_DrawRect(uint32_t *pixels, int x, int y, int w, int h) {
  if(x == 0 && y == 0 && w == 0 && h == 0){
    w = screen_w;
    h = screen_h;
  }
  int fd = open("/dev/fb", 0);
  x += (screen_w - canvas_w) / 2;
  y += (screen_h - canvas_h) / 2;


  // FILE *fp1 = fopen(out_file3, "a");
  // write_slide_pixels_to_file_in_SDL_UpdateRect(fp1, pixels, w, h);
  // fclose(fp1);

  // FILE *fp = fopen(out_file3, "w");

  uint32_t *ppixels = pixels;
  /* write line by line */
  for(int i = 0; i < h; i++) {
    lseek(fd, sizeof(int) * ((y+i)*screen_w + x), SEEK_SET);
    // write(fd, pixels, w*sizeof(int));
    // pixels += w;
    for(int j=0; j<w; j++) {
      write(fd, ppixels+i*w+j, sizeof(int));
      // fprintf(fp, "%d:%d ", (ppixels + i*w +j), *(ppixels + i*w +j) );
      // printf("%d:%d ", (ppixels + i*w +j), *(ppixels + i*w +j) );
      // fprintf(fp, "%d", j);
      // printf("%d", j);
      
      // ppixels++;
    }
    // fprintf(fp, "\n");
    // printf("\n");
  }
    // printf("\n");
  // fprintf(fp, "\n");
  // fclose(fp);

  // FILE *fp2 = fopen(out_file5, "a");
  // write_slide_pixels_to_file_in_SDL_UpdateRect(fp2, pixels, w, h);
  // fclose(fp2);

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
