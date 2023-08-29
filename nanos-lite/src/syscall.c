#include <common.h>
#include "syscall.h"
#include "fs.h"

void do_syscall(Context *c) {
  uintptr_t a[4];
  a[0] = c->GPR1;
  a[1] = c->GPR2;
  a[2] = c->GPR3;
  a[3] = c->GPR4;

  // Log("syscall ID = %d %d %d %d", a[0], a[1], a[2], a[3]);
  switch (a[0]) {
    case SYS_exit:
      halt(0);
      break;

    case SYS_yield: 
      yield();
      c->GPRx = 0;
      break;
    
    case SYS_write: {
      int fd = a[1];
      void *buf = (void *)a[2];
      size_t len = a[3];
      // if(fd == 1 || fd == 2) {
      //   // printf("%s", (char *) buf);
      //   for(int i = 0; i < count; i++){
      //     putch(*((char *)(buf+i)));
      //   }
      // } else {
        // panic("write failed!!");
      fs_write(fd, buf, len);
      // }
      c->GPRx = len;
      break;
    }

    case SYS_brk: {
      c->GPRx = 0;
      break;
    }

    case SYS_open: {
      const char *path = (const char *)a[1];
      int flags = a[2];
      int mode = a[3];
      int fd = fs_open(path, flags, mode);
      c->GPRx = fd;
      break;
    }

    case SYS_read: {
      int fd = a[1];
      void *buf = (void *)a[2];
      size_t count = a[3];
      int len = fs_read(fd, buf, count);
      c->GPRx = len;
      break;
    }

    case SYS_close: {
      int fd = a[1];
      c->GPRx = fs_close(fd);
      break;
    }

    case SYS_lseek: {
      int fd = a[1];
      int offset = a[2];
      int whence = a[3];
      c->GPRx = fs_lseek(fd, offset, whence);
      break;
    }

    default:
      panic("Unhandled syscall ID = %d %d %d %d", a[0], a[1], a[2], a[3]);
  }
}
