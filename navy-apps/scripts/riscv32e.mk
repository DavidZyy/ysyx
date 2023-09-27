CROSS_COMPILE = riscv64-linux-gnu-
LNK_ADDR = $(if $(VME), 0x40000000, 0x83000000)
CFLAGS  += -fno-pic -mcmodel=medany
LDFLAGS += --no-relax -Ttext-segment $(LNK_ADDR)

CFLAGS  += -march=rv32e -mabi=ilp32e  #overwrite
LDFLAGS += -melf32lriscv