#include <am.h>
#include <nemu.h>
#include <stdio.h>

#define KEYDOWN_MASK 0x8000

static uint32_t read_key(){
  // uint32_t key = *(volatile uint32_t *)KBD_ADDR;
  uint32_t key = inl(KBD_ADDR);
  printf("%x\n", key);
  return key;
}

void __am_input_keybrd(AM_INPUT_KEYBRD_T *kbd) {
  uint32_t key = read_key();
  kbd->keydown = key & KEYDOWN_MASK;
  // kbd->keycode = AM_KEY_NONE;
  kbd->keycode = key & ~KEYDOWN_MASK;
}
