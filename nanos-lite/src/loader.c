#include <proc.h>
#include <elf.h>

#ifdef __LP64__
# define Elf_Ehdr Elf64_Ehdr
# define Elf_Phdr Elf64_Phdr
#else
# define Elf_Ehdr Elf32_Ehdr
# define Elf_Phdr Elf32_Phdr
#endif

void printf_elf_header(Elf64_Ehdr elf_header){
  printf("ELF Header Information:\n");
  printf("  Magic: ");
  for (int i = 0; i < 16; i++) {
      printf("%02x ", elf_header.e_ident[i]);
  }
  printf("\n");
  printf("  Type: %u\n", elf_header.e_type);
  printf("  Machine: %u\n", elf_header.e_machine);
  printf("  Version: %u\n", elf_header.e_version);
  printf("  Entry point address: 0x%lx\n", elf_header.e_entry);
  printf("  Program header offset: %lu\n", elf_header.e_phoff);
  printf("  Section header offset: %lu\n", elf_header.e_shoff);
  printf("  Flags: %u\n", elf_header.e_flags);
  printf("  ELF header size: %u\n", elf_header.e_ehsize);
  printf("  Program header entry size: %u\n", elf_header.e_phentsize);
  printf("  Program header entry count: %u\n", elf_header.e_phnum);
  printf("  Section header entry size: %u\n", elf_header.e_shentsize);
  printf("  Section header entry count: %u\n", elf_header.e_shnum);
  printf("  Section header string table index: %u\n", elf_header.e_shstrndx);
}

size_t ramdisk_read(void *buf, size_t offset, size_t len);
static uintptr_t loader(PCB *pcb, const char *filename) {
  // TODO();
  Elf_Ehdr ehdr;
  ramdisk_read(&ehdr, 0, sizeof(Elf_Ehdr));
  assert(*(uint64_t *)ehdr.e_ident == 0x00010102464c457d);
  printf_elf_header(ehdr);
  return 0;
}

void naive_uload(PCB *pcb, const char *filename) {
  uintptr_t entry = loader(pcb, filename);
  Log("Jump to entry = %p", entry);
  ((void(*)())entry) ();
}

