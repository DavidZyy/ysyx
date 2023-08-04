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
  Log("ELF Header Information:\n");
  Log("  Magic: ");
  for (int i = 0; i < 16; i++) {
      Log("%02x ", elf_header.e_ident[i]);
  }
  Log("\n");
  Log("  Type: %u\n", elf_header.e_type);
  Log("  Machine: %u\n", elf_header.e_machine);
  Log("  Version: %u\n", elf_header.e_version);
  Log("  Entry point address: 0x%lx\n", elf_header.e_entry);
  Log("  Program header offset: %lu\n", elf_header.e_phoff);
  Log("  Section header offset: %lu\n", elf_header.e_shoff);
  Log("  Flags: %u\n", elf_header.e_flags);
  Log("  ELF header size: %u\n", elf_header.e_ehsize);
  Log("  Program header entry size: %u\n", elf_header.e_phentsize);
  Log("  Program header entry count: %u\n", elf_header.e_phnum);
  Log("  Section header entry size: %u\n", elf_header.e_shentsize);
  Log("  Section header entry count: %u\n", elf_header.e_shnum);
  Log("  Section header string table index: %u\n", elf_header.e_shstrndx);
}

size_t ramdisk_read(void *buf, size_t offset, size_t len);
static uintptr_t loader(PCB *pcb, const char *filename) {
  // TODO();
  Elf_Ehdr ehdr;
  ramdisk_read(&ehdr, 0, sizeof(Elf_Ehdr));
  printf_elf_header(ehdr);
  return 0;
}

void naive_uload(PCB *pcb, const char *filename) {
  uintptr_t entry = loader(pcb, filename);
  Log("Jump to entry = %p", entry);
  ((void(*)())entry) ();
}

