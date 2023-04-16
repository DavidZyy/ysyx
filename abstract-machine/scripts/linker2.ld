ENTRY(_start)
ROM_SIZE = 0x4000;
RAM_SIZE = 0x2000;
/* STACK_SIZE = 0x1000; */
MEMORY {
  rom (rx) : ORIGIN = 0x00000000, LENGTH = ROM_SIZE 
  ram (rwx) : ORIGIN = 0x20000000, LENGTH = RAM_SIZE 
}

SECTIONS {
  /* _pmem_start and _entry_offset are defined in LDFLAGS */
  /* . = _pmem_start + _entry_offset; */
  . = 0;
  .tex : {
    *(entry)
    *(.text*)
  } > rom
  etext = .;
  _etext = .;
  .rodata : {
    *(.rodata*)
  } > rom
  .data : {
    *(.data)
  } > ram
  edata = .;
  _data = .;
  .bss : {
    _bss_start = .;
    *(.bss*)
    *(.sbss*)
    *(.scommon)
  } > ram
  _stack_top = ALIGN(0x1000);
  . = _stack_top + 0x8000;
  _stack_pointer = .;
  end = .;
  _end = .;
  _heap_start = ALIGN(0x1000);
}
