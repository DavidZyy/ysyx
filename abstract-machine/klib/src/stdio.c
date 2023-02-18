#include <am.h>
#include <klib.h>
#include <klib-macros.h>
#include <stdarg.h>

#if !defined(__ISA_NATIVE__) || defined(__NATIVE_USE_KLIB__)

int printf(const char *fmt, ...) {
  panic("Not implemented");
}

int vsprintf(char *out, const char *fmt, va_list ap) {
  panic("Not implemented");
}

int sprintf(char *out, const char *fmt, ...) {
  va_list ap;
  va_start(ap, fmt);
  int d, p;
  char *str;

  while(*fmt != '\0'){
    if(*fmt == '%'){
      fmt++;
      switch (*fmt)
      {
      case 's':
        str = va_arg(ap, char*);
        strcpy(out, str);
        out += strlen(str);
        break;
      
      case 'd':
        d = va_arg(ap, int);
        /* change int to char* */
        char temp_buf[32];
        p = 0;
        while (d)
        {
          int rem = d%10;
          d = d/10;
          char ch = (char)((int)'0' + rem);
          temp_buf[p++] = ch;
        }
        p--;
        while(p >= 0){
          *out = temp_buf[p];
          // out++;
          p--;
        }
        break;

      default:
        panic("Not implemented");
        break;
      }
      fmt++;
    }
    else{
      *out = *fmt;
      out++;
      fmt++;
    }
  }
  *out = '\0';

  va_end(ap);
  return 0;
}

int snprintf(char *out, size_t n, const char *fmt, ...) {
  panic("Not implemented");
}

int vsnprintf(char *out, size_t n, const char *fmt, va_list ap) {
  panic("Not implemented");
}

#endif
