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
    while((key = read_key()) == 0); // cpu快于键盘，可能第二个数据没有准备好，poll一下
    kbd->keycode = key; 
  } else {
    kbd->keydown = 1;
    kbd->keycode = key;
  }
}
