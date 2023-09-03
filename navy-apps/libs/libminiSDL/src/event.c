#include <NDL.h>
#include <SDL.h>

#define keyname(k) #k,

static const char *keyname[] = {
  "NONE",
  _KEYS(keyname)
};

int SDL_PushEvent(SDL_Event *ev) {
  return 0;
}

int SDL_PollEvent(SDL_Event *ev) {
  return 0;
}

int SDL_WaitEvent(SDL_Event *event) {
  char buf[64];
  if (NDL_PollEvent(buf, sizeof(buf))) {
      // printf("receive event: %s\n", buf);
      if(buf[0] == 'k' && buf[1] == 'd')
        event->type = SDL_KEYDOWN;
      for(int i = 0; i < sizeof(keyname)/sizeof(char *); i++) {
          if(strcmp(keyname[i], buf + 2))
            event->key.keysym.sym = i;
      }
  }
  return 1;
}

int SDL_PeepEvents(SDL_Event *ev, int numevents, int action, uint32_t mask) {
  return 0;
}

uint8_t* SDL_GetKeyState(int *numkeys) {
  return NULL;
}
