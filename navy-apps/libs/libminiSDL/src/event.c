#include <NDL.h>
#include <SDL.h>
#include <assert.h>
#include <string.h>

#define keyname(k) #k,

static const char *keyname[] = {
  "NONE",
  _KEYS(keyname)
};

int SDL_PushEvent(SDL_Event *ev) {
  return 0;
}

int SDL_PollEvent(SDL_Event *event) {
  char buf[64];
  int RETN_VAL;
  memset(buf, 0, sizeof(buf));
  memset(event, 0, sizeof(event));
  if (NDL_PollEvent(buf, sizeof(buf))) {
    // printf("%s", buf);
    if(buf[0] == 'k' && buf[1] == 'd') {
      event->type = SDL_KEYDOWN;
      for(int i = 0; i < sizeof(keyname)/sizeof(char *); i++) {
          // int len = strlen(keyname[i]);
          char *key_name = buf+3;
          int len1 = strlen(keyname[i]);
          int len2 = strlen(key_name);
          // printf("%s, %s, %d\n", keyname[i], key_name, len1);
          if (len1 == len2 && !strncmp(keyname[i], key_name, len1)) {
            event->key.keysym.sym = i;
            // printf("i: %d, keyname: %s, keyname_i: %s\n", i, key_name, keyname[i]);
            // printf("%s vs %s\n", keyname[i], key_name);
          }
      }
    } else if(buf[0] == 'k' && buf[1] == 'u') {
      event->type = SDL_KEYUP;
    } else {
      assert(0);
    }

    RETN_VAL = 1;
  } else {
    RETN_VAL = 0;
  }
  return RETN_VAL;
}

int SDL_WaitEvent(SDL_Event *event) {
  char buf[64];
  int RETN_VAL;
  memset(buf, 0, sizeof(buf));
  memset(event, 0, sizeof(event));
  while(!NDL_PollEvent(buf, sizeof(buf)));
  if(buf[0] == 'k' && buf[1] == 'd') {
    event->type = SDL_KEYDOWN;
    for(int i = 0; i < sizeof(keyname)/sizeof(char *); i++) {
        char *key_name = buf+3;
        int len1 = strlen(keyname[i]);
        int len2 = strlen(key_name);
        // printf("%s, %s, %d\n", keyname[i], key_name, len);
        if (len1 == len2 && !strncmp(keyname[i], key_name, len1)) {
          event->key.keysym.sym = i;
          // printf("%s vs %s\n", keyname[i], key_name);
        }
    }
  } else if(buf[0] == 'k' && buf[1] == 'u') {
    event->type = SDL_KEYUP;
  } else {
    assert(0);
  }

  return 1;
}

int SDL_PeepEvents(SDL_Event *ev, int numevents, int action, uint32_t mask) {
  return 0;
}

uint8_t keystate[sizeof(keyname)/sizeof(char *)];

uint8_t* SDL_GetKeyState(int *numkeys) {
  memset(keystate, 0, sizeof(keystate));
  // printf("keystate: %d\n", sizeof(keystate));
  // assert(0);
  return keystate;
}
