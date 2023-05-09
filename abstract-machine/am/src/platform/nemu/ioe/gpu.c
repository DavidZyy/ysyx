#include <am.h>
#include <nemu.h>
// #include <stdio.h>

#define SYNC_ADDR (VGACTL_ADDR + 4)

void __am_gpu_init() {
  // int i;
  // // int w = 0;  // TODO: get the correct width
  // // int h = 0;  // TODO: get the correct height
  // // int w = 400;
  // // int h = 300;
  // int a = inl(VGACTL_ADDR);
  // int w = a >> 16;
  // int h = ((a << 16) >> 16);
  // // printf("%d\n", h);
  // uint32_t *fb = (uint32_t *)(uintptr_t)FB_ADDR;
  // for (i = 0; i < w * h; i ++) fb[i] = i;
  // outl(SYNC_ADDR, 1);
}

void __am_gpu_config(AM_GPU_CONFIG_T *cfg) {
  int a = inl(VGACTL_ADDR);
  int w = a >> 16;
  int h = ((a << 16) >> 16);
  *cfg = (AM_GPU_CONFIG_T) {
    .present = true, .has_accel = false,
    // .width = 0, .height = 0,
    .width = w, .height = h,
    .vmemsz = 0
  };
}

void __am_gpu_fbdraw(AM_GPU_FBDRAW_T *ctl) {
  int i;
  uint32_t *fb = (uint32_t *)(uintptr_t)FB_ADDR;
  uint32_t *ctl_pixels = (uint32_t *)ctl->pixels;
  // fb += ctl->x * ctl->y;
  int a = ctl->x * ctl->y;
  // for (i = 0; i < ctl->w * ctl->h; i ++) fb[a + i] = ctl_pixels[i];
  for (i = 0; i < ctl->w * ctl->h; i ++) fb[a + i] = ctl_pixels[i];
  if (ctl->sync) {
    // nemu no this func
    outl(SYNC_ADDR, 1);
  }
}

void __am_gpu_status(AM_GPU_STATUS_T *status) {
  status->ready = true;
}

void __am_gpu_screen_size() {
}
