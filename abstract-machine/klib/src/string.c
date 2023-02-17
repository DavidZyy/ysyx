#include <klib.h>
#include <klib-macros.h>
#include <stdint.h>

#if !defined(__ISA_NATIVE__) || defined(__NATIVE_USE_KLIB__)

size_t strlen(const char *s) {
  size_t n = 0;
  while(s[n] != '\0')
    n++;
  return n;
}

char *strcpy(char *dst, const char *src) {
  char *temp = dst;
  assert(dst != src);
  while(*src != '\0'){
    *dst = *src;
    dst++;
    src++;
  }
  *dst = '\0';
  return temp;
}

char *strncpy(char *dst, const char *src, size_t n) {
  /* add to fix bug */
  char *temp = dst;
  assert(dst != src);
  while(*src != '\0' && n){
    *dst = *src;
    dst++;
    src++;
    n--;
  }
  *dst = '\0';
  return temp;
}

char *strcat(char *dst, const char *src) {
  /* add to fix bug */
  char *temp = dst;
  while(*dst != '\0') dst++;
  strcpy(dst, src);
  return temp;
}

int strcmp(const char *s1, const char *s2) {
  while(*s1 != '\0' && *s2 != '\0'){
    if(*s1 - *s2) return *s1 - *s2;
    s1++;
    s2++;
  }
  /* '\0' is permited */
  return *s1 - *s2; 
}

int strncmp(const char *s1, const char *s2, size_t n) {
  while(*s1 != '\0' && *s2 != '\0' && n){
    if(*s1 - *s2) return *s1 - *s2;
    s1++;
    s2++;
    n--;
  }
  /* '\0' is permited */
  return *s1 - *s2; 
}

void *memset(void *s, int c, size_t n) {
  char *s1 = (char *)s;
  while(n--){
    // *s1 = (char)c;
    *s1 = c;
    s1++;
  }
  return s;
}

/* could overlap */
void *memmove(void *dst, const void *src, size_t n) {
  char *cdst = (char *)dst;
  char *csrc = (char *)src;
  while(*csrc != '\0' && n--){
    *cdst = *csrc;
    cdst++;
    csrc++;
  }
  return dst;
}

/* could not overlap */
void *memcpy(void *out, const void *in, size_t n) {
  assert(out >= in + n || out + n <= in);
  char *cdst = (char *)out;
  char *csrc = (char *)in;
  while(*csrc != '\0' && n--){
    *cdst = *csrc;
    cdst++;
    csrc++;
  }
  return out;
}

int memcmp(const void *s1, const void *s2, size_t n) {
  if(!n)
    return 0;

  unsigned char *cs1 = (unsigned char *)s1;
  unsigned char *cs2 = (unsigned char *)s2;
  while(n--){
    if(*cs1 != *cs2)
      return *cs1 - *cs2;
    cs1++;
    cs2++;
  }
  return 0;
}

#endif
