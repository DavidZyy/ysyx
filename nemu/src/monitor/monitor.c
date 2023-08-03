/***************************************************************************************
* Copyright (c) 2014-2022 Zihao Yu, Nanjing University
*
* NEMU is licensed under Mulan PSL v2.
* You can use this software according to the terms and conditions of the Mulan PSL v2.
* You may obtain a copy of Mulan PSL v2 at:
*          http://license.coscl.org.cn/MulanPSL2
*
* THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND,
* EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT,
* MERCHANTABILITY OR FIT FOR A PARTICULAR PURPOSE.
*
* See the Mulan PSL v2 for more details.
***************************************************************************************/

#include <isa.h>
#include <memory/paddr.h>
#include </usr/include/elf.h>

void init_rand();
void init_log(const char *log_file);
void init_mem();
void init_difftest(char *ref_so_file, long img_size, int port);
void init_device();
void init_sdb();
void init_disasm(const char *triple);

static void welcome() {
  Log("Trace: %s", MUXDEF(CONFIG_TRACE, ANSI_FMT("ON", ANSI_FG_GREEN), ANSI_FMT("OFF", ANSI_FG_RED)));
  IFDEF(CONFIG_TRACE, Log("If trace is enabled, a log file will be generated "
        "to record the trace. This may lead to a large log file. "
        "If it is not necessary, you can disable it in menuconfig"));
  Log("Build time: %s, %s", __TIME__, __DATE__);
  printf("Welcome to %s-NEMU!\n", ANSI_FMT(str(__GUEST_ISA__), ANSI_FG_YELLOW ANSI_BG_RED));
  printf("For help, type \"help\"\n");
  // Log("Exercise: Please remove me in the source code and compile NEMU again.");
  // assert(0);
}

#ifndef CONFIG_TARGET_AM
#include <getopt.h>

void sdb_set_batch_mode();

static char *log_file = NULL;
static char *diff_so_file = NULL;
static char *img_file = NULL;
static char *elf_file = NULL;
static int difftest_port = 1234;

static long load_img() {
  if (img_file == NULL) {
    Log("No image is given. Use the default build-in image.");
    return 4096; // built-in image size
  }

  FILE *fp = fopen(img_file, "rb");
  Assert(fp, "Can not open '%s'", img_file);

  fseek(fp, 0, SEEK_END);
  long size = ftell(fp);

  Log("The image is %s, size = %ld", img_file, size);

  fseek(fp, 0, SEEK_SET);
  int ret = fread(guest_to_host(RESET_VECTOR), size, 1, fp);
  assert(ret == 1);

  fclose(fp);
  return size;
}

static int parse_args(int argc, char *argv[]) {
  const struct option table[] = {
    {"batch"    , no_argument      , NULL, 'b'},
    {"log"      , required_argument, NULL, 'l'},
    {"diff"     , required_argument, NULL, 'd'},
    {"port"     , required_argument, NULL, 'p'},
    {"elf"      , required_argument, NULL, 'e'},
    {"help"     , no_argument      , NULL, 'h'},
    {0          , 0                , NULL,  0 },
  };
  int o;
  // : in getop_long means the option requires an argument
  while ( (o = getopt_long(argc, argv, "-bhl:d:p:e:", table, NULL)) != -1) {
    switch (o) {
      case 'b': sdb_set_batch_mode(); break;
      case 'p': sscanf(optarg, "%d", &difftest_port); break;
      case 'l': log_file = optarg; break;
      case 'd': diff_so_file = optarg; break;
      case 'e': elf_file = optarg; break;
      case 1: img_file = optarg; return 0;
      default:
        printf("Usage: %s [OPTION...] IMAGE [args]\n\n", argv[0]);
        printf("\t-b,--batch              run with batch mode\n");
        printf("\t-l,--log=FILE           output log to FILE\n");
        printf("\t-d,--diff=REF_SO        run DiffTest with reference REF_SO\n");
        printf("\t-p,--port=PORT          run DiffTest with port PORT\n");
        printf("\n");
        exit(0);
    }
  }
  return 0;
}

Elf64_Shdr section_headers[20];
char section_names[512];
Elf64_Sym symbols[200];
int func_id = 0;

typedef struct {
  char func_name[20];
  uint64_t func_addr_begin;
  uint64_t func_size;
} ftrace_struct;

