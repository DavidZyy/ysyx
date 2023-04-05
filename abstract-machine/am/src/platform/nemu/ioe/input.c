#include <am.h>
#include <nemu.h>

#define KEYDOWN_MASK 0x8000

static uint32_t read_key(){
  uint32_t key = *(volatile uint32_t *)KBD_ADDR;
  return key;
}

void __am_input_keybrd(AM_INPUT_KEYBRD_T *kbd) {
  uint32_t key = read_key();
  kbd->keydown = key & KEYDOWN_MASK;
  // kbd->keycode = AM_KEY_NONE;
  kbd->keycode = (uint16_t)key;
}
