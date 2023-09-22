#include <common.h>
#include <sys/time.h>

#if defined(MULTIPROGRAM) && !defined(TIME_SHARING)
# define MULTIPROGRAM_YIELD() yield()
#else
# define MULTIPROGRAM_YIELD()
#endif

#define NAME(key) \
  [AM_KEY_##key] = #key,

static const char *keyname[256] __attribute__((used)) = {
  [AM_KEY_NONE] = "NONE",
  AM_KEYS(NAME)
};

size_t serial_write(const void *buf, size_t offset, size_t len) {
  for(int i = 0; i < len; i++) {
    putch(*((char *)(buf+i)));
  }
  return len;
}

size_t events_read(void *buf, size_t offset, size_t len) {
  AM_INPUT_KEYBRD_T ev = io_read(AM_INPUT_KEYBRD);
  /* no read */
  if (ev.keycode == AM_KEY_NONE)
    return 0;
  snprintf(buf, len, "%s %s\0", ev.keydown ? "kd" : "ku", keyname[ev.keycode]);
  // printf("%s\n", buf);
  // snprintf(buf, len, "%s %d", ev.keydown ? "kd" : "ku", ev.keycode);
  return len;
}

size_t dispinfo_read(void *buf, size_t offset, size_t len) {
  int w = io_read(AM_GPU_CONFIG).width;
  int h = io_read(AM_GPU_CONFIG).height;

  assert(len >= 30);
  return snprintf(buf, len, "WIDTH: %d\nHEIGHT: %d\n", w, h);
}

size_t fb_write(const void *buf, size_t offset, size_t len) {
  int w = io_read(AM_GPU_CONFIG).width;

  size_t pixels_offset = offset / sizeof(int);
  size_t pixels_len = len / sizeof(int);

  int y = pixels_offset / w;
  int x = pixels_offset % w;

  // assert(x + pixels_len <= w);
  io_write(AM_GPU_FBDRAW, x, y, (uint32_t *)buf, pixels_len, 1, true);
  // Log("x %d y %d w %d off %d, len %d", x, y, w, pixels_offset, pixels_len);
  return len;
}

// struct timeval {
//   uint32_t tv_sec;		/* Seconds.  */
//   uint32_t tv_usec;	/* Microseconds.  */
// };

int mygettimeofday(struct timeval *tv) {
  tv->tv_sec  = io_read(AM_TIMER_UPTIME).us / 1000000;
  tv->tv_usec = io_read(AM_TIMER_UPTIME).us % 1000000;
  return 0;
}

void init_device() {
  // Log("Initializing devices...");
  ioe_init();
}
