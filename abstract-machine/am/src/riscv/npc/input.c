#include <am.h>
#include "include/npc.h"

#define KEYDOWN_MASK 0x8000

/* if press a, if key down is 802b, if key up is 2b, not same as ps/2 */
static uint32_t read_key(){
  // uint32_t key = inl(KBD_ADDR);
  // return key;
  return 0;
}

void __am_input_keybrd(AM_INPUT_KEYBRD_T *kbd) {
  uint32_t key = read_key();
  kbd->keydown = key & KEYDOWN_MASK;
  kbd->keycode = key & ~KEYDOWN_MASK;
}
