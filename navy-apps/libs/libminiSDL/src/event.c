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
  memset(buf, 0, sizeof(buf));
  if (NDL_PollEvent(buf, sizeof(buf))) {
    // printf("%s", buf);
    if(buf[0] == 'k' && buf[1] == 'd') {
      event->type = SDL_KEYDOWN;
      for(int i = 0; i < sizeof(keyname)/sizeof(char *); i++) {
          int len = strlen(keyname[i]);
          char *key_name = buf+3;
          // printf("%s, %s, %d\n", keyname[i], key_name, len);
          if(!strncmp(keyname[i], key_name, len)) {
            event->key.keysym.sym = i;
            // printf("%s vs %s\n", keyname[i], key_name);
          }
      }
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
