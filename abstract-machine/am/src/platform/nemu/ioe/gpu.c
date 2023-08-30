#include <am.h>
#include <nemu.h>

#define SYNC_ADDR (VGACTL_ADDR + 4)

static int w, h;

void __am_gpu_init() {
  int a = inl(VGACTL_ADDR);
  w = a >> 16;
  h = a & 0xffff;
}

void __am_gpu_config(AM_GPU_CONFIG_T *cfg) {
  int a = inl(VGACTL_ADDR);
  int w = a >> 16;
  int h = a & 0xffff;
  
  *cfg = (AM_GPU_CONFIG_T) {
    .present = true, .has_accel = false,
    .width = w, .height = h,
    .vmemsz = 0
  };
}

void __am_gpu_fbdraw(AM_GPU_FBDRAW_T *ctl) {
  uint32_t *fb = (uint32_t *)(uintptr_t)FB_ADDR;
  uint32_t *ctl_pixels = (uint32_t *)ctl->pixels;
  int a = w * ctl->y + ctl->x;
  int idx = 0;
  for (int i = 0; i < ctl->h; i++) {
    for(int j = 0; j < ctl->w; j++)
      fb[a + i*w + j] = ctl_pixels[idx++];
  }
  if (ctl->sync) {
    outl(SYNC_ADDR, 1);
  }
}

void __am_gpu_status(AM_GPU_STATUS_T *status) {
  status->ready = true;
}
