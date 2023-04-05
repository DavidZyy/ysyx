#include <am.h>
#include <klib.h>
#include <klib-macros.h>
#include <stdarg.h>

#if !defined(__ISA_NATIVE__) || defined(__NATIVE_USE_KLIB__)

#define max_char_cnt  256
/* */
// int printf(const char *fmt, ...) {
//   char buffer[max_char_cnt];
//   memset(buffer, 0, max_char_cnt);
// 
//   va_list args;
//   va_start(args, fmt);
//   /* not right pass args */
//   int char_cnt = sprintf(buffer, fmt, args);
//   if(char_cnt > max_char_cnt) {
//     panic("printf out of bound!");
//   }
//   va_end(args);
// 
//   for(int i = 0; buffer[i] != '\0'; i++)
//     putch(buffer[i]);
// 
//   return 0;
// }

int printf(const char *fmt, ...) {
  char buffer[256];
  char *out = buffer;
  // char *origin_out = out;
  va_list ap;
  va_start(ap, fmt);
  int d, p;
  char *str;

  while(*fmt != '\0'){
    if(*fmt == '%'){
      fmt++;
      switch (*fmt) {
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
           out++;
           p--;
         }
         break;

       default:
         panic("Not implemented");
         break;
      }
    }
    else{
      *out = *fmt;
      out++;
    }
    fmt++;
  }
  *out = '\0';

  va_end(ap);
  /* the chars copyed */
  // return out - origin_out;
  for(int i = 0; buffer[i] != '\0'; i++)
    putch(buffer[i]);
  return 0;
}


int vsprintf(char *out, const char *fmt, va_list ap) {
  panic("Not implemented");
}

int sprintf(char *out, const char *fmt, ...) {
  char *origin_out = out;
  va_list ap;
  va_start(ap, fmt);
  int d, p;
  char *str;

  while(*fmt != '\0'){
    if(*fmt == '%'){
      fmt++;
      switch (*fmt) {
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
           out++;
           p--;
         }
         break;

       default:
         panic("Not implemented");
         break;
      }
    }
    else{
      *out = *fmt;
      out++;
    }
    fmt++;
  }
  *out = '\0';

  va_end(ap);
  /* the chars copyed */
  return out - origin_out;
}

int snprintf(char *out, size_t n, const char *fmt, ...) {
  panic("Not implemented");
}

int vsnprintf(char *out, size_t n, const char *fmt, va_list ap) {
  panic("Not implemented");
}

#endif