void init_elf(const char* elf_file) {
  assert(elf_file);
  FILE *file = fopen(elf_file, "rb");
  assert(file);

  Elf64_Ehdr elf_header;
  assert(fread(&elf_header, sizeof(Elf64_Ehdr), 1, file) == 1);

  // Read and validate the section header table
  int num_sections = elf_header.e_shnum;
  assert(num_sections < sizeof(section_headers) / sizeof(Elf64_Shdr));
  // Elf64_Shdr *section_headers = malloc(sizeof(Elf64_Shdr) * num_sections);
  fseek(file, elf_header.e_shoff, SEEK_SET);
  assert(fread(section_headers, sizeof(Elf64_Shdr), num_sections, file) == num_sections);

  /* get symbol table section */
  Elf64_Shdr symtab, strtab;
  memset(&symtab, 0, sizeof(Elf64_Shdr));
  memset(&strtab, 0, sizeof(Elf64_Shdr));
  for(int i = 0; i < elf_header.e_shnum; i++) {
    if(section_headers[i].sh_type == SHT_SYMTAB) {
      symtab = section_headers[i];
      break;
    }
  }

  for(int i = 0; i < elf_header.e_shnum; i++) {
    if(section_headers[i].sh_type == SHT_STRTAB) {
      strtab = section_headers[i];
      break;
    }
  }

  /* read str table */
  // char *section_names = malloc(strtab.sh_size);
  assert(strtab.sh_size < sizeof(section_names));
  fseek(file, strtab.sh_offset, SEEK_SET);
  assert(fread(section_names, strtab.sh_size, 1, file) == 1);

  /*read symbol table */
  fseek(file, symtab.sh_offset, SEEK_SET);
  // Elf64_Sym *symbols = malloc(symtab.sh_size);
  // assert(fread(symbols, symtab.sh_size, 1, file) == 1);
  int ret = fread(symbols, symtab.sh_size, 1, file);
  assert(ret);

  func_id = 0;
  int num_symbols = symtab.sh_size / sizeof(Elf64_Sym);
  assert(num_symbols < sizeof(symbols) / sizeof(Elf64_Sym));
  for (int i = 0; i < num_symbols; i++) {
    // if(symbols[i].st_name)
      log_write("Symbol %-2d: Name=%-15s, Value=0x%-10lx, Size=%lu\n", i,
             section_names + symbols[i].st_name, symbols[i].st_value, symbols[i].st_size);
            //  NULL, symbols[i].st_value, symbols[i].st_size);
      // if(symbols[i].)
  }

  // free(section_names);
  // free(symbols);
  fclose(file);
  return;
}

void init_monitor(int argc, char *argv[]) {
  /* Perform some global initialization. */

  /* Parse arguments. */
  parse_args(argc, argv);

  // printf("image file:"ANSI_FMT("%s\n", ANSI_FG_RED), img_file);
  // printf("elf file:"ANSI_FMT("%s\n", ANSI_FG_RED), elf_file);


  /* Set random seed. */
  init_rand();

  /* Open the log file. */
  init_log(log_file);
  init_elf(elf_file);
  // Log("%s\n", elf_file);

  /* Initialize memory. */
  init_mem();

  /* Initialize devices. */
  IFDEF(CONFIG_DEVICE, init_device());

  /* Perform ISA dependent initialization. */
  /* load built-in img */
  init_isa();

  /* Load the image to memory. This will overwrite the built-in image. */
  long img_size = load_img();

  /* Initialize differential testing. */
  init_difftest(diff_so_file, img_size, difftest_port);

  /* Initialize the simple debugger. */
  init_sdb();

  IFDEF(CONFIG_ITRACE, init_disasm(
    MUXDEF(CONFIG_ISA_x86,     "i686",
    MUXDEF(CONFIG_ISA_mips32,  "mipsel",
    MUXDEF(CONFIG_ISA_riscv32, "riscv32",
    MUXDEF(CONFIG_ISA_riscv64, "riscv64", "bad")))) "-pc-linux-gnu"
  ));

  /* Display welcome message. */
  welcome();
}
#else // CONFIG_TARGET_AM
static long load_img() {
  extern char bin_start, bin_end;
  size_t size = &bin_end - &bin_start;
  Log("img size = %ld", size);
  memcpy(guest_to_host(RESET_VECTOR), &bin_start, size);
  return size;
}

void am_init_monitor() {
  init_rand();
  init_mem();
  init_isa();
  load_img();
  IFDEF(CONFIG_DEVICE, init_device());
  welcome();
}
#endif
