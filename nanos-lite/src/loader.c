#include <proc.h>
#include <elf.h>

#ifdef __LP64__
# define Elf_Ehdr Elf64_Ehdr
# define Elf_Phdr Elf64_Phdr
# define E_ident 0x00010102464c457f
#else
# define Elf_Ehdr Elf32_Ehdr
# define Elf_Phdr Elf32_Phdr
# define E_ident 0x010101464c457f
#endif

void print_elf_header(Elf_Ehdr elf_header) {
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

void print_program_header(Elf_Phdr program_header) {
  printf("Type: %u ", program_header.p_type);
  printf("Offset: 0x%lx ", program_header.p_offset);
  printf("Virtual Address: 0x%lx ", program_header.p_vaddr);
  printf("Physical Address: 0x%lx ", program_header.p_paddr);
  printf("File Size: 0x%lx ", program_header.p_filesz);
  printf("Memory Size: 0x%lx ", program_header.p_memsz);
  printf("Flags: 0x%x ", program_header.p_flags);
  printf("Align: 0x%lx\n", program_header.p_align);
}

extern uint8_t ramdisk_start;
size_t ramdisk_read(void *buf, size_t offset, size_t len);
static uintptr_t loader(PCB *pcb, const char *filename) {
  // TODO();
  Elf_Ehdr ehdr;
  ramdisk_read(&ehdr, 0, sizeof(Elf_Ehdr));
  print_elf_header(ehdr);
  assert(*(uint64_t *)ehdr.e_ident == E_ident);

  for(int i=0; i < ehdr.e_phnum; i++) {
    Elf_Phdr phdr;
    ramdisk_read(&phdr, ehdr.e_phoff + i*sizeof(Elf_Phdr), sizeof(Elf_Phdr));
    // print_program_header(phdr);
  }

  return (uintptr_t )(&ramdisk_start + ehdr.e_entry - 0x80000000);
}

void naive_uload(PCB *pcb, const char *filename) {
  uintptr_t entry = loader(pcb, filename);
  Log("Jump to entry = %p", entry);
  ((void(*)())entry) ();
}

