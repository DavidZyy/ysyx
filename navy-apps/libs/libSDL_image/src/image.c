#define SDL_malloc  malloc
#define SDL_free    free
#define SDL_realloc realloc

#define SDL_STBIMAGE_IMPLEMENTATION
#include "SDL_stbimage.h"

SDL_Surface* IMG_Load_RW(SDL_RWops *src, int freesrc) {
  assert(src->type == RW_TYPE_MEM);
  assert(freesrc == 0);
  return NULL;
}

SDL_Surface* IMG_Load(const char *filename) {
    // Step 1: Open the file
    FILE* file = fopen(filename, "rb");
    if (file == NULL) {
        fprintf(stderr, "Error: Could not open file '%s'\n", filename);
        assert(0);
        return NULL;
    }

    // Step 2: Get the file size
    fseek(file, 0, SEEK_END);
    long size = ftell(file);
    fseek(file, 0, SEEK_SET);
    printf("size: %d\n", size);

    // Step 3: Allocate memory for the entire file
    uint8_t* buf = (uint8_t*)malloc(size);
    if (buf == NULL) {
        fclose(file);
        fprintf(stderr, "Error: Memory allocation failed\n");
        assert(0);
        return NULL;
    }

    // Step 4: Read the entire file into memory
    int rd;
    if ((rd = fread(buf, 1, size, file)) == size) {
        printf("read size: %d\n", rd);
        fclose(file);
        free(buf);
        fprintf(stderr, "Error: Failed to read file '%s'\n", filename);
        assert(0);
        return NULL;
    }

    // Step 5: Load image from memory using STBIMG_LoadFromMemory
    // int width, height, channels;
    SDL_Surface* surface = STBIMG_LoadFromMemory(buf, size);
    assert(surface);

    fclose(file);
    free(buf);
    // stbi_image_free(image_data);
    return surface;
}

int IMG_isPNG(SDL_RWops *src) {
  return 0;
}

SDL_Surface* IMG_LoadJPG_RW(SDL_RWops *src) {
  return IMG_Load_RW(src, 0);
}

char *IMG_GetError() {
  return "Navy does not support IMG_GetError()";
}
