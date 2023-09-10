#include <fs.h>

typedef size_t (*ReadFn) (void *buf, size_t offset, size_t len);
typedef size_t (*WriteFn) (const void *buf, size_t offset, size_t len);
size_t ramdisk_read(void *buf, size_t offset, size_t len);
size_t ramdisk_write(const void *buf, size_t offset, size_t len);
size_t serial_write(const void *buf, size_t offset, size_t len);

typedef struct {
  char *name;
  size_t size;
  size_t disk_offset;
  size_t open_offset;

  ReadFn read;
  WriteFn write;
} Finfo;

enum {
  FD_STDIN, 
  FD_STDOUT, 
  FD_STDERR,
  FD_EVT, 
  FD_DISPINFO, 
  FD_FB
};

size_t invalid_read(void *buf, size_t offset, size_t len) {
  panic("should not reach here");
  return 0;
}

size_t invalid_write(const void *buf, size_t offset, size_t len) {
  panic("should not reach here");
  return 0;
}

size_t events_read(void *buf, size_t offset, size_t len);
size_t dispinfo_read(void *buf, size_t offset, size_t len);
size_t fb_write(const void *buf, size_t offset, size_t len);
/* This is the information about all files in disk. */
static Finfo file_table[] __attribute__((used)) = {
  [FD_STDIN]  = {"stdin",  0, 0, 0, invalid_read, invalid_write},
  [FD_STDOUT] = {"stdout", 0, 0, 0, invalid_read, serial_write},
  [FD_STDERR] = {"stderr", 0, 0, 0, invalid_read, serial_write},
  [FD_EVT]    = {"/dev/events", 0, 0, 0, events_read, invalid_write},
  [FD_DISPINFO] = {"/proc/dispinfo", 0, 0, 0, dispinfo_read, invalid_write},
  [FD_FB]     = {"/dev/fb", 0, 0, 0, invalid_read, fb_write},
#include "files.h"
};

void init_fs() {
  file_table[FD_FB].size = 
  io_read(AM_GPU_CONFIG).width * io_read(AM_GPU_CONFIG).height * 
  sizeof(int);
}

int fs_open(const char *pathname, int flags, int mode) {
  for(int i = 0; i < sizeof(file_table) / sizeof(Finfo); i++) {
    if(strcmp(pathname, file_table[i].name) == 0) {
      file_table[i].open_offset = file_table[i].disk_offset;
      return i;
    }
  }
  // not find
  panic("Not Find File: %s", pathname);
}

// size_t fs_read(int fd, void *buf, size_t len) {
//   size_t offset = file_table[fd].open_offset;
//   file_table[fd].open_offset += len;
//   // if(file_table[fd].open_offset !=  file_table[fd].disk_offset + file_table[fd].size){
//   Log("%d, %d, %d\n", file_table[fd].open_offset, len, file_table[fd].size);
//     // assert(0);
//   // }
//   return ramdisk_read((void *)buf, offset, len);
// }

size_t fs_read(int fd, void *buf, size_t len) {
  if(file_table[fd].read) {
    int offset = file_table[fd].open_offset;
    return file_table[fd].read(buf, offset, len);
  } else {
    size_t offset = file_table[fd].open_offset;
    // Calculate the remaining bytes available to read in the file
    size_t remaining_bytes = (file_table[fd].size + file_table[fd].disk_offset) - file_table[fd].open_offset;
    // Calculate the actual number of bytes to read
    size_t bytes_to_read = (len < remaining_bytes) ? len : remaining_bytes;
    file_table[fd].open_offset += bytes_to_read;
    assert(file_table[fd].open_offset <=  file_table[fd].disk_offset + file_table[fd].size);
    return ramdisk_read((void *)buf, offset, bytes_to_read);
  }
}

size_t fs_write(int fd, const void *buf, size_t len) {
  if(file_table[fd].write) {
    int offset = file_table[fd].open_offset;
    return file_table[fd].write(buf, offset, len);
  } else {
    size_t offset = file_table[fd].open_offset;
    file_table[fd].open_offset += len;
    /* should not largen file!, or it maybe overwirte the content of other file after it */
    assert(file_table[fd].open_offset <= file_table[fd].disk_offset + file_table[fd].size);
    return ramdisk_write(buf, offset, len);
  }
}

// size_t fs_lseek(int fd, size_t offset, int whence) {
//   file_table[fd].open_offset = file_table[fd].disk_offset + offset;
//   assert(file_table[fd].open_offset <= file_table[fd].disk_offset + file_table[fd].size);
//   return file_table[fd].open_offset;
// }

// Constants for 'whence' values
#define SEEK_SET 0
#define SEEK_CUR 1
#define SEEK_END 2

size_t fs_lseek(int fd, size_t offset, int whence) {
  switch (whence) {
    case SEEK_SET:
      // Set the open offset to the provided offset
      file_table[fd].open_offset = file_table[fd].disk_offset + offset;
      break;
    case SEEK_CUR:
      // Update the open offset by adding the provided offset
      file_table[fd].open_offset += offset;
      break;
    case SEEK_END:
      // Set the open offset to the end of the file plus the provided offset
      file_table[fd].open_offset = file_table[fd].disk_offset + file_table[fd].size + offset;
      // file_table[fd].open_offset = file_table[fd].disk_offset + file_table[fd].size;
      break;
    default:
      // Invalid 'whence' value
      panic("Invalid 'whence' value");
      break;
  }

  // Check if the open offset is within bounds
  // assert(file_table[fd].open_offset <= file_table[fd].disk_offset + file_table[fd].size);

  return file_table[fd].open_offset;
}

int fs_close(int fd) {
  return 0;
}
