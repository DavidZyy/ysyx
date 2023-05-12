#include <am.h>
#include <npc.h>
// #include <riscv.h>
/**
 * only need to support w,s,a,d,u,i,j,k eight keys in mario
 */

static uint32_t read_key(){
  // uint32_t key = *(volatile uint32_t *)KBD_ADDR;
  uint32_t key = inl(KBD_ADDR);
  // if(key) printf("%x\n", key);
  return key;
}

void __am_input_keybrd(AM_INPUT_KEYBRD_T *kbd) {
  uint32_t key = read_key();

  /* key up */
  if(key == 0xf0){
    kbd->keydown = 0;
    kbd->keycode = read_key();
  } else {
    kbd->keydown = 1;
    kbd->keycode = key;
  }

}
