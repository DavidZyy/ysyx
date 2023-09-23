TOPNAME = top
NXDC_FILES = constr/top.nxdc
INC_PATH = $(abspath ./csrc)/include

INCLUDE = $(abspath ./vsrc/include)
INCLUDE2 =  $(abspath ./vsrc)
INCLUDE3 =  $(abspath ./vsrc/peripheral/seg)

VERILATOR = verilator
VERILATOR_CFLAGS += -MMD --build -cc  \
				-O3 --x-assign fast --x-initial fast --noassert -I$(INCLUDE)

BUILD_DIR = ./build
OBJ_DIR = $(BUILD_DIR)/obj_dir
BIN = $(BUILD_DIR)/$(TOPNAME)

default: $(BIN)

$(shell mkdir -p $(BUILD_DIR))

# constraint file
SRC_AUTO_BIND = $(abspath $(BUILD_DIR)/auto_pin_bind.cpp)

$(SRC_AUTO_BIND): $(NXDC_FILES)
	python3 $(NVBOARD_HOME)/scripts/auto_pin_bind.py $^ $@

# project source
VSRCS = $(shell find $(abspath ./vsrc) -name "*.v")
SVSRCS = $(shell find $(abspath ./vsrc) -name "*.sv")
# CSRCS = $(shell find $(abspath ./csrc) -name "*.c" -or -name "*.cc" -or -name "*.cpp")
CSRCS = $(abspath ./csrc/main.cpp)
CSRCS += $(SRC_AUTO_BIND)

# $(error $(CSRCS))

# NVBOARD_HOME : environment variable .
include $(NVBOARD_HOME)/scripts/nvboard.mk


# rules for verilator
INCFLAGS = $(addprefix -I, $(INC_PATH))
# $(error $(INC_PATH))
CFLAGS += $(INCFLAGS) -DTOP_NAME="\"V$(TOPNAME)\"" -O2 -g
LDFLAGS += -lSDL2 -lSDL2_image

# cpp file for nvboard and simulation
# COMMON_CPP_FILE = $(abspath ./csrc/mem.cpp)
# cpp file for only simulation
# SIM_CPP_FILE = $(abspath ./csrc/dut.cpp)

SRC_DIR := ./csrc

# Use find to recursively locate .cpp and .c files in the source directory
CPP_FILES := $(shell find $(SRC_DIR) -type f -name '*.cpp')
C_FILES := $(shell find $(SRC_DIR) -type f -name '*.c')

# $(error $(CPP_FILES))
# $(error $(C_FILES))

all:
	@echo "Write this Makefile by your self."

# the program to be executed on npc, about ?=, 
# see gnu make 6.2.4 Conditional Variable Assignment
IMG ?= 
# SO = /home/zhuyangyang/project/ysyx-workbench/nemu/build/riscv32-nemu-interpreter-so
SO = $(NEMU_HOME)/build/riscv32-nemu-interpreter-so
LOG_FILE = $(NPC_HOME)/build/npc-log.txt

sim:
# DO NOT REMOVE THIS LINE!!!
	$(call git_commit, "sim RTL")
	@verilator --top-module $(TOPNAME) -I$(INCLUDE) -I$(INCLUDE2) -I$(INCLUDE3) \
	$(addprefix -CFLAGS , $(CFLAGS)) \
	$(addprefix -LDFLAGS , $(LDFLAGS)) \
	-trace --cc --exe --build -Wall \
	$(CPP_FILES) $(C_FILES) $(VSRCS) $(SVSRCS)
	@obj_dir/Vtop $(IMG) $(SO) $(LOG_FILE)
	@gtkwave dump.vcd

# sim:
# 	$(call git_commit, "sim RTL") # DO NOT REMOVE THIS LINE!!!
# 	verilator --top-module $(TOPNAME) -I$(INCLUDE) -I$(INCLUDE2) -I$(INCLUDE3) \
# 	$(addprefix -CFLAGS , $(CFLAGS)) \
# 	-trace --cc --exe --build -Wall \
# 	$(abspath ./csrc/sim_main.cpp) $(VSRCS) $(SVSRCS) \
# 	$(SIM_CPP_FILE) $(COMMON_CPP_FILE)
# 	obj_dir/Vtop $(IMG) $(SO) $(LOG_FILE)
# 	gtkwave dump.vcd

wv:
	gtkwave dump.vcd

include ../Makefile

# run:
# 	verilator --trace --cc --exe --build -Wall sim_main.cpp top.v
# 	./obj_dir/Vtop


# compile all things into one (compile into "build/top")

$(BIN): $(VSRCS) $(CSRCS) $(NVBOARD_ARCHIVE) $(COMMON_CPP_FILE) $(SVSRCS)
	@rm -rf $(OBJ_DIR)
	$(VERILATOR) $(VERILATOR_CFLAGS) \
		--top-module $(TOPNAME) $^ \
		$(addprefix -CFLAGS , $(CFLAGS)) $(addprefix -LDFLAGS , $(LDFLAGS)) \
		--Mdir $(OBJ_DIR) --exe -o $(abspath $(BIN))

all: default

# @build/top
run: $(BIN)
	@$< $(IMG)

clean:
	rm -rf logs obj_dir $(BUILD_DIR) *.vcd

.PHONY: default all clean run
