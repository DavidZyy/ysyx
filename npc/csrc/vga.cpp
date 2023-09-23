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


uint32_t vmem[SCREEN_W * SCREEN_H];

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

void init_vga() {
    init_screen();
    memset(vmem, 0, sizeof(vmem));
}

