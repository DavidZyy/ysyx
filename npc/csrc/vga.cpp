#include <stdint.h>
#include <assert.h>
#include <cstring>

#include "utils.h"
#include "isa.h"
#include "mem.h"
#include "conf.h"
#include "debug.h"
#include "npc.h"
#include "vga.h"


uint8_t vmem[SCREEN_W * SCREEN_H * sizeof(uint32_t)];
uint32_t vgactl_port_base[2];

#include <SDL2/SDL.h>

static SDL_Renderer *renderer = NULL;
static SDL_Texture *texture = NULL;

static void init_screen() {
    SDL_Window *window = NULL;
    char title[128];
    sprintf(title, "riscv32e-NPC");
    SDL_Init(SDL_INIT_VIDEO);
    SDL_CreateWindowAndRenderer(
        SCREEN_W,
        SCREEN_H,
        0, &window, &renderer);
    SDL_SetWindowTitle(window, title);
    texture = SDL_CreateTexture(renderer, SDL_PIXELFORMAT_ARGB8888,
        SDL_TEXTUREACCESS_STATIC, SCREEN_W, SCREEN_H);
}

static inline void update_screen() {
  SDL_UpdateTexture(texture, NULL, vmem, SCREEN_W * sizeof(uint32_t));
  SDL_RenderClear(renderer);
  SDL_RenderCopy(renderer, texture, NULL, NULL);
  SDL_RenderPresent(renderer);
}

void vga_update_screen() {
  if(vgactl_port_base[1]){
    update_screen();
    vgactl_port_base[1] = 0;
  }
}

void init_vga() {
    vgactl_port_base[0] = (SCREEN_W << 16) | SCREEN_H;
    init_screen();
    memset(vmem, 0, sizeof(vmem));
}

