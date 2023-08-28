#include <unistd.h>
#include <stdio.h>

extern _end;

int main() {
  write(1, "Hello World!\n", 13);
  // printf("_end is %x\n", &_end);
  int i = 2;
  volatile int j = 0;
  while (1) {
    j ++;
    if (j == 10000) {
      printf("Hello World from Navy-apps for the %dth time!\n", i ++);
      j = 0;
    }
  }
  return 0;
}
