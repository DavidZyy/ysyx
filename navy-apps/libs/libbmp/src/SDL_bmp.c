#include <SDL_bmp.h>
#include <BMP.h>
#include <assert.h>

char out_file2[] = "./test2.txt";
void write_slide_pixels_to_file(char *fname, FILE *fp, void *pixels, int w, int h) {
  fprintf(fp, "\n%s\n", fname);
  fprintf(fp, "width: %d, height: %d\n", w, h);
  for(int i=0; i<h; i++){
    for(int j=0; j<w; j++){
      fprintf(fp, "%x ", *(((uint32_t *)(pixels))+(i*w)+j));
    }
    fprintf(fp, "\n");
  }
}

SDL_Surface* SDL_LoadBMP(const char *filename) {
  // printf("in SDL_LoadBMP: %s\n", filename);
  int w, h;
  void *pixels = BMP_Load(filename, &w, &h);


  assert(pixels);
  SDL_Surface *s = SDL_CreateRGBSurfaceFrom(pixels, w, h, 32, w * sizeof(uint32_t),
      DEFAULT_RMASK, DEFAULT_GMASK, DEFAULT_BMASK, DEFAULT_AMASK);
  s->flags &= ~SDL_PREALLOC;

  // FILE *fp = fopen(out_file2, "a");
  // write_slide_pixels_to_file(filename, fp, pixels, w, h);
  // fclose(fp);

  // s->pixels = pixels;
  return s;
}
